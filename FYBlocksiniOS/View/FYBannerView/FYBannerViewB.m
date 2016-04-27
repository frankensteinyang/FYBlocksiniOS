//
//  FYBannerView.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/18/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>

#import "FYBannerViewB.h"
#import "FYCollectionViewFlowLayout.h"
#import "FYCollectionViewCell.h"
#import "UIColor+FYImageAdditions.h"
#import "FYPageControl.h"

@interface FYBannerViewB () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) FYCollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong) FYPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation FYBannerViewB

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
    
}

- (void)initialize {
    
    self.collectionViewLayout = [[FYCollectionViewFlowLayout alloc] init];
    self.collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:self.collectionViewLayout];
    [self addSubview:self.collectionView];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    [self.collectionView registerClass:[FYCollectionViewCell class]
            forCellWithReuseIdentifier:@"FYCollectionViewCell"];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    // 不受Autosizing的控制
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // PageControl
    _pageControl = [[FYPageControl alloc] initWithFrame:CGRectMake(20, 100, 80, 20)];
    [_pageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_pageControl setPageControlStyle:PageControlStyleRect];
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{ @"collectionView" : self.collectionView }]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{ @"collectionView" : self.collectionView }]];
    
    self.itemSize = self.frame.size;
    self.itemSpacing = 0;
    
    _isAutoScroll = YES;
    _timeInterval = 5;
    
    [self setupTimer];
}

#pragma mark - Timer

- (void)setupTimer {
    
    [self teardownTimer];
    if (!self.isAutoScroll) {
        return;
    }
    
    self.timer = [NSTimer timerWithTimeInterval:self.timeInterval
                                         target:self
                                       selector:@selector(timerFire:)
                                       userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)teardownTimer {
    
    [self.timer invalidate];
}

- (void)timerFire:(NSTimer *)timer {
    
    CGFloat currentOffset = self.collectionView.contentOffset.x;
    CGFloat targetOffset = currentOffset + self.itemSize.width + self.itemSpacing;
    
    [self.collectionView setContentOffset:CGPointMake(targetOffset, self.collectionView.contentOffset.y) animated:YES];
}

#pragma mark - Setter and Getter

- (void)setItems:(NSArray<FYBannerViewItem *> *)items {
    
    if (items.count == 0) {
        
        _pageControl.hidesForSinglePage = YES;
        return;
    }
    
    NSMutableArray *mutableItems = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < 3; i ++) {
        [mutableItems addObjectsFromArray:items];
    }
    _items = mutableItems.copy;
    
    [_pageControl setNumberOfPages:items.count];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:items.count inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        });
    });
    
}

- (void)setItemSize:(CGSize)itemSize {
    
    _itemSize = itemSize;
    self.collectionViewLayout.itemSize = itemSize;
}

- (void)setItemSpacing:(CGFloat)itemSpacing {
    
    _itemSpacing = itemSpacing;
    self.collectionViewLayout.minimumLineSpacing = itemSpacing;
}

- (void)setIsAutoScroll:(BOOL)isAutoScroll {
    
    _isAutoScroll = isAutoScroll;
    [self setupTimer];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    
    _timeInterval = timeInterval;
    [self setupTimer];
}

- (UIImage *)placeholderImage {
    
    if (!_placeholderImage) {
        UIColor *color = [UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1];
        _placeholderImage = [color fy_imageSized:self.itemSize];
    }
    return _placeholderImage;
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString *identifier = @"FYCollectionViewCell";
    FYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                           forIndexPath:indexPath];
    
    FYBannerViewItem *item = self.items[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:item.imageURL]
                      placeholderImage:self.placeholderImage];
    
    cell.label.text = item.text;
    return cell;
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.didSelectItemAtIndex) {
        self.didSelectItemAtIndex(indexPath.row % (self.items.count / 3));
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = self.itemSize.width + self.itemSpacing;
    CGFloat periodOffset = pageWidth * (self.items.count / 3);
    CGFloat offsetActivatingMoveToBeginning = pageWidth * ((self.items.count / 3) * 2);
    CGFloat offsetActivatingMoveToEnd = pageWidth * ((self.items.count / 3) * 1);
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
//    NSUInteger currentPage = periodOffset / offsetX - 1;
    
    NSLog(@"currentPage %d ---- %d", _pageControl.currentPage, self.items.count);
//    NSLog(@"pageWidth %f", pageWidth);
//    NSLog(@"periodOffset %f", periodOffset);
//    NSLog(@"offsetX %f", offsetX);
//    NSLog(@"offsetActivatingMoveToBeginning %f", offsetActivatingMoveToBeginning);
//    NSLog(@"offsetActivatingMoveToEnd %f", offsetActivatingMoveToEnd);
//    if (([self.items count] / 3) > 1){
//        page --;
//        if (page >= self.pageControl.numberOfPages){
//            page = 0;
//        }else if(page <0){
//            page = self.pageControl.numberOfPages -1;
//        }
//    }
//    self.pageControl.currentPage = page;
    
    if (offsetX > offsetActivatingMoveToBeginning) {
        scrollView.contentOffset = CGPointMake((offsetX - periodOffset), 0);
    } else if (offsetX < offsetActivatingMoveToEnd) {
        scrollView.contentOffset = CGPointMake((offsetX + periodOffset), 0);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self teardownTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    
    [self setupTimer];
}

@end
