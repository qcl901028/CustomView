//
//  CLKeyBoardPassWord.h
//  CLKeyboardPassWord
//
//  Created by hezhijingwei on 16/6/16.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^backBlock)(UIView *view);

typedef void(^returnCompletionBlock)(NSString *password);

@interface CLKeyBoardPassWord : UIView


@property (nonatomic ,copy) backBlock block;


@property (nonatomic ,copy) returnCompletionBlock pdBlock;


/**
 *  设置键盘
 *
 *  @param block     返回密码
 *  @param backBlock 点击左下角回退按钮执行的语句
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithPassword:(returnCompletionBlock)block backBlock:(backBlock)backBlock;

/**
 *  视图出现
 */
- (void)show;

/**
 *  视图消失
 */
- (void)dismiss;

@end
