//
//  FYCalendar.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/28/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FYCalendarModel.h"
#import "FYCalendarLayout.h"
#import "FYCalendarCell.h"

@class FYCalendar;

@protocol FYCalendarDelegate <NSObject>
@optional

/**
 *  获取用于直接显示在只显示年月的header中lb的string
 *
 *  @param cview
 *  @param year  年
 *  @param month 月
 *
 *  @return 需要显示的年月string，返回nil为使用默认
 */
- (NSString*)calendar:(FYCalendar *)cview headerLabelStringWithYear:(NSString*)year withMonth:(NSString*)month;

@end

@interface FYCalendar : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) id<FYCalendarDelegate> calendarDelegate;
@property (copy, nonatomic) NSArray *datas; // FYCalendarModel

/**
 *  创建一个价格日历
 *
 *  @return 价格日历
 */
+ (instancetype)calendarPriceView;

+ (instancetype)calendarPriceViewWithToday:(NSDate*)today;

+ (instancetype)calendarPriceViewWithTodayOfYear:(int)year ofMonth:(int)month ofDay:(int)day;

- (void)setTodayWithYear:(int)year withMonth:(int)month withDay:(int)day;

@end
