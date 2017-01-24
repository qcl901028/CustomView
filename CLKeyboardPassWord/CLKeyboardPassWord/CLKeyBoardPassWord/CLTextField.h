//
//  CLTextField.h
//  CLKeyboardPassWord
//
//  Created by hezhijingwei on 16/6/16.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^backBlock)(UIView *view);

typedef void(^returnCompletionBlock)(NSString *password);

@interface CLTextField : UIView


@property (nonatomic ,copy) backBlock block;


@property (nonatomic ,copy) returnCompletionBlock pdBlock;

- (instancetype)initWithPassword:(returnCompletionBlock)block backBlock:(backBlock)backBlock;


@end
