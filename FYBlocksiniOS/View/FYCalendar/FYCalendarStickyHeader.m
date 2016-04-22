//
//  FYCalendarStickyHeader.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/22/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYCalendarStickyHeader.h"
#import "UIView+FYExtension.h"
#import "FYCalendarDynamicHeader.h"

@interface FYCalendarStickyHeader ()

@property (weak, nonatomic) UIView *contentView;
@property (weak, nonatomic) UIView *separator;

@property (assign, nonatomic) BOOL needsAdjustingViewFrame;

@end

@implementation FYCalendarStickyHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _needsAdjustingViewFrame = YES;
        
        UIView *view;
        UILabel *label;
        
        view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
        self.contentView = view;
        
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [_contentView addSubview:label];
        self.titleLabel = label;
        
        view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.25];
        [_contentView addSubview:view];
        self.separator = view;
        
        NSMutableArray *weekdayLabels = [NSMutableArray arrayWithCapacity:7];
        for (int i = 0; i < 7; i++) {
            label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            [_contentView addSubview:label];
            [weekdayLabels addObject:label];
        }
        self.weekdayLabels = weekdayLabels.copy;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_needsAdjustingViewFrame) {
        
        _needsAdjustingViewFrame = NO;
        _contentView.frame = self.bounds;
        
        CGFloat weekdayWidth = self.fy_width / 7.0;
        CGFloat weekdayHeight = _calendar.preferredWeekdayHeight;
        CGFloat weekdayMargin = weekdayHeight * 0.1;
        CGFloat titleWidth = _contentView.fy_width;
        
        [_weekdayLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger index, BOOL *stop) { \
            label.frame = CGRectMake(index*weekdayWidth, _contentView.fy_height-weekdayHeight-weekdayMargin, weekdayWidth, weekdayHeight);
        }];
        
        CGFloat titleHeight = [@"1" sizeWithAttributes:@{NSFontAttributeName:_appearance.preferredHeaderTitleFont}].height*1.5 + weekdayMargin*3;
        
        _separator.frame = CGRectMake(0, _contentView.fy_height-weekdayHeight-weekdayMargin*2, _contentView.fy_width, 1.0);
        _titleLabel.frame = CGRectMake(0, _separator.fy_bottom-titleHeight-weekdayMargin, titleWidth,titleHeight);
        
    }
    
    [self reloadData];
}

#pragma mark - Properties

- (void)setCalendar:(FYCalendar *)calendar
{
    if (![_calendar isEqual:calendar]) {
        _calendar = calendar;
    }
    if (![_appearance isEqual:calendar.appearance]) {
        _appearance = calendar.appearance;
        [self invalidateHeaderFont];
        [self invalidateHeaderTextColor];
        [self invalidateWeekdayFont];
        [self invalidateWeekdayTextColor];
    }
}

#pragma mark - Public methods

- (void)reloadData
{
    [self invalidateWeekdaySymbols];
    _calendar.formatter.dateFormat = _appearance.headerDateFormat;
    BOOL usesUpperCase = (_appearance.caseOptions & 15) == FYCalendarCaseOptionsHeaderUsesUpperCase;
    NSString *text = [_calendar.formatter stringFromDate:_month];
    text = usesUpperCase ? text.uppercaseString : text;
    _titleLabel.text = text;
}

#pragma mark - Private methods

- (void)invalidateHeaderFont
{
    _titleLabel.font = _appearance.headerTitleFont;
}

- (void)invalidateHeaderTextColor
{
    _titleLabel.textColor = _appearance.headerTitleColor;
}

- (void)invalidateWeekdayFont
{
    [_weekdayLabels makeObjectsPerformSelector:@selector(setFont:) withObject:_appearance.weekdayFont];
}

- (void)invalidateWeekdayTextColor
{
    [_weekdayLabels makeObjectsPerformSelector:@selector(setTextColor:) withObject:_appearance.weekdayTextColor];
}

- (void)invalidateWeekdaySymbols
{
    BOOL useVeryShortWeekdaySymbols = (_appearance.caseOptions & (15<<4) ) == FYCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    NSArray *weekdaySymbols = useVeryShortWeekdaySymbols ? _calendar.calendar.veryShortStandaloneWeekdaySymbols : _calendar.calendar.shortStandaloneWeekdaySymbols;
    BOOL useDefaultWeekdayCase = (_appearance.caseOptions & (15<<4) ) == FYCalendarCaseOptionsWeekdayUsesDefaultCase;
    [_weekdayLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger index, BOOL *stop) {
        index += _calendar.firstWeekday-1;
        index %= 7;
        label.text = useDefaultWeekdayCase ? weekdaySymbols[index] : [weekdaySymbols[index] uppercaseString];
    }];
}

@end
