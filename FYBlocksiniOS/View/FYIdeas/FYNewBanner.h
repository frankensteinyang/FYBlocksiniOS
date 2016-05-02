//
//  FYNewBanner.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 5/2/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FYBannerResponseBlock)(NSString *url);

@interface FYNewBanner : UIView

@property (nonatomic, strong) UIImage                       *bannerPlaceHolder;
@property (nonatomic, strong) NSMutableArray                *imageArray;

- (instancetype)initWithFrame:(CGRect)frame responseBlock:(FYBannerResponseBlock)block;

@end
