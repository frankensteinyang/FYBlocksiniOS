//
//  FYBannerView.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/27/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "FYBannerView.h"
#import "FYBanner.h"

#import "UIView+FYRoundRect.h"

@interface FYBannerView ()

@property (nonatomic, strong) NSMutableArray *imageData;
@property (nonatomic, copy  ) FYBannerResponseBlock responseBlock;

@end

@implementation FYBannerView

- (instancetype)initWithFrame:(CGRect)frame
                    imageData:(NSArray *)data
                  bannerStyle:(RoundRectStyle)style
                responseBlock:(FYBannerResponseBlock)block {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageData = [NSMutableArray arrayWithArray:data];
        FYBanner *banner = [[FYBanner alloc] initWithFrame:frame imageData:_imageData bridgeBlock:^(NSString *link) {
            //
        }];
        
        banner.duration = 1.2;
        
        [self addSubview:banner];
        
        [banner mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        if (style == RoundRectStyleTwoRoundedCorners) {
            
            [self applyRoundCorners:UIRectCornerTopRight | UIRectCornerTopLeft
                             radius:9.0];
            
        } else if (style == RoundRectStyleDefault) {
            
            self.layer.cornerRadius = 9.0;
            self.layer.masksToBounds = YES;
            
        }
        
        _responseBlock = [block copy];
        
    }
    return self;

}

@end
