//
//  FYFareCalendarDefine.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/20/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#ifndef FYFareCalendarDefine_h
#define FYFareCalendarDefine_h


#define FY_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define FY_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define FY_UTILS_COLORRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define FY_Iphone6Scale(x) ((x) * FY_SCREEN_WIDTH / 375.0f)
#define FY_ONE_PIXEL (1.0f / [[UIScreen mainScreen] scale])

/*定义属性*/
// DateLabel默认文字颜色
#define FY_TextColor [UIColor blackColor]
// DateLabel选中时的背景色
#define FY_SelectBackgroundColor FY_UTILS_COLORRGB(29, 154, 72)
// DateLabel选中后文字颜色
#define FY_SelectTextColor [UIColor whiteColor]
// SubLabel文字颜色
#define FY_SelectSubLabelTextColor FY_UTILS_COLORRGB(29, 154, 180);
// SubLabel选中开始文字
#define FY_SelectBeginText @"开始"
// SubLabel选中结束文字
#define FY_SelectEndText @"结束"
// 节日颜色
#define FY_HolidayTextColor [UIColor purpleColor]
// 周末颜色
#define FY_WeekEndTextColor [UIColor redColor]
// 不可点击文字颜色
#define FY_TouchUnableTextColor FY_UTILS_COLORRGB(150, 150, 150)
// 周视图高度
#define FY_WeekViewHeight 40
// headerView线颜色
#define FY_HeaderViewLineColor [UIColor lightGrayColor]
// headerView文字颜色
#define FY_HeaderViewTextColor [UIColor blackColor]
// headerView高度
#define FY_HeaderViewHeight 50
// 弹出层文字颜色
#define FY_CalendarPopViewTextColor [UIColor whiteColor]
// 弹出层背景颜色
#define FY_CalendarPopViewBackgroundColor [UIColor blackColor]


#endif /* FYFareCalendarDefine_h */
