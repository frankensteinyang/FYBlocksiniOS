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
                   radius:(CGFloat)radius {
    
    CGSize size = CGSizeMake(radius, radius);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:size];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}

@end
