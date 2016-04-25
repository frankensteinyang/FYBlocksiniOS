//
//  FYCalendarView.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/21/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "FYCalendarView.h"
#import "FYCalendar.h"

@interface FYCalendarView () <FYCalendarDataSource, FYCalendarDelegate, FYCalendarDelegateAppearance>

@property (strong, nonatomic) FYCalendar *calendar;

@property (strong, nonatomic) UIButton *quitBtn;
@property (strong, nonatomic) UIButton *previousBtn;
@property (strong, nonatomic) UIButton *nextBtn;

@property (strong, nonatomic) NSDictionary *fillSelectionColors;
@property (strong, nonatomic) NSDictionary *fillDefaultColors;
@property (strong, nonatomic) NSDictionary *borderDefaultColors;
@property (strong, nonatomic) NSDictionary *borderSelectionColors;

@property (strong, nonatomic) NSArray *datesWithEvent;
@property (strong, nonatomic) NSArray *datesWithMultipleEvents;

- (void)previousClicked:(id)sender;
- (void)nextClicked:(id)sender;

@end

@implementation FYCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.quitBtn];
        [_quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(200, 200));
        }];
        
        [self addSubview:self.calendar];
        [_calendar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.top.mas_equalTo(_quitBtn.mas_bottom).with.offset(10);
        }];
        
        [_calendar addSubview:self.previousBtn];
        [_previousBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_calendar);
            make.left.mas_equalTo(_calendar);
            make.size.mas_equalTo(CGSizeMake(50, 30));
        }];
        
        [_calendar addSubview:self.nextBtn];
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_calendar);
            make.right.mas_equalTo(_calendar);
            make.size.mas_equalTo(CGSizeMake(50, 30));
        }];
        
    }
    return self;
    
}

- (UIButton *)previousBtn {
    
    if (!_previousBtn) {
        _previousBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_previousBtn setTitle:@"Prev" forState:UIControlStateNormal];
        [_previousBtn setTitleColor:[UIColor blueColor]
                           forState:UIControlStateNormal];
        _previousBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        _previousBtn.clipsToBounds = YES;
        
        [_previousBtn addTarget:self
                         action:@selector(previousClicked:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _previousBtn;
    
}

- (UIButton *)nextBtn {
    
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_nextBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor blueColor]
                       forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        _nextBtn.clipsToBounds = YES;
        
        [_nextBtn addTarget:self
                     action:@selector(nextClicked:)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
    
}

- (UIButton *)quitBtn {
    
    if (!_quitBtn) {
        _quitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_quitBtn setTitle:@"Close" forState:UIControlStateNormal];
        [_quitBtn setTitleColor:[UIColor blueColor]
                       forState:UIControlStateNormal];
        
        [_quitBtn addTarget:self
                     action:@selector(quit)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _quitBtn;
    
}

- (FYCalendar *)calendar {
    
    if (!_calendar) {
        _calendar = [[FYCalendar alloc] init];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.allowsMultipleSelection = YES;
        // 隐藏月份和年份，以便显示月份左右切换箭头
        _calendar.appearance.headerMinimumDissolvedAlpha = 0;
    }
    return _calendar;
    
}

- (void)quit {
    
    [self removeFromSuperview];
}

- (void)dealloc {
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)previousClicked:(id)sender {
    
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *preMonth = [self.calendar dateBySubstractingMonths:1
                                                      fromDate:currentMonth];
    [self.calendar setCurrentPage:preMonth animated:YES];
}

- (void)nextClicked:(id)sender {
    
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.calendar dateByAddingMonths:1
                                                   toDate:currentMonth];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}

#pragma mark - Delegate

- (FYCalendarCellShape)calendar:(FYCalendar *)calendar appearance:(FYCalendarAppearance *)appearance cellShapeForDate:(NSDate *)date {
    
    return FYCalendarCellShapeRectangle;
}

@end
