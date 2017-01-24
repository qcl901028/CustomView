//
//  CLScaleImageView.h
//  Image
//
//  Created by hezhijingwei on 2016/12/5.
//  Copyright © 2016年 hezhijingwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLLoadPhotoAsset.h"


@interface CLScaleImageView : UIScrollView

@property (nonatomic, strong) UIImage *image;

- (void)setLoadImage:(CLPhotoAssetInfo *)asset;


- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;


- (void)addSingleTap:(void(^)(UITapGestureRecognizer *))callBack;


- (void)setBackImage:(NSString *)url placeholderImage:(UIImage *)image;

@end
