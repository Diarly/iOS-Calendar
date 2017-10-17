//
//  GridCalModel.h
//  testList
//
//  Created by hiten on 2017/10/13.
//  Copyright © 2017年 hiten. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GridCalModel : NSObject

@property (assign, nonatomic) NSInteger year;
@property (assign, nonatomic) NSInteger month;
@property (assign, nonatomic) NSInteger day;
@property (assign ,nonatomic) BOOL isFillDay;
@property (assign, nonatomic) BOOL isSelectedDefaultDay; //是否为默认日期
@property (strong, nonatomic) NSMutableArray *attendances; //考勤记录

- (id)init;

@end
