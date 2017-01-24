//
//  CLViewController.m
//  CLLabel
//
//  Created by hezhijingwei on 2017/1/22.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "CLViewController.h"
#import "CLImitationTaoBao.h"

@interface CLViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation CLViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.view.backgroundColor = [UIColor whiteColor];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [CLImitationTaoBao imitationTaoBao:CLImitationTaoBaoModelTypePresent];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    
    return [CLImitationTaoBao imitationTaoBao:CLImitationTaoBaoModelTypeDismiss];
}



- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
