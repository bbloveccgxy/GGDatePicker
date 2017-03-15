# GGDatePicker
##Breif Introduction
A simple date picker<br>
##Usage
```objective-c
	GGDatePicker *picker = [GGDatePicker createWithCompletion:^(NSString *string){
        NSLog(@"%@",string);
    }];
    picker.dateMode = GGDatePickerModeDate;
    picker.startYear(2017).startMonth(4).startDay(1);
    picker.endYear(2018).endMonth(3).endDay(2);
    [picker show];
```
##Picker show
![Image has gone](https://github.com/bbloveccgxy/GGDatePicker/blob/master/Image/Image.png?raw=true "GGDatePicker")
##Problems
It seems that set hour and minutes has some problems, I will try to fix them in a few days. 

