//
//  YYSlideGallery.h
//  YYSlideGallery
//
//  Created by ChenZhiWen on 8/8/14.
//  Copyright (c) 2014 CZWEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoCell.h"
@protocol YYSlideGalleryDelegate<NSObject>
- (void)galleryCellImage:(UIImageView*)cellImageView forIndexPath:(NSIndexPath*)indexPath;
- (NSInteger)numbersOfImageInGallery;
@end
@interface YYSlideGallery : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic) UICollectionView *galleryView;

@property (assign,nonatomic) NSInteger photoCount;

@property (strong,nonatomic) UIPageControl *pageControl;

@property (strong,nonatomic) UIColor *currentPageIndicatorTintColor;

@property (strong,nonatomic) UIColor *pageIndicatorTintColor;

@property (weak, nonatomic) id<YYSlideGalleryDelegate>delegate;

- (void)reloadGallery;

- (void)deleteImageAtIndex:(NSInteger)index;

@end
