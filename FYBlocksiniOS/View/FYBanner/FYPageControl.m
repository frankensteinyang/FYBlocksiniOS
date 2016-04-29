//
//  FYPageControl.m
//  Pods
//
//  Created by Frankenstein Yang on 4/28/16.
//
//

#import "FYPageControl.h"

//#define COLOR_GRAYISHBLUE [UIColor colorWithRed:128/255.0 green:130/255.0 blue:133/255.0 alpha:1]
//#define COLOR_GRAY [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]

#define K_COLOR_GRAYISHBLUE [UIColor whiteColor]
#define K_COLOR_GRAY [UIColor orangeColor]

@implementation FYPageControl

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
    
}

- (void)setup {
    [self setBackgroundColor:[UIColor clearColor]];
    
    _strokeWidth = 2;
    _gapWidth = 10;
    _diameter = 12;
    _pageControlStyle = PageControlStyleDefault;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)onTapped:(UITapGestureRecognizer*)gesture {
    
    CGPoint touchPoint = [gesture locationInView:[gesture view]];
    
    if (touchPoint.x < self.frame.size.width/2) {
        // move left
        if (self.currentPage>0) {
            if (touchPoint.x <= 22) {
                self.currentPage = 0;
            } else {
                self.currentPage -= 1;
            }
        }
        
    } else {
        // move right
        if (self.currentPage<self.numberOfPages-1) {
            if (touchPoint.x >= (CGRectGetWidth(self.bounds) - 22)) {
                self.currentPage = self.numberOfPages-1;
            } else {
                self.currentPage += 1;
            }
        }
    }
    
    [self setNeedsDisplay];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}

- (void)drawRect:(CGRect)rect {
    
    UIColor *coreNormalColor, *coreSelectedColor, *strokeNormalColor, *strokeSelectedColor;
    
    if (self.coreNormalColor) {
        
        coreNormalColor = self.coreNormalColor;
        
    } else {
        
        coreNormalColor = K_COLOR_GRAYISHBLUE;
        
    }
    
    if (self.coreSelectedColor) {
        
        coreSelectedColor = self.coreSelectedColor;
        
    } else {
        if (self.pageControlStyle == PageControlStyleStrokedCircle) {
            
            coreSelectedColor = K_COLOR_GRAYISHBLUE;
        } else {
            coreSelectedColor = K_COLOR_GRAY;
        }
    }
    
    if (self.strokeNormalColor) {
        
        strokeNormalColor = self.strokeNormalColor;
        
    } else {
        if (self.pageControlStyle==PageControlStyleDefault && self.coreNormalColor) {
            strokeNormalColor = self.coreNormalColor;
        } else {
            strokeNormalColor = K_COLOR_GRAYISHBLUE;
        }
        
    }
    
    if (self.strokeSelectedColor) {
        
        strokeSelectedColor = self.strokeSelectedColor;
        
    } else {
        if (self.pageControlStyle == PageControlStyleStrokedCircle) {
            
            strokeSelectedColor = K_COLOR_GRAYISHBLUE;
            
        } else if (self.pageControlStyle==PageControlStyleDefault &&
                   self.coreSelectedColor) {
            
            strokeSelectedColor = self.coreSelectedColor;
            
        } else {
            
            strokeSelectedColor = K_COLOR_GRAY;
            
        }
    }
    
    // Drawing code
    if (self.hidesForSinglePage && self.numberOfPages == 1) {
        return;
    }
    
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    NSInteger gap = self.gapWidth;
    float diameter = self.diameter - 2 * self.strokeWidth;
    
    NSInteger total_width = self.numberOfPages*diameter + (self.numberOfPages-1)*gap;
    
    if (total_width > self.frame.size.width) {
        while (total_width > self.frame.size.width) {
            diameter -= 2;
            gap = diameter + 2;
            while (total_width > self.frame.size.width) {
                
                gap -= 1;
                total_width = self.numberOfPages * diameter + (self.numberOfPages-1) * gap;
                
                if (gap==2) {
                    break;
                }
            }
            
            if (diameter==2) {
                break;
            }
        }
    }
    
    int i;
    for (i=0; i<self.numberOfPages; i++) {
        
        int x = (self.frame.size.width-total_width)/2 + i*(diameter+gap);
        if (self.pageControlStyle==PageControlStyleDefault) {
            
            if (i==self.currentPage) {
                
                CGContextSetFillColorWithColor(myContext, [coreSelectedColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
                CGContextSetStrokeColorWithColor(myContext, [strokeSelectedColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
                
            } else {
                
                CGContextSetFillColorWithColor(myContext, [coreNormalColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
                CGContextSetStrokeColorWithColor(myContext, [strokeNormalColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
            }
        } else if (self.pageControlStyle == PageControlStyleStrokedCircle) {
            
            CGContextSetLineWidth(myContext, self.strokeWidth);
            if (i==self.currentPage) {
                CGContextSetFillColorWithColor(myContext, [coreSelectedColor CGColor]);
                CGContextFillEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
                CGContextSetStrokeColorWithColor(myContext, [strokeSelectedColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
            } else {
                CGContextSetStrokeColorWithColor(myContext, [strokeNormalColor CGColor]);
                CGContextStrokeEllipseInRect(myContext, CGRectMake(x,(self.frame.size.height-diameter)/2,diameter,diameter));
            }
            
        } else if (self.pageControlStyle == PageControlStyleRect) {
            
            if (i == self.currentPage) {
                
                // 画一个没有边框的矩形
                CGContextSetFillColorWithColor(myContext, [coreSelectedColor CGColor]);
                CGContextFillRect(myContext, CGRectMake(x, (self.frame.size.height - diameter), 15, 2));
                
            } else {
                
                CGContextSetFillColorWithColor(myContext, [coreNormalColor CGColor]);
                CGContextFillRect(myContext, CGRectMake(x, (self.frame.size.height - diameter), 15, 2));
                
            }
            
        }
    }
}

- (void)setPageControlStyle:(PageControlStyle)style {
    _pageControlStyle = style;
    [self setNeedsDisplay];
}

- (void)setCurrentPage:(NSInteger)page {
    _currentPage = page;
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)numOfPages {
    _numberOfPages = numOfPages;
    [self setNeedsDisplay];
}

@end
