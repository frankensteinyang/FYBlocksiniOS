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
    _calendar.userInteractionEnabled = NO;
    _calendar.calendarDelegate = self;
    _calendar.frame = CGRectMake(0, 114, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
    [self.view addSubview:_calendar];
    
    FYCalendarLayout* layout = (id)_calendar.collectionViewLayout;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    FYCalendarModel *model = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(1) withPrice:@(30)];
    FYCalendarModel *modelA = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(2) withPrice:@(120)];
    FYCalendarModel *modelB = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(3) withPrice:@(430)];
    FYCalendarModel *modelC = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(4) withPrice:@(119)];
    FYCalendarModel *modelD = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(5) withPrice:@(9)];
    FYCalendarModel *modelE = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(6) withPrice:@(120)];
    FYCalendarModel *modelF = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(7) withPrice:@(430)];
    FYCalendarModel *modelG = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(8) withPrice:@(119)];
    FYCalendarModel *modelH = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(9) withPrice:@(9)];
    FYCalendarModel *modelI = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(10) withPrice:@(9)];
    FYCalendarModel *modelJ = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(11) withPrice:@(120)];
    FYCalendarModel *modelK = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(12) withPrice:@(430)];
    FYCalendarModel *modelL = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(13) withPrice:@(430)];
    FYCalendarModel *modelM = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(14) withPrice:@(9)];
    FYCalendarModel *modelN = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(15) withPrice:@(120)];
    FYCalendarModel *modelO = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(16) withPrice:@(430)];
    FYCalendarModel *modelP = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(17) withPrice:@(119)];
    FYCalendarModel *modelQ = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(18) withPrice:@(9)];
    FYCalendarModel *modelR = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(19) withPrice:@(120)];
    FYCalendarModel *modelS = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(20) withPrice:@(430)];
    FYCalendarModel *modelT = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(21) withPrice:@(119)];
    FYCalendarModel *modelU = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(22) withPrice:@(9)];
    FYCalendarModel *model23 = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(23) withPrice:@(120)];
    FYCalendarModel *model24 = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(24) withPrice:@(430)];
    FYCalendarModel *model25 = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(25) withPrice:@(119)];
    FYCalendarModel *model26 = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(26) withPrice:@(9)];
    FYCalendarModel *model27 = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(27) withPrice:@(120)];
    FYCalendarModel *model28 = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(28) withPrice:@(430)];
    FYCalendarModel *model29 = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(29) withPrice:@(119)];
    FYCalendarModel *model30 = [FYCalendarModel calendarModelWithYear:@(2016) withMonth:@(4) withDay:@(30) withPrice:@(9)];
    _calendar.datas = @[model, modelA, modelB, modelC, modelD, modelE, modelF, modelG, modelH, modelI, modelJ, modelK, modelL, modelM, modelN, modelO, modelP, modelQ, modelR, modelS, modelT, modelU, model23, model24, model25, model26, model27, model28, model29, model30];
    _calendar.today = [NSDate date];
    
}

- (void)calendarTouchUpInside:(UITapGestureRecognizer *)recognizer {
    
    UILabel *lbl = (UILabel *)recognizer.view;
    NSLog(@"%@被点击了", lbl.text);
    
    [self.view addSubview:self.calendar];
    
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

- (NSDictionary *)calendar:(FYCalendar *)cview cellDataStringDictionaryWithIndexPath:(NSIndexPath *)indexPath withYear:(NSString *)year withMonth:(NSString *)month withDay:(NSString *)day withPrice:(NSString *)price withIsToday:(BOOL)isToady {
    
    return @{kFY_CALENDAR_CELL_KEY_DAY:[NSString stringWithFormat:@"%@", day],
             kFY_CALENDAR_CELL_KEY_PRICE:[NSString stringWithFormat:@"￥%@", price]};
    
}

#pragma mark - 代理

- (BOOL)calendar:(FYCalendar *)cview shouldSelectIndexWithPriceModel:(FYCalendarModel *)model {
    
    return YES;
}

- (void)dealloc {
    
    NSLog(@"FYCalendarViewController gets dealloced!");
}

@end
