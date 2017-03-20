//
//  GGDatePicker.m
//  GGDatePickerDemo
//
//  Created by gxy on 2017/3/15.
//  Copyright © 2017年 GaoXinYuan. All rights reserved.
//

#import "GGDatePicker.h"
#import "AppDelegate.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface GGDatePicker (){
    int start_year;
    int start_month;
    int start_day;
    int start_hour;
    int start_minute;
    int end_year;
    int end_month;
    int end_day;
    int end_hour;
    int end_minute;
}

@property (strong, nonatomic) UIButton *cancelButton;

@property (strong, nonatomic) UIButton *okButton;

@property (strong, nonatomic) UIDatePicker *datePicker;

@property (strong, nonatomic) Completion completionBlock;

@property (copy, nonatomic) NSString *start_am_pm;

@property (copy, nonatomic) NSString *end_am_pm;

@property (strong, nonatomic) NSDate *startDate;

@property (strong, nonatomic) NSDate *endDate;

@end

@implementation GGDatePicker

#pragma mark - Initializaztion

+ (GGDatePicker *)createWithCompletion:(Completion)completion {
    GGDatePicker *picker = [[GGDatePicker alloc] init];
    picker.completionBlock = completion;
    return picker;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addTarget:self action:@selector(dismissFromSuperview) forControlEvents:UIControlEventTouchUpInside];
        
        float backViewHeight = 250;
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-backViewHeight, ScreenWidth, backViewHeight)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        float buttonWidth = 50;
        float buttonHeight = 30;
        self.cancelButton.frame = CGRectMake(20, 5, buttonWidth, buttonHeight);
        self.okButton.frame = CGRectMake(ScreenWidth-buttonWidth-20, 5, buttonWidth, buttonHeight);
        
        [backView addSubview:self.cancelButton];
        [backView addSubview:self.okButton];
        
        self.datePicker.frame = CGRectMake(0, buttonHeight+10, ScreenWidth, backViewHeight-(buttonHeight+5));
        [backView addSubview:self.datePicker];
        
        start_year = 0;
        start_month = 0;
        start_day = 0;
        start_hour = 0;
        start_minute = 0;
        end_year = 0;
        end_month = 0;
        end_day = 0;
        end_hour = 0;
        end_minute = 0;
        self.start_am_pm = @"AM";
        self.end_am_pm = @"AM";
    }
    return self;
}

#pragma mark - Subviews
- (UIButton *)okButton {
    if (!_okButton) {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _okButton.layer.cornerRadius = 5;
        [_okButton setBackgroundColor:[UIColor colorWithRed:32.0/255 green:137.0/255 blue:212.0/255 alpha:1.0]];
        [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _okButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_okButton setTitle:@"确定" forState:UIControlStateNormal];
        [_okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.layer.cornerRadius = 5;
        [_cancelButton setBackgroundColor:[UIColor colorWithRed:32.0/255 green:137.0/255 blue:212.0/255 alpha:1.0]];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(dismissFromSuperview) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
    }
    return _datePicker;
}

#pragma mark - Button Action

- (void)okButtonAction:(id)sender {
    [self dismissFromSuperview];
    NSDate *date = self.datePicker.date;
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    switch (self.dateMode) {
        case GGDatePickerModeDate:
            [dateformatter setDateFormat:@"YYYY-M-d"];
            break;
        case GGDatePickerModeTime:
            [dateformatter setDateFormat:@"H:mm aa"];
            break;
        case GGDatePickerModeDateAndTime:
            [dateformatter setDateFormat:@"YYYY-M-d H:mm aa"];
            break;
        default:
            break;
    }
    NSString *locationString = [dateformatter stringFromDate:date];
    self.completionBlock(locationString);
}

#pragma mark - Setters and Getters

- (void)setDateMode:(GGDatePickerMode)dateMode {
    _dateMode = dateMode;
    if (_dateMode == GGDatePickerModeDate) {
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    else if (_dateMode == GGDatePickerModeDateAndTime) {
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    }
    else {
        _datePicker.datePickerMode = UIDatePickerModeTime;
    }
}

- (SetDate)startYear {
    __weak typeof(self) weakSelf = self;
    if (!_startYear) {
        _startYear = ^(int value) {
            start_year = value;
            return weakSelf;
        };
    }
    return _startYear;
}

- (SetDate)startMonth {
    __weak typeof(self) weakSelf = self;
    if (!_startMonth) {
        _startMonth = ^(int value) {
            start_month = value;
            return weakSelf;
        };
    }
    return _startMonth;
}

- (SetDate)startDay {
    __weak typeof(self) weakSelf = self;
    if (!_startDay) {
        _startDay = ^(int value) {
            start_day = value;
            return weakSelf;
        };
    }
    return _startDay;
}

- (SetDate)startHour {
    __weak typeof(self) weakSelf = self;
    if (!_startHour) {
        _startHour = ^(int value) {
            start_hour = value;
            return weakSelf;
        };
    }
    return _startHour;
}

- (SetDate)startMinute {
    __weak typeof(self) weakSelf = self;
    if (!_startMinute) {
        _startMinute = ^(int value) {
            start_minute = value;
            return weakSelf;
        };
    }
    return _startMinute;
}

- (GGDatePicker *(^)())startAM {
    __weak typeof(self) weakSelf = self;
    if (!_startAM) {
        _startAM = ^() {
            weakSelf.start_am_pm = @"AM";
            return weakSelf;
        };
    }
    return _startAM;
}

- (GGDatePicker *(^)())startPM {
    __weak typeof(self) weakSelf = self;
    if (!_startPM) {
        _startPM = ^() {
            weakSelf.start_am_pm = @"PM";
            return weakSelf;
        };
    }
    return _startPM;
}

- (SetDate)endYear {
    __weak typeof(self) weakSelf = self;
    if (!_endYear) {
        _endYear = ^(int value) {
            end_year = value;
            return weakSelf;
        };
    }
    return _endYear;
}

- (SetDate)endMonth {
    __weak typeof(self) weakSelf = self;
    if (!_endMonth) {
        _endMonth = ^(int value) {
            end_month = value;
            return weakSelf;
        };
    }
    return _endMonth;
}

- (SetDate)endDay {
    __weak typeof(self) weakSelf = self;
    if (!_endDay) {
        _endDay = ^(int value) {
            end_day = value;
            return weakSelf;
        };
    }
    return _endDay;
}

- (SetDate)endHour {
    __weak typeof(self) weakSelf = self;
    if (!_endHour) {
        _endHour = ^(int value) {
            end_hour = value;
            return weakSelf;
        };
    }
    return _endHour;
}

- (SetDate)endMinute {
    __weak typeof(self) weakSelf = self;
    if (!_endMinute) {
        _endMinute = ^(int value) {
            end_minute = value;
            return weakSelf;
        };
    }
    return _endMinute;
}

- (GGDatePicker *(^)())endAM {
    __weak typeof(self) weakSelf = self;
    if (!_endAM) {
        _endAM = ^() {
            weakSelf.end_am_pm = @"AM";
            return weakSelf;
        };
    }
    return _endAM;
}

- (GGDatePicker *(^)())endPM {
    __weak typeof(self) weakSelf = self;
    if (!_endPM) {
        _endPM = ^() {
            weakSelf.end_am_pm = @"PM";
            return weakSelf;
        };
    }
    return _endPM;
}

//---------------------------------------------------------------------------------------------------

- (NSDate *)startDate {
    if (!_startDate) {
        
        switch (self.dateMode) {
            case GGDatePickerModeDate:
            {
                BOOL isYear = start_year > 0 && start_year > 1900;
                BOOL isMonth = start_month > 0 && start_month < 13;
                BOOL isDay = start_day > 0 && start_day < 32;
                
                if (isYear && isMonth && isDay) {
                    NSString *dateString = [NSString stringWithFormat:@"%d-%d-%d",start_year,start_month,start_day];
                    NSDateFormatter *format=[[NSDateFormatter alloc] init];
                    [format setDateFormat:@"YYYY-M-d"];
                    _startDate = [format dateFromString:dateString];
                }
            }
                break;
            case GGDatePickerModeTime:
            {
                BOOL isHour = start_hour >= 0 && start_hour < 13;
                BOOL isMinute  = start_minute >= 0 && start_minute < 61;
                
                if (isHour && isMinute) {
                    NSString *dateString = [NSString stringWithFormat:@"%d:%d %@",start_hour,start_minute,self.start_am_pm];
                    NSDateFormatter *format=[[NSDateFormatter alloc] init];
                    [format setDateFormat:@"HH:mm aa"];
                    _startDate = [format dateFromString:dateString];
                }
            }
                break;
            case GGDatePickerModeDateAndTime:
            {
                BOOL isYear = start_year > 0 && start_year > 1900;
                BOOL isMonth = start_month > 0 && start_month < 13;
                BOOL isDay = start_day > 0 && start_day < 32;
                BOOL isHour = start_hour >= 0 && start_hour < 13;
                BOOL isMinute  = start_minute >= 0 && start_minute < 61;
                
                if (isYear && isMonth && isDay && isHour && isMinute) {
                    NSString *dateString = [NSString stringWithFormat:@"%d-%d-%d %d:%d %@",start_year,start_month,start_day,start_hour,start_minute,self.start_am_pm];
                    NSDateFormatter *format=[[NSDateFormatter alloc] init];
                    [format setDateFormat:@"YYYY-M-d H:mm aa"];
                    _startDate = [format dateFromString:dateString];
                }
            }
                break;
            default:
                _startDate = nil;
                break;
        }
    }
    return _startDate;
}

- (NSDate *)endDate {
    if (!_endDate) {
        
        switch (self.dateMode) {
            case GGDatePickerModeDate:
            {
                BOOL isYear = end_year >= start_year;
                
                BOOL isMonth;
                if (end_year == start_year) {
                    isMonth = end_month >= start_month && end_month < 13;
                }else {
                    isMonth = end_month > 0 && end_month < 13;
                }
                
                BOOL isDay;
                if (end_year == start_year && end_month == start_month) {
                    isDay = end_day > start_day && end_day < 32;
                }
                else {
                    isDay = end_day > 0 && end_day < 32;
                }
                
                if (isYear && isMonth && isDay) {
                    NSString *dateString = [NSString stringWithFormat:@"%d-%d-%d",end_year,end_month,end_day];
                    NSDateFormatter *format=[[NSDateFormatter alloc] init];
                    [format setDateFormat:@"YYYY-M-d"];
                    _endDate = [format dateFromString:dateString];
                }
            }
                break;
            case GGDatePickerModeTime:
            {
                BOOL isHour = end_hour >= start_hour && end_hour < 13;
                
                BOOL isMinute;
                if (end_hour == start_hour) {
                    isMinute = end_minute > start_minute && end_minute < 61;
                }else {
                    isMinute = end_minute >= 0 && end_minute < 61;
                }
                
                if (isHour && isMinute) {
                    NSString *dateString = [NSString stringWithFormat:@"%d:%d %@",end_hour,end_minute,self.end_am_pm];
                    NSDateFormatter *format=[[NSDateFormatter alloc] init];
                    [format setDateFormat:@"H:mm aa"];
                    _endDate = [format dateFromString:dateString];
                }
            }
                break;
            case GGDatePickerModeDateAndTime:
            {
                BOOL isYear = end_year >= start_year;
                
                BOOL isMonth;
                if (end_year == start_year) {
                    isMonth = end_month >= start_month && end_month < 13;
                }else {
                    isMonth = end_month > 0 && end_month < 13;
                }
                
                BOOL isDay;
                if (end_year == start_year && end_month == start_month) {
                    isDay = end_day > start_day && end_day < 32;
                }
                else {
                    isDay = end_day > 0 && end_day < 32;
                }
                
                BOOL isHour;
                if (end_year == start_year && end_month == start_month && end_day == start_day) {
                    isHour = end_hour >= start_hour && end_hour < 13;
                }
                else {
                    isHour = end_hour >= 0 && end_hour < 13;
                }
                BOOL isMinute;
                if (end_year == start_year && end_month == start_month && end_day == start_day && end_hour == start_hour) {
                    isMinute = end_minute > start_minute && end_minute < 61;
                }
                else {
                    isMinute = end_minute >= 0 && end_minute < 61;
                }
                
                
                if (isYear && isMonth && isDay && isHour && isMinute) {
                    NSString *dateString = [NSString stringWithFormat:@"%d-%d-%d %d:%d %@",end_year,end_month,end_day,end_hour,end_minute,self.end_am_pm];
                    NSDateFormatter *format=[[NSDateFormatter alloc] init];
                    [format setDateFormat:@"YYYY-M-d H:mm aa"];
                    _endDate = [format dateFromString:dateString];
                }
            }
                break;
            default:
                _endDate = nil;
                break;
        }
    }
    return _endDate;
}
#pragma mark - Show and Dismiss self

- (void)dismissFromSuperview {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^(){
        weakSelf.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
    }];
    [self removeFromSuperview];
}

- (void)show {
    
    if (self.startDate) {
        _datePicker.minimumDate = self.startDate;
        _datePicker.date = self.startDate;
    }
    else {
        NSDate *minDate = [NSDate date];
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:minDate];
        NSDate *localDate = [minDate dateByAddingTimeInterval:interval];
        _datePicker.minimumDate = localDate;
        _datePicker.date = localDate;
    }
    
    if (self.endDate) {
        _datePicker.maximumDate = self.endDate;
    }
    
    self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
    AppDelegate* myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [myDelegate.window addSubview:self];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^(){
        weakSelf.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }];
}

@end
