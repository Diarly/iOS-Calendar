//
//  AttendanceListViewCell.h
//  testList
//
//  Created by hiten on 2017/9/25.
//  Copyright © 2017年 hiten. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendanceListViewCell : UITableViewCell

@property (strong, nonatomic) NSArray *list;

+ (NSString *)reuseId;
+ (CGFloat)rowHeightForCell:(NSArray *)list;

@end
