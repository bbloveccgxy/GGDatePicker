//
//  ViewController.m
//  GGDatePickerDemo
//
//  Created by gxy on 2017/3/15.
//  Copyright © 2017年 GaoXinYuan. All rights reserved.
//

#import "ViewController.h"
#import "GGDatePicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Date" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(date) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(20, 40, 100, 30);
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"DateAndTime" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor redColor];
    [button1 addTarget:self action:@selector(dateAndTime) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(20, 90, 100, 30);
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"Time" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor redColor];
    [button2 addTarget:self action:@selector(time) forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(20, 140, 100, 30);
    [self.view addSubview:button2];
    
}

- (void)date{
    GGDatePicker *picker = [GGDatePicker createWithCompletion:^(NSString *string){
        NSLog(@"%@",string);
    }];
    picker.dateMode = GGDatePickerModeDate;
    picker.startYear(2017).startMonth(4).startDay(1);
    picker.endYear(2018).endMonth(3).endDay(2);
    [picker show];
}

- (void)dateAndTime {
    GGDatePicker *picker = [GGDatePicker createWithCompletion:^(NSString *string){
        NSLog(@"%@",string);
    }];
    picker.dateMode = GGDatePickerModeDateAndTime;
    picker.startYear(2017).startMonth(4).startDay(1).startHour(3).startMinute(20).startAM();
    picker.endYear(2018).endMonth(3).endDay(2).endHour(4).endMinute(15).endPM();
    [picker show];
}

- (void)time {
    GGDatePicker *picker = [GGDatePicker createWithCompletion:^(NSString *string){
        NSLog(@"%@",string);
    }];
    picker.dateMode = GGDatePickerModeTime;
    picker.startHour(3).startMinute(20).startAM();
    picker.endHour(4).endMinute(15).endPM();
    [picker show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
