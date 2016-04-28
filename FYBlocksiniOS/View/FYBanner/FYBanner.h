//
//  FYBanner.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/26/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FYBannerResponseBridgeBlock)(NSString *link);

@interface FYBanner : UIView

@property (nonatomic, strong) UIImage                       *placeHolder;

- (instancetype)initWithFrame:(CGRect)frame
                    imageData:(NSMutableArray *)data
                     interval:(CFTimeInterval)interval
                  bridgeBlock:(FYBannerResponseBridgeBlock)block;

@end
