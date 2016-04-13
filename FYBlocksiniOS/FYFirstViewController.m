//
//  FYFirstViewController.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/9/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <libextobjc/EXTScope.h>

#import "FYFirstViewController.h"

@implementation FYFirstViewController

- (void)viewDidLoad {

    @weakify(self);
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    [backBtn addTarget:self
                action:@selector(backBtnClicked)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
}

- (void)backBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    
    NSLog(@"FYFirstViewController gets dealloced!");
}

@end
