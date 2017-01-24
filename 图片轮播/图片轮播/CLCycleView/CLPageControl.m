//
//  CLPageControl.m
//  图片轮播
//
//  Created by hezhijingwei on 16/9/9.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import "CLPageControl.h"

@interface CLPageControl ()


@end


@implementation CLPageControl


- (instancetype)initWithFrame:(CGRect)frame currentColor:(UIColor *)currentColor tintColor:(UIColor *)tintColor
{
    self = [super initWithFrame:frame];
    if (self) {
       
        if (currentColor == nil) {
            
            self.currentColor = [UIColor whiteColor];
            
        } else {
        
            self.currentColor = currentColor;
        
        }
        
        
        if (tintColor) {
           
            self.tintColor = tintColor;
            
        }
        else {
            
            self.tintColor = [UIColor grayColor];
            
        }
        
        
        
        
        
        
    }
    return self;
}




-(void) setCurrentPage:(NSInteger)page

{
    
    [super setCurrentPage:page];
    
    [self updateDots];
    
}

-(void) updateDots

{
    
    for (int i=0; i<[self.subviews count]; i++) {
        
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        CGSize size;
        
        if (self.diameter == 0) {
            self.diameter = 8.f;
        }
        
        if (self.diameter >15.0f) {
            self.diameter = 15.f;
        }
        
        
        dot.layer.masksToBounds = YES;
        dot.layer.cornerRadius = self.diameter/2.0;
        
        
        size.height = self.diameter;     //自定义圆点的大小
        size.width = self.diameter;      //自定义圆点的大小
        
        
        [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, size.width, size.width)];
 
        if (i==self.currentPage)
        {
            dot.backgroundColor = self.currentColor;
            
        }
        else
        {
            dot.backgroundColor = self.tintColor;
        }
        
    }

}





@end
