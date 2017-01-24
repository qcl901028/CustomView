//
//  CLViewController.m
//  模仿淘宝选择购物车
//
//  Created by hezhijingwei on 2017/1/23.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "CLViewController.h"
#import "CLAnimationModel.h"

@interface CLViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation CLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];

    
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
     [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [CLAnimationModel animationModelWithModelType:CLAnimationModelTypePresent height:300];
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [CLAnimationModel animationModelWithModelType:CLAnimationModelTypeDismiss height:300];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
