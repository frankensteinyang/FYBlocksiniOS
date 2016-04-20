//
//  FYFareCalendarView.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/18/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYFareCalendarView.h"
#import "FYFareCalendarDefine.h"

static const CGFloat FareCalendarViewArrowHeight = 7.0f;
static const CGFloat FareCalendarViewAlpha = 0.5f;

@interface FYFareCalendarView ()

@property (nonatomic,assign) FYFareCalendarViewArrowPosition arrowPosition;
@property (nonatomic,assign) CGRect sideViewInWindowRect;
@property (nonatomic,assign) CGFloat drawArrowStartX;
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UILabel *topLabel;
@property (nonatomic,strong) UILabel *bottomLabel;

@end

@implementation FYFareCalendarView

- (instancetype)initWithSideView:(UIView *)sideView arrowPosition:(FYFareCalendarViewArrowPosition)arrowPosition
{
    self = [super initWithFrame:CGRectZero];
    if(self)
    {
        _arrowPosition = arrowPosition;
        _sideViewInWindowRect = [self getFrameInWindow:sideView];
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.backgroundColor = [UIColor clearColor];
    _backgroundView = [[UIView alloc]init];
    _backgroundView.backgroundColor = [FY_CalendarPopViewBackgroundColor colorWithAlphaComponent:FareCalendarViewAlpha];
    _backgroundView.layer.cornerRadius = 5.0f;
    [self addSubview:_backgroundView];
    
    _topLabel = [[UILabel alloc]init];
    _topLabel.textColor = FY_CalendarPopViewTextColor;
    _topLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    _topLabel.textAlignment = NSTextAlignmentCenter;
    [_backgroundView addSubview:_topLabel];
    
    _bottomLabel = [[UILabel alloc]init];
    _bottomLabel.textColor = FY_CalendarPopViewTextColor;
    _bottomLabel.font = [UIFont boldSystemFontOfSize:10.0f];
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    [_backgroundView addSubview:_bottomLabel];
}

- (void)showWithAnimation
{
    if(!self.superview)
    {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

// 获取指定视图在window中的位置
- (CGRect)getFrameInWindow:(UIView *)view
{
    return [view.superview convertRect:view.frame toView:[UIApplication sharedApplication].keyWindow];
}

- (void)drawRect:(CGRect)rect
{
    // 画三角
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(_drawArrowStartX, rect.size.height)];
    [path addLineToPoint:CGPointMake(_drawArrowStartX - FareCalendarViewArrowHeight, rect.size.height - FareCalendarViewArrowHeight)];
    [path addLineToPoint:CGPointMake(_drawArrowStartX + FareCalendarViewArrowHeight, rect.size.height - FareCalendarViewArrowHeight)];
    [path closePath];
    [[FY_CalendarPopViewBackgroundColor colorWithAlphaComponent:FareCalendarViewAlpha]setFill];
    [path fill];
}

- (void)setLayerAnchorPoint
{
    if(_arrowPosition == FYFareCalendarViewArrowPositionLeft)
    {
        _drawArrowStartX = _sideViewInWindowRect.size.width / 2 - 10;
    }
    else if(_arrowPosition == FYFareCalendarViewArrowPositionMiddle)
    {
        _drawArrowStartX = self.frame.size.width / 2;
    }
    else
    {
        _drawArrowStartX = self.frame.size.width - _sideViewInWindowRect.size.width / 2 + 10;
    }
    CGRect oldRect = self.frame;
    self.layer.anchorPoint = CGPointMake(_drawArrowStartX / self.frame.size.width, 1.0);
    self.frame = oldRect;
}

- (void)setTopLabelText:(NSString *)topLabelText
{
    _topLabelText = topLabelText;
    _topLabel.text = _topLabelText;
    [self updateUI];
}

- (void)setBottomLabelText:(NSString *)bottomLabelText
{
    _bottomLabelText = bottomLabelText;
    _bottomLabel.text = _bottomLabelText;
    [self updateUI];
}

- (void)updateUI
{
    CGRect topTextRect = [_topLabelText boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_topLabel.font} context:nil];
    CGRect bottomTextRect = [_bottomLabelText boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_bottomLabel.font} context:nil];
    CGFloat width = MAX(topTextRect.size.width, bottomTextRect.size.width) + 20;
    
    CGFloat x = 0.0f;
    if(_arrowPosition == FYFareCalendarViewArrowPositionLeft)
    {
        x = _sideViewInWindowRect.origin.x + 10;
    }
    else if(_arrowPosition == FYFareCalendarViewArrowPositionMiddle)
    {
        x = CGRectGetMidX(_sideViewInWindowRect) - width / 2;
    }
    else
    {
        x = _sideViewInWindowRect.origin.x + _sideViewInWindowRect.size.width - width - 10;
    }
    CGFloat height = 50.0f;
    self.frame = CGRectMake(x, _sideViewInWindowRect.origin.y - height - FareCalendarViewArrowHeight, width, height + FareCalendarViewArrowHeight);
    _backgroundView.frame = CGRectMake(0, 0, width, height);
    _topLabel.frame = CGRectMake(0, 13, width, 12);
    _bottomLabel.frame = CGRectMake(0, 28, width, 10);
    [self setLayerAnchorPoint];
}

@end
