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
    _calendar.userInteractionEnabled = NO;
    _calendar.calendarDelegate = self;
    _calendar.frame = CGRectMake(0, 114, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
    [self.view addSubview:_calendar];
    
    FYCalendarLayout* layout = (id)_calendar.collectionViewLayout;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    
    
#if DEBUG
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
    
    NSUInteger numberOfDaysInMonth = range.length;
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSInteger iCurYear = [components year];  //当前的年份
    
    NSInteger iCurMonth = [components month];  //当前的月份
    
    for (NSInteger i = 1; i < numberOfDaysInMonth + 1; i++) {
        
        FYCalendarModel *model = [FYCalendarModel calendarModelWithYear:&iCurYear withMonth:&iCurMonth withDay:&i withPrice:@"234"];
        
        _calendar.datas = @[model];
        
    }
    
#endif
    
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

- (NSDictionary *)calendar:(FYCalendar *)cview cellDataStringDictionaryWithIndexPath:(NSIndexPath *)indexPath withYear:(NSString *)year withMonth:(NSString *)month withDay:(NSString *)day withPrice:(NSString *)price {
    
    return 0;
    
}

#pragma mark - 代理

- (BOOL)calendar:(FYCalendar *)cview shouldSelectIndexWithPriceModel:(FYCalendarModel *)model {
    
    return YES;
}

- (void)dealloc {
    
    NSLog(@"FYCalendarViewController gets dealloced!");
}

#if DEBUG

#endif

@end
