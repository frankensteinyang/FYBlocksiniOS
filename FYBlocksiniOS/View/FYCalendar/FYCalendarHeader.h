//
//  FYCalendarHeader.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/22/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYCalendarCollectionView.h"

@class FYCalendar, FYCalendarAppearance;

@interface FYCalendarHeader : UIView

@property (weak, nonatomic) FYCalendarCollectionView *collectionView;
@property (weak, nonatomic) FYCalendar *calendar;
@property (weak, nonatomic) FYCalendarAppearance *appearance;

@property (assign, nonatomic) CGFloat scrollOffset;
@property (assign, nonatomic) UICollectionViewScrollDirection scrollDirection;
@property (assign, nonatomic) BOOL scrollEnabled;
@property (assign, nonatomic) BOOL needsAdjustingViewFrame;

- (void)reloadData;

@end

@interface FYCalendarHeaderCell : UICollectionViewCell

@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) FYCalendarHeader *header;

- (void)invalidateHeaderFont;
- (void)invalidateHeaderTextColor;

@end

@interface FYCalendarHeaderTouchDeliver : UIView

@property (weak, nonatomic) FYCalendar *calendar;
@property (weak, nonatomic) FYCalendarHeader *header;

@end
