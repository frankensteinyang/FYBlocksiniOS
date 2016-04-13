//
//  FYParametricClass.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/14/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^classBlock)();

@interface FYParametricClass : NSObject

@property(nonatomic, copy) classBlock classBlock;

- (void)doSomething;

@end
