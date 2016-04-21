//
//  FYFareCalendarViewController.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/20/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYFareCalendarViewController.h"
#import "FYFareCalendarView.h"
#import "FYFareCalendarManager.h"
#import "FYFareCalendarDefine.h"
#import "FYFareCalendarCollectionViewCell.h"
#import "FYFareCalendarCollectionReusableView.h"
#import "FYFareCalendarHeaderModel.h"

@interface FYFareCalendarViewController ()

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) FYFareCalendarView *calendarView;

@end

@implementation FYFareCalendarViewController

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _afterTodayCanTouch = YES;
        _beforeTodayCanTouch = NO;
        _dataArray = [[NSMutableArray alloc]init];
        _showHolidayDifferentColor = NO;
        _showAlertView = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDataSource];
    [self createUI];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(_calendarView)
    {
        [_calendarView removeFromSuperview];
        _calendarView = nil;
    }
}

- (void)initDataSource
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        FYFareCalendarManager *manager = [[FYFareCalendarManager alloc] initWithStartDate:_startDate];
        NSArray *tempDataArray = [manager getCalendarDataSoruceWithLimitMonth:_limitMonth type:_type];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_dataArray addObjectsFromArray:tempDataArray];
            [self showCollectionViewWithStartIndexPath:manager.startIndexPath];
        });
    });
}

- (void)addWeakView
{
    UIView *weekView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, FY_SCREEN_WIDTH, FY_WeekViewHeight)];
    weekView.backgroundColor = FY_SelectBackgroundColor;
    [self.view addSubview:weekView];
    
    NSArray *weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    int i = 0;
    NSInteger width = FY_Iphone6Scale(54);
    for(i = 0; i < 7;i++)
    {
        UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * width, 0, width, FY_WeekViewHeight)];
        weekLabel.backgroundColor = [UIColor clearColor];
        weekLabel.text = weekArray[i];
        weekLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        if(i == 0 || i == 6)
        {
            weekLabel.textColor = FY_WeekEndTextColor;
        }
        else
        {
            weekLabel.textColor = FY_SelectTextColor;
        }
        [weekView addSubview:weekLabel];
    }
}

- (void)showCollectionViewWithStartIndexPath:(NSIndexPath *)startIndexPath
{
    [self addWeakView];
    [_collectionView reloadData];
    // 滚动到上次选中的位置
    if(startIndexPath)
    {
        [_collectionView scrollToItemAtIndexPath:startIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        _collectionView.contentOffset = CGPointMake(0, _collectionView.contentOffset.y - FY_HeaderViewHeight);
    }
    else
    {
        if(_type == FYFareCalendarViewControllerLastType)
        {
            if([_dataArray count] > 0)
            {
                [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_dataArray.count - 1] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            }
        }
        else if(_type == FYFareCalendarViewControllerMiddleType)
        {
            if([_dataArray count] > 0)
            {
                [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:(_dataArray.count - 1) / 2] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
                _collectionView.contentOffset = CGPointMake(0, _collectionView.contentOffset.y - FY_HeaderViewHeight);
            }
        }
    }
}

- (void)createUI
{
    NSInteger width = FY_Iphone6Scale(54);
    NSInteger height = FY_Iphone6Scale(60);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(width, height);
    flowLayout.headerReferenceSize = CGSizeMake(FY_SCREEN_WIDTH, FY_HeaderViewHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64 + FY_WeekViewHeight, width * 7, FY_SCREEN_HEIGHT - 64 - FY_WeekViewHeight) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[FYFareCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"FYFareCalendarCollectionViewCell"];
    [_collectionView registerClass:[FYFareCalendarCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FYFareCalendarCollectionReusableView"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_dataArray count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    FYFareCalendarHeaderModel *headerItem = _dataArray[section];
    return headerItem.calendarItemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FYFareCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FYFareCalendarCollectionViewCell" forIndexPath:indexPath];
    if(cell)
    {
        FYFareCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
        FYFareCalendarModel *calendarItem = headerItem.calendarItemArray[indexPath.row];
        cell.dateLabel.text = @"";
        cell.dateLabel.textColor = FY_TextColor;
        cell.subLabel.text = @"";
        cell.subLabel.textColor = FY_SelectSubLabelTextColor;
        cell.isSelected = NO;
        cell.userInteractionEnabled = NO;
        if(calendarItem.day > 0)
        {
            cell.dateLabel.text = [NSString stringWithFormat:@"%ld",(long)calendarItem.day];
            cell.userInteractionEnabled = YES;
        }
        
        // 价格标签逻辑，待完善
        if(NO)
        {
            cell.subLabel.text = calendarItem.chineseCalendar;
        }
        
        // 开始日期
        if(calendarItem.dateInterval == _startDate)
        {
            cell.isSelected = YES;
            cell.dateLabel.textColor = FY_SelectTextColor;
            cell.subLabel.text = FY_SelectBeginText;
            
        }
        // 结束日期
        else if (calendarItem.dateInterval == _endDate)
        {
            cell.isSelected = YES;
            cell.dateLabel.textColor = FY_SelectTextColor;
            cell.subLabel.text = FY_SelectEndText;
        }
        // 开始和结束之间的日期
        else if(calendarItem.dateInterval > _startDate && calendarItem.dateInterval < _endDate)
        {
            cell.isSelected = YES;
            cell.dateLabel.textColor = FY_SelectTextColor;
        }
        else
        {
            if(calendarItem.week == 0 || calendarItem.week == 6)
            {
                cell.dateLabel.textColor = FY_WeekEndTextColor;
                cell.subLabel.textColor = FY_WeekEndTextColor;
            }
            if(calendarItem.holiday.length > 0)
            {
                cell.dateLabel.text = calendarItem.holiday;
                if(_showHolidayDifferentColor)
                {
                    cell.dateLabel.textColor = FY_HolidayTextColor;
                    cell.subLabel.textColor = FY_HolidayTextColor;
                }
            }
        }
        
        if(!_afterTodayCanTouch)
        {
            if(calendarItem.type == FYFareCalendarNextType)
            {
                cell.dateLabel.textColor = FY_TouchUnableTextColor;
                cell.subLabel.textColor = FY_TouchUnableTextColor;
                cell.userInteractionEnabled = NO;
            }
        }
        if(!_beforeTodayCanTouch)
        {
            if(calendarItem.type == FYFareCalendarLastType)
            {
                cell.dateLabel.textColor = FY_TouchUnableTextColor;
                cell.subLabel.textColor = FY_TouchUnableTextColor;
                cell.userInteractionEnabled = NO;
            }
        }
    }
    return cell;
}

// 添加header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        FYFareCalendarCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FYFareCalendarCollectionReusableView" forIndexPath:indexPath];
        FYFareCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
        headerView.headerLabel.text = headerItem.headerText;
        return headerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FYFareCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
    FYFareCalendarModel *calendaItem = headerItem.calendarItemArray[indexPath.row];
    // 当开始日期为空时
    if(_startDate == 0)
    {
        _startDate = calendaItem.dateInterval;
        [self showPopViewWithIndexPath:indexPath];
    }
    // 当开始日期和结束日期同时存在时(点击为重新选时间段)
    else if(_startDate > 0 && _endDate > 0)
    {
        _startDate = calendaItem.dateInterval;
        _endDate = 0;
        [self showPopViewWithIndexPath:indexPath];
    }
    else
    {
        // 判断第二个选择日期是否比现在开始日期大
        if(_startDate < calendaItem.dateInterval)
        {
            _endDate = calendaItem.dateInterval;
            if([_delegate respondsToSelector:@selector(calendarViewSelectedWithStartDate:endDate:)])
            {
                [_delegate calendarViewSelectedWithStartDate:_startDate endDate:_endDate];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            _startDate = calendaItem.dateInterval;
            [self showPopViewWithIndexPath:indexPath];
        }
    }
    [_collectionView reloadData];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(_calendarView)
    {
        [_calendarView removeFromSuperview];
        _calendarView = nil;
    }
}

- (void)showPopViewWithIndexPath:(NSIndexPath *)indexPath;
{
    if(_showAlertView)
    {
        [_calendarView removeFromSuperview];
        _calendarView = nil;
        
        FYFareCalendarViewArrowPosition arrowPostion = FYFareCalendarViewArrowPositionMiddle;
        NSInteger position = indexPath.row % 7;
        if(position == 0)
        {
            arrowPostion = FYFareCalendarViewArrowPositionLeft;
        }
        else if(position == 6)
        {
            arrowPostion = FYFareCalendarViewArrowPositionRight;
        }
        
        FYFareCalendarCollectionViewCell *cell = (FYFareCalendarCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
        _calendarView = [[FYFareCalendarView alloc]initWithSideView:cell.dateLabel arrowPosition:arrowPostion];
        _calendarView.topLabelText = [NSString stringWithFormat:@"请选择%@日期",FY_SelectEndText];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"MM月dd日"FY_SelectBeginText];
        NSString *startDateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:_startDate]];
        _calendarView.bottomLabelText = startDateString;
        [_calendarView showWithAnimation];
    }
}

@end
