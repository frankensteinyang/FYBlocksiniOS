//
//  FYARCBlockClass.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/15/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYARCBlockClass.h"

typedef long (^ARCBlock)(int, int);

@implementation FYARCBlockClass

- (instancetype)init {
    
    self = [super init];
    
    ARCBlock blockA = ^long (int a, int b) {
        return a + b;
    };
    NSLog(@"blockA = %@", blockA);
    
    int base = 10;
    ARCBlock blockB = ^long (int a, int b) {
        return base + a + b;
    };
    NSLog(@"blockB = %@", blockB);
    
    __block int sum = 11;
    ARCBlock blockC = ^long (int a, int b) {
        return sum + a + b;
    };
    NSLog(@"blockC = %@", blockC);
    
    return self;
}

- (void)dealloc {
    NSLog(@"FYARCBlockClass gets dealloced!");
}

@end
