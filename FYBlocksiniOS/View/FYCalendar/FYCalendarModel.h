//
//  FYCalendarModel.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/29/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FYCalendarDataSubModel.h"

@interface FYCalendarModel : FYCalendarDataSubModel

@property (copy, nonatomic) NSNumber *year; // 年
@property (copy, nonatomic) NSNumber *month; // 月

+ (FYCalendarModel *)calendarModelWithYear:(NSNumber*)year withMonth:(NSNumber*)month withDay:(NSNumber*)day withPrice:(NSNumber*)price;

@end
