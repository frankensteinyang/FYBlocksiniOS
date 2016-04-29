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
#import "FYCalendar.h"

@interface FYCalendarViewController () <FYCalendarDelegate>

@property (nonatomic, strong) FYCalendar *calendar;

@end

@implementation FYCalendarViewController

- (void)viewDidLoad {
    
    @weakify(self);
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    
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
    
    UILabel *calendarLbl = [[UILabel alloc] init];
    [calendarLbl setText:@"$126"];
    [calendarLbl setTextColor:[UIColor orangeColor]];
    [calendarLbl setTextAlignment:NSTextAlignmentCenter];
    calendarLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *taper = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(calendarTouchUpInside:)];
    [calendarLbl addGestureRecognizer:taper];
    [self.view addSubview:calendarLbl];
    [calendarLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(backBtn.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    _calendar = [FYCalendar calendarPriceViewWithToday:[NSDate date]];
    _calendar.today = [NSDate date];
    _calendar.calendarDelegate = self;
    _calendar.frame = CGRectMake(0, 114, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
    [self.view addSubview:_calendar];
    
    FYCalendarLayout* layout = (id)_calendar.collectionViewLayout;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    FYCalendarModel *model = [FYCalendarModel calendarModelWithYear:@(2015) withMonth:@(3) withDay:@(22) withPrice:@(30) withCount:@(10)];
    FYCalendarModel *model2 = [FYCalendarModel calendarModelWithYear:@(2015) withMonth:@(9) withDay:@(22) withPrice:@(10) withCount:@(10)];
    FYCalendarModel *model3 = [FYCalendarModel calendarModelWithYear:@(2015) withMonth:@(7) withDay:@(24) withPrice:@(20) withCount:@(10)];
    _calendar.datas = @[model, model2, model3];
    _calendar.today = [NSDate date];
    
}

- (void)calendarTouchUpInside:(UITapGestureRecognizer *)recognizer {
    
    UILabel *lbl = (UILabel *)recognizer.view;
    NSLog(@"%@被点击了", lbl.text);
    
    [self.view addSubview:self.calendar];
    [self makeConstraints];
    
}

- (void)backBtnClicked {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - 懒加载

- (FYCalendar *)calendar {
    
    if (!_calendar) {
        _calendar = [[FYCalendar alloc] init];
    }
    return _calendar;
    
}

#pragma mark - 约束

- (void)makeConstraints {
    
    @weakify(self);
    [_calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view).offset(200);
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.bottom.equalTo(self.view).offset(-50);
    }];
    
}

- (NSDictionary *)calendar:(FYCalendar *)cview cellDataStringDictionaryWithIndexPath:(NSIndexPath *)indexPath withYear:(NSString *)year withMonth:(NSString *)month withDay:(NSString *)day withPrice:(NSString *)price withCount:(NSString *)count withIsToday:(BOOL)isToady {
    
    return @{kFYCalendarCellDataKeyDay:[NSString stringWithFormat:@"%@号", day],
             kFYCalendarCellDataKeyPrice:[NSString stringWithFormat:@"%@元", price]
             //             kSkyCalendarPriceViewCellDataKeyCount:[NSString stringWithFormat:@"还有%@", count]
             };
    
}

#pragma mark - 代理

- (BOOL)calendar:(FYCalendar *)cview shouldSelectIndexWithPriceModel:(FYCalendarModel *)model {
    
    return YES;
}

- (void)dealloc {
    
    NSLog(@"FYCalendarViewController gets dealloced!");
}

@end
