//
//  FYBannerView.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/27/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RoundRectStyle) {
    RoundRectStyleTwoRoundedCorners = 0,
    RoundRectStyleDefault = 1
};

typedef void (^FYBannerResponseBlock)(NSString *url);

@interface FYBannerView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                    imageData:(NSArray *)data
                     interval:(CFTimeInterval)interval
                  bannerStyle:(RoundRectStyle)style
                responseBlock:(FYBannerResponseBlock)block;

@end
