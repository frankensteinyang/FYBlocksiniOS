//
//  FYBannerViewItem.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/18/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYBannerViewItem : NSObject

@property (nonatomic, copy, readonly) NSString *imageURL;
@property (nonatomic, copy, readonly) NSString *text;

+ (instancetype)itemWithImageURL:(NSString *)imageURL text:(NSString *)text;

@end
