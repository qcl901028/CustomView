//
//  CLLoadPhotoAsset.m
//  PHPhotoAssetCollection
//
//  Created by 秦传龙 on 2016/12/1.
//  Copyright © 2016年 hezhijingwei. All rights reserved.
//

#import "CLLoadPhotoAsset.h"
#import "CLPhotoAssetConst.h"
#import "CLPhotoAssetAlbumInfo.h"
#import "CLPhotoAssetInfo.h"
@interface CLLoadPhotoAsset ()

@property (nonatomic, strong) PHAssetCollection *allAssetAlbum;

@end


@implementation CLLoadPhotoAsset

+ (instancetype)defaultManager {
    
    static dispatch_once_t oncetoken = 0;
    static CLLoadPhotoAsset *photoAsset = nil;
    
    dispatch_once(&oncetoken, ^{
        
        photoAsset = [[self alloc] init];
        
    });
    
    return photoAsset;
}





- (void)loadPhotoAsset:(void (^)(NSMutableArray<PHAssetCollection *>*))photoAsset videoAsset:(void (^)(NSMutableArray<PHAssetCollection *>*))videoAsset failture:(void (^)(CLPhotoAssetFailtureReason))failture {
    
    // 1. 获取当前应用对照片的访问权限 这个获取的是系统的相册
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusRestricted ) {
        
        if (failture) {
            failture(CLPhotoAssetFailtureReasonRestricted);
        }
        
        return;
    } else if (status == PHAuthorizationStatusDenied) {
        
        if (failture) {
            failture(CLPhotoAssetFailtureReasonDenied);
        }
        
        return;
    }
    
    
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
    
    NSMutableArray *imageList = [[NSMutableArray alloc] init];
    NSMutableArray *videoList = [[NSMutableArray alloc] init];
    
    for (PHCollection *collection in result) {
        
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            
            PHAssetCollection *assetCollection = (id)collection;
            if ([assetCollection.localizedTitle isEqualToString:@"视频"]) {
                [videoList addObject:assetCollection];
                continue;
            }
            
            if ([assetCollection.localizedTitle isEqualToString:@"所有照片"]) {
                
                self.allAssetAlbum = assetCollection;
                
                
            } else {
                
                PHFetchOptions *option = [[PHFetchOptions alloc] init];
                option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
                PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
                
                if (fetchResult.count > 0) {
                    [imageList addObject:assetCollection];
                }
                
            }
            
        }
        
    }
    
    // 这个获取的是应用创建的相册  比如QQ 微博 等应用保存的照片会生成一个文件夹
    PHFetchResult *ownAlbumsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
    for (NSInteger i = 0; i < ownAlbumsFetchResult.count; i++) {
        PHCollection *collection = ownAlbumsFetchResult[i];
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            
            if ([assetCollection.localizedTitle isEqualToString:@"视频"]) {
                
                [videoList addObject:assetCollection];
                continue;
            }
            
            PHFetchOptions *option = [[PHFetchOptions alloc] init];
            option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
            
            if (fetchResult.count > 0) {
                [imageList addObject:assetCollection];
            }
            
        }
    }
    
    
    if (self.allAssetAlbum) {
        [imageList insertObject:self.allAssetAlbum atIndex:0];
    }
    
    if (photoAsset) {
        photoAsset(imageList);
    }
    
    if (videoAsset) {
        videoAsset(videoList);
    }
    
    
}


+ (CLPhotoAssetAlbumInfo *)photoAssetAlbumInfoWithAssetCollection:(PHAssetCollection *)assetCollection {
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    
    PHFetchResult *albumResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
    PHAsset *asset = [albumResult lastObject];
    PHImageManager *imageManager = [PHImageManager defaultManager];
   
    CLPhotoAssetAlbumInfo *assetInfo = [[CLPhotoAssetAlbumInfo alloc] init];
    assetInfo.photoNum = albumResult.count;
    assetInfo.AlbumName = assetCollection.localizedTitle;
    
    [imageManager requestImageForAsset:asset targetSize:CGSizeMake(150, 150) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        assetInfo.AlbumFirstImage = result;
        
    }];
    
    return assetInfo;
}


+ (void)largePhotoAssetInfoWithAssetCollection:(PHAsset *)asset resultHandle:(void(^)(UIImage *image))resultHandle progress:(void(^)(double progress))progress {
    
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeNone;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.synchronous = NO;
    options.version = PHImageRequestOptionsVersionOriginal;
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width*2, 2 *[UIScreen mainScreen].bounds.size.width);

    options.progressHandler = ^(double progress1, NSError *__nullable error, BOOL *stop, NSDictionary *__nullable info) {
      
        
        if (progress) {
            progress(progress1);
        }
        
        if (error) {
            *stop = YES;
        }
        
        
        
        
    };
    
    PHImageManager *imageManager = [PHImageManager defaultManager];
    [imageManager requestImageForAsset:asset
                            targetSize:size
                           contentMode:PHImageContentModeAspectFit
                               options:options
                         resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {

                                 if (resultHandle) {
                                     resultHandle(result);
                             };
                             
                         }];
    
    
    
    
}





+ (void)nomalPhotoAssetInfoWithAssetCollection:(PHAsset *)asset resultHandle:(void(^)(UIImage *image))resultHandle{
    
    
    PHImageManager *imageManager = [PHImageManager defaultManager];
    [imageManager requestImageForAsset:asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        
        if (result) {
            if (resultHandle) {
                resultHandle(result);
 
            }
            
        }

    }];
    
}



// 获取assetCollection 中的图片资源
+ (void)photoAssetInfoWithAssetCollection:(PHAssetCollection *)assetCollection  photoAssets:(void(^)(NSArray *))photoAssets {
    
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    
    PHFetchResult *albumResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
    
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    
    [albumResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
       
        CLPhotoAssetInfo *AssetInfo = [[CLPhotoAssetInfo alloc] init];
        AssetInfo.asset = asset;
        AssetInfo.selected = NO;
        [mArr addObject:AssetInfo];
        
    }];

    if (photoAssets) {
        photoAssets(mArr);
    }
}


+ (void)photoAssetInfoWithAssetCollection:(PHAsset *)asset size:(CGSize)size resultHandle:(void(^)(UIImage *image))resultHandle {
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.synchronous = NO;
    options.version = PHImageRequestOptionsVersionOriginal;
    PHImageManager *imageManager = [PHImageManager defaultManager];
    [imageManager requestImageForAsset:asset
                            targetSize:size
                           contentMode:PHImageContentModeAspectFit
                               options:options
                         resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                             if (result) {
                                 if (resultHandle) {
                                     resultHandle(result);
                                 }
                             };
                             
                         }];
}





@end
