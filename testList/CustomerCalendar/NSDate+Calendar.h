//
//  NSDate+Calendar.h
//  testList
//
//  Created by hiten on 2017/10/13.
//  Copyright © 2017年 hiten. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)

//转换给定的年 月为标准时间
+ (NSDate *)dateFromYear:(NSInteger)year month:(NSInteger)month;
//转换给定的年 月 日为标准时间
+ (NSDate *)dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

//获取日
- (NSInteger)day;

//获取月
- (NSInteger)month;

//获取年
- (NSInteger)year;

//本月第一天是星期几
- (NSInteger)firstWeekdayInMonth;

//获取当月有多少天
- (NSInteger)totalDaysInMonth;

@end
