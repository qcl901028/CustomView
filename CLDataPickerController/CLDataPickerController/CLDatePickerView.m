//
//  CLDatePickerView.m
//  CLDataPickerController
//
//  Created by hezhijingwei on 2016/12/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "CLDatePickerView.h"

@interface CLDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSArray *years;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *month;

@end


@implementation CLDatePickerView

//字符串拼接
- (NSString *)stringCombine:(NSString *)str string:(NSString *)string
{
    NSString *stringCom = [NSString stringWithFormat:@"%@%@",str,string];
    return stringCom;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        [self inital];
        [self layoutBgView];
        [self backgroundViewLayout];
        [self pickerViewLayout];
        [self layoutLineView];
        [self btnLayout];
    }
    return self;
}




- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        [self inital];
        [self layoutBgView];
        [self backgroundViewLayout];
        [self pickerViewLayout];
        [self layoutLineView];
        [self btnLayout];
        
    }
    return self;
}

- (void)btnLayout {
    [self.backgroundView addSubview:self.cancelBtn];
    [self.backgroundView addSubview:self.okBtn];
    
    
    
}

- (void)okeyBtnClick:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(datePickerView:didSelectedItem:month:)]) {
        
        [_delegate datePickerView:self didSelectedItem:self.year month:self.month];
        
    }
    
    [self close];
    
    
}


- (void)cancelBtnClick:(UIButton *)sender {
    
    [self close];
    
}


- (void)close {
    
    [UIView animateWithDuration:0.15 animations:^{
       
        self.backgroundView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        self.backgroundView.alpha = 0;
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
    
}



- (UIButton *)okBtn {
    
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _okBtn.frame = CGRectMake(CGRectGetWidth(self.backgroundView.frame)/2.0f, CGRectGetMaxY(self.lineView.frame), CGRectGetWidth(self.backgroundView.frame)/2.0f, 50);
        _okBtn.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:74.0/255.0 blue:66.0/255.0 alpha:1];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(okeyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
    
}


- (UIButton *)cancelBtn {
    
    if (!_cancelBtn) {
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), CGRectGetWidth(self.backgroundView.frame)/2.0f, 50);
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelBtn;
}



- (void)layoutLineView {
    
    [self.backgroundView addSubview:self.lineView];
    
    
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pickerView.frame), CGRectGetWidth(self.pickerView.frame), 0.5)];
        _lineView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    }
    return _lineView;
}




- (void)inital {
    
    
    // 当前时间 选择器默认显示时间
    NSDate* date = [NSDate date];
    NSDateFormatter *fm =[[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy";
    NSInteger yearN = [[fm stringFromDate:date] integerValue];
    self.year = [NSString stringWithFormat:@"%ld",yearN];
    self.years = @[[NSString stringWithFormat:@"%ld年",yearN-10],
                   [NSString stringWithFormat:@"%ld年", yearN-9],
                   [NSString stringWithFormat:@"%ld年", yearN-8],
                   [NSString stringWithFormat:@"%ld年", yearN-7],
                   [NSString stringWithFormat:@"%ld年", yearN-6],
                   [NSString stringWithFormat:@"%ld年", yearN-5],
                   [NSString stringWithFormat:@"%ld年", yearN-4],
                   [NSString stringWithFormat:@"%ld年", yearN-3],
                   [NSString stringWithFormat:@"%ld年", yearN-2],
                   [NSString stringWithFormat:@"%ld年", yearN-1],
                   [NSString stringWithFormat:@"%ld年",   yearN],
                   [NSString stringWithFormat:@"%ld年", yearN+1],
                   [NSString stringWithFormat:@"%ld年", yearN+2],
                   [NSString stringWithFormat:@"%ld年", yearN+3],
                   [NSString stringWithFormat:@"%ld年", yearN+4],
                   [NSString stringWithFormat:@"%ld年", yearN+5],
                   [NSString stringWithFormat:@"%ld年", yearN+6],
                   [NSString stringWithFormat:@"%ld年", yearN+7],
                   [NSString stringWithFormat:@"%ld年", yearN+8],
                   [NSString stringWithFormat:@"%ld年", yearN+9],
                   [NSString stringWithFormat:@"%ld年",yearN+10]];
    
}


- (void)backgroundViewLayout {
    
    [self addSubview:self.backgroundView];
    
    self.backgroundView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.backgroundView.alpha = 0.8;
    
    [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseOut animations:^{
       
        self.backgroundView.transform = CGAffineTransformMakeScale(1, 1);
        self.backgroundView.alpha = 1;
        
        
    } completion:^(BOOL finished) {
        
    }];
}



- (UIView *)backgroundView {
    
    if (!_backgroundView) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width-120.0f/568.0*[UIScreen mainScreen].bounds.size.width;
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        _backgroundView.layer.cornerRadius = 5;
        _backgroundView.layer.masksToBounds = YES;
        _backgroundView.center = self.center;
        _backgroundView.backgroundColor = [UIColor whiteColor];
        
    }
    
    return _backgroundView;
}



- (void)pickerViewLayout {
    
    [self.backgroundView addSubview:self.pickerView];

}


- (UIPickerView *)pickerView {

    if (!_pickerView) {

        CGFloat width = [UIScreen mainScreen].bounds.size.width-120.0f/568.0*[UIScreen mainScreen].bounds.size.width;
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, width, width-50)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        
        // 当前时间 选择器默认显示时间
        NSDate* date = [NSDate date];
        NSDateFormatter *fm =[[NSDateFormatter alloc] init];
        fm.dateFormat = @"MM";
        NSInteger yearN = [[fm stringFromDate:date] integerValue];
         self.month = [NSString stringWithFormat:@"%02ld",yearN];
        [_pickerView selectRow:10 inComponent:0 animated:NO];
        [_pickerView selectRow:yearN-1 inComponent:1 animated:NO];
    }
    
    return _pickerView;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    [self clearSpearatorLine];

    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component==0) {
        
        return self.years.count;
    }
    
    return 12;
    
    
}

#pragma mark --- 与处理有关的代理方法
//设置组件的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 0) {
        return 100;
    }
    else
    {
        return 80;
    }
    
}
//设置组件中每行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if (component == 0) {
        return 44;
    }
    else
    {
        return 44;
    }
}
//设置组件中每行的标题row:行
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return self.years[row];
    }
    else
    {
        return [NSString stringWithFormat:@"%02ld月",row+1];
    }
}


//选中行的事件处理
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        NSString *year = self.years[row];
        
        if ([year hasSuffix:@"年"]) {
           self.year = [year substringToIndex:year.length-1];
        }
        
        

    }
    else
    {
        self.month = [NSString stringWithFormat:@"%02ld",row+1];
    }
}


- (void)clearSpearatorLine
{
    [self.pickerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView  *obj, NSUInteger idx, BOOL  *stop) {
        if (obj.frame.size.height < 1)
        {
            [obj setBackgroundColor:[UIColor clearColor]];
        }
    }];
}

- (void)layoutBgView {
    [self addSubview:self.bgView];
    
    self.bgView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_bgView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bgView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bgView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bgView)]];
    
    
}


- (UIView *)bgView {
    
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.1;
    }
    return _bgView;
}








@end
