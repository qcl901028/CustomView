//
//  CLPageControl.h
//  图片轮播
//
//  Created by hezhijingwei on 16/9/9.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLPageControl : UIPageControl

/**
 *  设置直径
 */
@property (nonatomic, assign) CGFloat diameter;


- (instancetype)initWithFrame:(CGRect)frame currentColor:(UIColor *)currentColor tintColor:(UIColor *)tintColor;

@property (nonatomic ,strong) UIColor *currentColor;
@property (nonatomic ,strong) UIColor *tintColor;



@end
