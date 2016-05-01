//
//  FYCalendarHeader.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/29/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYCalendarHeader.h"

@interface FYCalendarHeader ()

@property (strong, nonatomic) UILabel        *yearAndMonthLb;
@property (strong, nonatomic) NSMutableArray *weekLbs;

@end

@implementation FYCalendarHeader

static void(^headerStyleBlock)(UIView *);

+ (void)initWithHeaderMonthViewStyleBlock:(void(^)(UIView *view))block {
    
    if(headerStyleBlock) {
        Block_release((__bridge void*)block);
    }
    
    headerStyleBlock = (__bridge id)Block_copy((__bridge void*)block);
    
}

static void(^weekLableStyleBlock)(NSArray *);

+ (void)calendarHeaderWithLabelStyleBlock:(void(^)(NSArray *labels))block {
    if(weekLableStyleBlock) {
        Block_release((__bridge void*)block);
    }
    weekLableStyleBlock = (__bridge id)Block_copy((__bridge void*)block);
}

+ (CGFloat)height {
    
    return FYCalendarHeader_TOP_PADDING +
        FYCalendarHeader_WEEK_LB_HEIGHT +
        FYCalendarHeader_YEAR_MONTH_LB_HEIGHT;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = FYCalendarHeader_BACKGROUND_COLOR;
        
        UILabel *yearAndMonthLb = [UILabel new];
        _yearAndMonthLb = yearAndMonthLb;
        yearAndMonthLb.textAlignment = NSTextAlignmentCenter;
        yearAndMonthLb.translatesAutoresizingMaskIntoConstraints = NO;
        yearAndMonthLb.font = [UIFont systemFontOfSize:kFY_CALENDAR_HEADER_YEAR_MONTH_FONT_SIZE];
        yearAndMonthLb.textColor = kFY_CALENDAR_HEADER_YEAR_MONTH_FONT_COLOR;
        
        UIView *weekView = [UIView new];
        weekView.translatesAutoresizingMaskIntoConstraints = NO;
        weekView.backgroundColor = FYCalendarHeader_WEEK_VIEW_BACKGROUND_COLOR;
        
        [self addSubview:yearAndMonthLb];
        [self addSubview:weekView];
        
        id vs = NSDictionaryOfVariableBindings(yearAndMonthLb, weekView);
        id ms = @{@"topPadding":@(FYCalendarHeader_TOP_PADDING), @"weekLbHeight":@(FYCalendarHeader_WEEK_LB_HEIGHT), @"YearMonthLbHeight":@(FYCalendarHeader_YEAR_MONTH_LB_HEIGHT)};
        id cs1 = [NSLayoutConstraint constraintsWithVisualFormat:@"|[yearAndMonthLb]|" options:0 metrics:nil views:vs];
        id cs2 = [NSLayoutConstraint constraintsWithVisualFormat:@"|[weekView]|" options:0 metrics:nil views:vs];
        id cs3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topPadding-[yearAndMonthLb(YearMonthLbHeight)][weekView(weekLbHeight)]" options:0 metrics:ms views:vs];
        [self addConstraints:cs1];
        [self addConstraints:cs2];
        [self addConstraints:cs3];
        
        _weekLbs = [[NSMutableArray alloc] init];
        
        id weeks = @[FYCalendarHeader_SYMBOL_MONDAY,
                     FYCalendarHeader_SYMBOL_TUESDAY,
                     FYCalendarHeader_SYMBOL_WEDNESDAY,
                     FYCalendarHeader_SYMBOL_THURSDAY,
                     FYCalendarHeader_SYMBOL_FRIDAY,
                     FYCalendarHeader_SYMBOL_SATURDAY,
                     FYCalendarHeader_SYMBOL_SUNDAY];
        
        for(int i = 0; i < 7 ; i++) {
            UILabel *lb = [[UILabel alloc] init];
            lb.font = [UIFont systemFontOfSize:kFY_CALENDAR_HEADER_WEEK_FONT_SIZE];
            lb.textColor = kFY_CALENDAR_HEADER_WEEK_FONT_COLOR;
            lb.textAlignment = NSTextAlignmentCenter;
            lb.text = weeks[i];
            [weekView addSubview:lb];
            [_weekLbs addObject:lb];
        }
        [self adjustWeekLbsWithWidth:CGRectGetWidth(frame) withCellSpace:1.f withSectionInset:UIEdgeInsetsZero];
        
        if(headerStyleBlock) {
            headerStyleBlock(yearAndMonthLb);
        }
        if(weekLableStyleBlock) {
            weekLableStyleBlock(_weekLbs);
        }
    }
    return self;
}

- (void)adjustWeekLbsWithWidth:(CGFloat)width withCellSpace:(CGFloat)space withSectionInset:(UIEdgeInsets)inset {
    CGFloat w = (width-space*6.f-inset.left-inset.right)/7.f;
    CGFloat x = w+space;
    [_weekLbs enumerateObjectsUsingBlock:^(UILabel *lb, NSUInteger idx, BOOL *stop) {
        lb.frame = CGRectMake(inset.left+x*idx, 0.f, w, FYCalendarHeader_WEEK_LB_HEIGHT);
    }];
}

- (void)setTitle:(NSString*)title {
    
    _yearAndMonthLb.text = title;
}

@end
