//
//  AttendanceFooterReusableView.h
//  testList
//
//  Created by hiten on 2017/9/25.
//  Copyright © 2017年 hiten. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AttendanceFooterReusableView;
@protocol AttendanceFooterReusableViewDelegate<NSObject>

- (void)reuseView:(AttendanceFooterReusableView *)view isNotShowMore:(BOOL)isNotShowMore;

@end

@interface AttendanceFooterReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) id <AttendanceFooterReusableViewDelegate>delegate;

@end
