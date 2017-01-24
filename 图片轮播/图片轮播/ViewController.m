//
//  ViewController.m
//  图片轮播
//
//  Created by hezhijingwei on 16/9/9.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "ViewController.h"
#import "CLCycleView.h"



@interface ViewController ()<CLCycleViewDelegate>


@property (nonatomic ,strong) CLCycleView *cycleView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    CGRect frame = CGRectMake(0, 100, self.view.frame.size.width, 200);
    
    NSArray *imageArr = @[@"1.jpg",@"2.png",@"3.jpg",@"4.jpg",@"1.jpg",@"2.png",@"3.jpg",@"4.jpg",@"1.jpg",@"2.png",@"3.jpg",@"4.jpg"];
    
    CLCycleView *cycleView = [[CLCycleView alloc] initWithFrame:frame duration:3 imageArr:imageArr];
    cycleView.delegate = self;
    cycleView.currentPageIndicatorTintColor = [UIColor redColor];
    cycleView.pageIndicatorTintColor = [UIColor blueColor];
    cycleView.diameter = 20;
    cycleView.cycleView = ^(NSInteger indexPage) {
        NSLog(@"block显示点击%ld张图片",indexPage);
    };
    
    self.cycleView = cycleView;
    [self.view addSubview:cycleView];
  
}


#pragma mark - cycleViewDelegate
- (void)cycleViewDidSelected:(NSInteger)pageIndex {
    
     NSLog(@"delegate显示点击%ld张图片",pageIndex);
    [self.cycleView stop];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CLCycleView" message:[NSString stringWithFormat:@"点击了第%ld张图片,并且停止播放",pageIndex] preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"开始轮播" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.cycleView start];
        
        
    }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
