//
//  FYCalendarDynamicHeader.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/22/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//  动态头文件

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "FYCalendar.h"
#import "FYCalendarCell.h"
#import "FYCalendarHeader.h"
#import "FYCalendarStickyHeader.h"

@interface FYCalendar (Dynamic)

@property (readonly, nonatomic) CAShapeLayer *maskLayer;
@property (readonly, nonatomic) FYCalendarHeader *header;
@property (readonly, nonatomic) UICollectionView *collectionView;
@property (readonly, nonatomic) UICollectionViewFlowLayout *collectionViewLayout;
@property (readonly, nonatomic) NSArray *weekdays;
@property (readonly, nonatomic) BOOL ibEditing;
@property (readonly, nonatomic) BOOL floatingMode;
@property (readonly, nonatomic) NSArray *visibleStickyHeaders;
@property (readonly, nonatomic) CGFloat preferredHeaderHeight;
@property (readonly, nonatomic) CGFloat preferredWeekdayHeight;
@property (readonly, nonatomic) CGFloat preferredRowHeight;
@property (readonly, nonatomic) UIView *bottomBorder;

@property (readonly, nonatomic) NSCalendar *calendar;
@property (readonly, nonatomic) NSDateComponents *components;
@property (readonly, nonatomic) NSDateFormatter *formatter;

@property (readonly, nonatomic) UIView *contentView;
@property (readonly, nonatomic) UIView *daysContainer;

@property (assign, nonatomic) BOOL needsAdjustingMonthPosition;
@property (assign, nonatomic) BOOL needsAdjustingViewFrame;

- (void)invalidateWeekdayFont;
- (void)invalidateWeekdayTextColor;

- (void)invalidateHeaders;
- (void)invalidateWeekdaySymbols;
- (void)invalidateAppearanceForCell:(FYCalendarCell *)cell;

- (NSDate *)dateForIndexPath:(NSIndexPath *)indexPath;
- (NSDate *)dateForIndexPath:(NSIndexPath *)indexPath scope:(FYCalendarScope)scope;
- (NSIndexPath *)indexPathForDate:(NSDate *)date;
- (NSIndexPath *)indexPathForDate:(NSDate *)date scope:(FYCalendarScope)scope;

- (NSInteger)numberOfHeadPlaceholdersForMonth:(NSDate *)month;

- (CGSize)sizeThatFits:(CGSize)size scope:(FYCalendarScope)scope;

@end

@interface FYCalendarAppearance (Dynamic)

@property (readwrite, nonatomic) FYCalendar *calendar;

@property (readonly, nonatomic) NSDictionary *backgroundColors;
@property (readonly, nonatomic) NSDictionary *titleColors;
@property (readonly, nonatomic) NSDictionary *subtitleColors;
@property (readonly, nonatomic) NSDictionary *borderColors;

@property (readonly, nonatomic) UIFont *preferredTitleFont;
@property (readonly, nonatomic) UIFont *preferredSubtitleFont;
@property (readonly, nonatomic) UIFont *preferredWeekdayFont;
@property (readonly, nonatomic) UIFont *preferredHeaderTitleFont;

- (void)adjustTitleIfNecessary;
- (void)invalidateFonts;

@end


@interface FYCalendarHeader (Dynamic)

@property (readonly, nonatomic) UICollectionView *collectionView;

@end
