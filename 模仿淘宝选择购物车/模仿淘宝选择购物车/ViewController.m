//
//  ViewController.m
//  模仿淘宝选择购物车
//
//  Created by hezhijingwei on 2017/1/23.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "ViewController.h"
#import "CLViewController.h"


@interface ViewController ()<CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) UIView *tempView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)btnClick:(id)sender {
    
    UIView *btn = [self imageFromView:sender];
    [self.view addSubview:btn];
    btn.frame = [(UIButton *)sender frame];
    self.tempView = btn;
    CGPoint btnCenter = btn.center;
    CGPoint endCenter = self.imageView.center;
    
    CGFloat a = btnCenter.x;
    CGFloat b = btnCenter.y;
    
    CGFloat m = endCenter.x;
    CGFloat n = endCenter.y;
    
    
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:btnCenter];
    for (int i = btnCenter.x; i < endCenter.x; i++) {
        
        CGFloat y = (n-b)/((m-a)*(m-a))*(i - a)*(i-a)+b;
        [bezierPath addLineToPoint:CGPointMake(i, y)];
        
    }
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 2;
    animationGroup.fillMode = kCAFillModeForwards;
    
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    animation.path = bezierPath.CGPath;
    
    
    CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    an.fromValue = @(0);
    an.toValue = @(M_PI*2);
    an.repeatCount = MAXFLOAT;
    an.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    an.duration = 0.5;
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @(1);
    scale.toValue = @(0.3);
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    

    animationGroup.animations = @[an,animation,scale];
    
    
    [btn.layer addAnimation:animationGroup forKey:nil];
    
}


// 截屏
- (UIImageView*)imageFromView:(UIView *)snapView{
    
    UIGraphicsBeginImageContextWithOptions(snapView.frame.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [snapView.layer renderInContext:context];
    
    UIImage*targetImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:targetImage];
    
    imageView.frame= snapView.frame;
    
    return imageView;
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [self.tempView removeFromSuperview];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    CLViewController *vc = [[CLViewController alloc] init];
    
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
