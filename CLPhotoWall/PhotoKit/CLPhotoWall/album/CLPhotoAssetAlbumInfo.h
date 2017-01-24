//
//  CLPhotoAssetAlbumInfo.h
//  PHPhotoAssetCollection
//
//  Created by 秦传龙 on 2016/12/1.
//  Copyright © 2016年 hezhijingwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CLPhotoAssetAlbumInfo : NSObject

@property (nonatomic, copy) NSString *AlbumName; // 相册名字
@property (nonatomic, strong) UIImage *AlbumFirstImage; // 第一张图片
@property (nonatomic, assign) NSInteger photoNum; // 图片张数

@end
