//
//  CLLargeImageCollectionViewCell.m
//  PHPhotoAssetCollection
//
//  Created by 秦传龙 on 16/12/1.
//  Copyright © 2016年 hezhijingwei. All rights reserved.
//

#import "CLLargeImageCollectionViewCell.h"
#import "CLLoadPhotoAsset.h"
@interface CLLargeImageCollectionViewCell ()
@end


@implementation CLLargeImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.shouldRasterize = YES;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}


- (void)setAssetInfo:(CLPhotoAssetInfo *)assetInfo {
    
    [self.imageView setLoadImage:assetInfo];
    
    
//    if (!assetInfo.largeImage) {
//        self.imageView.image = assetInfo.nomalImage;
//        [CLLoadPhotoAsset largePhotoAssetInfoWithAssetCollection:assetInfo.asset resultHandle:^(UIImage *result) {
//            
//            
//            if (result) {
//                self.imageView.image = result;
//                assetInfo.largeImage = result;
//            } else {
//                
//                self.imageView.image = assetInfo.nomalImage;
//            }
//            
//        } progress:^(double progress) {
//            
//            
//            NSLog(@"%f",progress);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.contentView animated:YES];
//                hud.mode = MBProgressHUDModeIndeterminate;
//                hud.progress = progress;
//                self.hud = hud;
//                
//                if (progress == 1) {
//                    
//                    [self.hud hide:YES];
//                    
//                }
//                
//                
//            });
//            
//            
//            
//        }];
//    } else {
//        
//        self.imageView.image = assetInfo.largeImage;
//        
//    }

    
    
}

- (CLScaleImageView *)imageView {

    if (!_imageView) {
        
        _imageView = [[CLScaleImageView alloc] initWithFrame:self.contentView.frame];
        __weak typeof(self)weakSelf = self;
        [_imageView addSingleTap:^(UITapGestureRecognizer *tap) {
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(largeImageCollectionViewDidClick:)]) {
                [weakSelf.delegate largeImageCollectionViewDidClick:tap];
            }
            
        }];
    }
    return _imageView;
}











@end
