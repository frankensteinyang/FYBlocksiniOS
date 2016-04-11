//
//  FYFirstViewController.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/9/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYFirstViewController.h"

@implementation FYFirstViewController

- (void)viewDidLoad {

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.frame = CGRectMake(20, 100, 100, 50);
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    [backBtn addTarget:self
                action:@selector(backBtnClicked)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
}

- (void)backBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    
    NSLog(@"FYFirstViewController gets dealloced!");
}

@end
