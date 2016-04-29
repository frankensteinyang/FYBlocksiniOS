//
//  FYCalendarHeader.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/29/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FYCalendarUIDefine.h"

/**
 *  价格日历的头部View，显示年份和月份
 */
@interface FYCalendarHeader : UICollectionReusableView

/**
 *  初始化显示年月的view样式
 *
 *  @param block
 */
+ (void)initWithHeaderMonthViewStyleBlock:(void(^)(UIView *view))block;

/**
 *  初始化显示星期的label样式，从周日开始到周六
 *
 *  @param block
 */
+ (void)calendarHeaderWithLabelStyleBlock:(void(^)(NSArray *labels))block;

+ (CGFloat)height;

- (void)adjustWeekLbsWithWidth:(CGFloat)width withCellSpace:(CGFloat)space withSectionInset:(UIEdgeInsets)inset;

- (void)setTitle:(NSString*)title;

@end
