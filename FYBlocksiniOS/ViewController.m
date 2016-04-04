//
//  ViewController.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/1/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "ViewController.h"

// 定义Block类型
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
    
    // Block作为参数
    newBlock paraBlock = ^(int newNum) {
        NSLog(@"参数传递：newNum = %d", newNum);
        return 7;
    };
    
    [self objMethod:paraBlock];
    
}

/**
 *  参数传递
 */
- (void)objMethod:(newBlock)block {
    // Block回调
    block(1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
