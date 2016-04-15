//
//  FYParametricClass.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/14/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <libextobjc/EXTScope.h>

#import "FYParametricClass.h"

@implementation FYParametricClass

- (instancetype)init {

    self = [super init];
    
    __block typeof(self) temp = self;
//    __weak typeof(self) weak_self = self;
//    @weakify(self);
    block = ^{
//        @strongify(self);
//        NSLog(@"self = %@", self);
//        NSLog(@"self = %@", weak_self);
        NSLog(@"self = %@", temp);
        temp = nil;
    };
    
    // 如果这里不调用block, temp = nil 将永远只是被暂存在block里，造成循环引用
    block();
    return self;
    
}

- (void)doSomething {
    
    NSLog(@"I did something wrong!");
    
}

- (void)dealloc {

    NSLog(@"FYParametricClass gets dealloced!");
}

@end
