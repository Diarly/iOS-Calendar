//
//  AttendanceCellInListViewCell.h
//  testList
//
//  Created by hiten on 2017/9/25.
//  Copyright © 2017年 hiten. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AttendanceCellInListViewCell;
@protocol AttendanceCellInListViewCellDelegate<NSObject>

- (void)cell:(AttendanceCellInListViewCell *)cell isShowMore:(BOOL)isShowMore;

@end

@interface AttendanceCellInListViewCell : UICollectionViewCell

@property (strong, nonatomic) id <AttendanceCellInListViewCellDelegate>delegate;
@property (strong, nonatomic) NSDictionary *info;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UIView *lineView;

+ (CGFloat)collectionRowHeightForCell:(NSString *)dateStr address:(NSString *)address;

@end
