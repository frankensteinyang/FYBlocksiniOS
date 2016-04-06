//
//  ViewController.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/1/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "ViewController.h"

// 定义block类型
typedef int (^newBlock)(int);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
    
    // block作为参数
    newBlock paraBlock = ^(int newNum) {
        NSLog(@"参数传递：newNum = %d", newNum);
        return 7;
    };
    
    [self objMethod:paraBlock];
    
    // 回调
    [self objectMethod:^int(int a, int b) {
        NSLog(@"回调的block，a + b = %d", a + b);
        return a + b;
    }];
    
}

/**
 *  参数传递
 */
- (void)objMethod:(newBlock)block {
    // block回调
    block(1);
}

// block作为参数
- (void)objectMethod:(int (^)(int, int))callback {
    
    // 调用block
    callback(11, 13);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
