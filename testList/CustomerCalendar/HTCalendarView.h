//
//  HTCalendarView.h
//  testList
//
//  Created by hiten on 2017/10/12.
//  Copyright © 2017年 hiten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+Calendar.h"
#import "GridCalModel.h"

@class HTCalendarView;
@protocol HTCalendarViewDataSource<NSObject>

- (NSArray *)additionalViewInfo:(HTCalendarView *)view;

@end

@protocol HTCalendarViewDelegate<NSObject>

- (void)calendarView:(HTCalendarView *)view didSelectedDate:(NSDate *)date calModel:(GridCalModel *)model;
- (void)calendarView:(HTCalendarView *)view didSelectedPreviousOrAfterDate:(NSDate *)date isPrevious:(BOOL)isPrevious;
- (void)calendarView:(HTCalendarView *)view viewHeight:(CGFloat)viewHeight;

@end

@interface HTCalendarView : UIView

@property (weak, nonatomic) id <HTCalendarViewDataSource>dataSource;
@property (weak, nonatomic) id <HTCalendarViewDelegate>delegate;

- (void)initialDate:(NSDate *)date;
- (void)updateData:(NSDate *)date;

@end
