//
//  FYCalendarCell.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/22/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FYCalendar.h"
#import "FYCalendarEventIndicator.h"

@interface FYCalendarCell : UICollectionViewCell

@property (weak, nonatomic) FYCalendar *calendar;
@property (weak, nonatomic) FYCalendarAppearance *appearance;

@property (weak, nonatomic) UILabel  *titleLabel;
@property (weak, nonatomic) UILabel  *subtitleLabel;
@property (weak, nonatomic) UIImageView *imageView;

@property (weak, nonatomic) CAShapeLayer *shapeLayer;
@property (weak, nonatomic) FYCalendarEventIndicator *eventIndicator;

@property (strong, nonatomic) NSDate   *date;
@property (strong, nonatomic) NSString *subtitle;
@property (strong, nonatomic) UIImage  *image;

@property (assign, nonatomic) BOOL needsAdjustingViewFrame;
@property (assign, nonatomic) NSInteger numberOfEvents;

@property (assign, nonatomic) BOOL dateIsPlaceholder;
@property (assign, nonatomic) BOOL dateIsSelected;
@property (assign, nonatomic) BOOL dateIsToday;

@property (readonly, nonatomic) BOOL weekend;

@property (strong, nonatomic) UIColor *preferredFillDefaultColor;
@property (strong, nonatomic) UIColor *preferredFillSelectionColor;
@property (strong, nonatomic) UIColor *preferredTitleDefaultColor;
@property (strong, nonatomic) UIColor *preferredTitleSelectionColor;
@property (strong, nonatomic) UIColor *preferredSubtitleDefaultColor;
@property (strong, nonatomic) UIColor *preferredSubtitleSelectionColor;
@property (strong, nonatomic) UIColor *preferredBorderDefaultColor;
@property (strong, nonatomic) UIColor *preferredBorderSelectionColor;
@property (strong, nonatomic) id preferredEventColor;
@property (assign, nonatomic) FYCalendarCellShape preferredCellShape;

- (void)invalidateTitleFont;
- (void)invalidateSubtitleFont;
- (void)invalidateTitleTextColor;
- (void)invalidateSubtitleTextColor;

- (void)invalidateBorderColors;
- (void)invalidateFillColors;
- (void)invalidateEventColors;
- (void)invalidateCellShapes;

- (void)invalidateImage;

- (UIColor *)colorForCurrentStateInDictionary:(NSDictionary *)dictionary;
- (void)performSelecting;

@end
