//
//  CLAnimationModel.h
//  模仿淘宝选择购物车
//
//  Created by hezhijingwei on 2017/1/23.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CLAnimationModelType) {
    
    CLAnimationModelTypePresent,
    CLAnimationModelTypeDismiss
    
};


@interface CLAnimationModel : NSObject <UIViewControllerAnimatedTransitioning>

+ (CLAnimationModel *)animationModelWithModelType:(CLAnimationModelType)modelType height:(CGFloat)height;



@end
