//
//  FYMRCBlockClass.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/15/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYMRCBlockClass.h"

typedef long (^MRCBlock)(int, int);

@implementation FYMRCBlockClass

- (instancetype)init {
    
    self = [super init];
    
    MRCBlock blockA = ^long (int a, int b) {
        return a + b;
    };
    NSLog(@"blockA = %@", blockA);
    
    int base = 10;
    MRCBlock blockB = ^long (int a, int b) {
        return base + a + b;
    };
    NSLog(@"blockB = %@", blockB);
    
    MRCBlock blockC = [[blockB copy] autorelease];
    NSLog(@"blockC = %@", blockC);
    
    return self;
}

- (void)dealloc {
    
    [super dealloc];
    NSLog(@"FYMRCBlockClass gets dealloced!");
}

@end
