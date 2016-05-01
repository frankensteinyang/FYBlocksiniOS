//
//  FYCalendarDataModel.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/29/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYCalendarDataModel.h"
#import "FYCalendarModel.h"

@implementation FYCalendarDataModel

+ (NSArray *)calendarDataModelWithCalendarModel:(NSArray*)models {
    
    models = [models sortedArrayUsingComparator:^NSComparisonResult(FYCalendarModel *obj1, FYCalendarModel *obj2) {
        BOOL great = NO;
        if(obj1.year > obj2.year) {
            great = YES;
        } else if(obj1.year == obj2.year) {
            if(obj1.month > obj2.month) {
                great = YES;
            } else if(obj1.month ==obj2.month) {
                great = obj1.day >obj2.day;
            }
        }
        return great;
    }];
    
    NSMutableArray * __autoreleasing dms = [NSMutableArray new];
    FYCalendarModel *modelFirst = models.firstObject;
    FYCalendarModel *modelLast = models.lastObject;
    NSInteger fy = *(modelFirst.year);
    NSInteger fm = *(modelFirst.month);
    NSInteger ly = *(modelLast.year);
    NSInteger lm = *(modelLast.month);
    
    NSUInteger msIdx = 0;
    NSInteger msCount = models.count;
    NSCalendar *cd = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    dc.day = 1;
    for(NSInteger year=fy; year<=ly; year++) {
        dc.year = year;
        for(NSInteger month=fm; month<=lm; month++) {
            FYCalendarDataModel *dm = [FYCalendarDataModel new];
            dm.year = @(year);
            dm.month = @(month);
            
            dc.month = month;
            NSDate *d = [cd dateFromComponents:dc];
            
            NSDateComponents *resDc = [cd components:NSCalendarUnitWeekday fromDate:d];
            
            NSUInteger ds = [cd rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:d].length;
            dm.startWeek = @(resDc.weekday - 2);
            dm.dayCount = @(ds);
            NSMutableDictionary *dsms = [NSMutableDictionary new];
            while(msIdx<msCount) {
                FYCalendarModel *model = models[msIdx];
                if((model.year == &(year)) && (model.month == &(month))) {
                    ++msIdx;
                    
                    [dsms setObject:model forKey:[NSNumber numberWithInt:*(model.day)]];
                } else {
                    break;
                }
            }
            dm.models = dsms;
            [dms addObject:dm];
        }
    }
    
    return dms;
}

- (FYCalendarDataModel *)modelFromDay:(NSInteger)day {
    
    return _models.count ? _models[@(day)] : nil;
    
}

@end
