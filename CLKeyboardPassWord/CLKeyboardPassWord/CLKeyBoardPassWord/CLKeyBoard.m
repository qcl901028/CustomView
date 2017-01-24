//
//  CLKeyBoard.m
//  CLKeyboardPassWord
//
//  Created by hezhijingwei on 16/6/16.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "CLKeyBoard.h"
#define CLB_H [UIScreen mainScreen].bounds.size.height

#define CLB_W [UIScreen mainScreen].bounds.size.width
#define CLKeyB_H 216.0/568.0*CLB_H - 20

@interface CLKeyBoard ()

@property (nonatomic ,strong) NSMutableArray *conArr;


@end


@implementation CLKeyBoard


- (NSMutableArray *)conArr {
    
    if (! _conArr) {
        _conArr = [[NSMutableArray alloc] initWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
    }
    return _conArr;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, CLKeyB_H)];
    if (self) {
        
        
        [self setupUI];
        
    }
    return self;
}

- (instancetype)initWithBlock:(returnStringBlock)block
{
    self = [super initWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, CLKeyB_H )];
    if (self) {
        
        self.block = block;
        [self setupUI];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setupUI {

    self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    
//    NSArray *titles = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"",@"9",@"C"];
    
    int num = 0;
    
 
    
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 3; j++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [self addSubview:btn];
            btn.backgroundColor = [UIColor whiteColor];
            btn.frame = CGRectMake(j * ((CLB_W-2)/3.0+1), i*((self.bounds.size.height - 3)/4.0+1), (CLB_W - 2)/3.0, (CLKeyB_H-3)/4.0);
            btn.titleLabel.font = [UIFont systemFontOfSize:30];
            [btn setTitle: [self randomWith:num] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            num ++;
            if (num == 10) {
                
                btn.titleLabel.font = [UIFont systemFontOfSize:25];
                
                btn.backgroundColor = [UIColor clearColor];
            } else if (num == 12) {
                
                btn.backgroundColor = [UIColor clearColor];
                
            }
            
            [btn addTarget:self action:@selector(keyboardClicked:) forControlEvents:UIControlEventTouchUpInside];
           
        }
    }
    
}

- (NSString *)randomWith:(NSInteger)flag {
    
    
    
   
    
    if (flag == 9) {
        return @"后退";
    } else if (flag == 10) {
        
        return @"0";
    } else if (flag == 11) {
        
        return @"C";
    }
    
    NSInteger num = self.conArr.count;

    NSString *resultStr = self.conArr[arc4random()%num];
    
    [self.conArr removeObject:resultStr];
    
    return resultStr;
}



- (void)keyboardClicked:(UIButton *)sender {
    
    if (_block) {
        _block(sender.currentTitle);
    }
    
}



@end
