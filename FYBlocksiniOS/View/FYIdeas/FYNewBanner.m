//
//  FYNewBanner.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 5/2/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImageManager.h>

#import "FYNewBanner.h"
#import "FYPageControl.h"

#define kFY_ITEM_WIDTH  (self.frame.size.width)
#define kFY_ITEM_HEIGHT (self.frame.size.height)
#define kFY_SAFE_BLOCK_RUN(block, ...) block ? block(__VA_ARGS__) : nil

@interface FYNewBanner () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView          *scrollView;
@property (nonatomic, strong) FYPageControl         *pageControl;
@property (nonatomic, copy  ) FYBannerResponseBlock responseBlock;
// 用来缓存imageView
@property (nonatomic, strong) NSMutableDictionary   *imageViewsStore;
// 用来缓存banner图片
@property (nonatomic, strong) NSMutableArray        *bannerImages;
// 当前翻页的索引
@property (nonatomic, assign) NSInteger             currentPagingIndex;

@end

@implementation FYNewBanner

- (void)dealloc {
    
    _scrollView.delegate = nil;
    _scrollView = nil;
    _pageControl = nil;
    _bannerPlaceHolder = nil;
    
    if (_responseBlock) {
        _responseBlock = nil;
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame responseBlock:(FYBannerResponseBlock)block {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        
        [self makeConstraints];
        
        _responseBlock = [block copy];
        
    }
    return self;
    
}

#pragma mark - 懒加载

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.clipsToBounds = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        
    }
    return _scrollView;
    
}

- (FYPageControl *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [[FYPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.currentPage = 0;
        [_pageControl setPageControlStyle:PageControlStyleRect];
    }
    return _pageControl;
    
}

#pragma mark - 约束

- (void)makeConstraints {
    
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self);
        make.center.mas_equalTo(self);
    }];
    
    [_pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-5);
        make.left.equalTo(self.mas_left).offset(5);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
        make.height.equalTo(@20);
    }];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake((_imageArray.count + 2) * self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
}

#pragma mark - Setter

- (void)setBannerPlaceHolder:(UIImage *)bannerPlaceHolder {
    if (bannerPlaceHolder) {
        _bannerPlaceHolder = bannerPlaceHolder;
    }
}

- (void)resetImageViewForPageIndex:(NSInteger)pageIndex {
    
    UIImageView *idleImageView = [self idleImageView];
    if (idleImageView) {
        
        idleImageView.image = [self.bannerImages objectAtIndex:pageIndex];
        // 重新设置frame
        CGRect frame = idleImageView.frame;
        frame.origin.x = pageIndex * frame.size.width;
        idleImageView.frame = frame;
        
        // 重新缓存
        [self.imageViewsStore setObject:idleImageView forKey:@(pageIndex)];
    }
}

/**
 *  翻页结束
 */
- (void)didPaginged {
    
    // 检查当前图片左侧是否有imageView
    NSInteger leftIndex = self.currentPagingIndex - 1;
    if (leftIndex >= 0) {
        UIImageView *leftImageView = [self.imageViewsStore objectForKey:@(leftIndex)];
        if (!leftImageView) {
            
            [self resetImageViewForPageIndex:leftIndex];
        }
    }
    
    // 检查当前图片右侧是否有imageView
    NSInteger rightIndex = self.currentPagingIndex + 1;
    if (rightIndex < self.imageArray.count) {
        
        UIImageView *rightImageView = [self.imageViewsStore objectForKey:@(rightIndex)];
        if (!rightImageView) {
            
            [self resetImageViewForPageIndex:rightIndex];
        }
    }
}

/**
 *  寻找闲置的imageview
 *
 */
- (UIImageView *)idleImageView {
    
    // 先查找左侧闲置的imageView
    NSInteger idleIndex = self.currentPagingIndex - 2;
    UIImageView *idleImageView = [self.imageViewsStore objectForKey:@(idleIndex)];
    if (!idleImageView) {
        
        // 右侧闲置的imageView
        idleIndex = self.currentPagingIndex + 2;
        idleImageView = [self.imageViewsStore objectForKey:@(idleIndex)];
    }
    // 从imageViewsStore中移除
    [self.imageViewsStore removeObjectForKey:@(idleIndex)];
    return idleImageView;
}

- (void)initBannerItems {
    
    // 最多创建3个 (左 | 中 | 右) 当图片小于3个时，则创建图片数量个数的imageview
    NSInteger imageViewCount = self.imageArray.count > 3 ? 3 : self.imageArray.count;
    self.imageViewsStore = [[NSMutableDictionary alloc] initWithCapacity:imageViewCount];
    
    for (NSInteger i = 0; i < imageViewCount; i++) {
        
        // 宽高 frame
        CGFloat width = self.scrollView.frame.size.width;
        CGFloat height = self.scrollView.frame.size.height;
        CGRect frame = CGRectMake(i * width, 0, width, height);
        
        // imageView
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = self.bannerPlaceHolder;
        
        // 宽高自动伸缩，左右距离自动伸缩
        imageView.autoresizingMask =    UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
        imageView.tag = i;
        
        // 存储imageView
        [self.imageViewsStore setObject:imageView forKey:@(i)];
        
        // 添加到scrollView中
        [self.scrollView addSubview:imageView];
    }
    
}

- (void)setupScrollViewConntentSize {
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.imageArray.count,
                                             self.scrollView.frame.size.height);
}

- (void)setupScrollViewPaging {
    
    self.pageControl.hidden = NO;
    self.pageControl.numberOfPages = [self.imageArray count];
}


- (void)reloadImage:(UIImage *)image
          withIndex:(NSInteger)imageIndex {
    
    UIImageView *bannerImageView = [self.imageViewsStore objectForKey:@(imageIndex)];
    if (bannerImageView) {
        bannerImageView.image = image;
    }
}

- (void)setImageArray:(NSMutableArray *)imageArray {
    
    if (!imageArray.count) {
        return;
    }
    _imageArray = imageArray;
    
    // 初始化bannerItems
    [self initBannerItems];
    
    // 设置scrollView翻页相关
    [self setupScrollViewConntentSize];
    [self setupScrollViewPaging];
    
    // 初始化存储图片的bannerImages并进行填充
    self.bannerImages = [[NSMutableArray alloc] initWithCapacity:imageArray.count];
    for (NSInteger i = 0; i < imageArray.count; i++) {
        [self.bannerImages addObject:@(0)];
    }
    
    // 下载图片
    NSInteger imageIndex = 0;
    for (NSString *imageURL in imageArray) {
        
        [self downloadImageWithUrl:imageURL relatedLink:imageURL downloadImageCallBack:^(UIImage *image, NSString *link) {
            if (image) {
                
                [self.bannerImages replaceObjectAtIndex:imageIndex withObject:image];
                // 重新加载索引对应的图片
                [self reloadImage:image withIndex:imageIndex];
            }
        }];
        
        imageIndex ++;
    }
    
}


#pragma mark - ScrollView 代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat contentOffsetX          = self.scrollView.contentOffset.x;
    NSInteger pageIndex             = contentOffsetX / self.scrollView.frame.size.width;
    
    self.currentPagingIndex         = pageIndex;
    self.pageControl.currentPage    = self.currentPagingIndex;
    
    [self didPaginged];
}


#pragma mark - 下载图片

- (void)downloadImageWithUrl:(NSString *)url
                 relatedLink:(NSString *)relatedlink
       downloadImageCallBack:(void (^)(UIImage *image, NSString *link))block {
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:url]
                                                    options:SDWebImageProgressiveDownload
                                                   progress:nil
                                                  completed:^(UIImage *image,
                                                              NSError *error,
                                                              SDImageCacheType cacheType,
                                                              BOOL finished,
                                                              NSURL *imageURL) {
                                                      
                                                      if (finished) {
                                                          kFY_SAFE_BLOCK_RUN(block, image, relatedlink ?: @"");
                                                      }
                                                  }];
}

@end
