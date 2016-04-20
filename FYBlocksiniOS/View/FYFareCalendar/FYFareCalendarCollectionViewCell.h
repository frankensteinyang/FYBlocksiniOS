//
//  FYFareCalendarCollectionViewCell.h
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/20/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FYCircleLabel.h"

@interface FYFareCalendarCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)FYCircleLabel *dateLabel;
@property (nonatomic,strong)UILabel *subLabel;
@property (nonatomic,assign)BOOL isSelected;

@end
