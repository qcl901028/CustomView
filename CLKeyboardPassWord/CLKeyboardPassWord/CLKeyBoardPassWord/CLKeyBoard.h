//
//  CLKeyBoard.h
//  CLKeyboardPassWord
//
//  Created by hezhijingwei on 16/6/16.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnStringBlock)(NSString *string);



@interface CLKeyBoard : UIView

- (instancetype)initWithBlock:(returnStringBlock)block;


@property (nonatomic ,copy) returnStringBlock block;

@end
