//
//  FYBannerViewController.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/17/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <libextobjc/EXTScope.h>

#import "FYBannerViewController.h"
#import "FYBannerView.h"
#import "FYBannerViewItem.h"
#import "UIColor+FYImageAdditions.h"
#import "FYBanner.h"

@interface FYBannerViewController ()

@property (nonatomic, strong) FYBannerView *bannerView;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, copy) NSArray<FYBannerViewItem *> *items;

@end
@implementation FYBannerViewController

- (void)viewDidLoad {
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    @weakify(self);
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
    
    // Banner
//    self.bannerView = [[FYBannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), self.itemSize.height)];
//    self.bannerView = [[FYBannerView alloc] init];
//    [self.view addSubview:self.bannerView];
//    
//    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.bottom.equalTo(self.view.mas_bottom);
//        make.right.equalTo(self.view.mas_right);
//        make.left.equalTo(self.view.mas_left);
//        make.height.mas_equalTo(150);
//    }];
//    
//    self.bannerView.itemSize = self.itemSize;
//    self.bannerView.itemSpacing = self.itemSpacing;
//    
//    self.bannerView.isAutoScroll = YES;
//    self.bannerView.timeInterval = 2.0;
//    
//    UIColor *color = [UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1];
//    self.bannerView.placeholderImage = [color fy_imageSized:self.itemSize];
//    self.bannerView.didSelectItemAtIndex = ^(NSUInteger index) {
//        NSLog(@"Did select item at index : %@", @(index));
//    };
//    self.bannerView.items = self.items;
//    NSLog(@"%lu", (unsigned long)[self.bannerView.items count]);
    
    // 另一种Banner思路
    FYBanner *banner = [[FYBanner alloc] initWithContainerView:self.view responseBlock:^(NSString *link) {
        NSLog(@"the link of the image you pressed is %@", link);
    }];
    banner.frame = CGRectMake(20, 200, self.view.frame.size.width - 40, 105);
    // 设置placeHolder image
//        banner.placeHolder = [UIImage imageNamed:@"Frankenstein.jpg"];
    banner.duration = 1.5;
    banner.imageArray = [NSMutableArray arrayWithArray:self.imageArray];
    NSLog(@"%@", NSStringFromCGRect(banner.frame));
    
}

- (NSArray *)items {
    NSArray *imgURLs = nil;
    imgURLs = @[
                @"http://image.photophoto.cn/nm-8/056/001/0560010001.jpg",
                @"http://image.photophoto.cn/nm-8/056/002/0560020026.jpg",
                @"http://image.photophoto.cn/nm-8/056/002/0560020022.jpg",
                @"http://image.photophoto.cn/nm-8/056/001/0560010012.jpg",
                @"http://image.photophoto.cn/nm-8/056/002/0560020017.jpg",
                @"http://image.photophoto.cn/nm-8/056/002/0560020015.jpg"];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSString *imageURL in imgURLs) {
        FYBannerViewItem *item = [FYBannerViewItem itemWithImageURL:imageURL text:nil];
        [items addObject:item];
    }
    
    return items.copy;
    
}

- (NSArray *)imageArray {
    
    if (!_imageArray) {
        _imageArray = @[
                        @"http://image.photophoto.cn/nm-8/056/001/0560010001.jpg",
                        @"http://image.photophoto.cn/nm-8/056/002/0560020026.jpg",
                        @"http://image.photophoto.cn/nm-8/056/002/0560020022.jpg",
                        @"http://image.photophoto.cn/nm-8/056/001/0560010012.jpg",
                        @"http://image.photophoto.cn/nm-8/056/002/0560020017.jpg",
                        @"http://image.photophoto.cn/nm-8/056/002/0560020015.jpg"];
    }
    return _imageArray;
    
}

- (CGSize)itemSize {
    
    return CGSizeMake(320, 130);
}

- (CGFloat)itemSpacing {
    
    return 0;
}

- (void)backBtnClicked {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)dealloc {
    
    NSLog(@"FYBannerViewController gets dealloced!");
}

@end
