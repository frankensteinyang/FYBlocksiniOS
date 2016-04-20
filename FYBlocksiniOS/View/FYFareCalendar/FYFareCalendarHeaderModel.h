//
//  FYFareCalendarHeaderModel.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/20/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYFareCalendarHeaderModel : NSObject

@property (nonatomic,copy)NSString *headerText;
@property (nonatomic,strong)NSArray *calendarItemArray;
@end

typedef NS_ENUM(NSInteger, FYFareCalendarType)
{
    FYFareCalendarTodayType = 0,
    FYFareCalendarLastType,
    FYFareCalendarNextType
};

@interface FYFareCalendarModel : NSObject

@property (nonatomic,assign)NSInteger year;
@property (nonatomic,assign)NSInteger month;
@property (nonatomic,assign)NSInteger day;
@property (nonatomic,copy)NSString *chineseCalendar;// 农历
@property (nonatomic,copy)NSString *holiday;// 节日
@property (nonatomic,assign)FYFareCalendarType type;
@property (nonatomic,assign)NSInteger dateInterval;// 日期的时间戳
@property (nonatomic,assign)NSInteger week;// 星期

@end
