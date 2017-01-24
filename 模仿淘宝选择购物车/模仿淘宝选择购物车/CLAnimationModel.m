//
//  CLAnimationModel.m
//  模仿淘宝选择购物车
//
//  Created by hezhijingwei on 2017/1/23.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "CLAnimationModel.h"


typedef void(^callBack)(void);

@interface CLAnimationModel ()
{
    
    UIViewController *fromVC;
    
}
@property (nonatomic, assign) CLAnimationModelType modelType;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CGFloat height;

@end


@implementation CLAnimationModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.duration = 0.5;
    }
    return self;
}



- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return self.duration;
}


+ (CLAnimationModel *)animationModelWithModelType:(CLAnimationModelType)modelType height:(CGFloat)height {
    
    CLAnimationModel *model = [[CLAnimationModel alloc] init];

    model.modelType = modelType;
    model.height = height;
    return model;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    if (self.modelType == CLAnimationModelTypePresent) {
        [self present:transitionContext];
    } else {
        [self dismiss:transitionContext];
    }
    

}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *containerView = [transitionContext containerView];
    UIView *toView = containerView.subviews.firstObject;
    
    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    
    

    fromView.frame = CGRectMake(0, containerView.frame.size.height-self.height, containerView.frame.size.width, self.height);

    CATransform3D transform3d = CATransform3DIdentity;
    transform3d.m34 = 1.0/-900;
    transform3d = CATransform3DScale(transform3d, 0.95, 0.95, 1);
    
    
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m34 = transform3d.m34;
    transform3D = CATransform3DRotate(transform3D, 0, 1, 0, 0);
    transform3D = CATransform3DScale(transform3D, 1, 1, 1);
    transform3D = CATransform3DTranslate(transform3D, 0, 0, 0);
    
    [UIView animateWithDuration:self.duration animations:^{

        fromView.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, self.height);
        
    }completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        
        [transitionContext viewForKey:UITransitionContextToViewKey].hidden = NO;
        [toView removeFromSuperview];
        
    }];
    
    [UIView animateWithDuration:self.duration/2 animations:^{
        
        toView.layer.transform = transform3d;
        toView.alpha = 1;
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration:self.duration/2 animations:^{
            
            toView.layer.transform = transform3D;
            
        }];
        
    }];
    

}



- (void)present:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIImageView *fromViewTemp = [self imageFromView:fromView];
    fromView.hidden = YES;
    
    [containerView addSubview:fromViewTemp];
    [containerView addSubview:toView];
    
    toView.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, self.height);
    fromViewTemp.frame = containerView.frame;

    
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m34 = 1.0/-4000;
    transform3D = CATransform3DScale(transform3D, 0.95, 0.95, 1);
    transform3D = CATransform3DRotate(transform3D, 15*M_PI/180.0f, 1, 0, 0);

    CATransform3D transform3d = CATransform3DIdentity;
    transform3d.m34 = transform3D.m34;
    transform3d = CATransform3DTranslate(transform3d, 0, -0.08*containerView.frame.size.height, 0);
    transform3d = CATransform3DScale(transform3d, 0.9, 0.9, 1);
    
    fromViewTemp.layer.anchorPoint = CGPointMake(0.5, 1);
    fromViewTemp.layer.position = CGPointMake(CGRectGetMidX(containerView.frame), CGRectGetMaxY(containerView.frame));
    fromViewTemp.layer.shouldRasterize = YES;
    

    fromViewTemp.layer.anchorPoint = CGPointMake(0.5, 1);
    fromViewTemp.layer.position = CGPointMake(CGRectGetMidX(containerView.frame), CGRectGetMaxY(containerView.frame));
    
    
    
    [UIView animateWithDuration:self.duration animations:^{
        containerView.backgroundColor = [UIColor blackColor];
        toView.frame = CGRectMake(0, containerView.frame.size.height-self.height, containerView.frame.size.width, self.height);
        
    }completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        
    }];
    
    [UIView animateWithDuration:self.duration/2 animations:^{
        
        fromViewTemp.layer.transform = transform3D;
        fromViewTemp.alpha = 0.6;
    }completion:^(BOOL finished) {
       
        [UIView animateWithDuration:self.duration/2 animations:^{
            
            fromViewTemp.layer.transform = transform3d;
            
        }];
        
    }];
    
    
    
    
    

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


@end
