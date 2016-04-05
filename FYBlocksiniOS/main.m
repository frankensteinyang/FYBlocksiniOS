//
//  main.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/1/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

void blockTest();

int main(int argc, char * argv[]) {
    
    @autoreleasepool {
        
        blockTest();
        return 0;
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    
    // Block封装、保存代码，可以在任何时候执行
    // Block可作为函数的参数、返回值
    // Block苹果推荐，效率非常高
    // Block实现了通信时对象之间的解耦
//    void (^myBlock)() = ^{
//        NSLog(@"Frankenstein!");
//    };
//    
//    myBlock();
//    myBlock();
//    
//    return 0;
    
}

void blockTest() {
    
    int age = 10;
    void (^block)() = ^{
        NSLog(@"年龄：%d", age);
    };
    
    // Block练习题，这里赋值后打印仍然为10，这里的赋值不会影响到block里的age
    age = 20;
    
    block();
}