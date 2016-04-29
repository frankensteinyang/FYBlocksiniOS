//
//  FYCalendarModel.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/29/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYCalendarModel.h"

@implementation FYCalendarModel

+ (FYCalendarModel *)calendarModelWithYear:(NSNumber*)year withMonth:(NSNumber*)month withDay:(NSNumber*)day withPrice:(NSNumber*)price withCount:(NSNumber*)count {
    FYCalendarModel * __autoreleasing m = [self new];
    m.year = year;
    m.month = month;
    m.day = day;
    m.price = price;
    m.count = count;
    return m;
}

@end
