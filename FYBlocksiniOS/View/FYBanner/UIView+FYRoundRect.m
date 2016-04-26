//
//  UIView+FYRoundRect.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/27/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "UIView+FYRoundRect.h"

@implementation UIView (FYRoundRect)

- (void)applyRoundCorners:(UIRectCorner)corners
                   radius:(CGFloat)radius
                    frame:(CGRect)frame {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}

@end
