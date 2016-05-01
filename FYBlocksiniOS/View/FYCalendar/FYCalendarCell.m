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
@property (strong, nonatomic) UIView *container;

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
        
        [self.container addSubview:self.dayLbl];
        [self.container addSubview:self.priceLbl];
        [self addSubview:self.container];
        
        [self makeConstraints];
        
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
    
    if ([day isEqualToString:@"18"]) {
        UIImage *image = [UIImage imageNamed:@"calendar_left"];
        [self.cellBackgroundView setImage:image];
        [self.priceLbl setTextColor:[UIColor whiteColor]];
        [self.dayLbl setTextColor:[UIColor whiteColor]];
        self.priceLbl.font = [UIFont boldSystemFontOfSize:kFY_CALENDAR_CELL_PRICE_FONT_SIZE];
    } else if ([day isEqualToString:@"23"]) {
        UIImage *image = [UIImage imageNamed:@"calendar_right"];
        [self.cellBackgroundView setImage:image];
        [self.priceLbl setTextColor:[UIColor whiteColor]];
        [self.dayLbl setTextColor:[UIColor whiteColor]];
        self.priceLbl.font = [UIFont boldSystemFontOfSize:kFY_CALENDAR_CELL_PRICE_FONT_SIZE];
    } else if ([day isEqualToString:@"19"] || [day isEqualToString:@"20"] || [day isEqualToString:@"21"] || [day isEqualToString:@"22"]) {
        // 56 x 43
        //    CGFloat top = 0; // 顶端盖高度
        //    CGFloat bottom = 0 ; // 底端盖高度
        //    CGFloat left = 0; // 左端盖宽度
        //    CGFloat right = 30; // 右端盖宽度
        //    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        [self.priceLbl setTextColor:[UIColor whiteColor]];
        [self.dayLbl setTextColor:[UIColor whiteColor]];
        UIImage *image = [UIImage imageNamed:@"Calender"];
        UIImage *clippedImg = [self imageFromImage:image inRect:CGRectMake(30, 30, 30, 30)];
        // 指定为拉伸模式，伸缩后重新赋值
        //    UIImage *resizedImage = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
        [self.cellBackgroundView setImage:clippedImg];
        self.priceLbl.font = [UIFont boldSystemFontOfSize:kFY_CALENDAR_CELL_PRICE_FONT_SIZE];
        
    }
    
    self.dayLbl.text = day;
    self.priceLbl.text = price;
    [self.contentView addSubview:self.cellBackgroundView];
    
    [self.cellBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
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
    
    [self.container mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(43);
    }];
    
    [self.dayLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.container).offset(2);
        make.centerX.equalTo(self.container);
    }];
    
    [self.priceLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dayLbl.mas_bottom).offset(3);
        make.centerX.equalTo(self.container);
    }];
}

#pragma mark - 懒加载

- (UIImageView *)cellBackgroundView {
    
    if (!_cellBackgroundView) {
        _cellBackgroundView = [[UIImageView alloc] init];
    }
    return _cellBackgroundView;
    
}

- (UILabel *)dayLbl {
    
    if (!_dayLbl) {
        _dayLbl = [[UILabel alloc] init];
        _dayLbl.textColor = kFY_CALENDAR_CELL_DAY_FONT_COLOR;
    }
    return _dayLbl;
}

- (UILabel *)priceLbl {
    
    if (!_priceLbl) {
        _priceLbl = [[UILabel alloc] init];
        _priceLbl.textColor = kFY_CALENDAR_CELL_PRICE_FONT_COLOR;
        _priceLbl.font = [UIFont systemFontOfSize:kFY_CALENDAR_CELL_PRICE_FONT_SIZE];
    }
    return _priceLbl;
    
}

- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

- (UIView *)container {
    
    if (!_container) {
        _container = [[UIView alloc] init];
    }
    return _container;
    
}

@end
