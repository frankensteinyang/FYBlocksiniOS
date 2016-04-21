//
//  FYFareCalendarView.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/18/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FYFareCalendarViewArrowPosition)
{
    FYFareCalendarViewArrowPositionLeft = 0,
    FYFareCalendarViewArrowPositionMiddle,
    FYFareCalendarViewArrowPositionRight
};

@interface FYFareCalendarView : UIView

@property (nonatomic,copy)NSString *topLabelText;
@property (nonatomic,copy)NSString *bottomLabelText;

- (instancetype)initWithSideView:(UIView *)sideView
                   arrowPosition:(FYFareCalendarViewArrowPosition)arrowPosition;

- (void)showWithAnimation;

@end
