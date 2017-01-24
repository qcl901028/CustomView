//
//  CLCycleView.h
//  图片轮播
//
//  Created by hezhijingwei on 16/9/9.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CLCycleViewCallBack)(NSInteger pageIndex);


@protocol CLCycleViewDelegate <NSObject>


/**
 *  点击当前的imageView 返回点击的第几张图片，便于使用   根据您的习惯你也可以选择block的形式cycleView来做相应的处理
 *
 *  @param pageIndex <#pageIndex description#>
 */
- (void)cycleViewDidSelected:(NSInteger)pageIndex;

@end


@interface CLCycleView : UIView


/**
 *  没选中的颜色
 */
@property (nonatomic ,strong) UIColor *pageIndicatorTintColor;

/**
 *  被选中的颜色 The color Of selected
 */
@property( nonatomic,strong) UIColor *currentPageIndicatorTintColor;

/**
 *  设置原点的半径 当原点大于15时  设置为 15； 当原点不设置默认是8.0
 */
@property (nonatomic ,assign) CGFloat diameter;


/**
 *  代理
 */
@property (nonatomic ,weak) id <CLCycleViewDelegate> delegate;

/**
 *   点击当前的imageView 返回点击的第几张图片，便于使用   根据您的习惯你也可以选择代理方法cycleViewDidSelected:来做相应的处理
 */
@property (nonatomic, copy) CLCycleViewCallBack cycleView;

/**
 *  停止播放
 */
- (void)stop;


/**
 *  开始播放
 */
- (void)start;


/**
 *  设置scrollview
 *
 *  @param frame    设置图片轮播视图的大小
 *  @param duration 设置图片滚动的时间间隔 当时间间隔小于0时  默认设置为3s
 *  @param imageArr 图片的数组个数必须大于3 否则不会显示
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame duration:(CGFloat)duration imageArr:(NSArray<NSString *> *)imageArr;

@end
