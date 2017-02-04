//
//  ViewController.m
//  模仿动动进入菜单
//
//  Created by hezhijingwei on 2017/2/4.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor cyanColor];
    [self createRightItem];
    
}

- (void)createRightItem {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(selectImage)];
    
}

- (void)selectImage {

    [self.view addSubview:self.tableView];
    
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 250) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.bounces = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableView"];
        
    }
    
    return _tableView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableView"];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"---------%ld行-------------",indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGRect frame = cell.frame;
    
    frame.origin.x += cell.frame.size.width;
    cell.frame = frame;
    
    frame.origin.x = 0;
    
    
    CGFloat delay = indexPath.row * 0.05;
    
    
    [UIView animateWithDuration:1.0f delay:delay usingSpringWithDamping:0.7 initialSpringVelocity:12 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        cell.frame = frame;
        
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.tableView) {
        [self willDimss];
    }
    
}



- (void)willDimss {
    
    for (UIView *view in self.tableView.subviews) {
        
        if ([view isKindOfClass:NSClassFromString(@"UITableViewWrapperView")]) {
            
            for (UIView *cellView in view.subviews) {
                
                if ([cellView isKindOfClass:[UITableViewCell class]]) {
                    
                    UITableViewCell *cell = (UITableViewCell *)cellView;
                    
                    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
                    
                    CGFloat delay = indexPath.row*0.05;
                    
                    CGRect frame = cell.frame;
                    frame.origin.x += cell.frame.size.width;
                    
                    
                    [UIView animateWithDuration:0.2 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
                        cell.frame = frame;
                    } completion:^(BOOL finished) {
                        if (finished) {
                            
                            [self.tableView removeFromSuperview];
                            self.tableView = nil;
                            
                        }
                    }];

                }
                
            }
        }
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
