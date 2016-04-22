//
//  UIView+FYExtension.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/22/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "UIView+FYExtension.h"

@implementation UIView (FYExtension)

- (CGFloat)fy_width
{
    return CGRectGetWidth(self.frame);
}

- (void)setFy_width:(CGFloat)fy_width
{
    self.frame = CGRectMake(self.fy_left, self.fy_top, fy_width, self.fy_height);
}

- (CGFloat)fy_height
{
    return CGRectGetHeight(self.frame);
}

- (void)setFy_height:(CGFloat)fy_height
{
    self.frame = CGRectMake(self.fy_left, self.fy_top, self.fy_width, fy_height);
}

- (CGFloat)fy_top
{
    return CGRectGetMinY(self.frame);
}

- (void)setFy_top:(CGFloat)fy_top
{
    self.frame = CGRectMake(self.fy_left, fy_top, self.fy_width, self.fy_height);
}

- (CGFloat)fy_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setFy_bottom:(CGFloat)fy_bottom
{
    self.fy_top = fy_bottom - self.fy_height;
}

- (CGFloat)fy_left
{
    return CGRectGetMinX(self.frame);
}

- (void)setFy_left:(CGFloat)fy_left
{
    self.frame = CGRectMake(fy_left, self.fy_top, self.fy_width, self.fy_height);
}

- (CGFloat)fy_right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setFy_right:(CGFloat)fy_right
{
    self.fy_left = self.fy_right - self.fy_width;
}

@end
