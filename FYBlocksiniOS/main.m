//
//  main.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/1/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    
    @autoreleasepool {
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
