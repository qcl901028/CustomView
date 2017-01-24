//
//  CLKeyBoardPassWord.m
//  CLKeyboardPassWord
//
//  Created by hezhijingwei on 16/6/16.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "CLKeyBoardPassWord.h"
#import "CLTextField.h"


#define CLBounds [UIScreen mainScreen].bounds

#define CLB_S [UIScreen mainScreen].bounds.size

#define CLB_W [UIScreen mainScreen].bounds.size.width

#define CLB_H [UIScreen mainScreen].bounds.size.height

#define CLKeyB_H 216.0/568.0*CLB_H

@interface CLKeyBoardPassWord ()

@property (nonatomic ,strong) UIView *contentView;



@end



@implementation CLKeyBoardPassWord


- (instancetype)initWithPassword:(returnCompletionBlock)block backBlock:(backBlock)backBlock
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        self.block = backBlock;
        self.pdBlock = block;
        [self setupUI];
        [self createTextField];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {

        [self setupUI];
        [self createTextField];
    }
    return self;
}


- (void)setupUI {
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CLBounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.2;
    
    [self addSubview:bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [bgView addGestureRecognizer:tap];
    
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CLB_H - (CLKeyB_H + 60), CLB_W, CLKeyB_H+60)];
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    [self addSubview:view];
    self.contentView = view;


}


- (void)tap {
    
    [self dismiss];
    
}


- (void)createTextField {
    
    CLTextField *tf = [[CLTextField alloc] initWithPassword:^(NSString *password) {
        
        if (_pdBlock) {
            _pdBlock(password);
        }
        
        
    } backBlock:^(UIView *view){
        
        if (_block) {
            _block(self);
        }
        
        
    }];
    [self.contentView addSubview:tf];
    
    
}


- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.contentView.frame = CGRectMake(0, CLB_H, CLB_W, CLKeyB_H+60);
    
    [UIView animateWithDuration:0.3 animations:^{
       
        
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -(CLKeyB_H+60));
        
    }];
    
    
    
}


- (void)dismiss {

    [UIView animateWithDuration:0.3 animations:^{
        
        self.contentView.frame = CGRectMake(0, CLB_H, CLB_W, CLKeyB_H+60);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
    
    
    
}


@end
