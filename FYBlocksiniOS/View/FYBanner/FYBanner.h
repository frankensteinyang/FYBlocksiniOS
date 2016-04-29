//
//  FYBanner.h
//  Pods
//
//  Created by Frankenstein Yang on 4/28/16.
//
//

#import <UIKit/UIKit.h>

typedef void (^FYBannerResponseBlock)(NSString *url);

@interface FYBanner : UIView

@property (nonatomic, strong) UIImage                       *bannerPlaceHolder;
@property (nonatomic, strong) NSMutableArray                *imageArray;

- (instancetype)initWithFrame:(CGRect)frame responseBlock:(FYBannerResponseBlock)block;

@end
