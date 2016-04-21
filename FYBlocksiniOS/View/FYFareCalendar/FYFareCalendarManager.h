//
//  FYFareCalendarManager.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/20/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FYFareCalendarViewController.h"

@interface FYFareCalendarManager : NSObject

- (instancetype)initWithStartDate:(NSInteger)startDate;
// 获取数据源
- (NSArray *)getCalendarDataSoruceWithLimitMonth:(NSInteger)limitMonth type:(FYFareCalendarViewControllerType)type;

@property (nonatomic,strong)NSIndexPath *startIndexPath;

@end
