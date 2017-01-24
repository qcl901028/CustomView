//
//  ViewController.m
//  CLLabel
//
//  Created by hezhijingwei on 2017/1/22.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "ViewController.h"

#import "CLViewController.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer1;
@property (nonatomic, assign) CGFloat dong;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 239 191 133
    self.view.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:191.0f/255.0f blue:133.0f/255.0f alpha:1];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self layer];
    self.dong = 0;
    
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(disPlayLink:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    return cell;
}


- (UITableView *)tableView {
    
    if (_tableView == nil ) {
        CGRect frame = self.view.frame;
        frame.origin.y -= 60;
        frame.size.height += 60;
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)disPlayLink:(CADisplayLink *)displayLink {
    self.dong = self.dong+0.05;
    self.shapeLayer.path = [self getWavePath:8 W:0.04 d:25+60 dong:0].CGPath;
    self.shapeLayer1.path = [self getWavePath:8 W:0.04 d:29+60 dong:10].CGPath;
}




- (void)layer {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 260)];
    view.backgroundColor = [UIColor whiteColor];
    self.headerView = view;
    self.tableView.tableHeaderView = self.headerView;
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.fillColor = [UIColor orangeColor].CGColor;
    layer2.frame = view.bounds;
    layer2.shouldRasterize = YES;
    layer2.path = [self getLayerBezierPath].CGPath;
    [view.layer addSublayer:layer2];
    
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.frame = view.bounds;
    layer.opacity = 0.3;
    layer.shouldRasterize = YES;
    layer.path = [self getWavePath:8 W:0.04 d:25+60 dong:0].CGPath;
    self.shapeLayer = layer;
    [view.layer addSublayer:layer];
    
    
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.fillColor = [UIColor whiteColor].CGColor;
    layer1.frame = view.bounds;
    layer1.opacity = 0.3;
    layer1.shouldRasterize = YES;
    layer1.path = [self getWavePath:8 W:0.04 d:29+60 dong:10].CGPath;
    self.shapeLayer1 = layer1;
    [view.layer addSublayer:layer1];
    
    
}


- (UIBezierPath *)getLayerBezierPath {

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat R = 25+pow(width, 2)/400.0f;
    CGPoint centerArc = CGPointMake(width/2.0f,260-R);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake(0, 210)];
    [bezierPath addArcWithCenter:centerArc radius:R startAngle:acos(width/(2*R)) endAngle:(M_PI-acos(width/(2*R))) clockwise:YES];
    [bezierPath addLineToPoint:CGPointMake(width, 210)];
    [bezierPath addLineToPoint:CGPointMake(width, 0)];
    [bezierPath closePath];
    
    return bezierPath;

}



- (UIBezierPath *)getWavePath:(CGFloat)A W:(CGFloat)w d:(CGFloat)d dong:(CGFloat)dong{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, 50)];
    
    for (int i = 0; i < [UIScreen mainScreen].bounds.size.width; i++) {
        CGFloat y = A*sinf(i*w +dong+self.dong)+d;
        
        [path addLineToPoint:CGPointMake(i, y)];
    }
    
    [path addLineToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
    [path closePath];
    return path;

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y <-60) {
        
        CLViewController *vc = [CLViewController new];
        
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
