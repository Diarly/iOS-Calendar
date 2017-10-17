//
//  AttendanceFooterReusableView.m
//  testList
//
//  Created by hiten on 2017/9/25.
//  Copyright © 2017年 hiten. All rights reserved.
//

#import "AttendanceFooterReusableView.h"

@interface AttendanceFooterReusableView()

@end

@implementation AttendanceFooterReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)showBtnPressed:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(reuseView:isNotShowMore:)]) {
        
        [self.delegate reuseView:self isNotShowMore:YES];
    }
}

@end
