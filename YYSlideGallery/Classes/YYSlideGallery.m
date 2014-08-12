//
//  YYSlideGallery.m
//  YYSlideGallery
//
//  Created by ChenZhiWen on 8/8/14.
//  Copyright (c) 2014 CZWEN. All rights reserved.
//

#import "YYSlideGallery.h"
@implementation YYSlideGallery

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupGalleryWithFrame:frame];
    }
    return self;
}


- (void)awakeFromNib
{
    [self setupGalleryWithFrame:self.frame];
}


- (void)setupPageControl:(CGRect)frame andNumbersOfPage:(NSInteger)pages
{
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
    self.pageControl.numberOfPages = pages;
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.pageControl sizeToFit];
    self.pageControl.frame = CGRectMake(20,frame.size.height-self.pageControl.frame.size.height, self.pageControl.frame.size.width, self.pageControl.frame.size.height);
    
    [self addSubview:self.pageControl];
}

- (void)setupGalleryWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumInteritemSpacing:0.0f];
    [layout setMinimumLineSpacing:0.0f];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.galleryView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    self.galleryView.backgroundColor = [UIColor whiteColor];
    self.galleryView.delegate = self;
    self.galleryView.dataSource = self;
    self.galleryView.showsHorizontalScrollIndicator = NO;
    self.galleryView.alwaysBounceHorizontal = NO;
    self.galleryView.alwaysBounceVertical = NO;
    self.galleryView.allowsSelection = YES;
    self.galleryView.pagingEnabled = YES;
    [self.galleryView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self addSubview:self.galleryView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(numbersOfImageInGallery)]) {
        NSInteger numbersOfPages = [self.delegate numbersOfImageInGallery];
        [self setupPageControl:self.frame andNumbersOfPage:numbersOfPages];
        return numbersOfPages;
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = (PhotoCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(galleryCellImage:forIndexPath:)]) {
        [self.delegate galleryCellImage:cell.imageView forIndexPath:indexPath];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int page = scrollView.contentOffset.x / 320;
    
    self.pageControl.currentPage = page;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 320);
}

@end
