//
//  CLImitationTaoBao.h
//  CLLabel
//
//  Created by hezhijingwei on 2017/1/22.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CLImitationTaoBaoModelType) {
    CLImitationTaoBaoModelTypePresent,
    CLImitationTaoBaoModelTypeDismiss
};


@interface CLImitationTaoBao : NSObject <UIViewControllerAnimatedTransitioning>

+ (CLImitationTaoBao *)imitationTaoBao:(CLImitationTaoBaoModelType)modelType;


@end
