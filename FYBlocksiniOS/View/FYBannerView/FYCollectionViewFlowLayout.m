//
//  FYCollectionViewFlowLayout.m
//  FYBlocksiniOS
//
//  Created by Frankenstein Yang on 4/18/16.
//  Copyright © 2016 Frankenstein Yang. All rights reserved.
//

#import "FYCollectionViewFlowLayout.h"

@implementation FYCollectionViewFlowLayout

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
                                 withScrollingVelocity:(CGPoint)velocity {
    
    CGFloat proposedContentOffsetCenterX = proposedContentOffset.x +
                        CGRectGetWidth(self.collectionView.bounds) * 0.5;
    NSArray *layoutAttributesForElements =
    [self layoutAttributesForElementsInRect:self.collectionView.bounds];
    UICollectionViewLayoutAttributes *layoutAttributes =
    layoutAttributesForElements.firstObject;
    for (UICollectionViewLayoutAttributes *layoutAttributesForElement
         in layoutAttributesForElements) {
        
        if (layoutAttributesForElement.representedElementCategory !=
            UICollectionElementCategoryCell) {
            continue;
        }
        
        CGFloat distanceA = layoutAttributesForElement.center.x -
                            proposedContentOffsetCenterX;
        CGFloat distanceB = layoutAttributes.center.x -
                            proposedContentOffsetCenterX;
        if (fabs(distanceA) < fabs(distanceB)) {
            layoutAttributes = layoutAttributesForElement;
        }
    }
    
    if (layoutAttributes != nil) {
        
        CGFloat width = CGRectGetWidth(self.collectionView.bounds) * 0.5;
        CGFloat x = layoutAttributes.center.x - width;
        CGFloat y = proposedContentOffset.y;
        return CGPointMake(x, y);
    }
    return [super targetContentOffsetForProposedContentOffset:proposedContentOffset
                                        withScrollingVelocity:velocity];
    
}

@end
