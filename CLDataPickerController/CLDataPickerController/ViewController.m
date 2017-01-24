//
//  ViewController.m
//  CLDataPickerController
//
//  Created by hezhijingwei on 2016/12/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "ViewController.h"
#import "CLDatePickerView.h"

@interface ViewController ()<CLDatePickerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    


}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CLDatePickerView *datePicker = [[CLDatePickerView alloc] init];
    datePicker.delegate = self;
    [self.view addSubview:datePicker];
    
}


- (void)datePickerView:(CLDatePickerView *)datePickerView didSelectedItem:(NSString *)year month:(NSString *)month {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"CLDatePickerView" message:[NSString stringWithFormat:@"选择了：%@年%@月",year,month] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alertView show];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
