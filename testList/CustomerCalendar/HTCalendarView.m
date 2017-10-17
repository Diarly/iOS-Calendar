//
//  HTCalendarView.m
//  testList
//
//  Created by hiten on 2017/10/12.
//  Copyright © 2017年 hiten. All rights reserved.
//

#import "HTCalendarView.h"
#import "HTCalDayGridCell.h"

#define CalSize [UIScreen mainScreen].bounds.size
#define ButtonPadding 12
#define ButtonWidth  32
#define ButtonHeight ButtonWidth
#define LabelHeight 30
#define WeekTitleHeight 31
#define DayCellPadding 2

@interface HTCalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UIView *topBgView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *previousButton;
@property (strong, nonatomic) UIButton *afterButton;
@property (strong, nonatomic) UIView *weekTitleView;
@property (strong, nonatomic) UICollectionView *daysCollectionView;
@property (strong, nonatomic) NSDate *selectedDate;  //选择的时间
@property (strong, nonatomic) NSMutableArray *cellArrays;
@property (assign, nonatomic) CGFloat viewHeight;

@end

@implementation HTCalendarView

@synthesize topBgView;
@synthesize titleLabel;
@synthesize previousButton;
@synthesize afterButton;
@synthesize weekTitleView;
@synthesize daysCollectionView;
@synthesize selectedDate;
@synthesize cellArrays;
@synthesize viewHeight;

- (void)initialization{
    
    topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.origin.y, CalSize.width, 44)];
    topBgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topBgView];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CalendarSetting" ofType:@"bundle"];
    NSString *previousImagePath = [bundlePath stringByAppendingPathComponent:@"before@2x.png"];
    NSString *afterImagePath = [bundlePath stringByAppendingPathComponent:@"after@2x.png"];
    
    previousButton = [[UIButton alloc] initWithFrame:CGRectMake(ButtonPadding, (topBgView.bounds.size.height - ButtonHeight)/2, ButtonWidth, ButtonHeight)];
    [previousButton setBackgroundImage:[UIImage imageNamed:previousImagePath] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(beforeBtnTouch:) forControlEvents:UIControlEventTouchDown];
    [previousButton setAdjustsImageWhenHighlighted:NO];
    [topBgView addSubview:previousButton];
    
    afterButton = [[UIButton alloc] initWithFrame:CGRectMake(CalSize.width - ButtonPadding - ButtonWidth, (topBgView.bounds.size.height - ButtonHeight)/2, ButtonWidth, ButtonHeight)];
    [afterButton setBackgroundImage:[UIImage imageNamed:afterImagePath] forState:UIControlStateNormal];
    [afterButton addTarget:self action:@selector(afterBtnTouch:) forControlEvents:UIControlEventTouchDown];
    [afterButton setAdjustsImageWhenHighlighted:NO];
    [topBgView addSubview:afterButton];
    
    CGFloat titleX = CGRectGetMaxX(previousButton.frame);
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX + ButtonPadding, (topBgView.bounds.size.height - LabelHeight)/2, topBgView.bounds.size.width - 2 *(titleX + ButtonPadding), LabelHeight)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [topBgView addSubview:titleLabel];
    
    CGFloat weekTitleY = CGRectGetMaxY(topBgView.frame);
    CGFloat weekTitleWidth = CGRectGetWidth(topBgView.frame);
    weekTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, weekTitleY, weekTitleWidth, 40)];
    weekTitleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:weekTitleView];
    
    NSArray *weekTitleArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    for (int i = 0; i < weekTitleArray.count; i++) {
        UILabel *weekTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(i * ((weekTitleWidth/(weekTitleArray.count))), (weekTitleView.bounds.size.height - WeekTitleHeight)/2, weekTitleWidth/(weekTitleArray.count ), WeekTitleHeight)];
        if (i == 0 || i == weekTitleArray.count - 1) {
#warning 设置星期的颜色
            weekTitleLable.textColor = [UIColor blackColor];
        }else{

            weekTitleLable.textColor = [UIColor blackColor];
        }
        weekTitleLable.text = [weekTitleArray objectAtIndex:i];
        weekTitleLable.textAlignment = NSTextAlignmentCenter;
        [weekTitleView addSubview:weekTitleLable];
    }
    
    CGFloat colY = CGRectGetMaxY(weekTitleView.frame);
    CGFloat colWidth = CGRectGetWidth(weekTitleView.frame);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = DayCellPadding;
    layout.minimumInteritemSpacing = DayCellPadding;
    daysCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, colY, colWidth, 300) collectionViewLayout:layout];
    daysCollectionView.backgroundColor = [UIColor whiteColor];
    daysCollectionView.delegate = self;
    daysCollectionView.dataSource = self;
    [daysCollectionView registerNib:[UINib nibWithNibName:@"HTCalDayGridCell" bundle:nil] forCellWithReuseIdentifier:@"HTCalDayGridCell"];
    [self addSubview:daysCollectionView];
}

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        [self initialization];
    }
    return self;
}

- (void)initialDate:(NSDate *)date{
    
    selectedDate = date;
    [self updateData:date];
}



#pragma mark -UICollectionView DataSource - Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return cellArrays.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat colWidth = CGRectGetWidth(daysCollectionView.frame);
    CGFloat cellWidth = (colWidth - DayCellPadding * 6) / 7;
    return CGSizeMake(cellWidth, cellWidth);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(DayCellPadding, 0, 0, 0);
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HTCalDayGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HTCalDayGridCell" forIndexPath:indexPath];
    GridCalModel *model = cellArrays[indexPath.row];
    cell.model = model;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GridCalModel *model = cellArrays[indexPath.row];
    for (GridCalModel *tempModel in cellArrays) {
        
        if ((tempModel.day == model.day) && (tempModel.year = model.year) && (tempModel.month == model.month)) {
            
            tempModel.isSelectedDefaultDay = YES;
        }else{
            
            tempModel.isSelectedDefaultDay = NO;
        }
    }
    selectedDate = [NSDate dateFromYear:model.year month:model.month day:model.day];
    [collectionView reloadData];

    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarView:didSelectedDate:calModel:)]) {
        
        [self.delegate calendarView:self didSelectedDate:selectedDate calModel:model];
    }
}


#pragma mark -Button Method
- (void)beforeBtnTouch:(UIButton *)sender{
    
    NSInteger year = [selectedDate year];
    NSInteger month = [selectedDate month];
    NSInteger day = [selectedDate day];
    
    NSInteger beforeMonth = month - 1;
    NSInteger beforeYear = year;
    NSInteger beforeDay = day;
    
    if (beforeMonth == 0) {
        
        beforeYear = beforeYear - 1;
        beforeMonth = 12;
    }
    
    NSDate *standardDate = [NSDate dateFromYear:beforeYear month:beforeMonth];
    if (beforeDay > [standardDate totalDaysInMonth]) {
        
        beforeDay = [standardDate totalDaysInMonth];
    }
    NSDate *beforeDate = [NSDate dateFromYear:beforeYear month:beforeMonth day:beforeDay];
    [self updateData:beforeDate];
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarView:didSelectedPreviousOrAfterDate:isPrevious:)]) {
        
        [self.delegate calendarView:self didSelectedPreviousOrAfterDate:beforeDate isPrevious:YES];
    }
    selectedDate = beforeDate;
    
}

- (void)afterBtnTouch:(UIButton *)sender{
    
    NSInteger year = [selectedDate year];
    NSInteger month = [selectedDate month];
    NSInteger day = [selectedDate day];
    
    NSInteger afterMonth = month + 1;
    NSInteger afterYear = year;
    NSInteger afterDay = day;
    
    if (afterMonth == 13) {
        
        afterYear = afterYear + 1;
        afterMonth = 1;
    }
    
    NSDate *standardDate = [NSDate dateFromYear:afterYear month:afterMonth];
    if (afterDay > [standardDate totalDaysInMonth]) {
        
        afterDay = [standardDate totalDaysInMonth];
    }
    NSDate *afterDate = [NSDate dateFromYear:afterYear month:afterMonth day:afterDay];
    [self updateData:afterDate];
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarView:didSelectedPreviousOrAfterDate:isPrevious:)]) {
        
        [self.delegate calendarView:self didSelectedPreviousOrAfterDate:afterDate isPrevious:NO];
    }
    selectedDate = afterDate;
}

#pragma mark - 更新数据
- (void)updateData:(NSDate *)date{
    
    [self updateTitle:date];
    [self fillCellData:date];
    
}

#pragma mark -更新标题
- (void)updateTitle:(NSDate *)date{
    
    NSInteger year = [date year];
    NSInteger month = [date month];
    NSInteger day = [date day];
    titleLabel.text = [NSString stringWithFormat:@"%ld年%ld月%ld日",year,month,day];
}

- (NSInteger)weekRowsInView:(NSDate *)date{
    
    NSInteger totalDays = [date totalDaysInMonth];
    NSInteger weekday = [date firstWeekdayInMonth];
    NSInteger weekRows = 0;
    
    if (weekday > 0) {
        
        weekRows += 1;
        totalDays -= (7 - weekday);
    }
    
    weekRows += totalDays/7;
    weekRows += (totalDays%7 > 0)?1:0;
    return weekRows;
}

- (void)updateCalFrame:(NSInteger)rows columns:(NSInteger)columns{
    
    CGFloat colWidth = CGRectGetWidth(daysCollectionView.frame);
    CGFloat cellWidth = (colWidth - DayCellPadding * 6) / 7;
    CGFloat colY = daysCollectionView.frame.origin.y;
    CGFloat colHeight = cellWidth *rows + DayCellPadding * (rows + 1);
    daysCollectionView.frame = CGRectMake(0, colY, colWidth, colHeight);
    viewHeight = CGRectGetMaxY(daysCollectionView.frame);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarView:viewHeight:)]) {
        
        [self.delegate calendarView:self viewHeight:viewHeight];
    }
    
}

- (void)fillCellData:(NSDate *)date{
    
    NSInteger rows = [self weekRowsInView:date];
    NSInteger columns = 7;
    [self updateCalFrame:rows columns:columns];
    cellArrays = [NSMutableArray arrayWithCapacity:rows * columns];
    NSInteger totalDays = [date totalDaysInMonth];
    
    //本月第一天是星期几
    NSInteger weekday = [date firstWeekdayInMonth];
    
    for (int i = 0; i < columns * rows; i++) {
        
        GridCalModel *model = [[GridCalModel alloc] init];
        if (i < weekday) {
            
            model.isFillDay = NO;
            
        }else if (i >= (totalDays+weekday)){
            
            model.isFillDay = NO;
            
        }else{
            
            model.year = [date year];
            model.month = [date month];
            model.day = i-weekday+1;
            model.isFillDay = YES;
            
            if (model.day == [date day]) {
                
                model.isSelectedDefaultDay = YES;
            }
            
            
        }
        [cellArrays addObject:model];
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(additionalViewInfo:)]) {
        
        NSArray *infos = [self.dataSource additionalViewInfo:self];
        
        for (GridCalModel *sourceModel in infos) {
            
            for (GridCalModel *targetModel in cellArrays) {
                
                if ((targetModel.year == sourceModel.year) && (targetModel.month == sourceModel.month) && (targetModel.day == sourceModel.day)) {
                    
                    targetModel.attendances = sourceModel.attendances;
                }
            }
        }
    }
    
    [self.daysCollectionView reloadData];
}

@end
