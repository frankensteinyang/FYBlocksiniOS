//
//  FYCalendar.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/28/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "FYCalendar.h"

#define kFY_WEEK_VIEW_FONTCOLOR ([UIColor colorWithRed:173/256.0  green:173/256.0 blue:173/256.0 alpha:1])

@interface FYCalendar ()

@property (nonatomic, strong) UIView *weekView;
@property (nonatomic, strong) UILabel *weekLbl;

@end

@implementation FYCalendar

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        [self assembly];
    }
    
    return self;
}

- (void)assembly {
    
    [self addSubview:self.weekView];
    [_weekView addSubview:self.weekLbl];
    NSArray *textArray = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
    for (int i = 0; i < textArray.count; i++) {
//        [self initHeaderWeekText:textArray[i] titleColor:kFY_WEEK_VIEW_FONTCOLOR x:CATDayLabelWidth * i y:yOffset];
    }
    
    
    [self makeConstraints];
}

- (void)weekViewSetup {
    
    _weekView.clipsToBounds = YES;
//    UILabel *masterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 10.0f, headerWidth, 30.f)];
//    [masterLabel setTextAlignment:NSTextAlignmentCenter];
//    [masterLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]];
//    self.masterLabel = masterLabel;
//    self.masterLabel.textColor = COLOR_THEME;
//    [self addSubview:self.masterLabel];
//    CGFloat yOffset = 45.0f;
//    NSArray *textArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
//    for (int i = 0; i < textArray.count; i++) {
//        [self initHeaderWeekText:textArray[i] titleColor:COLOR_THEME x:CATDayLabelWidth * i y:yOffset];
//    }
    
}

#pragma mark - 懒加载

- (UIView *)weekView {
    
    if (!_weekView) {
        _weekView = [[UIView alloc] init];
    }
    return _weekView;
}

- (UILabel *)weekLbl {
    
    if (!_weekLbl) {
        _weekLbl = [[UILabel alloc] init];
    }
    return _weekLbl;
}

- (void)makeConstraints {
    
    [_weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(12);
    }];

}

@end
