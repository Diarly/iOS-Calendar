//
//  CustomerCalendarViewController.m
//  testList
//
//  Created by hiten on 2017/10/12.
//  Copyright © 2017年 hiten. All rights reserved.
//

#import "CustomerCalendarViewController.h"
#import "HTCalendarView.h"

@interface CustomerCalendarViewController ()<HTCalendarViewDelegate,HTCalendarViewDataSource>

@property (strong, nonatomic) HTCalendarView *calView;
@property (strong, nonatomic) NSMutableArray *sArray;
@end

@implementation CustomerCalendarViewController

@synthesize calView;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize boundsSize = [UIScreen mainScreen].bounds.size;
    CGRect calFrame = CGRectMake(0, self.view.bounds.origin.y + 70, boundsSize.width, 420);
    calView = [[HTCalendarView alloc] initWithFrame:calFrame];
    calView.delegate = self;
    calView.dataSource = self;
    [self.view addSubview:calView];
    
    NSDate *date = [NSDate date];
    [calView initialDate:date];
    
    self.sArray = [NSMutableArray array];
    [self fillData:date];
    [self.calView updateData:date];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fillData:(NSDate *)date{
    
    for (int i = 0; i < 25; i++) {
        
        GridCalModel *model = [[GridCalModel alloc] init];
        model.year = [date year];
        model.month = [date month];
        model.day = i + 1;
        
        if (i % 3 == 0) {
            
            [model.attendances addObject:@{@"address":@"dddddd"}];
        }
        [self.sArray addObject:model];
    }
}

- (NSArray *)additionalViewInfo:(HTCalendarView *)view{
    
    return self.sArray;
}

- (void)calendarView:(HTCalendarView *)view viewHeight:(CGFloat)viewHeight{
    
    CGSize boundsSize = [UIScreen mainScreen].bounds.size;
    CGRect calFrame = CGRectMake(0, self.view.bounds.origin.y + 70, boundsSize.width,viewHeight);
    calView.frame = calFrame;

}

- (void)calendarView:(HTCalendarView *)view didSelectedDate:(NSDate *)date calModel:(GridCalModel *)model{
    
    NSLog(@"date is:%@",date);
    
}
- (void)calendarView:(HTCalendarView *)view didSelectedPreviousOrAfterDate:(NSDate *)sdate isPrevious:(BOOL)isPrevious{
    
    __weak CustomerCalendarViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.calView updateData:sdate];
        });
    });
    
}



@end
