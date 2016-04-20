//
//  FYFareCalendarCollectionReusableView.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/20/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYFareCalendarCollectionReusableView.h"
#import "FYFareCalendarDefine.h"

@implementation FYFareCalendarCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createReusableView];
    }
    return self;
}

- (void)createReusableView
{
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:headerView];
    
    _headerLabel = [[UILabel alloc]init];
    _headerLabel.frame = CGRectMake(10, 0, self.frame.size.width - 10, self.frame.size.height);
    _headerLabel.textAlignment = NSTextAlignmentCenter;
    _headerLabel.backgroundColor = [UIColor clearColor];
    _headerLabel.textColor = FY_HeaderViewTextColor;
    [headerView addSubview:_headerLabel];
    
    
    UIView *topLineView = [[UIView alloc]init];
    topLineView.frame = CGRectMake(0, 0, headerView.frame.size.width, FY_ONE_PIXEL);
    topLineView.backgroundColor = FY_HeaderViewLineColor;
    [headerView addSubview:topLineView];
    
    UIView *bottomLineView = [[UIView alloc]init];
    bottomLineView.frame = CGRectMake(0, headerView.frame.size.height - FY_ONE_PIXEL, headerView.frame.size.width, FY_ONE_PIXEL);
    bottomLineView.backgroundColor = FY_HeaderViewLineColor;
    [headerView addSubview:bottomLineView];
}

@end
