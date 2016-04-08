//
//  ViewController.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/1/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "ViewController.h"
#import "FYSecondController.h"

// 定义Block类型
typedef int (^newBlock)(int);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blueColor];
    
    int (^myNum)(int);
    myNum = ^(int num){
        NSLog(@"参数：%d", num);
        return 8;
    };
    
    int newNum = myNum(88);
    NSLog(@"新参数：%d", newNum);
    
    newBlock block = ^(int myNum) {
        NSLog(@"参数：%d", myNum);
        return 6;
    };
    block(7);
    
    // Block作为参数
    newBlock paraBlock = ^(int newNum) {
        NSLog(@"参数传递：newNum = %d", newNum);
        return 7;
    };
    
    [self objMethod:paraBlock];
    
    // block的循环引用(Circular reference)
    newBlock crBlock = ^(int num) {
//        [self GoToNext];
        return 0;
    };
    
    [self objMethod:crBlock];
    
    UIButton *goToNextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goToNextBtn.frame = CGRectMake(20, 100, 100, 50);
    goToNextBtn.backgroundColor = [UIColor redColor];
    [goToNextBtn setTitle:@"Go To Next" forState:UIControlStateNormal];
    [goToNextBtn addTarget:self
                    action:@selector(GoToNext)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goToNextBtn];
    
}

/**
 *  参数传递
 */
- (void)objMethod:(newBlock)block {
    // Block回调
    block(1);
}

- (void)GoToNext {
    
    FYSecondController *controller = [[FYSecondController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"The object gets dealloced.");
}

@end
