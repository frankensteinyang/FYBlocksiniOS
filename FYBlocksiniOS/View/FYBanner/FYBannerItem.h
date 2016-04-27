//
//  FYBannerItem.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/26/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYBannerItem : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSString    *link;
@property (nonatomic, strong) UIImageView *placeHolderImageView;
@property (nonatomic, strong) UIImage     *placeHolderImage;
@property (nonatomic, assign) BOOL        hasSetImage;


- (instancetype)initWithFrame:(CGRect)frame
             placeHolderImage:(UIImage *)placeHolderImage;

- (void)setImage:(UIImage *)image;

@end
