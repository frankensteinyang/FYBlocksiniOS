//
//  FYBannerItem.h
//  Pods
//
//  Created by Frankenstein Yang on 4/28/16.
//
//

#import <UIKit/UIKit.h>

@interface FYBannerItem : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSString    *url;
@property (nonatomic, strong) UIImageView *placeHolderImageView;
@property (nonatomic, strong) UIImage     *placeHolderImage;
@property (nonatomic, assign) BOOL        hasSetImage;

- (instancetype)initWithFrame:(CGRect)frame
             placeHolderImage:(UIImage *)placeHolderImage;

- (void)setImage:(UIImage *)image;

@end
