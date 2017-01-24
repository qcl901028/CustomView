//
//  CLImitationTaoBao.m
//  CLLabel
//
//  Created by hezhijingwei on 2017/1/22.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "CLImitationTaoBao.h"

@interface CLImitationTaoBao ()

@property (nonatomic, assign) CLImitationTaoBaoModelType modelType;

@end

@implementation CLImitationTaoBao

+ (CLImitationTaoBao *)imitationTaoBao:(CLImitationTaoBaoModelType)modelType {
    
    CLImitationTaoBao *imitation = [[CLImitationTaoBao alloc] init];
    imitation.modelType = modelType;
    return imitation;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    
    if (self.modelType == CLImitationTaoBaoModelTypePresent) {
    
        [self present:transitionContext];
        
    } else {
    
        [self dismiss:transitionContext];
        
    }
    
    
    
    
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
    return 0.5;
}


- (void)present:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIView *fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromeView];
    [containerView addSubview:toView];
    
    fromeView.frame = containerView.frame;
    toView.frame = CGRectMake(0, -containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
       
        fromeView.frame = CGRectMake(0, containerView.frame.size.height*4/5.0f, containerView.frame.size.width, containerView.frame.size.height);
        toView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
        
    }];
    
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromeView];
    [containerView addSubview:toView];
    
    fromeView.frame = containerView.frame;
    toView.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromeView.frame = CGRectMake(0, -containerView.frame.size.height, containerView.frame.size.width, containerView.frame.size.height);
        toView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
        
    }];
    
}



@end
