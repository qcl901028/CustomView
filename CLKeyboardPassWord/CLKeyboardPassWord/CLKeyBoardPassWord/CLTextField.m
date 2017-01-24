//
//  CLTextField.m
//  CLKeyboardPassWord
//
//  Created by hezhijingwei on 16/6/16.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "CLTextField.h"
#import "CLKeyBoard.h"


#define CLB_H [UIScreen mainScreen].bounds.size.height

#define CLB_W [UIScreen mainScreen].bounds.size.width
#define CLKeyB_H 216.0/568.0*CLB_H - 20

@interface CLTextField () {
    
    BOOL isDelegate;
}


@property (nonatomic ,assign) NSInteger number;
@property (nonatomic ,strong) NSMutableArray *labels;
@property (nonatomic ,strong) NSMutableArray *pwViews;


@end

@implementation CLTextField



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80+ CLKeyB_H)];
    if (self) {
        
        
        [self setupUI];
        
    }
    return self;
}



- (instancetype)initWithPassword:(returnCompletionBlock)block backBlock:(backBlock)backBlock
{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80+CLKeyB_H)];
    if (self) {
       
        self.block = backBlock;
        self.pdBlock = block;

        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
    
    [self setTextField];
    [self setKeyBoard];
}

- (void)setTextField {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *keyboardBgView = [[UIView alloc] initWithFrame:CGRectMake((CLB_W - 44*6)/2.0, 18, 44*6, 44)];
    [self addSubview:keyboardBgView];
    keyboardBgView.layer.masksToBounds = YES;
    keyboardBgView.layer.cornerRadius = 4;
    keyboardBgView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    keyboardBgView.layer.borderWidth = 1;
    
    for (int i = 0; i < 6; i++) {
        
        UILabel *tf = [[UILabel alloc] initWithFrame:CGRectMake(i*44, 0, 44, 44)];
        
        [keyboardBgView addSubview:tf];
        tf.textAlignment = NSTextAlignmentCenter;
        
        tf.font = [UIFont systemFontOfSize:25];
        
        tf.tag = i;
        [self.labels addObject:tf];
        
        if (i != 5) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((44 - 0.5)*(i+1), 0, 1, 44)];
            
            
            lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
            
            [keyboardBgView addSubview:lineView];
            
        }
        
        
    }
    
    
    
    
    
}


- (NSMutableArray *)labels {
    
    if (_labels == nil) {
        _labels = [[NSMutableArray alloc] init];
    }
    
    return _labels;
}

- (void)setKeyBoard {

    _number = 0;
    NSMutableString *resultStr = [[NSMutableString alloc] init];

    CLKeyBoard *keyBoardView = [[CLKeyBoard alloc] initWithBlock:^(NSString *string) {
        
        
        if ([string isEqualToString:@"C"]) {
            isDelegate = NO;
            if (resultStr.length > 0) {
                [resultStr deleteCharactersInRange:NSMakeRange(resultStr.length -1, 1)];
                UILabel *label = self.labels[resultStr.length];
                label.text = @"";
                [self removeView:label];
            }
        }
        
        if (![string isEqualToString:@"C"] && ![string isEqualToString:@"后退"]) {
            if (resultStr.length < 6) {
                
                UILabel *label = self.labels[resultStr.length];
                [resultStr appendString:string];
                label.text = string;

                [self performSelector:@selector(createSeWith:) withObject:label afterDelay:0.15];
            }
            
            if (resultStr.length == 6 && !isDelegate) {
                
                isDelegate = YES;
                if (_pdBlock) {
                    _pdBlock(resultStr);
                }
            }
            
        }
        
        if ([string isEqualToString:@"后退"]) {
            
            
            if (_block) {
                _block(self);
            }
            
        }

       
    }];
    [self addSubview:keyBoardView];
    
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(keyBoardView.frame), CLB_W, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self addSubview:lineView];
    
    
}

- (void)createSeWith:(UILabel *)label {

    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 5, label.frame.size.height - 10, label.frame.size.height - 10)];
    view.backgroundColor = [UIColor blackColor];
    
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = (label.frame.size.height - 10)/2.0;
    [label addSubview:view];
    
}


- (void)removeView:(UILabel *)label {
    
    [label.subviews.firstObject removeFromSuperview];
    
    
}

- (NSMutableArray *)pwViews {
    
    if (nil == _pwViews) {
        _pwViews = [[NSMutableArray alloc] init];
    }
    
    return _pwViews;
}

@end
