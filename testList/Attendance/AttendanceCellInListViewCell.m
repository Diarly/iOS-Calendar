//
//  AttendanceCellInListViewCell.m
//  testList
//
//  Created by hiten on 2017/9/25.
//  Copyright © 2017年 hiten. All rights reserved.
//

#import "AttendanceCellInListViewCell.h"

@interface AttendanceCellInListViewCell()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@end

@implementation AttendanceCellInListViewCell

@synthesize dateLabel;
@synthesize addressLabel;


+ (CGFloat)collectionRowHeightForCell:(NSString *)dateStr address:(NSString *)address{
    
    CGFloat dateTextWidth = [UIScreen mainScreen].bounds.size.width - 15 - 12 - 10 - 15 - 19 - 10;
    CGFloat addressTextWidth = [UIScreen mainScreen].bounds.size.width - 15 - 11 - 10 - 15 - 19 - 10;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]};
    CGRect tempDateFrame = [dateStr boundingRectWithSize:CGSizeMake(dateTextWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    CGRect dateTextFrame = CGRectMake(15 + 12 + 10, 15, tempDateFrame.size.width, tempDateFrame.size.height);
    
    CGRect tempAddressFrame = [address boundingRectWithSize:CGSizeMake(addressTextWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    CGRect addressTextFrame = CGRectMake(15 + 11 + 10, CGRectGetMaxY(dateTextFrame) + 15, tempAddressFrame.size.width, tempAddressFrame.size.height);

    CGFloat rowHeight = CGRectGetMaxY(addressTextFrame) + 5 + 10 + 5;
    
    return rowHeight;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setInfo:(NSDictionary *)info{
    
    NSString *dateStr = info[@"createDate"];
    dateLabel.text = dateStr;
    NSString *addressStr = info[@"gpsAddress"];
    addressLabel.text = addressStr;
}

- (IBAction)showBtnPressed:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:isShowMore:)]) {
        
        [self.delegate cell:self isShowMore:YES];
    }
}

@end
