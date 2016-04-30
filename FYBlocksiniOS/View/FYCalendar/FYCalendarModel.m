//
//  FYCalendarModel.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/29/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYCalendarModel.h"

@implementation FYCalendarModel

+ (FYCalendarModel *)calendarModelWithYear:(NSNumber*)year withMonth:(NSNumber*)month withDay:(NSNumber*)day withPrice:(NSNumber*)price {
    
    FYCalendarModel * __autoreleasing m = [self new];
    m.year = year;
    m.month = month;
    m.day = day;
    m.price = price;
    
    return m;
    
}

@end
