//
//  FYFareCalendarViewController.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/20/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FYFareCalendarViewControllerDelegate <NSObject>

- (void)calendarViewSelectedWithStartDate:(NSInteger)startDate
                                  endDate:(NSInteger)endDate;

@end

typedef NS_ENUM(NSInteger, FYFareCalendarViewControllerType)
{
    FYFareCalendarViewControllerLastType = 0, // 显示当前月之前
    FYFareCalendarViewControllerMiddleType, // 前后月份各显示一半
    FYFareCalendarViewControllerNextType // 显示当前月之后
};

@interface FYFareCalendarViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,weak) id <FYFareCalendarViewControllerDelegate>delegate;
@property (nonatomic,assign) NSInteger startDate;// 选中开始时间
@property (nonatomic,assign) NSInteger endDate;// 选中结束时间

@property (nonatomic,assign) NSInteger limitMonth;// 显示几个月的数据
@property (nonatomic,assign) FYFareCalendarViewControllerType type;
@property (nonatomic,assign) BOOL afterTodayCanTouch;// 今天之后的日期是否可以点击
@property (nonatomic,assign) BOOL beforeTodayCanTouch;// 今天之前的日期是否可以点击

@property (nonatomic,assign) BOOL showHolidayDifferentColor;// 节假日是否宣示不同的颜色

@property (nonatomic,assign) BOOL showAlertView;// 是否显示提示弹窗

@end
