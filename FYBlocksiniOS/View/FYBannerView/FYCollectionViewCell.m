//
//  FYCollectionViewCell.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/18/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYCollectionViewCell.h"

@interface FYCollectionViewCell ()

@property (nonatomic, strong, readwrite) UIImageView *imgView;
@property (nonatomic, strong, readwrite) UILabel *label;

@end

@implementation FYCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView.clipsToBounds = YES;
    self.imgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imgView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:@{ @"imgView" : self.imgView }]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imgView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:@{ @"imgView" : self.imgView }]];
    
    self.label = [[UILabel alloc] init];
    [self.contentView addSubview:self.label];
    
    self.label.font = [UIFont systemFontOfSize:17.0f];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 0;
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|" options:0 metrics:nil views:@{ @"label" : self.label }]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.label
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.contentView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1
                                                                   constant:0]];
}

@end
