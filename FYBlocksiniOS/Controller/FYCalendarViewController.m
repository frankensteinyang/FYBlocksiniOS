//
//  FYCalendarViewController.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/20/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <libextobjc/EXTScope.h>

#import "FYCalendarViewController.h"
#import "FYFareCalendarViewController.h"

@interface FYCalendarViewController () <FYFareCalendarViewControllerDelegate>

@property (nonatomic, assign)NSInteger startDate;
@property (nonatomic, assign)NSInteger endDate;

@end

@implementation FYCalendarViewController

- (void)viewDidLoad {
    
    @weakify(self);
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.backgroundColor = [UIColor whiteColor];
    [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    [backBtn addTarget:self
                action:@selector(backBtnClicked)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(60);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    UILabel *fareLbl = [[UILabel alloc] init];
    [fareLbl setText:@"￥125"];
    [fareLbl setTextColor:[UIColor orangeColor]];
    [fareLbl setTextAlignment:NSTextAlignmentCenter];
    
    fareLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *lblTaper = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self
                                                action:@selector(lblTouchUpInside:)];
    [fareLbl addGestureRecognizer:lblTaper];
    
    [self.view addSubview:fareLbl];
    [fareLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(backBtn.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
}

- (void)calendarViewSelectedWithStartDate:(NSInteger)startDate endDate:(NSInteger)endDate {
}

- (void)lblTouchUpInside:(UITapGestureRecognizer *)recognizer {
    
    UILabel *label = (UILabel *)recognizer.view;
    NSLog(@"%@被点击了",label.text);
    
    FYFareCalendarViewController *fcvc = [[FYFareCalendarViewController alloc] init];
    fcvc.limitMonth = 12 * 6;// 显示几个月的日历
    /**
     * FYFareCalendarViewControllerLastType 只显示当前月之前
     * FYFareCalendarViewControllerMiddleType 前后各显示一半
     * FYFareCalendarViewControllerNextType 只显示当前月之后
     */
    fcvc.type = FYFareCalendarViewControllerMiddleType;
    fcvc.beforeTodayCanTouch = YES;// 今天之后的日期是否可以点击
    fcvc.afterTodayCanTouch = NO;// 今天之前的日期是否可以点击
    fcvc.startDate = _startDate;// 选中开始时间
    fcvc.endDate = _endDate;// 选中结束时间
    fcvc.showHolidayDifferentColor = YES;// 节假日是否显示不同的颜色
    fcvc.showAlertView = NO;// 是否显示提示弹窗
    fcvc.delegate = self;
    [self presentViewController:fcvc animated:YES completion:nil];
    
}

- (void)backBtnClicked {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)dealloc {
    
    NSLog(@"FYCalendarViewController gets dealloced!");
}

@end
