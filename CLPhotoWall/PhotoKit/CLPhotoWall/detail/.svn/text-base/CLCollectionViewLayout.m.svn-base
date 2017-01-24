//
//  CLCollectionViewLayout.m
//  CollectionView
//
//  Created by hezhijingwei on 2017/1/5.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "CLCollectionViewLayout.h"

@implementation CLCollectionViewLayout


// 准备布局调用这个方法
- (void)prepareLayout {
    [super prepareLayout];
    
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
}


// 是否允许重新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
    
}


// 当滚动时调用这个方法  对每个item进行布局
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2.0f;
    
    NSMutableArray *array1 = [[NSMutableArray alloc] init];
    
    for (UICollectionViewLayoutAttributes *attributes in array) {
                
        CGFloat scale = (attributes.center.x - centerX)/self.collectionView.frame.size.width;
        
        CATransform3D transform3D = CATransform3DIdentity;
        
        transform3D.m34 = -1/2000.0;
        transform3D = CATransform3DRotate(transform3D, scale*-1, 0, 1, 0);
        attributes.transform3D = transform3D;

        [array1 addObject:attributes];
        
    }
    
    return array1;
    
}

/**
 *  只要手一松开就会调用
 *  这个方法的返回值，就决定了CollectionView停止滚动时的偏移量
 *  proposedContentOffset这个是最终的 偏移量的值 但是实际的情况还是要根据返回值来定
 *  velocity  是滚动速率  有个x和y 如果x有值 说明x上有速度
 *  如果y有值 说明y上又速度 还可以通过x或者y的正负来判断是左还是右（上还是下滑动）  有时候会有用
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGRect rect;
    rect.origin.x = proposedContentOffset.x;
    rect.origin.y = 0;
    rect.size = self.collectionView.frame.size;
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = self.collectionView.frame.size.width/2 + proposedContentOffset.x;
    
    CGFloat minDelta = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attributes in array) {
        
        if (ABS(minDelta) > ABS(attributes.center.x - centerX)) {
            
            minDelta = attributes.center.x-centerX;
            
        }
        
    }
    
    proposedContentOffset.x += minDelta;
    
    
    return proposedContentOffset;
}



@end
