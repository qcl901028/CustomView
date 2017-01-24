//
//  CLLargeImageViewController.h
//  PHPhotoAssetCollection
//
//  Created by 秦传龙 on 16/12/1.
//  Copyright © 2016年 hezhijingwei. All rights reserved.
//

#import <UIKit/UIKit.h>


@class photos;


@protocol CLLargeImagePopViewDelegate <NSObject>

- (void)largeImagePopView:(NSArray *)selectArr dataSource:(NSArray *)dataSource;

@end


@interface CLLargeImageViewController : UIViewController


@property(nonatomic,strong) NSIndexPath * indexPath;
@property(nonatomic,strong) NSMutableArray * dataSource;
@property (nonatomic, strong) NSMutableArray *selectArr;
@property (nonatomic, assign) NSInteger didSelectCount;
@property (nonatomic, weak) id<CLLargeImagePopViewDelegate> delegate;

@end
