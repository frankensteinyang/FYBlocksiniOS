//
//  FYCircleLabel.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/20/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYCircleLabel.h"
#import "FYFareCalendarDefine.h"

@implementation FYCircleLabel

- (void)drawRect:(CGRect)rect
{
    if(_isSelected)
    {
        [FY_SelectBackgroundColor setFill];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:self.frame.size.height / 2 startAngle:0.0 endAngle:180.0 clockwise:YES];
        [path fill];
    }
    [super drawRect:rect];
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    [self setNeedsDisplay];
}

@end
