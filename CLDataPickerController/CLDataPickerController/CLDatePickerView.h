//
//  CLDatePickerView.h
//  CLDataPickerController
//
//  Created by hezhijingwei on 2016/12/26.
//  Copyright © 2016年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLDatePickerView;

@protocol CLDatePickerViewDelegate <NSObject>

- (void)datePickerView:(CLDatePickerView *)datePickerView didSelectedItem:(NSString *)year month:(NSString *)month;

@end

@interface CLDatePickerView : UIView

@property (nonatomic, weak) id<CLDatePickerViewDelegate> delegate;


@end
