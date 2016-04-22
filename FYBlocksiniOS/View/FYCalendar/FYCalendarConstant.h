//
//  FYCalendarConstant.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/22/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#pragma mark - Constants

UIKIT_EXTERN CGFloat const FYCalendarStandardHeaderHeight;
UIKIT_EXTERN CGFloat const FYCalendarStandardWeekdayHeight;
UIKIT_EXTERN CGFloat const FYCalendarStandardMonthlyPageHeight;
UIKIT_EXTERN CGFloat const FYCalendarStandardWeeklyPageHeight;
UIKIT_EXTERN CGFloat const FYCalendarStandardCellDiameter;
UIKIT_EXTERN CGFloat const FYCalendarAutomaticDimension;
UIKIT_EXTERN CGFloat const FYCalendarDefaultBounceAnimationDuration;
UIKIT_EXTERN CGFloat const FYCalendarStandardRowHeight;
UIKIT_EXTERN CGFloat const FYCalendarStandardTitleTextSize;
UIKIT_EXTERN CGFloat const FYCalendarStandardSubtitleTextSize;
UIKIT_EXTERN CGFloat const FYCalendarStandardWeekdayTextSize;
UIKIT_EXTERN CGFloat const FYCalendarStandardHeaderTextSize;
UIKIT_EXTERN CGFloat const FYCalendarMaximumEventDotDiameter;

UIKIT_EXTERN NSInteger const FYCalendarDefaultHourComponent;

#if TARGET_INTERFACE_BUILDER
#define FYCalendarDeviceIsIPad NO
#else
#define FYCalendarDeviceIsIPad [[UIDevice currentDevice].model hasPrefix:@"iPad"]
#endif

#define FYCalendarStandardSelectionColor  FYColorRGBA(31,119,219,1.0)
#define FYCalendarStandardTodayColor      FYColorRGBA(198,51,42 ,1.0)
#define FYCalendarStandardTitleTextColor  FYColorRGBA(14,69,221 ,1.0)
#define FYCalendarStandardEventDotColor   FYColorRGBA(31,119,219,0.75)

#define FYColorRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#if CGFLOAT_IS_DOUBLE
#define FYCalendarFloor(c) floor(c)
#else
#define FYCalendarFloor(c) floorf(c)
#endif
