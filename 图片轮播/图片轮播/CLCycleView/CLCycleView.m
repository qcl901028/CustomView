//
//  CLCycleView.m
//  图片轮播
//
//  Created by hezhijingwei on 16/9/9.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "CLCycleView.h"
#import "CLPageControl.h"


@interface CLCycleView ()<UIScrollViewDelegate>


/**
 *  数据源
 */
@property (nonatomic ,strong) NSArray *dataSource;


/**
 *  图片轮播的间隔  duration 时间间隔 default is 3.0f second;
 */
@property (nonatomic ,assign) CGFloat duration;


/**
 * 定时器
 */
@property (nonatomic ,strong) NSTimer *timer;

/**
 *  页面控制器
 */
@property (nonatomic ,strong) CLPageControl *pageControl;

/**
 *  当前页
 */
@property (nonatomic, assign) NSInteger currentPage;

/**
 *  左侧的imageView
 */
@property (nonatomic ,strong) UIImageView *leftImageView;

/**
 *  中间的imageView
 */
@property (nonatomic ,strong) UIImageView *middleImageView;

/**
 *  右侧的imageView
 */
@property (nonatomic ,strong) UIImageView *rightImageView;

/**
 *  滚动视图
 */
@property (nonatomic ,strong) UIScrollView *scrollView;

@end


@implementation CLCycleView


- (instancetype)initWithFrame:(CGRect)frame duration:(CGFloat)duration imageArr:(NSArray<NSString *> *)imageArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (imageArr.count <= 2) {
           
            NSLog(@"ERROR:the count of imageArr is %ld, less than 3, please set it more than 3",imageArr.count);
            return nil;
        }
        
        
        self.dataSource = imageArr;
        self.duration = 3.0;
        
        
        if (self.duration <= 0) {
            self.duration = 3.0;
        } else {
            
            self.duration = duration;
        }

        [self addSubview:self.scrollView];

        [self.scrollView addSubview:self.leftImageView];
        [self.scrollView addSubview:self.middleImageView];
        [self.scrollView addSubview:self.rightImageView];
        [self createTimer];
        [self setPageControl];
        
    }
    return self;
}

/**
 *   创建scrollview
 *
 *  @return <#return value description#>
 */
- (UIScrollView *)scrollView {
    
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width*3, self.bounds.size.height);
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    
    return _scrollView;
}

/**
 *   创建左侧的imageView
 *
 *  @return <#return value description#>
 */
- (UIImageView *)leftImageView {
    
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _leftImageView.image = [UIImage imageNamed:[self.dataSource lastObject]];
    }
    
    return _leftImageView;
    
}

/**
 *   创建右侧的imageView
 *
 *  @return <#return value description#>
 */

- (UIImageView *)middleImageView {
    
    if (!_middleImageView) {
        _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    
        _middleImageView.image = [UIImage imageNamed:self.dataSource[0]];
        _middleImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [_middleImageView addGestureRecognizer:tap];
    }
    
    return _middleImageView;
}


/**
 *  当前点击的视图
 */
- (void)tap:(UITapGestureRecognizer *)tap {
    
            
    if (_delegate && [_delegate respondsToSelector:@selector(cycleViewDidSelected:)]) {
        [_delegate cycleViewDidSelected:self.currentPage];
    }
    
    if (self.cycleView) {
        self.cycleView(self.currentPage);
    }
    
    

    
    
}



/**
 *  创建中间的imageView
 *
 *  @return <#return value description#>
 */
- (UIImageView *)rightImageView {
    
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width*2, 0, self.bounds.size.width, self.bounds.size.height)];
        
        _rightImageView.image = [UIImage imageNamed:self.dataSource[1]];
    }
    
    return _rightImageView;
}


/**
 *  创建定时器
 */
- (void)createTimer {
    
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(timeStart) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    

}

/**
 *  定时器出发方法
 */
- (void)timeStart {
    
    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width*2, 0) animated:YES];
    
}

/**
 *  定时器摧毁
 */
- (void)invalidate {
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
}


/**
 *   这个是核心方法  主要逻辑都在这个代理方法中
 *
 *  @param scrollView <#scrollView description#>
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
   
    // 说明是向右滚动
    if (x == self.bounds.size.width *2 ) {
        
           self.currentPage ++;
        
        // 说明当前显示的是最后一张图片
        if (self.currentPage == self.dataSource.count-1)
        
        {

           _leftImageView.image = [UIImage imageNamed:self.dataSource[self.currentPage -1 ]];
           _middleImageView.image = [UIImage imageNamed:self.dataSource[self.currentPage]];
           _rightImageView.image = [UIImage imageNamed:self.dataSource[0]];

            
        }
        
        // 说明显示的第一张图片
        else if (self.currentPage == 0)
        {
            
           _leftImageView.image = [UIImage imageNamed:[self.dataSource lastObject]];
           _middleImageView.image = [UIImage imageNamed:self.dataSource[self.currentPage]];
           _rightImageView.image = [UIImage imageNamed:self.dataSource[self.currentPage + 1]];
            
        }
        
        else if (self.currentPage == self.dataSource.count)
        {
        
            _leftImageView.image = [UIImage imageNamed:self.dataSource[self.currentPage-1]];
            _middleImageView.image = [UIImage imageNamed:self.dataSource[0]];
            _rightImageView.image = [UIImage imageNamed:self.dataSource[1]];
            self.currentPage = 0;
        
        }
        
        
        else {
            
            
            _leftImageView.image = [UIImage imageNamed:self.dataSource[self.currentPage - 1]];
            _middleImageView.image = [UIImage imageNamed:self.dataSource[self.currentPage]];
            _rightImageView.image = [UIImage imageNamed:self.dataSource[self.currentPage + 1]];
            
            
        }
        

        self.pageControl.currentPage = self.currentPage;

        [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
    }
    
    // 说明向左滚动
    if (x == 0) {
        
        
        self.currentPage--;
        
        
        if (self.currentPage == -1)
        {
            _leftImageView.image = [UIImage imageNamed:self.dataSource[self.dataSource.count - 2]];
            _middleImageView.image = [UIImage imageNamed:[self.dataSource lastObject]];
            _rightImageView.image = [UIImage imageNamed:self.dataSource[0]];
            self.currentPage = self.dataSource.count - 1;
        }
        else if (self.currentPage == 0)
        {
        
            _leftImageView.image = [UIImage imageNamed:[self.dataSource lastObject]];
            _middleImageView.image = [UIImage imageNamed:self.dataSource[0]];
            _rightImageView.image = [UIImage imageNamed:self.dataSource[1]];
        
        }
        else if (self.currentPage == self.dataSource.count - 1)
        {
            _leftImageView.image = [UIImage imageNamed:self.dataSource[ self.currentPage - 1]];
            _middleImageView.image = [UIImage imageNamed:self.dataSource[self.currentPage]];
            _rightImageView.image = [UIImage imageNamed:self.dataSource[0]];
        
        }
        
        else {
        
            _leftImageView.image = [UIImage imageNamed:self.dataSource[self.currentPage - 1]];
            _middleImageView.image = [UIImage imageNamed:self.dataSource[self.currentPage]];
            _rightImageView.image = [UIImage imageNamed:self.dataSource[self.currentPage + 1]];
        
        }

        [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
         self.pageControl.currentPage = self.currentPage;
    }
   
}

/**
 *  当开始拖动scrollview的时候  把定时器摧毁
 *
 *  @param scrollView <#scrollView description#>
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self invalidate];
    
}

/**
 *  停止拖动时 把创建定时器
 *
 *  @param scrollView <#scrollView description#>
 */

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [self createTimer];
}


- (void)setPageControl {
    
    CGFloat kWidth = self.bounds.size.width;
    CGFloat kHeight = self.bounds.size.height;
    
    
    self.pageControl = [[CLPageControl alloc] initWithFrame:(CGRectMake(30, kHeight - 35, kWidth - 60, 30)) currentColor:self.currentPageIndicatorTintColor tintColor:self.pageIndicatorTintColor];
    self.pageControl.numberOfPages = self.dataSource.count ;
    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
}


- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    
    _pageControl.currentColor = currentPageIndicatorTintColor;
    
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    
    _pageControl.tintColor = pageIndicatorTintColor;
    _pageIndicatorTintColor = pageIndicatorTintColor;
    
}

- (void)setDiameter:(CGFloat)diameter {
    
    _diameter = diameter;
    _pageControl.diameter = diameter;
    
}

- (void)stop {
    
    [self invalidate];
    
}


- (void)start {
    
    [self createTimer];
    
}


@end
