//
//  FYCalendarView.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/21/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "FYCalendarView.h"

@interface FYCalendarView ()

@property (nonatomic, strong) UIButton *quitBtn;
@property (nonatomic, strong) FYCalendar *calendar;

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
        
    }
    return self;
    
}

- (UIButton *)quitBtn {
    
    if (!_quitBtn) {
        _quitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_quitBtn setTitle:@"Close" forState:UIControlStateNormal];
        [_quitBtn setTitleShadowColor:[UIColor redColor] forState:UIControlStateNormal];
        [_quitBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_quitBtn addTarget:self
                     action:@selector(quit)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _quitBtn;
}

- (FYCalendar *)calendar {
    
    if (!_calendar) {
        _calendar = [[FYCalendar alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.allowsMultipleSelection = YES;
    }
    return _calendar;
    
}

- (void)quit {
    
    [self removeFromSuperview];
}

@end
