//
//  FYCalendarStickyHeader.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/22/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FYCalendar, FYCalendarAppearance;

@interface FYCalendarStickyHeader : UICollectionReusableView

@property (weak, nonatomic) FYCalendar *calendar;
@property (weak, nonatomic) FYCalendarAppearance *appearance;

@property (weak, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) NSArray *weekdayLabels;
@property (strong, nonatomic) NSDate *month;

- (void)invalidateHeaderFont;
- (void)invalidateHeaderTextColor;
- (void)invalidateWeekdayFont;
- (void)invalidateWeekdayTextColor;

- (void)invalidateWeekdaySymbols;

@end
