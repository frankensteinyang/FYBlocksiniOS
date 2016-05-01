//
//  FYCalendarModel.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/29/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYCalendarModel : NSObject

@property (assign, nonatomic) NSInteger *year; // 年
@property (assign, nonatomic) NSInteger *month; // 月
@property (assign, nonatomic) NSInteger *day; // 天
@property (strong, nonatomic) NSString  *price; // 价格

+ (FYCalendarModel *)calendarModelWithYear:(NSInteger *)year withMonth:(NSInteger *)month withDay:(NSInteger *)day withPrice:(NSString *)price;

@end
