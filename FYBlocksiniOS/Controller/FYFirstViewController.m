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
#import "FYParametricClass.h"

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
    
    //*****Tips*****
    // 怎么使用block: 如一个对象在运行，而需要知道另一个对象什么时候运行完成，就需要设一个
    // 回调函数，代理和block的使用要根据情况，有的地方用代理有点大材小用
    //*****Tips*****
    
    // 深入探究block循环引用(Circular reference)
    // http://blog.oneiv.com/blog/Block-4.html
    // http://www.jianshu.com/p/7a9c8c8e53a0
    
    FYParametricClass *class = [[FYParametricClass alloc] init];
    __weak FYParametricClass *weakClass = class;
    class.classBlock = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakClass doSomething];
        });
    };
    class.classBlock();
}

- (void)backBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    
    NSLog(@"FYFirstViewController gets dealloced!");
}

@end
