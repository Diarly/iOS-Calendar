//
//  HTCalDayGridCell.m
//  testList
//
//  Created by hiten on 2017/10/12.
//  Copyright © 2017年 hiten. All rights reserved.
//

#import "HTCalDayGridCell.h"

@interface HTCalDayGridCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;

@end

@implementation HTCalDayGridCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 28/2;
    self.bgView.clipsToBounds = YES;
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CalendarSetting" ofType:@"bundle"];
    NSString *flagImagePath = [bundlePath stringByAppendingPathComponent:@"flag@2x.png"];
    self.flagImageView.image = [UIImage imageNamed:flagImagePath];
}

- (void)setModel:(GridCalModel *)model{
    
    _model = model;
    
    if (_model.isFillDay) {
        
        self.dayLabel.text = [NSString stringWithFormat:@"%ld",_model.day];
        
        
    }else{
        
        self.dayLabel.text = nil;
    }
    
    if (_model.isSelectedDefaultDay) {
        
        self.bgView.backgroundColor = [UIColor colorWithRed:97/255.0 green:183/255.0 blue:76/255.0 alpha:1.0];
        self.dayLabel.textColor = [UIColor whiteColor];
        
        
    }else{
        
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.dayLabel.textColor = [UIColor blackColor];
    }
    
    if (_model.attendances.count != 0) {
        
        self.flagImageView.hidden = NO;
        
    }else{
        
        self.flagImageView.hidden = YES;
    }
    
}

@end
