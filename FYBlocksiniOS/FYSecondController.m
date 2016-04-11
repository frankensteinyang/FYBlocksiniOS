//
//  FYSecondController.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/8/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYSecondController.h"

@implementation FYSecondController

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

    NSLog(@"Oh my God!");
}

@end
