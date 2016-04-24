//
//  FYCalendarFlowLayout.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/24/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYCalendarFlowLayout.h"
#import "FYCalendarDynamicHeader.h"
#import "UIView+FYExtension.h"

@implementation FYCalendarFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumInteritemSpacing = 0;
        self.minimumLineSpacing = 0;
        self.itemSize = CGSizeMake(1, 1);
        self.sectionInset = UIEdgeInsetsZero;
    }
    return self;
    
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    
    CGFloat rowHeight = self.calendar.preferredRowHeight;
    
    if (!self.calendar.floatingMode) {
        
        self.headerReferenceSize = CGSizeZero;
        
        CGFloat padding = self.calendar.preferredWeekdayHeight*0.1;
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            padding = FYCalendarFloor(padding);
            rowHeight = FYCalendarFloor(rowHeight*2)*0.5; // Round to nearest multiple of 0.5. e.g. (16.8->16.5),(16.2->16.0)
        }
        self.sectionInset = UIEdgeInsetsMake(padding, 0, padding, 0);
        switch (self.calendar.scope) {
                
            case FYCalendarScopeMonth: {
                
                CGSize itemSize = CGSizeMake(
                                             self.collectionView.fy_width/7.0-(self.scrollDirection == UICollectionViewScrollDirectionVertical)*0.1,
                                             rowHeight
                                             );
                self.itemSize = itemSize;
                
                break;
            }
            case FYCalendarScopeWeek: {
                
                CGSize itemSize = CGSizeMake(self.collectionView.fy_width/7.0, rowHeight);
                self.itemSize = itemSize;
                
                break;
                
            }
                
        }
    } else {
        
        CGFloat headerHeight = self.calendar.preferredWeekdayHeight*1.5+self.calendar.preferredHeaderHeight;
        self.headerReferenceSize = CGSizeMake(self.collectionView.fy_width, headerHeight);
        
        CGSize itemSize = CGSizeMake(
                                     self.collectionView.fy_width/7-(self.scrollDirection == UICollectionViewScrollDirectionVertical)*0.1,
                                     rowHeight
                                     );
        self.itemSize = itemSize;
        
        self.sectionInset = UIEdgeInsetsZero;
        
    }
    
}

@end
