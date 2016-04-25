//
//  FYCalendarAnimator.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/25/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FYCalendar.h"
#import "FYCalendarFlowLayout.h"
#import "FYCalendarCollectionView.h"
#import "FYCalendarDynamicHeader.h"

typedef NS_ENUM(NSUInteger, FYCalendarTransition) {
    FYCalendarTransitionNone,
    FYCalendarTransitionMonthToWeek,
    FYCalendarTransitionWeekToMonth
};

typedef NS_ENUM(NSUInteger, FYCalendarTransitionState) {
    FYCalendarTransitionStateIdle,
    FYCalendarTransitionStateInProgress
};

@interface FYCalendarAnimator : NSObject

@property (weak, nonatomic) FYCalendar *calendar;
@property (weak, nonatomic) FYCalendarCollectionView *collectionView;
@property (weak, nonatomic) FYCalendarFlowLayout *collectionViewLayout;

@property (assign, nonatomic) FYCalendarTransition transition;
@property (assign, nonatomic) FYCalendarTransitionState state;

- (void)performScopeTransitionFromScope:(FYCalendarScope)fromScope toScope:(FYCalendarScope)toScope animated:(BOOL)animated;
- (void)performBoudingRectTransitionFromMonth:(NSDate *)fromMonth toMonth:(NSDate *)toMonth duration:(CGFloat)duration;

@end
