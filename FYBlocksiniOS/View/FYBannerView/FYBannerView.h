//
//  FYBannerView.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/18/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYBannerViewItem.h"

@interface FYBannerView : UIView

@property (nonatomic, copy) NSArray<FYBannerViewItem *> *items;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) BOOL isAutoScroll;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, copy) void (^didSelectItemAtIndex)(NSUInteger index);

@end
