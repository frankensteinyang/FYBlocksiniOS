//
//  FYPageControl.h
//  Pods
//
//  Created by Frankenstein Yang on 4/28/16.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PageControlStyle) {
    PageControlStyleDefault = 0,
    PageControlStyleStrokedCircle = 1,
    PageControlStyleRect = 2
};

@interface FYPageControl : UIControl

@property (nonatomic) UIColor *coreNormalColor, *coreSelectedColor;
@property (nonatomic) UIColor *strokeNormalColor, *strokeSelectedColor;
@property (nonatomic, assign) NSInteger currentPage, numberOfPages;
@property (nonatomic, assign) BOOL hidesForSinglePage;
@property (nonatomic, assign) PageControlStyle pageControlStyle;
@property (nonatomic, assign) NSInteger strokeWidth, diameter, gapWidth;

@end
