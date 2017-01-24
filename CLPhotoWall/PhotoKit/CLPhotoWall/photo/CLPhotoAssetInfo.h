//
//  CLPhotoAssetInfo.h
//  PHPhotoAssetCollection
//
//  Created by 秦传龙 on 2016/12/1.
//  Copyright © 2016年 hezhijingwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface CLPhotoAssetInfo : NSObject


@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, strong) UIImage *nomalImage;
@property (nonatomic, strong) UIImage *largeImage;

@end
