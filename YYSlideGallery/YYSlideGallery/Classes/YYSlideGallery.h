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

@end
@interface YYSlideGallery : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (strong,nonatomic) UICollectionView *galleryView;

@property (strong,nonatomic) NSMutableArray *photos;

@property (strong,nonatomic) UIPageControl *pageControl;

@property (strong,nonatomic) UIColor *currentPageIndicatorTintColor;

@property (strong,nonatomic) UIColor *pageIndicatorTintColor;

- (id)initWithFrame:(CGRect)frame andPhotos:(NSArray*)photos;

@property (assign, nonatomic) id<YYSlideGalleryDelegate>delegate;

@end
