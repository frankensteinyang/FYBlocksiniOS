//
//  FYCalendarCell.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/29/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYCalendarCell : UICollectionViewCell

+ (CGFloat)height;

- (void)setContentWithDay:(NSString *)day withPrice:(NSString *)price;

- (void)setContentWithDay:(NSString *)day;

- (void)setContentEmpty;

@end
