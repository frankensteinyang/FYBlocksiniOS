//
//  FYCalendarModel.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/29/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYCalendarModel.h"

@implementation FYCalendarModel

+ (FYCalendarModel *)calendarModelWithYear:(NSInteger *)year withMonth:(NSInteger *)month withDay:(NSInteger *)day withPrice:(NSString *)price {
    
    FYCalendarModel * __autoreleasing m = [[self alloc] init];
    m.year = year;
    m.month = month;
    m.day = day;
    m.price = price;
    
    return m;
    
}

@end
