//
//  ViewController.m
//  AlertController
//
//  Created by sethmedia on 16/11/20.
//  Copyright © 2016年 sethmedia. All rights reserved.
//

#import "ViewController.h"
#import "CLAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor cyanColor];
    
}

- (IBAction)sheet:(id)sender {
    
    CLAlertController *alert = [CLAlertController alertControllerWithTitle:@"更改头像" message:@"选择方式如下：各种小魔头这是一个AlertController 用来学习用的这是一个AlertController 用来学习用的这是一个AlertController 用来学习用的" preferredStyle:CLAlertControllerStyleSheet];

    [alert addAction:[CLAlertModel actionWithTitle:@"打开相机" style:CLAlertActionStyleDefault handler:^(CLAlertModel *action) {
        
    }]];
    
    [alert addAction:[CLAlertModel actionWithTitle:@"保存照片" style:CLAlertActionStyleDefault handler:^(CLAlertModel *action) {
        
    }]];
    
    [alert addAction:[CLAlertModel actionWithTitle:@"打开相册" style:CLAlertActionStyleDestructive handler:^(CLAlertModel *action) {
        
    }]];
    
    [alert addAction:[CLAlertModel actionWithTitle:@"取消" style:CLAlertActionStyleCancel handler:^(CLAlertModel *action) {
        
    }]];
    
    
    
    [self presentToViewController:alert completion:nil];
    
}

- (IBAction)alert两个按钮:(id)sender {
    
    
    CLAlertController *alert = [CLAlertController alertControllerWithTitle:@"标题" message:@"这是一个AlertController 用来学习用的" preferredStyle:CLAlertControllerStyleAlert];
    
    [alert addAction:[CLAlertModel actionWithTitle:@"确定" style:CLAlertActionStyleDefault handler:^(CLAlertModel *action) {
        
    }]];
    
    [alert addAction:[CLAlertModel actionWithTitle:@"取消" style:CLAlertActionStyleDefault handler:^(CLAlertModel *action) {}]];
    
    
    
    
    [self presentToViewController:alert completion:nil];
    
}

- (IBAction)alert非两个按钮:(id)sender {
    
    
    CLAlertController *alert = [CLAlertController alertControllerWithTitle:@"标题" message:@"这是一个AlertController 用来学习用的这是一个AlertController 用来学习用的这是一个AlertController 用来学习用的" preferredStyle:CLAlertControllerStyleAlert];
    
    [alert addAction:[CLAlertModel actionWithTitle:@"确定" style:CLAlertActionStyleDefault handler:^(CLAlertModel *action) {
        
    }]];
    

    
    
    [self presentToViewController:alert completion:nil];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
