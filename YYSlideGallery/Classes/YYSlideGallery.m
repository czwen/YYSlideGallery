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


- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)makeImageZoomIn
{
    PhotoCell *cell = [[self.galleryView visibleCells]firstObject];
    CGRect rect = cell.frame;
    rect.size.height = self.frame.size.height;
    cell.frame = rect;
    cell.imageView.frame = self.frame;
}

- (void)setupPageControl:(CGRect)frame andNumbersOfPage:(NSInteger)pages
{
    if (!self.pageControl) {
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
        self.pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    self.pageControl.pageIndicatorTintColor = self.pageIndicatorTintColor;
    self.pageControl.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor;
    self.pageControl.numberOfPages = pages;
    [self.pageControl sizeToFit];
    self.pageControl.frame = CGRectMake(20,frame.size.height-self.pageControl.frame.size.height, 16*pages, self.pageControl.frame.size.height);
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.pageControl];
}


- (void)setupGalleryWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumInteritemSpacing:0.0f];
    [layout setMinimumLineSpacing:0.0f];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.galleryView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    self.galleryView.clipsToBounds = NO;
    self.galleryView.backgroundColor = [UIColor whiteColor];
    self.galleryView.delegate = self;
    self.galleryView.dataSource = self;
    self.galleryView.showsHorizontalScrollIndicator = NO;
    self.galleryView.alwaysBounceHorizontal = NO;
    self.galleryView.alwaysBounceVertical = NO;
    self.galleryView.allowsSelection = YES;
    self.galleryView.pagingEnabled = YES;
    [self.galleryView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"cell"];
    [self setupPageControl:frame andNumbersOfPage:0];
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
    return self.frame.size;
}
- (void)changePage:(id)sender
{
    [self.galleryView setContentOffset:CGPointMake(320*self.pageControl.currentPage, 0) animated:YES];
}

- (void)deleteImageAtIndex:(NSInteger)index
{
    [self.galleryView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]];
    [self reloadGallery];
}

- (void)reloadGallery
{
    [self.galleryView reloadData];
}
@end
