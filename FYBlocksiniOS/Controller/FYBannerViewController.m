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
#import "FYNewBanner.h"

typedef enum : NSUInteger {
    FYContainerStatusTypeSmaller,
    FYContainerStatusTypeBigger,
} FYContainerStatusType;

@interface FYBannerViewController ()

@property (nonatomic, strong) FYBanner *banner;
@property (nonatomic, strong) FYNewBanner *newBanner;
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, assign) FYContainerStatusType status;
@property (nonatomic, strong) UIView *magicContainer;
@property (nonatomic, strong) UIView *amazingContainer;

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *magicBtn;
@property (nonatomic, strong) UIButton *amazingBtn;

@end

@implementation FYBannerViewController

- (void)viewDidLoad {
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.magicBtn];
    [self.view addSubview:self.magicContainer];
    [_magicContainer addSubview:self.banner];
    [self.view addSubview:self.amazingBtn];
    [self.view addSubview:self.amazingContainer];
    [_amazingContainer addSubview:self.newBanner];
    
    [self makeConstraints];
    
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

#pragma mark - 懒加载


- (UIView *)magicContainer {
    
    if (!_magicContainer) {
        
        _magicContainer = [[UIView alloc] init];
        _magicContainer.layer.cornerRadius = 4;
        _magicContainer.clipsToBounds = YES;
        _magicContainer.backgroundColor = [UIColor grayColor];
        
    }
    return _magicContainer;
    
}

- (UIView *)amazingContainer {
    
    if (!_amazingContainer) {
        _amazingContainer = [[UIView alloc] init];
        _amazingContainer.layer.cornerRadius = 8;
        _amazingContainer.clipsToBounds = YES;
        _amazingContainer.backgroundColor = [UIColor brownColor];
    }
    return _amazingContainer;
    
}

- (UIButton *)backBtn {
    
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _backBtn.backgroundColor = [UIColor whiteColor];
        [_backBtn setTitle:@"Back" forState:UIControlStateNormal];
        [_backBtn addTarget:self
                     action:@selector(backBtnClicked)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
    
}

- (UIButton *)magicBtn {
    
    if (!_magicBtn) {
        _magicBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _magicBtn.backgroundColor = [UIColor whiteColor];
        [_magicBtn setTitle:@"Magic" forState:UIControlStateNormal];
        [_magicBtn addTarget:self
                      action:@selector(magicBtnClicked)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _magicBtn;
    
}

- (UIButton *)amazingBtn {
    
    if (!_amazingBtn) {
        _amazingBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _amazingBtn.backgroundColor = [UIColor whiteColor];
        [_amazingBtn setTitle:@"Amazing" forState:UIControlStateNormal];
        [_amazingBtn addTarget:self
                        action:@selector(amazingBtnClicked)
              forControlEvents:UIControlEventTouchUpInside];
    }
    return _amazingBtn;
    
}

- (void)magicBtnClicked {
    
    if (self.status == FYContainerStatusTypeSmaller) {
        [self magicConstraints:FYContainerStatusTypeBigger];
    } else {
        [self magicConstraints:FYContainerStatusTypeSmaller];
    }
}

- (void)amazingBtnClicked {
    
    if (self.status == FYContainerStatusTypeSmaller) {
        [self magicConstraints:FYContainerStatusTypeBigger];
    } else {
        [self magicConstraints:FYContainerStatusTypeSmaller];
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

- (FYNewBanner *)newBanner {
    
    if (!_newBanner) {
        _newBanner = [[FYNewBanner alloc] initWithFrame:CGRectZero responseBlock:^(NSString *url) {
            NSLog(@"%s", __FUNCTION__);
        }];
    }
    return _newBanner;
    
}

#pragma mark - 约束

- (void)makeConstraints {
    
    [_magicContainer setBackgroundColor:[UIColor redColor]];
    [_magicContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_magicBtn.mas_bottom).offset(30);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(105);
    }];
    [_banner mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.magicContainer);
        make.center.equalTo(self.magicContainer);
        make.size.equalTo(self.magicContainer);
    }];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(29);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [_magicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_backBtn.mas_bottom).with.offset(5);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [_amazingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_banner.mas_bottom).with.offset(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
}

- (void)magicConstraints:(FYContainerStatusType)status {
    
    self.status = status;
    if (self.status == FYContainerStatusTypeSmaller) {
        
        [_magicContainer setBackgroundColor:[UIColor brownColor]];
        [_magicContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_magicBtn.mas_bottom).offset(30);
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.height.mas_equalTo(105);
        }];
        [_banner mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.magicContainer);
            make.center.equalTo(self.magicContainer);
            make.size.equalTo(self.magicContainer);
        }];
        
    } else {
        
        [_magicContainer setBackgroundColor:[UIColor redColor]];
        [_magicContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_magicBtn.mas_bottom).offset(30);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.height.mas_equalTo(105);
        }];
        [_banner mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.magicContainer);
            make.center.equalTo(self.magicContainer);
            make.size.equalTo(self.magicContainer);
        }];
    }
}

- (void)amazingConstraints:(FYContainerStatusType)status {
    
    self.status = status;
    if (self.status == FYContainerStatusTypeSmaller) {
        
        [_amazingContainer setBackgroundColor:[UIColor brownColor]];
        [_amazingContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_magicBtn.mas_bottom).offset(30);
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.height.mas_equalTo(105);
        }];
        [_newBanner mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.amazingContainer);
            make.center.equalTo(self.amazingContainer);
            make.size.equalTo(self.amazingContainer);
        }];
        
    } else {
        
        [_amazingContainer setBackgroundColor:[UIColor redColor]];
        [_amazingContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_magicBtn.mas_bottom).offset(30);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.height.mas_equalTo(105);
        }];
        [_newBanner mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.amazingContainer);
            make.center.equalTo(self.amazingContainer);
            make.size.equalTo(self.amazingContainer);
        }];
    }
    
}

- (void)setNeedsUpdateConstraints {
    
    [self magicConstraints:212];
}

- (void)dealloc {
    
    NSLog(@"FYBannerViewController gets dealloced!");
}

@end
