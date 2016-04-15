//
//  FYSecondViewController.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/8/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <libextobjc/EXTScope.h>

#import "FYSecondViewController.h"

@implementation FYSecondViewController

- (void)viewDidLoad {
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    
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
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    /** __blcok关键字的神奇功效 **
     *  如果需要在调用之前，变量的修改都会影响 block 内部对这个变量的使用，
     *  换句话说，block 对变量不再是简单的值复制，而是动态的"监听"值的变化，
     *  然后在调用的时候读取变量的值。需要对这个变量添加一个__block修饰。
     */
    __block int x = 10;
    void (^printXAndY)(int) = ^(int y) {
//        x = 11;
        NSLog(@"x equals %d, y equals %d.", x, y);
    };
    x = 12; // block 会「动态」识别外部变量的变化，输出 x equals 12
    printXAndY(13);
    
    /** 变量和指针所指向的变量的区别 **
     *  这里的 [str appendString:@"stein"]; 不报错是因为 str 是指
     *  向@"Franken"的函数指针, [str appendString:@"stein"] 并不是
     *  修改 str 存储的值,本质上是 str 向@"Franken"发送了一条 appendString 消
     *  息,然后再更改@"Franken"为@"Frankenstein",而 str 存储的指
     *  向@"Frankenstein"对象的指针没有发生变化。所以, block 本质是不能
     *  修改变量存储的值,但是消息分发依旧有效。
     */
    NSMutableString *str = [NSMutableString stringWithFormat:@"Franken"];
    void (^printStr)() = ^ {
        [str appendString:@"stein"];
        NSLog(@"I am %@.", str);
    };
    printStr();
    
}

- (void)backBtnClicked {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)dealloc {

    NSLog(@"FYSecondViewController gets dealloced!");
}

@end
