//
//  FYCalendarCell.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/29/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYCalendarCell : UICollectionViewCell

+ (void)calendarCellStyleWithBlock:(void(^)(UICollectionViewCell *cell))block;

+ (CGFloat)hegith;

- (void)setContentWithDay:(NSString*)day withPrice:(NSString*)price withCount:(NSString*)count;

- (void)setContentWithDay:(NSString*)day;

- (void)setContentEmpty;

@end
