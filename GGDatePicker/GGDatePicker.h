//
//  GGDatePicker.h
//  GGDatePickerDemo
//
//  Created by gxy on 2017/3/15.
//  Copyright © 2017年 GaoXinYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GGDatePickerMode) {
    GGDatePickerModeTime,
    GGDatePickerModeDate,
    GGDatePickerModeDateAndTime
};

typedef void(^Completion)(NSString *dateString);

@interface GGDatePicker : UIControl

+ (GGDatePicker*)createWithCompletion:(Completion)completion;

- (void)show;

/**
 Default is Date.
 */
@property (assign, nonatomic) GGDatePickerMode dateMode;

//-------------------------------------------------------------
typedef GGDatePicker* (^SetDate)(int value);

//Start date and time settings

@property (copy, nonatomic) SetDate startYear;

@property (copy, nonatomic) SetDate startMonth;

@property (copy, nonatomic) SetDate startDay;

@property (copy, nonatomic) SetDate startHour;

@property (copy, nonatomic) SetDate startMinute;

@property (copy, nonatomic) GGDatePicker* (^startAM)();

@property (copy, nonatomic) GGDatePicker* (^startPM)();

//End date and time settings

@property (copy, nonatomic) SetDate endYear;

@property (copy, nonatomic) SetDate endMonth;

@property (copy, nonatomic) SetDate endDay;

@property (copy, nonatomic) SetDate endHour;

@property (copy, nonatomic) SetDate endMinute;

@property (copy, nonatomic) GGDatePicker* (^endAM)();

@property (copy, nonatomic) GGDatePicker* (^endPM)();


@end
