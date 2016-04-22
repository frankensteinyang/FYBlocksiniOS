//
//  FYCalendarAppearance.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/22/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYCalendarAppearance.h"
#import "FYCalendarDynamicHeader.h"
#import "UIView+FYExtension.h"

@interface FYCalendarAppearance ()

@property (weak  , nonatomic) FYCalendar *calendar;

@property (strong, nonatomic) NSMutableDictionary *backgroundColors;
@property (strong, nonatomic) NSMutableDictionary *titleColors;
@property (strong, nonatomic) NSMutableDictionary *subtitleColors;
@property (strong, nonatomic) NSMutableDictionary *borderColors;

@property (strong, nonatomic) NSString *titleFontName;
@property (strong, nonatomic) NSString *subtitleFontName;
@property (strong, nonatomic) NSString *weekdayFontName;
@property (strong, nonatomic) NSString *headerTitleFontName;

@property (assign, nonatomic) CGFloat titleFontSize;
@property (assign, nonatomic) CGFloat subtitleFontSize;
@property (assign, nonatomic) CGFloat weekdayFontSize;
@property (assign, nonatomic) CGFloat headerTitleFontSize;

@property (assign, nonatomic) CGFloat preferredTitleFontSize;
@property (assign, nonatomic) CGFloat preferredSubtitleFontSize;
@property (assign, nonatomic) CGFloat preferredWeekdayFontSize;
@property (assign, nonatomic) CGFloat preferredHeaderTitleFontSize;

@property (readonly, nonatomic) UIFont *preferredTitleFont;
@property (readonly, nonatomic) UIFont *preferredSubtitleFont;
@property (readonly, nonatomic) UIFont *preferredWeekdayFont;
@property (readonly, nonatomic) UIFont *preferredHeaderTitleFont;

- (void)adjustTitleIfNecessary;

- (void)invalidateFonts;
- (void)invalidateTextColors;
- (void)invalidateTitleFont;
- (void)invalidateSubtitleFont;
- (void)invalidateWeekdayFont;
- (void)invalidateHeaderFont;
- (void)invalidateTitleTextColor;
- (void)invalidateSubtitleTextColor;
- (void)invalidateWeekdayTextColor;
- (void)invalidateHeaderTextColor;

- (void)invalidateBorderColors;
- (void)invalidateFillColors;
- (void)invalidateEventColors;
- (void)invalidateCellShapes;

@end

@implementation FYCalendarAppearance

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _adjustsFontSizeToFitContentSize = YES;
        
        _titleFontSize = _preferredTitleFontSize  = FYCalendarStandardTitleTextSize;
        _subtitleFontSize = _preferredSubtitleFontSize = FYCalendarStandardSubtitleTextSize;
        _weekdayFontSize = _preferredWeekdayFontSize = FYCalendarStandardWeekdayTextSize;
        _headerTitleFontSize = _preferredHeaderTitleFontSize = FYCalendarStandardHeaderTextSize;
        
        _titleFontName = [UIFont systemFontOfSize:1].fontName;
        _subtitleFontName = [UIFont systemFontOfSize:1].fontName;
        _weekdayFontName = [UIFont systemFontOfSize:1].fontName;
        _headerTitleFontName = [UIFont systemFontOfSize:1].fontName;
        
        _headerTitleColor = FYCalendarStandardTitleTextColor;
        _headerDateFormat = @"MMMM yyyy";
        _headerMinimumDissolvedAlpha = 0.2;
        _weekdayTextColor = FYCalendarStandardTitleTextColor;
        _caseOptions = FYCalendarCaseOptionsHeaderUsesDefaultCase|FYCalendarCaseOptionsWeekdayUsesDefaultCase;
        
        _backgroundColors = [NSMutableDictionary dictionaryWithCapacity:5];
        _backgroundColors[@(FYCalendarCellStateNormal)]      = [UIColor clearColor];
        _backgroundColors[@(FYCalendarCellStateSelected)]    = FYCalendarStandardSelectionColor;
        _backgroundColors[@(FYCalendarCellStateDisabled)]    = [UIColor clearColor];
        _backgroundColors[@(FYCalendarCellStatePlaceholder)] = [UIColor clearColor];
        _backgroundColors[@(FYCalendarCellStateToday)]       = FYCalendarStandardTodayColor;
        
        _titleColors = [NSMutableDictionary dictionaryWithCapacity:5];
        _titleColors[@(FYCalendarCellStateNormal)]      = [UIColor blackColor];
        _titleColors[@(FYCalendarCellStateSelected)]    = [UIColor whiteColor];
        _titleColors[@(FYCalendarCellStateDisabled)]    = [UIColor grayColor];
        _titleColors[@(FYCalendarCellStatePlaceholder)] = [UIColor lightGrayColor];
        _titleColors[@(FYCalendarCellStateToday)]       = [UIColor whiteColor];
        
        _subtitleColors = [NSMutableDictionary dictionaryWithCapacity:5];
        _subtitleColors[@(FYCalendarCellStateNormal)]      = [UIColor darkGrayColor];
        _subtitleColors[@(FYCalendarCellStateSelected)]    = [UIColor whiteColor];
        _subtitleColors[@(FYCalendarCellStateDisabled)]    = [UIColor lightGrayColor];
        _subtitleColors[@(FYCalendarCellStatePlaceholder)] = [UIColor lightGrayColor];
        _subtitleColors[@(FYCalendarCellStateToday)]       = [UIColor whiteColor];
        
        _borderColors[@(FYCalendarCellStateSelected)] = [UIColor clearColor];
        _borderColors[@(FYCalendarCellStateNormal)] = [UIColor clearColor];
        
        _cellShape = FYCalendarCellShapeCircle;
        _eventColor = FYCalendarStandardEventDotColor;
        
        _borderColors = [NSMutableDictionary dictionaryWithCapacity:2];
        
    }
    return self;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    BOOL needsInvalidating = NO;
    if (![_titleFontName isEqualToString:titleFont.fontName]) {
        _titleFontName = titleFont.fontName;
        needsInvalidating = YES;
    }
    if (_titleFontSize != titleFont.pointSize) {
        _titleFontSize = titleFont.pointSize;
        needsInvalidating = YES;
    }
    if (needsInvalidating) {
        [self invalidateTitleFont];
    }
}

- (UIFont *)titleFont
{
    return [UIFont fontWithName:_titleFontName size:_titleFontSize];
}

- (void)setSubtitleFont:(UIFont *)subtitleFont
{
    BOOL needsInvalidating = NO;
    if (![_subtitleFontName isEqualToString:subtitleFont.fontName]) {
        _subtitleFontName = subtitleFont.fontName;
        needsInvalidating = YES;
    }
    if (_subtitleFontSize != subtitleFont.pointSize) {
        _subtitleFontSize = subtitleFont.pointSize;
        needsInvalidating = YES;
    }
    if (needsInvalidating) {
        [self invalidateSubtitleFont];
    }
}

- (UIFont *)subtitleFont
{
    return [UIFont fontWithName:_subtitleFontName size:_subtitleFontSize];
}

- (void)setWeekdayFont:(UIFont *)weekdayFont
{
    BOOL needsInvalidating = NO;
    if (![_weekdayFontName isEqualToString:weekdayFont.fontName]) {
        _weekdayFontName = weekdayFont.fontName;
        needsInvalidating = YES;
    }
    if (_weekdayFontSize != weekdayFont.pointSize) {
        _weekdayFontSize = weekdayFont.pointSize;
        needsInvalidating = YES;
    }
    if (needsInvalidating) {
        [self invalidateWeekdayFont];
    }
}

- (UIFont *)weekdayFont
{
    return [UIFont fontWithName:_weekdayFontName size:_weekdayFontSize];
}

- (void)setHeaderTitleFont:(UIFont *)headerTitleFont
{
    BOOL needsInvalidating = NO;
    if (![_headerTitleFontName isEqualToString:headerTitleFont.fontName]) {
        _headerTitleFontName = headerTitleFont.fontName;
        needsInvalidating = YES;
    }
    if (_headerTitleFontSize != headerTitleFont.pointSize) {
        _headerTitleFontSize = headerTitleFont.pointSize;
        needsInvalidating = YES;
    }
    if (needsInvalidating) {
        [self invalidateHeaderFont];
    }
}

- (void)setTitleVerticalOffset:(CGFloat)titleVerticalOffset
{
    if (_titleVerticalOffset != titleVerticalOffset) {
        _titleVerticalOffset = titleVerticalOffset;
        [_calendar.collectionView.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
    }
}

- (void)setSubtitleVerticalOffset:(CGFloat)subtitleVerticalOffset
{
    if (_subtitleVerticalOffset != subtitleVerticalOffset) {
        _subtitleVerticalOffset = subtitleVerticalOffset;
        [_calendar.collectionView.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
    }
}

- (UIFont *)headerTitleFont
{
    return [UIFont fontWithName:_headerTitleFontName size:_headerTitleFontSize];
}

- (void)setTitleDefaultColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FYCalendarCellStateNormal)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FYCalendarCellStateNormal)];
    }
    [self invalidateTitleTextColor];
}

- (UIColor *)titleDefaultColor
{
    return _titleColors[@(FYCalendarCellStateNormal)];
}

- (void)setTitleSelectionColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FYCalendarCellStateSelected)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FYCalendarCellStateSelected)];
    }
    [self invalidateTitleTextColor];
}

- (UIColor *)titleSelectionColor
{
    return _titleColors[@(FYCalendarCellStateSelected)];
}

- (void)setTitleTodayColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FYCalendarCellStateToday)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FYCalendarCellStateToday)];
    }
    [self invalidateTitleTextColor];
}

- (UIColor *)titleTodayColor
{
    return _titleColors[@(FYCalendarCellStateToday)];
}

- (void)setTitlePlaceholderColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FYCalendarCellStatePlaceholder)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FYCalendarCellStatePlaceholder)];
    }
    [self invalidateTitleTextColor];
}

- (UIColor *)titlePlaceholderColor
{
    return _titleColors[@(FYCalendarCellStatePlaceholder)];
}

- (void)setTitleWeekendColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FYCalendarCellStateWeekend)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FYCalendarCellStateWeekend)];
    }
    [self invalidateTitleTextColor];
}

- (UIColor *)titleWeekendColor
{
    return _titleColors[@(FYCalendarCellStateWeekend)];
}

- (void)setSubtitleDefaultColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(FYCalendarCellStateNormal)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(FYCalendarCellStateNormal)];
    }
    [self invalidateSubtitleTextColor];
}

-(UIColor *)subtitleDefaultColor
{
    return _subtitleColors[@(FYCalendarCellStateNormal)];
}

- (void)setSubtitleSelectionColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(FYCalendarCellStateSelected)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(FYCalendarCellStateSelected)];
    }
    [self invalidateSubtitleTextColor];
}

- (UIColor *)subtitleSelectionColor
{
    return _subtitleColors[@(FYCalendarCellStateSelected)];
}

- (void)setSubtitleTodayColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(FYCalendarCellStateToday)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(FYCalendarCellStateToday)];
    }
    [self invalidateSubtitleTextColor];
}

- (UIColor *)subtitleTodayColor
{
    return _subtitleColors[@(FYCalendarCellStateToday)];
}

- (void)setSubtitlePlaceholderColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(FYCalendarCellStatePlaceholder)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(FYCalendarCellStatePlaceholder)];
    }
    [self invalidateSubtitleTextColor];
}

- (UIColor *)subtitlePlaceholderColor
{
    return _subtitleColors[@(FYCalendarCellStatePlaceholder)];
}

- (void)setSubtitleWeekendColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(FYCalendarCellStateWeekend)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(FYCalendarCellStateWeekend)];
    }
    [self invalidateSubtitleTextColor];
}

- (UIColor *)subtitleWeekendColor
{
    return _subtitleColors[@(FYCalendarCellStateWeekend)];
}

- (void)setSelectionColor:(UIColor *)color
{
    if (color) {
        _backgroundColors[@(FYCalendarCellStateSelected)] = color;
    } else {
        [_backgroundColors removeObjectForKey:@(FYCalendarCellStateSelected)];
    }
    [self invalidateFillColors];
}

- (UIColor *)selectionColor
{
    return _backgroundColors[@(FYCalendarCellStateSelected)];
}

- (void)setTodayColor:(UIColor *)todayColor
{
    if (todayColor) {
        _backgroundColors[@(FYCalendarCellStateToday)] = todayColor;
    } else {
        [_backgroundColors removeObjectForKey:@(FYCalendarCellStateToday)];
    }
    [self invalidateFillColors];
}

- (UIColor *)todayColor
{
    return _backgroundColors[@(FYCalendarCellStateToday)];
}

- (void)setTodaySelectionColor:(UIColor *)todaySelectionColor
{
    if (todaySelectionColor) {
        _backgroundColors[@(FYCalendarCellStateToday|FYCalendarCellStateSelected)] = todaySelectionColor;
    } else {
        [_backgroundColors removeObjectForKey:@(FYCalendarCellStateToday|FYCalendarCellStateSelected)];
    }
    [self invalidateFillColors];
}

- (UIColor *)todaySelectionColor
{
    return _backgroundColors[@(FYCalendarCellStateToday|FYCalendarCellStateSelected)];
}

- (void)setEventColor:(UIColor *)eventColor
{
    if (![_eventColor isEqual:eventColor]) {
        _eventColor = eventColor;
        [self invalidateEventColors];
    }
}

- (void)setBorderDefaultColor:(UIColor *)color
{
    if (color) {
        _borderColors[@(FYCalendarCellStateNormal)] = color;
    } else {
        [_borderColors removeObjectForKey:@(FYCalendarCellStateNormal)];
    }
    [self invalidateBorderColors];
}

- (UIColor *)borderDefaultColor
{
    return _borderColors[@(FYCalendarCellStateNormal)];
}

- (void)setBorderSelectionColor:(UIColor *)color
{
    if (color) {
        _borderColors[@(FYCalendarCellStateSelected)] = color;
    } else {
        [_borderColors removeObjectForKey:@(FYCalendarCellStateSelected)];
    }
    [self invalidateBorderColors];
}

- (UIColor *)borderSelectionColor
{
    return _borderColors[@(FYCalendarCellStateSelected)];
}

- (void)setCellShape:(FYCalendarCellShape)cellShape
{
    if (_cellShape != cellShape) {
        _cellShape = cellShape;
        [self invalidateCellShapes];
    }
}

- (void)setWeekdayTextColor:(UIColor *)weekdayTextColor
{
    if (![_weekdayTextColor isEqual:weekdayTextColor]) {
        _weekdayTextColor = weekdayTextColor;
        [self invalidateWeekdayTextColor];
    }
}

- (void)setHeaderTitleColor:(UIColor *)color
{
    if (![_headerTitleColor isEqual:color]) {
        _headerTitleColor = color;
        [self invalidateHeaderTextColor];
    }
}

- (void)setHeaderMinimumDissolvedAlpha:(CGFloat)headerMinimumDissolvedAlpha
{
    if (_headerMinimumDissolvedAlpha != headerMinimumDissolvedAlpha) {
        _headerMinimumDissolvedAlpha = headerMinimumDissolvedAlpha;
        [_calendar.header.collectionView.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
        [_calendar.visibleStickyHeaders makeObjectsPerformSelector:@selector(setNeedsLayout)];
    }
}

- (void)setHeaderDateFormat:(NSString *)headerDateFormat
{
    if (![_headerDateFormat isEqual:headerDateFormat]) {
        _headerDateFormat = headerDateFormat;
        [_calendar invalidateHeaders];
    }
}

- (void)setAdjustsFontSizeToFitContentSize:(BOOL)adjustsFontSizeToFitContentSize
{
    if (_adjustsFontSizeToFitContentSize != adjustsFontSizeToFitContentSize) {
        _adjustsFontSizeToFitContentSize = adjustsFontSizeToFitContentSize;
        if (adjustsFontSizeToFitContentSize) {
            [self invalidateFonts];
        }
    }
}

- (UIFont *)preferredTitleFont
{
    return [UIFont fontWithName:_titleFontName size:_adjustsFontSizeToFitContentSize?_preferredTitleFontSize:_titleFontSize];
}

- (UIFont *)preferredSubtitleFont
{
    return [UIFont fontWithName:_subtitleFontName size:_adjustsFontSizeToFitContentSize?_preferredSubtitleFontSize:_subtitleFontSize];
}

- (UIFont *)preferredWeekdayFont
{
    return [UIFont fontWithName:_weekdayFontName size:_adjustsFontSizeToFitContentSize?_preferredWeekdayFontSize:_weekdayFontSize];
}

- (UIFont *)preferredHeaderTitleFont
{
    return [UIFont fontWithName:_headerTitleFontName size:_adjustsFontSizeToFitContentSize?_preferredHeaderTitleFontSize:_headerTitleFontSize];
}

- (void)adjustTitleIfNecessary
{
    if (!self.calendar.floatingMode) {
        if (_adjustsFontSizeToFitContentSize) {
            CGFloat factor       = (_calendar.scope==FYCalendarScopeMonth) ? 6 : 1.1;
            _preferredTitleFontSize       = _calendar.collectionView.fy_height/3/factor;
            _preferredTitleFontSize       -= (_preferredTitleFontSize-FYCalendarStandardTitleTextSize)*0.5;
            _preferredSubtitleFontSize    = _calendar.collectionView.fy_height/4.5/factor;
            _preferredSubtitleFontSize    -= (_preferredSubtitleFontSize-FYCalendarStandardSubtitleTextSize)*0.75;
            _preferredHeaderTitleFontSize = _preferredTitleFontSize * 1.25;
            _preferredWeekdayFontSize     = _preferredTitleFontSize;
            
        }
    } else {
        _preferredHeaderTitleFontSize = 20;
        if (FYCalendarDeviceIsIPad) {
            _preferredHeaderTitleFontSize = FYCalendarStandardHeaderTextSize * 1.5;
            _preferredTitleFontSize = FYCalendarStandardTitleTextSize * 1.3;
            _preferredSubtitleFontSize = FYCalendarStandardSubtitleTextSize * 1.15;
            _preferredWeekdayFontSize = _preferredTitleFontSize;
        }
    }
    
    // reload appearance
    [self invalidateFonts];
}

- (void)setCaseOptions:(FYCalendarCaseOptions)caseOptions
{
    if (_caseOptions != caseOptions) {
        _caseOptions = caseOptions;
        [_calendar invalidateWeekdaySymbols];
        [_calendar invalidateHeaders];
    }
}

- (void)invalidateAppearance
{
    [self invalidateFonts];
    [self invalidateTextColors];
    [self invalidateBorderColors];
    [self invalidateFillColors];
    /*
     [_calendar.collectionView.visibleCells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
     [_calendar invalidateAppearanceForCell:obj];
     }];
     [_calendar.header.collectionView.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
     [_calendar.visibleStickyHeaders makeObjectsPerformSelector:@selector(setNeedsLayout)];
     */
}

- (void)invalidateFonts
{
    [self invalidateTitleFont];
    [self invalidateSubtitleFont];
    [self invalidateWeekdayFont];
    [self invalidateHeaderFont];
}

- (void)invalidateTextColors
{
    [self invalidateTitleTextColor];
    [self invalidateSubtitleTextColor];
    [self invalidateWeekdayTextColor];
    [self invalidateHeaderTextColor];
}

- (void)invalidateBorderColors
{
    [_calendar.collectionView.visibleCells makeObjectsPerformSelector:_cmd];
}

- (void)invalidateFillColors
{
    [_calendar.collectionView.visibleCells makeObjectsPerformSelector:_cmd];
}

- (void)invalidateEventColors
{
    [_calendar.collectionView.visibleCells makeObjectsPerformSelector:_cmd];
}

- (void)invalidateCellShapes
{
    [_calendar.collectionView.visibleCells makeObjectsPerformSelector:_cmd];
}

- (void)invalidateTitleFont
{
    [_calendar.collectionView.visibleCells makeObjectsPerformSelector:_cmd];
}

- (void)invalidateSubtitleFont
{
    [_calendar.collectionView.visibleCells makeObjectsPerformSelector:_cmd];
}

- (void)invalidateTitleTextColor
{
    [_calendar.collectionView.visibleCells makeObjectsPerformSelector:_cmd];
}

- (void)invalidateSubtitleTextColor
{
    [_calendar.collectionView.visibleCells makeObjectsPerformSelector:_cmd];
}

- (void)invalidateWeekdayFont
{
    [_calendar invalidateWeekdayFont];
    [_calendar.visibleStickyHeaders makeObjectsPerformSelector:_cmd];
}

- (void)invalidateWeekdayTextColor
{
    [_calendar invalidateWeekdayTextColor];
    [_calendar.visibleStickyHeaders makeObjectsPerformSelector:_cmd];
}

- (void)invalidateHeaderFont
{
    [_calendar.header.collectionView.visibleCells makeObjectsPerformSelector:_cmd];
    [_calendar.visibleStickyHeaders makeObjectsPerformSelector:_cmd];
}

- (void)invalidateHeaderTextColor
{
    [_calendar.header.collectionView.visibleCells makeObjectsPerformSelector:_cmd];
    [_calendar.visibleStickyHeaders makeObjectsPerformSelector:_cmd];
}

@end

