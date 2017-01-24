//
//  CLLargeImageCollectionViewCell.h
//  PHPhotoAssetCollection
//
//  Created by 秦传龙 on 16/12/1.
//  Copyright © 2016年 hezhijingwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLScaleImageView.h"
#import "CLPhotoAssetInfo.h"

@protocol LargeImageCollectionViewDelegate <NSObject>

- (void)largeImageCollectionViewDidClick:(UITapGestureRecognizer *)tap;

@end

@interface CLLargeImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) CLScaleImageView *imageView;
@property (nonatomic, weak) id<LargeImageCollectionViewDelegate> delegate;
@property (nonatomic, strong) CLPhotoAssetInfo *assetInfo;


@end
