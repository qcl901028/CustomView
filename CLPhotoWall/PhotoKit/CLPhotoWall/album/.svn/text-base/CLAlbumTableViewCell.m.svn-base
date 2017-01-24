//
//  CLAlbumTableViewCell.m
//  PHPhotoAssetCollection
//
//  Created by 秦传龙 on 2016/12/1.
//  Copyright © 2016年 hezhijingwei. All rights reserved.
//

#import "CLAlbumTableViewCell.h"
#import "CLPhotoAssetAlbumInfo.h"
@interface CLAlbumTableViewCell ()

@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *countLabel;

@end


@implementation CLAlbumTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.preservesSuperviewLayoutMargins = NO;
        self.layoutMargins = UIEdgeInsetsZero;
        self.separatorInset = UIEdgeInsetsZero;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self setup];
        
    }
    
    return self;
}

- (void)setup {
    
    [self.contentView addSubview:self.firstImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.countLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_firstImageView(60)]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstImageView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_firstImageView(60)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstImageView)]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_firstImageView]-8-[_nameLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel,_firstImageView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_nameLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel)]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_nameLabel]-12-[_countLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel,_countLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_countLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_countLabel)]];
    
    
}




- (UILabel *)countLabel {
    
    if (!_countLabel) {

        _countLabel = [[UILabel alloc] init];
        _countLabel.font = [UIFont systemFontOfSize:14];
        _countLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1];
        _countLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
    }

    return _countLabel;
}



- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
     
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:16];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return _nameLabel;
}



- (UIImageView *)firstImageView {
    
    if (!_firstImageView) {
        
        _firstImageView = [[UIImageView alloc] init];
        _firstImageView.contentMode = UIViewContentModeScaleAspectFill;
        _firstImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _firstImageView.layer.cornerRadius = 5;
        _firstImageView.layer.masksToBounds = YES;
        
    }
    
    return _firstImageView;
}



- (void)setAlbumInfo:(CLPhotoAssetAlbumInfo *)albumInfo {
    _albumInfo = albumInfo;
    
    self.firstImageView.image = albumInfo.AlbumFirstImage;
    self.nameLabel.text = albumInfo.AlbumName;
    self.countLabel.text = [NSString stringWithFormat:@"(%ld)",(long)albumInfo.photoNum];
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

 
}

@end
