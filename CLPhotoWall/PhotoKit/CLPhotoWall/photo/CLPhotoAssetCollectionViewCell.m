
//
//  CLPhotoAssetCollectionViewCell.m
//  PHPhotoAssetCollection
//
//  Created by 秦传龙 on 2016/12/1.
//  Copyright © 2016年 hezhijingwei. All rights reserved.
//

#import "CLPhotoAssetCollectionViewCell.h"

@interface CLPhotoAssetCollectionViewCell ()



@end


@implementation CLPhotoAssetCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.selectBtn];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_selectBtn(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_selectBtn)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_selectBtn(30)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_selectBtn)]];
    
    
    
}

- (UIButton *)selectBtn {
    
    if (!_selectBtn) {
        
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"def_picker"] forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"sel_picker"] forState:UIControlStateHighlighted];
        [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return _selectBtn;
}

- (void)selectBtnClick:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectBtnClick:)]) {
        [_delegate selectBtnClick:sender];
    }
    
}





- (UIImageView *)imageView {
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return _imageView;
    
}







@end


