//
//  ViewController.m
//  加载动画
//
//  Created by hezhijingwei on 2017/1/24.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


// 81 141 229
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [self.view addSubview:view1];
    view1.backgroundColor = [UIColor blackColor];
    view1.alpha = 0.77;
    view1.center = self.view.center;
    view1.layer.cornerRadius = 5;
    view1.layer.masksToBounds = YES;

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [self.view addSubview:view];
    view.center = self.view.center;
    
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(40, 30) radius:15 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 0, view.frame.size.width, 60);
    [view.layer addSublayer:layer];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 3;
    layer.shouldRasterize = YES;

    
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(40, 30) radius:15 startAngle:0 endAngle:45*(M_PI/180.0f) clockwise:YES];
    bezierPath.lineWidth = 3;
    bezierPath.lineCapStyle = kCGLineCapRound;
    
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.frame = CGRectMake(0, 0, view.frame.size.width, 60);
    [layer addSublayer:layer1];
    layer1.path = bezierPath.CGPath;
    layer1.strokeColor = [UIColor colorWithRed:81.0f/255.0f green:141.0f/255.0f blue:229.0f/255.0f alpha:1].CGColor;
    layer1.fillColor = [UIColor clearColor].CGColor;
    layer1.lineWidth = 3;
    layer1.shouldRasterize = YES;
    
    
    CABasicAnimation *rotaAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotaAni.fromValue = @(0);
    rotaAni.toValue = @(M_PI*2);
    rotaAni.duration = 1;
    rotaAni.repeatCount = MAXFLOAT;
    rotaAni.fillMode = kCAFillModeForwards;
    rotaAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [layer addAnimation:rotaAni forKey:@"ads"];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 54, 80, 20)];
    [view addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.text = @"正在加载...";
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
