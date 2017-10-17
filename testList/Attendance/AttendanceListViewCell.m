//
//  AttendanceListViewCell.m
//  testList
//
//  Created by hiten on 2017/9/25.
//  Copyright © 2017年 hiten. All rights reserved.
//

#import "AttendanceListViewCell.h"
#import "AttendanceCellInListViewCell.h"
#import "AttendanceFooterReusableView.h"
@interface AttendanceListViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,AttendanceFooterReusableViewDelegate,AttendanceCellInListViewCellDelegate>

@property (strong, nonatomic) UICollectionView *sCollectionView;
@property (assign, nonatomic) BOOL isNeedShowUpAndDownButton;
@property (assign, nonatomic) BOOL isDownButtonWillShow;
@property (strong, nonatomic) UILabel *infoLabel;
@property (strong, nonatomic) UILabel *contentLabel;

@end

@implementation AttendanceListViewCell

@synthesize sCollectionView;
@synthesize isNeedShowUpAndDownButton;
@synthesize isDownButtonWillShow;
@synthesize infoLabel;
@synthesize contentLabel;

+ (NSString *)reuseId{
    
    return @"AttendanceListViewCell";
}

+ (CGFloat)rowHeightForCell:(NSArray *)list{
    
    NSLog(@"listCount:%ld",list.count);
    return 400.0f;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 200, 20)];
        infoLabel.text = @"报销人考勤记录";
        infoLabel.textColor = [UIColor darkGrayColor];
        infoLabel.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:infoLabel];
        
        CGFloat contentX = [UIScreen mainScreen].bounds.size.width - 15 - 20;
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentX, 15, 20, 20)];
        contentLabel.text = @"无";
        contentLabel.textColor = [UIColor lightGrayColor];
        contentLabel.font = [UIFont systemFontOfSize:15.0f];
        contentLabel.hidden = YES;
        [self addSubview:contentLabel];
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        sCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        sCollectionView.backgroundColor = [UIColor whiteColor];
        sCollectionView.delegate = self;
        sCollectionView.dataSource = self;
        [sCollectionView registerNib:[UINib nibWithNibName:@"AttendanceCellInListViewCell" bundle:nil] forCellWithReuseIdentifier:@"AttendanceCellInListViewCell"];
        [sCollectionView registerNib:[UINib nibWithNibName:@"AttendanceFooterReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"AttendanceFooterReusableView"];
        [self addSubview:sCollectionView];
        
        isNeedShowUpAndDownButton = NO;
        isDownButtonWillShow = NO;
        
    }
    return self;
}

- (void)setList:(NSArray *)list{
    
    _list = list;
    if (_list.count == 0) {
        
        isNeedShowUpAndDownButton = NO;
        isDownButtonWillShow = NO;
        contentLabel.hidden = NO;
        
    }else if (_list.count == 1){
        
        isNeedShowUpAndDownButton = NO;
        isDownButtonWillShow = NO;
        contentLabel.hidden = YES;
        
    }else{
        
        isNeedShowUpAndDownButton = YES;
        isDownButtonWillShow = YES;
        contentLabel.hidden = YES;
        
    }
}

- (void)layoutSubviews{
    
    sCollectionView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [sCollectionView reloadData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (isNeedShowUpAndDownButton && isDownButtonWillShow) {
        
        return 1;
        
    }else{
        
        return self.list.count;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize boundsSize = [UIScreen mainScreen].bounds.size;
    NSDictionary *info = self.list[indexPath.row];
    NSString *dateStr = info[@"createDate"];
    NSString *address = info[@"gpsAddress"];
    CGFloat  rowHeight = [AttendanceCellInListViewCell collectionRowHeightForCell:dateStr address:address];
    return CGSizeMake(boundsSize.width, rowHeight);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (!isNeedShowUpAndDownButton) {
        
        return CGSizeMake(0, 0);
        
    }else{
        
        if (isDownButtonWillShow) {
            
            return CGSizeMake(0, 0);
            
        }else{
            
            CGSize boundsSize = [UIScreen mainScreen].bounds.size;
            return CGSizeMake(boundsSize.width, 50);
        }
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (!isNeedShowUpAndDownButton) {
        
        return nil;
    }else{
        
        if (isDownButtonWillShow) {
            
            return nil;
            
        }else{
            
            UICollectionReusableView *reusableView = nil;
            if (kind == UICollectionElementKindSectionFooter) {
                
                AttendanceFooterReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"AttendanceFooterReusableView" forIndexPath:indexPath];
                footerView.delegate = self;
                reusableView = footerView;
                
            }
            return reusableView;
        }
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AttendanceCellInListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AttendanceCellInListViewCell" forIndexPath:indexPath];
    NSDictionary *info = self.list[indexPath.row];
    cell.info = info;
    cell.delegate = self;
    
    if (!isNeedShowUpAndDownButton) {
        
        cell.showButton.hidden = YES;
        cell.lineView.hidden = YES;
        
    }else{
        
        if (isDownButtonWillShow) {
            
            cell.showButton.hidden = NO;
            cell.lineView.hidden = YES;
            
        }else{
            
            cell.showButton.hidden = YES;
            cell.lineView.hidden = NO;
        }
    }
    

    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)cell:(AttendanceCellInListViewCell *)cell isShowMore:(BOOL)isShowMore{
    
    if (isShowMore) {
        
        isDownButtonWillShow = NO;
        [self.sCollectionView reloadData];
    }
}

- (void)reuseView:(AttendanceFooterReusableView *)view isNotShowMore:(BOOL)isNotShowMore{
    
    if (isNotShowMore) {
        
        isDownButtonWillShow = YES;
        [self.sCollectionView reloadData];
    }
}

@end
