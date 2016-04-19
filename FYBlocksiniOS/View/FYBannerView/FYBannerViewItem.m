//
//  FYBannerViewItem.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/18/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYBannerViewItem.h"

@interface FYBannerViewItem ()

@property (nonatomic, copy, readwrite) NSString *imageURL;
@property (nonatomic, copy, readwrite) NSString *text;

@end

@implementation FYBannerViewItem

+ (instancetype)itemWithImageURL:(NSString *)imageURL text:(NSString *)text {

    FYBannerViewItem *item = [[FYBannerViewItem alloc] init];
    item.imageURL = imageURL;
    item.text = text;
    return item;
}

@end
