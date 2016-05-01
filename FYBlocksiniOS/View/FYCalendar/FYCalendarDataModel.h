//
//  FYCalendarDataModel.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/29/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYCalendarDataModel : NSObject

@property (strong, nonatomic) NSNumber *year;
@property (strong, nonatomic) NSNumber *month;
@property (strong, nonatomic) NSNumber *startWeek;
@property (strong, nonatomic) NSNumber *dayCount;
@property (strong, nonatomic) NSDictionary *models;

+ (NSArray *)calendarDataModelWithCalendarModel:(NSArray*)models;

@end
