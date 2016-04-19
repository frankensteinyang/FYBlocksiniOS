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

@interface FYBannerViewController ()

@property (nonatomic, strong) FYBannerView *bannerView;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemSpacing;

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
    self.bannerView = [[FYBannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), self.itemSize.height)];
    [self.view addSubview:self.bannerView];
    
//    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.bottom.equalTo(self.view.mas_bottom);
//        make.right.equalTo(self.view.mas_right);
//        make.left.equalTo(self.view.mas_left);
//        make.height.mas_equalTo(150);
//    }];
    
    self.bannerView.itemSize = self.itemSize;
    self.bannerView.itemSpacing = self.itemSpacing;
    
    self.bannerView.isAutoScroll = YES;
    self.bannerView.timeInterval = 2.0;
    
    UIColor *color = [UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1];
    self.bannerView.placeholderImage = [color fy_imageSized:self.itemSize];
    self.bannerView.didSelectItemAtIndex = ^(NSUInteger index) {
        NSLog(@"Did select item at index : %@", @(index));
    };
    self.bannerView.items = self.items;
    NSLog(@"%lu", (unsigned long)[self.bannerView.items count]);
    
}

- (NSArray *)items {
    NSArray *imgURLs = nil;
    imgURLs = @[
                @"http://file11.zk71.com/File/CorpProductImages/2015/10/14/3_bianpinqi_5120_1_20151014163756.jpg",
                @"http://a4.mzstatic.com/us/r30/Features49/v4/77/73/3b/77733b19-2fb6-be1a-6a5e-8e01c30d2c94/flowcase_640_260_2x.jpeg",
                @"http://img.taopic.com/uploads/allimg/140102/234988-1401020QU589.jpg"
                ];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSString *imageURL in imgURLs) {
        FYBannerViewItem *item = [FYBannerViewItem itemWithImageURL:imageURL text:nil];
        [items addObject:item];
    }
    
    return items.copy;
    
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
