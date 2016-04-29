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

#import "FYBanner.h"

#define kFY_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

typedef enum : NSUInteger {
    FYContainerStatusTypeSmaller,
    FYContainerStatusTypeBigger,
} FYContainerStatusType;

@interface FYBannerViewController ()

@property (nonatomic, strong) FYBanner *banner;
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic,assign) FYContainerStatusType status;
@property (nonatomic,strong) UIView *container;

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
    
    UIButton *magicBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    magicBtn.backgroundColor = [UIColor whiteColor];
    [magicBtn setTitle:@"Magic" forState:UIControlStateNormal];
    [magicBtn addTarget:self
                action:@selector(magicBtnClicked)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:magicBtn];
    [magicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(backBtn.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [self.view addSubview:self.container];
    [_container addSubview:self.banner];
    [self remakeConstraint:100];
    
    
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

- (void)backBtnClicked {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc] init];
        _container.layer.cornerRadius = 4;
        _container.clipsToBounds = YES;
        _container.backgroundColor = [UIColor grayColor];
        
    }
    return _container;
    
}

- (void)magicBtnClicked {
    
    if (self.status == FYContainerStatusTypeSmaller) {
        [self remakeConstraint:FYContainerStatusTypeBigger];
    } else {
        [self remakeConstraint:FYContainerStatusTypeSmaller];
    }
}

- (FYBanner *)banner {
    
    if (!_banner) {
        _banner = [[FYBanner alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen ].bounds.size.width, 120) responseBlock:^(NSString *url) {
            NSLog(@"%s", __FUNCTION__);
        }];
        _banner.imageArray = [NSMutableArray arrayWithArray:self.imageArray];
    }
    return _banner;
    
}

- (void)remakeConstraint:(FYContainerStatusType)status {
    
    @weakify(self);
    self.status = status;
    if (self.status == FYContainerStatusTypeSmaller) {
        
        [_container setBackgroundColor:[UIColor brownColor]];
        [_container mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.view.mas_top).offset(200);
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.height.mas_equalTo(kFY_SCREEN_WIDTH - 200);
        }];
        [_banner mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.edges.equalTo(self.container);
            make.center.equalTo(self.container);
            make.size.equalTo(self.container);
        }];
        
    } else {
        
        [_container setBackgroundColor:[UIColor redColor]];
        [_container mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.equalTo(self.view.mas_top).with.offset(200);
            make.left.equalTo(self.view.mas_left).with.offset(10);
            make.right.equalTo(self.view.mas_right).with.offset(-10);
            make.height.mas_equalTo(kFY_SCREEN_WIDTH - 200);
        }];
        [_banner mas_updateConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.edges.equalTo(self.container);
            make.center.equalTo(self.container);
            make.size.equalTo(self.container);
        }];
    }
    
}

- (void)setNeedsUpdateConstraints {
    
    [self remakeConstraint:212];
}

- (void)dealloc {
    
    NSLog(@"FYBannerViewController gets dealloced!");
}

@end
