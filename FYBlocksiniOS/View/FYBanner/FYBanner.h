//
//  FYBanner.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/26/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FYBannerResponseBlock)(NSString * link);

@interface FYBanner : UIControl

@property (nonatomic, strong) UIImage                       *placeHolder;
@property (nonatomic, strong) NSMutableArray                *imageArray;
@property (nonatomic, assign) CFTimeInterval                duration;

- (instancetype)initWithContainerView:(UIView *)contianer responseBlock:(FYBannerResponseBlock)block;

@end
