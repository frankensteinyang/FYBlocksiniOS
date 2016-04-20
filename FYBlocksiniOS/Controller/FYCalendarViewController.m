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

@property (nonatomic,strong)UILabel *startLabel;
@property (nonatomic,strong)UILabel *endLabel;
@property (nonatomic,assign)NSInteger startDate;
@property (nonatomic,assign)NSInteger endDate;

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
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTouchUpInside:)];
    [fareLbl addGestureRecognizer:labelTapGestureRecognizer];
    
    [self.view addSubview:fareLbl];
    [fareLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(backBtn.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
}

- (void)calendarViewConfirmClickWithStartDate:(NSInteger)startDate endDate:(NSInteger)endDate
{
    _startDate = startDate;
    _endDate = endDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSString *startDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_startDate]];
    NSString *endDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_endDate]];
    _startLabel.text = [NSString stringWithFormat:@"开始日期:%@",startDateString];
    _endLabel.text = [NSString stringWithFormat:@"结束日期:%@",endDateString];
}

- (void)labelTouchUpInside:(UITapGestureRecognizer *)recognizer {
    
    UILabel *label = (UILabel *)recognizer.view;
    NSLog(@"%@被点击了",label.text);
    
    FYFareCalendarViewController *cvc = [[FYFareCalendarViewController alloc]init];
    cvc.limitMonth = 12 * 15;// 显示几个月的日历
    /*
     MSSCalendarViewControllerLastType 只显示当前月之前
     MSSCalendarViewControllerMiddleType 前后各显示一半
     MSSCalendarViewControllerNextType 只显示当前月之后
     */
    cvc.type = FYFareCalendarViewControllerLastType;
    cvc.beforeTodayCanTouch = YES;// 今天之后的日期是否可以点击
    cvc.afterTodayCanTouch = NO;// 今天之前的日期是否可以点击
    cvc.startDate = _startDate;// 选中开始时间
    cvc.endDate = _endDate;// 选中结束时间
    /*以下两个属性设为YES,计算中国农历非常耗性能（在5s加载15年以内的数据没有影响）*/
    cvc.showChineseHoliday = YES;// 是否展示农历节日
    cvc.showChineseCalendar = YES;// 是否展示农历
    cvc.showHolidayDifferentColor = YES;// 节假日是否显示不同的颜色
    cvc.showAlertView = NO;// 是否显示提示弹窗
    cvc.delegate = self;
    [self presentViewController:cvc animated:YES completion:nil];
    
}

- (void)backBtnClicked {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)dealloc {
    
    NSLog(@"FYCalendarViewController gets dealloced!");
}

@end
