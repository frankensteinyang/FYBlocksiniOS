//
//  FYCalendarEventIndicator.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/22/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYCalendarEventIndicator : UIView

@property (assign, nonatomic) NSInteger numberOfEvents;
@property (strong, nonatomic) id color;
@property (assign, nonatomic) BOOL needsAdjustingViewFrame;

@end
