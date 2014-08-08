//
//  YYSlideGallery.h
//  YYSlideGallery
//
//  Created by ChenZhiWen on 8/8/14.
//  Copyright (c) 2014 CZWEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GalleryView.h"
#import "PhotoCell.h"
@interface YYSlideGallery : NSObject<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (strong,nonatomic) GalleryView *galleryView;

@property (strong,nonatomic) NSMutableArray *photos;


- (id)initWithFrame:(CGRect)frame andPhotos:(NSArray*)photos;

@end
