//
//  ViewController.m
//  CLKeyboardPassWord
//
//  Created by hezhijingwei on 16/6/16.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "ViewController.h"
#import "CLKeyBoardPassWord.h"


@interface ViewController () {
    
    CLKeyBoardPassWord *key;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
}


- (IBAction)btn:(id)sender {
    
    key = [[CLKeyBoardPassWord alloc] initWithPassword:^(NSString *password) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码" message:password delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [alert show];
        
    } backBlock:^(UIView *view) {
        
      [key dismiss];
        
    }];
    [key show];
    

    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
