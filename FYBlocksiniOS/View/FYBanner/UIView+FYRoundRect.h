//
//  UIView+FYRoundRect.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/27/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FYRoundRect)

- (void)applyRoundCorners:(UIRectCorner)corners
                   radius:(CGFloat)radius;

@end
