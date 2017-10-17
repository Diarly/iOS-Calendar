//
//  NSDate+Calendar.m
//  testList
//
//  Created by hiten on 2017/10/13.
//  Copyright © 2017年 hiten. All rights reserved.
//

#import "NSDate+Calendar.h"

@implementation NSDate (Calendar)

+ (NSDate *)dateFromYear:(NSInteger)year month:(NSInteger)month{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setDay:1];
    [comp setMonth:month];
    [comp setYear:year];
    NSDate *date = [gregorian dateFromComponents:comp];
    return date;
}

+ (NSDate *)dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setDay:day];
    [comp setMonth:month];
    [comp setYear:year];
    NSDate *date = [gregorian dateFromComponents:comp];
    return date;
}

//获取日
- (NSInteger)day{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return components.day;
}

//获取月
- (NSInteger)month{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return components.month;
}

//获取年
- (NSInteger)year{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return components.year;
}

- (NSInteger)firstWeekdayInMonth{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday-1;
}

- (NSInteger)totalDaysInMonth{
    NSRange daysInMonthRange = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return daysInMonthRange.length;
}
@end
