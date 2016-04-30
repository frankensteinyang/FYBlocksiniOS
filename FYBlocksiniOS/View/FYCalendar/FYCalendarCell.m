//
//  FYCalendarCell.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/29/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "FYCalendarCell.h"
#import "FYCalendarUIDefine.h"

#define kFY_CALENDAR_CELL_PADDING (7.0f)
#define kFY_CALENDAR_CELL_HEIGHT (43.0f)

@interface FYCalendarCell ()

@property (strong, nonatomic) UILabel *dayLbl;
@property (strong, nonatomic) UILabel *priceLbl;
@property (strong, nonatomic) UIImageView *cellBackgroundView;

@end

@implementation FYCalendarCell

+ (CGFloat)height {
    
    return (FYCalendarCell_LB_HEIGHT) * 3.f +
            FYCalendarCell_LB_PADDING * 2.f +
            FYCalendarCell_PADDING * 2.f;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.dayLbl];
        [self addSubview:self.priceLbl];
        
//        [self.contentView addSubview:self.cellBackgroundView];
//        CGFloat top = 25; // 顶端盖高度
//        CGFloat bottom = 25 ; // 底端盖高度
//        CGFloat left = 10; // 左端盖宽度
//        CGFloat right = 10; // 右端盖宽度
//        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
//        // 指定为拉伸模式，伸缩后重新赋值
//        UIImage *image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
//        id vs = NSDictionaryOfVariableBindings(dayLbl, priceLbl);
//        
//        id ms = @{@"lbHeight":@(FYCalendarCell_LB_HEIGHT), @"lbPadding":@(FYCalendarCell_LB_PADDING)};
//        id cs1 = [NSLayoutConstraint constraintsWithVisualFormat:@"|[dayLbl]|" options:0 metrics:nil views:vs];
//        
//        id cs2 = [NSLayoutConstraint constraintsWithVisualFormat:@"|[priceLbl]|" options:0 metrics:nil views:vs];
//        
//        id cs4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dayLbl(lbHeight)]-lbPadding-[priceLbl(lbHeight)]" options:0 metrics:ms views:vs];
//        
//        // NSLayoutAttributeNotAnAttribute
//        id c = [NSLayoutConstraint constraintWithItem:priceLbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:dayLbl.superview attribute:NSLayoutAttributeCenterY multiplier:1.f constant:1.f];
//        
//        [self.contentView addConstraint:c];
//        [self.contentView addConstraints:cs1];
//        [self.contentView addConstraints:cs2];
//        [self.contentView addConstraints:cs4];
        
    }
    return self;
}

- (void)setContentWithDay:(NSString*)day withPrice:(NSString*)price {
    
    
         [self.contentView addSubview:self.cellBackgroundView];
    CGFloat top = 25; // 顶端盖高度
    CGFloat bottom = 25 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    UIImage *image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    _dayLbl.text = day;
    _priceLbl.text = price;
    
    _priceLbl.textColor = FYCalendarCell_PRICE_COLOR;
    _priceLbl.font = [UIFont systemFontOfSize:kFY_CALENDAR_CELL_PRICE_FONT_SIZE];
    
}

- (void)setContentWithDay:(NSString*)day {
    
    _dayLbl.text = @"";
    _priceLbl.text = day;
    
    _priceLbl.textColor = FYCalendarCell_DARE_COLOR_ONLY_DAY;
    _priceLbl.font = [UIFont systemFontOfSize:FYCalendarCell_LB_FONE_SIZE_ONLY_DAY];
    
}

- (void)setContentEmpty {
    
    _dayLbl.text = @"";
    _priceLbl.text = @"";
    
}

#pragma mark - 约束
- (void)makeConstraints {
    
    [self.dayLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
    }];
    
    [self.priceLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
    }];
}

#pragma mark - 懒加载

- (UIImageView *)cellBackgroundView {
    
    if (!_cellBackgroundView) {
        _cellBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Calender"]];
    }
    return _cellBackgroundView;
    
}

- (UILabel *)dayLbl {
    
    if (!_dayLbl) {
        _dayLbl = [[UILabel alloc] init];
        [_dayLbl setBackgroundColor:[UIColor redColor]];
        _dayLbl.textColor = kFY_CALENDAR_CELL_DAY_COLOR;
    }
    return _dayLbl;
}

- (UILabel *)priceLbl {
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] init];
        [_dayLbl setBackgroundColor:[UIColor yellowColor]];
    }
    return _priceLbl;
    
}

@end
