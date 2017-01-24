//
//  CLScaleImageView.m
//  Image
//
//  Created by hezhijingwei on 2016/12/5.
//  Copyright © 2016年 hezhijingwei. All rights reserved.
//

#import "CLScaleImageView.h"
#import "CLPhotoAssetInfo.h"

@interface CLScaleImageView ()<UIScrollViewDelegate>

@property (nonatomic, copy) void(^tapHandle)(UITapGestureRecognizer *tap);
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;
@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;

@end


@implementation CLScaleImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (UIActivityIndicatorView *)indicatorView {
    
    if (!_indicatorView) {
        
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithFrame:self.frame];
        _indicatorView = view;
        _indicatorView.hidesWhenStopped = YES;
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [self addSubview:_indicatorView];
    }
    
    return _indicatorView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageFrame = frame;
        [self initialize];
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageFrame = frame;
        self.image = image;
        [self initialize];
        [self setup];
    }
    return self;
}



- (void)initialize {
    
    CGFloat width = self.imageFrame.size.width;
    CGFloat height = self.imageFrame.size.height;
    CGSize size = self.image.size;
    
    CGFloat heightRate = size.height/height;
    CGFloat widthRate  = size.width/width;
    
    if (heightRate > widthRate) {  // 这个是长图
        size = CGSizeMake(size.width*height/size.height, height);
    } else if (widthRate > heightRate) { // 这个是一般情况
        size = CGSizeMake(width, size.height*width/size.width);
    }
    self.imageView.frame = CGRectMake(0, 0, size.width, size.height);
    self.imageView.center = self.center;
    self.contentSize = size;
    self.imageSize = size;
    
}

- (void)setup {
    
    self.delegate = self;
    self.minimumZoomScale = 1;
    self.maximumZoomScale = 2;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.zoomScale = 1;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    tap.numberOfTapsRequired = 2;
    self.doubleTap = tap;
    self.imageView.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    
}

- (void)tapHandle:(UITapGestureRecognizer *)recongnizer {
    
    if (recongnizer.state == UIGestureRecognizerStateEnded) {
        
        // 获取点击位置
        CGPoint touchPoint=[recongnizer locationInView:recongnizer.view];
        // 是否是放大
        BOOL zoomOut = NO;
        
        // 如果图片是最小的就放大 否则缩小
        if (self.zoomScale == self.minimumZoomScale) {
        
            zoomOut = YES;
        }
        
        // 获取缩放的倍数
        CGFloat scale = self.minimumZoomScale;
        
        if (zoomOut) {
        
            scale = self.maximumZoomScale;
        
        }
        
        //
        [UIView animateWithDuration:0.3 animations:^{
            
            // 先放大 或者缩小 动画
            self.zoomScale=scale;
            // 放大的时候需要设置偏移量 目的是为了点击的位置放大
            if(zoomOut){
                
                CGFloat x = touchPoint.x*scale - self.bounds.size.width/2;
                CGFloat maxX = self.contentSize.width - self.bounds.size.width;
                CGFloat minX = 0;
                x = x > maxX ? maxX : x;
                x = x < minX ? minX : x;
                
                CGFloat y = touchPoint.y * scale - self.bounds.size.height/2;
                CGFloat maxY = self.contentSize.height - self.bounds.size.height;
                CGFloat minY = 0;
                y = y > maxY ? maxY : y;
                y = y < minY ? minY : y;
                
                self.contentOffset = CGPointMake(x, y);
            }
        }];
        
    }
    
    
}


- (void)addSingleTap:(void(^)(UITapGestureRecognizer *))callBack {
    
    self.tapHandle = callBack;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self addGestureRecognizer:tap];
    
    [tap requireGestureRecognizerToFail:self.doubleTap];
    
}

- (void)singleTap:(UITapGestureRecognizer *)tap {
    
    if (self.tapHandle) {
        self.tapHandle(tap);
    }
    
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.imageView;
    
}


//缩放后让图片显示到屏幕中间
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    CGSize originalSize= scrollView.bounds.size;
    CGSize contentSize= scrollView.contentSize;
    
    NSLog(@"%@",NSStringFromCGSize(originalSize)); // 经过打印发现scrollView 的size是没变化的
    NSLog(@"%@",NSStringFromCGSize(contentSize)); // 而scrollview的contentsize发生了变化
    NSLog(@"%@",NSStringFromCGSize(self.imageView.frame.size)); // 而imageView的size也发生了变化
    // 所以放大或者缩小时  就要调整图片的中心位置 不然会发现有部分图片显示不出来
    
    // 图片中心的偏移量
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;
    
    // 这个是图片缩放倍数大于1的情况
    if (originalSize.width > contentSize.width)
    {
        
        offsetX = (originalSize.width - contentSize.width)/2;
        
    }
    else
    {
        // 这个是图片缩放倍数小于等于1的情况
        offsetX = 0;
        
    }

    
    // 这个是图片缩放倍数大于1的情况
    if (originalSize.height > contentSize.height) {
        
        offsetY = (originalSize.height - contentSize.height)/2.0f;
        
    }
    else
    {
        // 这个是图片缩放倍数小于等于1的情况
        offsetY = 0;
        
    }
    
    CGFloat centerX = contentSize.width/2 + offsetX;
    CGFloat centerY = contentSize.height/2 + offsetY;
    
    self.imageView.center = CGPointMake(centerX, centerY);
}



- (UIImageView *)imageView {
    
    if (!_imageView) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
    }
    
    return _imageView;
}


//- (void)setBackImage:(NSString *)url placeholderImage:(UIImage *)image {
//    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:image options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//       
//        
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//        self.image = image;
//        
//    }];
//    
//    
//}


- (void)setLoadImage:(CLPhotoAssetInfo *)assetInfo {
    
        self.image = assetInfo.nomalImage;
        
        [CLLoadPhotoAsset largePhotoAssetInfoWithAssetCollection:assetInfo.asset resultHandle:^(UIImage *result) {

            if (result) {
                self.image = result;
            }
            
        } progress:^(double progress) {
            
            
        }];
    
    
}


- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
    CGFloat width = self.imageFrame.size.width;
    CGFloat height = self.imageFrame.size.height;
    CGSize size = image.size;
    
    CGFloat heightRate = size.height/height;
    CGFloat widthRate  = size.width/width;
    
    if (heightRate > widthRate) {  // 这个是长图
        
        size = CGSizeMake(size.width*height/size.height, height);
        
    } else if (widthRate > heightRate) { // 这个是一般情况
        
        size = CGSizeMake(width, size.height*width/size.width);
        
    } else {
        
        size = self.imageFrame.size;
        
    }
    
    self.imageView.frame = CGRectMake(0, 0, size.width, size.height);
    self.imageView.center = self.center;
    self.contentSize = size;
    self.imageSize = size;
}





/*
 *这个方法，默认没有做任何事情，需要子类进行重写 。 系统在很多时候会去调用这个方法： （当frame发生变化时会调用）
 *1.初始化不会触发layoutSubviews，但是如果设置了不为CGRectZero的frame的时候就会触发。
 *2.addSubview会触发layoutSubviews
 *3.设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 *4.滚动一个UIScrollView会触发layoutSubviews
 *5.旋转Screen会触发父UIView上的layoutSubviews事件
 *6.改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
}





@end
