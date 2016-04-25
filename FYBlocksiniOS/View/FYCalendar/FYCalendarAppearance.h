//
//  FYCalendarAppearance.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/22/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYCalendarConstant.h"

typedef NS_ENUM(NSInteger, FYCalendarCellState) {
    FYCalendarCellStateNormal      = 0,
    FYCalendarCellStateSelected    = 1,
    FYCalendarCellStatePlaceholder = 1 << 1,
    FYCalendarCellStateDisabled    = 1 << 2,
    FYCalendarCellStateToday       = 1 << 3,
    FYCalendarCellStateWeekend     = 1 << 4,
    FYCalendarCellStateTodaySelected = FYCalendarCellStateToday|FYCalendarCellStateSelected
};

typedef NS_ENUM(NSUInteger, FYCalendarCellShape) {
    // 圆形
    FYCalendarCellShapeCircle    = 0,
    // 矩形
    FYCalendarCellShapeRectangle = 1
};

typedef NS_OPTIONS(NSUInteger, FYCalendarCaseOptions) {
    FYCalendarCaseOptionsHeaderUsesDefaultCase      = 0,
    FYCalendarCaseOptionsHeaderUsesUpperCase        = 1,
    
    FYCalendarCaseOptionsWeekdayUsesDefaultCase     = 0 << 4,
    FYCalendarCaseOptionsWeekdayUsesUpperCase       = 1 << 4,
    FYCalendarCaseOptionsWeekdayUsesSingleUpperCase = 2 << 4,
};

@interface FYCalendarAppearance : NSObject

/**
 * The font of the day text.
 *
 * @warning The size of font is adjusted by calendar size. To turn it off, set adjustsFontSizeToFitContentSize to NO;
 */
@property (strong, nonatomic) UIFont   *titleFont;

/**
 * The font of the subtitle text.
 *
 * @warning The size of font is adjusted by calendar size. To turn it off, set adjustsFontSizeToFitContentSize to NO;
 */
@property (strong, nonatomic) UIFont   *subtitleFont;

/**
 * The font of the weekday text.
 *
 * @warning The size of font is adjusted by calendar size. To turn it off, set adjustsFontSizeToFitContentSize to NO;
 */
@property (strong, nonatomic) UIFont   *weekdayFont;

/**
 * The font of the month text.
 *
 * @warning The size of font is adjusted by calendar size. To turn it off, set adjustsFontSizeToFitContentSize to NO;
 */
@property (strong, nonatomic) UIFont   *headerTitleFont;

/**
 * The vertical offset of the day text from default position.
 */
@property (assign, nonatomic) CGFloat  titleVerticalOffset;

/**
 * The vertical offset of the suntitle text from default position.
 */
@property (assign, nonatomic) CGFloat  subtitleVerticalOffset;

/**
 * The color of event dots.
 */
@property (strong, nonatomic) UIColor  *eventColor;

/**
 * The color of weekday text.
 */
@property (strong, nonatomic) UIColor  *weekdayTextColor;

/**
 * The color of month header text.
 */
@property (strong, nonatomic) UIColor  *headerTitleColor;

/**
 * The date format of the month header.
 */
@property (strong, nonatomic) NSString *headerDateFormat;

/**
 * The alpha value of month label staying on the fringes.
 */
@property (assign, nonatomic) CGFloat  headerMinimumDissolvedAlpha;

/**
 * The day text color for unselected state.
 */
@property (strong, nonatomic) UIColor  *titleDefaultColor;

/**
 * The day text color for selected state.
 */
@property (strong, nonatomic) UIColor  *titleSelectionColor;

/**
 * The day text color for today in the calendar.
 */
@property (strong, nonatomic) UIColor  *titleTodayColor;

/**
 * The day text color for days out of current month.
 */
@property (strong, nonatomic) UIColor  *titlePlaceholderColor;

/**
 * The day text color for weekend.
 */
@property (strong, nonatomic) UIColor  *titleWeekendColor;

/**
 * The subtitle text color for unselected state.
 */
@property (strong, nonatomic) UIColor  *subtitleDefaultColor;

/**
 * The subtitle text color for selected state.
 */
@property (strong, nonatomic) UIColor  *subtitleSelectionColor;

/**
 * The subtitle text color for today in the calendar.
 */
@property (strong, nonatomic) UIColor  *subtitleTodayColor;

/**
 * The subtitle text color for days out of current month.
 */
@property (strong, nonatomic) UIColor  *subtitlePlaceholderColor;

/**
 * The subtitle text color for weekend.
 */
@property (strong, nonatomic) UIColor  *subtitleWeekendColor;

/**
 * The fill color of the shape for selected state.
 */
@property (strong, nonatomic) UIColor  *selectionColor;

/**
 * The fill color of the shape for today.
 */
@property (strong, nonatomic) UIColor  *todayColor;

/**
 * The fill color of the shape for today and selected state.
 */
@property (strong, nonatomic) UIColor  *todaySelectionColor;

/**
 * The border color of the shape for unselected state.
 */
@property (strong, nonatomic) UIColor  *borderDefaultColor;

/**
 * The border color of the shape for selected state.
 */
@property (strong, nonatomic) UIColor  *borderSelectionColor;

/**
 * The shape appears when a day is selected or today.
 *
 * @see FYCalendarCellShape
 */
@property (assign, nonatomic) FYCalendarCellShape cellShape;

/**
 * The case options manage the case of month label and weekday symbols.
 *
 * @see FYCalendarCaseOptions
 */
@property (assign, nonatomic) FYCalendarCaseOptions caseOptions;

/**
 * A Boolean value indicates whether the calendar should adjust font size by its content size.
 *
 * @see titleFont
 * @see subtitleFont
 * @see weekdayFont
 * @see headerTitleFont
 */
@property (assign, nonatomic) BOOL adjustsFontSizeToFitContentSize;

#if TARGET_INTERFACE_BUILDER

// For preview only
@property (assign, nonatomic) BOOL      fakeSubtitles;
@property (assign, nonatomic) NSInteger fakedSelectedDay;

#endif

/**
 * Triggers an appearance update.
 */
- (void)invalidateAppearance;

@end
