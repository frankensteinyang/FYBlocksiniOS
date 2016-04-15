//
//  FYParametricClass.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/14/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^classBlock)();
typedef void (^crBlock)(void);

@interface FYParametricClass : NSObject {

    crBlock block;
}

/**
 *  1、默认情况下，block 是放在栈里面的
 *  2、一旦blcok进行了copy操作，block的内存就会被放在堆里面
 *  3、堆里面的block（被copy过的block）有以下现象:
 *      1> block内部如果通过外面声明的强引用来使用，
 *      那么block内部会自动产生一个强引用指向所使用的对象。
 *      2> block内部如果通过外面声明的弱引用来使用，
 *      那么block内部会自动产生一个弱引用指向所使用的对象。
 */
@property(nonatomic, copy) classBlock classBlock;

- (void)doSomething;

@end
