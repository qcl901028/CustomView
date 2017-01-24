//
//  CLPhotoAssetCollectionViewCell.h
//  PHPhotoAssetCollection
//
//  Created by 秦传龙 on 2016/12/1.
//  Copyright © 2016年 hezhijingwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectBtnClickDelegate <NSObject>

- (void)selectBtnClick:(UIButton *)sender;

@end


@interface CLPhotoAssetCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, weak) id<SelectBtnClickDelegate> delegate;
@property (nonatomic, strong) UIImageView *imageView;




@end
