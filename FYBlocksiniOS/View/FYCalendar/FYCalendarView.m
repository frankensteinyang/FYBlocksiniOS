//
//  FYCalendarView.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/21/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "FYCalendarView.h"

@interface FYCalendarView () {
    
    UICollectionView *calendarCollectionView;
}

@property (nonatomic, strong) UIButton *quitBtn;

@end
@implementation FYCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.quitBtn];
        
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
        [_quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(200, 200));
            make.bottom.mas_equalTo(self).with.offset(20);
        }];
    }
    return _quitBtn;
}

- (void)quit {
    
    [self removeFromSuperview];
}

@end
