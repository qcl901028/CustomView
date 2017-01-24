//
//  CLLoadPhotoAsset.h
//  PHPhotoAssetCollection
//
//  Created by 秦传龙 on 2016/12/1.
//  Copyright © 2016年 hezhijingwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@class CLPhotoAssetAlbumInfo,CLPhotoAssetInfo;


typedef NS_ENUM(NSInteger, CLPhotoAssetFailtureReason) {
    
    CLPhotoAssetFailtureReasonDenied, // 用户拒绝
    CLPhotoAssetFailtureReasonRestricted, // 受限
    CLPhotoAssetFailtureReasonNotDetermined // 不确定的状态
    
};



@interface CLLoadPhotoAsset : NSObject

+ (instancetype)defaultManager ;


- (void)loadPhotoAsset:(void (^)(NSMutableArray<PHAssetCollection *>* photoList))photoAsset videoAsset:(void (^)(NSMutableArray<PHAssetCollection *>* videoList))videoAsset failture:(void (^)(CLPhotoAssetFailtureReason failtureReason))failture;


+ (CLPhotoAssetAlbumInfo *)photoAssetAlbumInfoWithAssetCollection:(PHAssetCollection *)assetCollection;


+ (void)photoAssetInfoWithAssetCollection:(PHAssetCollection *)assetCollection  photoAssets:(void(^)(NSArray *))photoAssets;

// 根据PHAsset 得到大图
+ (void)largePhotoAssetInfoWithAssetCollection:(PHAsset *)asset resultHandle:(void(^)(UIImage *image))resultHandle progress:(void(^)(double progress))progress;
// 根据PHAsset 得到小图
+ (void)nomalPhotoAssetInfoWithAssetCollection:(PHAsset *)asset resultHandle:(void(^)(UIImage *image))resultHandle;

// 得到自己想要的图片 PHImageManagerMaximumSize 是要的原图尺寸
+ (void)photoAssetInfoWithAssetCollection:(PHAsset *)asset size:(CGSize)size resultHandle:(void(^)(UIImage *image))resultHandle;


@end
