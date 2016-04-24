//
//  FYCalendarFlowLayout.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/24/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FYCalendar;

typedef NS_ENUM(NSUInteger, FYCalendarScope);

@interface FYCalendarFlowLayout : UICollectionViewFlowLayout

@property (weak, nonatomic) FYCalendar *calendar;

@end
