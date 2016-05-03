//
//  FYBanner.m
//  Pods
//
//  Created by Frankenstein Yang on 4/28/16.
//
//

#import <Masonry/Masonry.h>
#import <libextobjc/EXTScope.h>
#import <SDWebImage/SDWebImageManager.h>

#import "FYBanner.h"
#import "FYPageControl.h"
#import "FYBannerItem.h"

#define kFY_ITEM_WIDTH  (self.frame.size.width)
#define kFY_ITEM_HEIGHT (self.frame.size.height)
#define kFY_SAFE_BLOCK_RUN(block, ...) block ? block(__VA_ARGS__) : nil

@interface FYBanner () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView              *scrollView;
@property (nonatomic, strong) FYPageControl             *pageControl;
@property (nonatomic, copy  ) FYBannerResponseBlock     responseBlock;

@end

@implementation FYBanner

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
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.clipsToBounds = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(scrollViewTapped:)];
        [_scrollView addGestureRecognizer:tapGesture];
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
    
    @weakify(self);
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(self);
        make.center.mas_equalTo(self);
    }];
    
    [_pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self.mas_right).offset(-5);
        make.left.equalTo(self.mas_left).offset(5);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
        make.height.equalTo(@20);
    }];
    
}

#pragma mark - Setter

- (void)setBannerPlaceHolder:(UIImage *)bannerPlaceHolder {
    
    if (bannerPlaceHolder) {
        _bannerPlaceHolder = bannerPlaceHolder;
    }
}

- (void)setImageArray:(NSMutableArray *)imageArray {
    
    if (!imageArray || (imageArray && ![imageArray count])) {
        return;
    }
    _imageArray = imageArray;
    
    if (_imageArray.count) {
        
        // 首尾各加一张图片
        self.pageControl.hidden = YES;
        
        CGFloat width = kFY_ITEM_WIDTH * (_imageArray.count+2);
        CGSize size = CGSizeMake(width, kFY_ITEM_HEIGHT);
        self.scrollView.contentSize = size;
        
        // 中间视图
        for (NSInteger i = 0; i < _imageArray.count; i ++) {
            NSInteger tag = 100+i;
            [self buildSubViewOfScrollViewWithTag:tag andImageData:[_imageArray objectAtIndex:i]];
        }
        
        // 前视图
        NSInteger tag_head = 99;
        [self buildSubViewOfScrollViewWithTag:tag_head andImageData:[_imageArray lastObject]];
        
        // 后视图
        NSInteger tag_tail = 100 + [_imageArray count];
        [self buildSubViewOfScrollViewWithTag:tag_tail andImageData:[_imageArray firstObject]];
        
        [self gotoStartPostionAfterSetData];
    }
}

#pragma mark - 构建视图

- (void)buildSubViewOfScrollViewWithTag:(NSInteger)tag andImageData:(id)imageData {
    
    if ([self.scrollView viewWithTag:tag]) {
        [[self.scrollView viewWithTag:tag] removeFromSuperview];
    }
    
    NSInteger position;
    if (tag == 99) {
        position = 0;
    } else if (tag == (100 + [_imageArray count])){
        position = [_imageArray count]+1;
    } else {
        position = (tag - 100) + 1;
    }
    
    CGRect rect = CGRectMake(kFY_ITEM_WIDTH * position, 0, kFY_ITEM_WIDTH, kFY_ITEM_HEIGHT);
    FYBannerItem *item = [[FYBannerItem alloc] initWithFrame:rect
                                            placeHolderImage:_bannerPlaceHolder];
    
    item.tag = tag;
    [self.scrollView addSubview:item];
    
    if ([imageData isKindOfClass:[UIImage class]]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            item.url = nil;
            [item setImage:(UIImage *)imageData];
            if (self.pageControl.hidden) {
                self.pageControl.hidden = NO;
            }
        });
        
    } else if ([imageData isKindOfClass:[NSString class]]) {
        
        @weakify(self);
        [self downloadImageWithUrl:imageData relatedLink:imageData downloadImageCallBack:^(UIImage *image, NSString *link) {
            @strongify(self);
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    item.url = link;
                    [item setImage:image];
                    if (self.pageControl.hidden) {
                        self.pageControl.hidden = NO;
                    }
                });
            }
        }];
    }
}

- (void)gotoStartPostionAfterSetData {
    
    self.pageControl.numberOfPages = [_imageArray count];
    self.pageControl.currentPage = 0;
    [self scrollToIndex:0];
    CGFloat targetX = self.scrollView.contentOffset.x + self.scrollView.frame.size.width;
    targetX = (NSInteger)(targetX / kFY_ITEM_WIDTH) * kFY_ITEM_WIDTH;
    [self.scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
}


#pragma mark - 点击事件

- (void)scrollViewTapped:(UITapGestureRecognizer *)gesture {
    
    CGPoint point = [gesture locationInView:self.scrollView];
    NSInteger page = (NSInteger)point.x / (NSInteger)self.frame.size.width;
    
    FYBannerItem *item;
    NSInteger currentTag;
    if (page == 0) { // 首视图
        currentTag = 99;
    }else if (page == [self.imageArray count]+1){ // 尾视图
        currentTag = (100 + [_imageArray count]);
    }else{ // 中间视图
        currentTag = (page - 1 + 100);
    }
    
    if ([self.scrollView viewWithTag:currentTag] &&
        [[self.scrollView viewWithTag:currentTag] isKindOfClass:[FYBannerItem class]]) {
        
        item = (FYBannerItem *)[self.scrollView viewWithTag:currentTag];
        
        if (_responseBlock) {
            if (item.url && [item.url length]) {
                kFY_SAFE_BLOCK_RUN(_responseBlock, item.url);
            }
        }
    }
}

#pragma mark - ScrollView 代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat targetX = scrollView.contentOffset.x;
    if ([self.imageArray count] >= 1){
        if (targetX >= kFY_ITEM_WIDTH * ([self.imageArray count] + 1)) {
            targetX = kFY_ITEM_WIDTH;
            [self.scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }else if(targetX <= 0){
            targetX = kFY_ITEM_WIDTH *[self.imageArray count];
            [self.scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
        }
    }
    NSInteger page = (self.scrollView.contentOffset.x + kFY_ITEM_WIDTH / 2.0) / kFY_ITEM_WIDTH;
    
    if ([self.imageArray count] > 1){
        page --;
        if (page >= self.pageControl.numberOfPages){
            page = 0;
        }else if(page <0){
            page = self.pageControl.numberOfPages -1;
        }
    }
    self.pageControl.currentPage = page;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!decelerate){
        CGFloat targetX = _scrollView.contentOffset.x + _scrollView.frame.size.width;
        targetX = (NSInteger)(targetX / kFY_ITEM_WIDTH) * kFY_ITEM_WIDTH;
        [self.scrollView setContentOffset:CGPointMake((NSInteger)targetX, 0) animated:YES];
    }
}

- (void)scrollToIndex:(NSInteger)aIndex {
    if ([self.imageArray count]>1){
        if (aIndex >= ([self.imageArray count])){
            aIndex = [self.imageArray count]-1;
        }
        [self.scrollView setContentOffset:CGPointMake(kFY_ITEM_WIDTH * (aIndex+1), 0) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    [self scrollViewDidScroll:self.scrollView];
}



#pragma mark - 下载图片

- (void)downloadImageWithUrl:(NSString *)url
                 relatedLink:(NSString *)relatedlink
       downloadImageCallBack:(void (^)(UIImage *image,NSString *link))block {
    if (url && ([url isKindOfClass:[NSString class]] && [url length])) {
        [[SDImageCache sharedImageCache] queryDiskCacheForKey:url done:^(UIImage *image, SDImageCacheType cacheType) {
            if (!image) {
                [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageProgressiveDownload progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if (finished) {
                        [[SDWebImageManager sharedManager] saveImageToCache:image forURL:[NSURL URLWithString:url]];
                        kFY_SAFE_BLOCK_RUN(block, image, relatedlink ?: @"");
                    }
                }];
            }else{
                kFY_SAFE_BLOCK_RUN(block, image, relatedlink ?: @"");
            }
        }];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self makeConstraints];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    self.scrollView.frame = CGRectMake(0, 0, width, height);
    
    CGFloat contentSizeWidth = width * (_imageArray.count + 2);
    CGSize size = CGSizeMake(contentSizeWidth, kFY_ITEM_HEIGHT);
    self.scrollView.contentSize = size;
    [self layoutIfNeeded];
    
}

@end
