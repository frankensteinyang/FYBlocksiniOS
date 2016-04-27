//
//  FYBannerViewController.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/17/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <libextobjc/EXTScope.h>

#import "UIColor+FYImageAdditions.h"

#import "FYBannerViewController.h"
#import "FYBannerViewItem.h"
#import "FYBannerViewB.h"
#import "FYBannerView.h"

@interface FYBannerViewController ()

@property (nonatomic, strong) FYBannerViewB *bannerView;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIView *roundRect;

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
    
    CGRect rect = CGRectMake(20, 360, self.view.frame.size.width - 40, 105);
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.imageArray];
    
    // RoundRectStyleTwoRoundedCorners RoundRectStyleDefault
    FYBannerView *view = [[FYBannerView alloc] initWithFrame:rect imageData:array bannerStyle:RoundRectStyleTwoRoundedCorners responseBlock:^(NSString *url) {
        //
    }];
    
    [self.view addSubview:view];
    
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
