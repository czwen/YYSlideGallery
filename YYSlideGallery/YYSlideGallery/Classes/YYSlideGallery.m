//
//  YYSlideGallery.m
//  YYSlideGallery
//
//  Created by ChenZhiWen on 8/8/14.
//  Copyright (c) 2014 CZWEN. All rights reserved.
//

#import "YYSlideGallery.h"
@interface YYSlideGallery()
@property (strong,nonatomic) UIPanGestureRecognizer *panGesture;
@end
@implementation YYSlideGallery

- (id)initWithFrame:(CGRect)frame andPhotos:(NSArray*)photos
{
    self = [super init];
    if (self) {
        self.photos = [NSMutableArray arrayWithArray:photos];
        [self setupGalleryWithFrame:frame];
    }
    return self;
}

- (void)setupGalleryWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumInteritemSpacing:0.0f];
    [layout setMinimumLineSpacing:0.0f];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.galleryView = [[GalleryView alloc]initWithFrame:frame collectionViewLayout:layout];
    self.galleryView.backgroundColor = [UIColor whiteColor];
    self.galleryView.delegate = self;
    self.galleryView.dataSource = self;
    self.galleryView.showsHorizontalScrollIndicator = NO;
    self.galleryView.alwaysBounceHorizontal = NO;
    self.galleryView.alwaysBounceVertical = NO;
    self.galleryView.allowsSelection = YES;
    
    self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    self.panGesture.delegate = self;
    [self.galleryView addGestureRecognizer:self.panGesture];
    [self.galleryView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor colorWithRed:(CGFloat)random()/(CGFloat)RAND_MAX green:(CGFloat)random()/(CGFloat)RAND_MAX blue:(CGFloat)random()/(CGFloat)RAND_MAX alpha:1.0f];
    if(indexPath.row %2 ==0){
        cell.backgroundColor = [UIColor yellowColor];
    }else{
        cell.backgroundColor = [UIColor redColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.galleryView visibleCells]count]>1) {
        [self.galleryView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer*)recognizer
{

    CGFloat progress = [recognizer translationInView:self.galleryView].x / (self.galleryView.bounds.size.width * 1.0);
    NSLog(@"%f",progress);
    //大于0向右
    if (progress>0) {
        if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == 5) {
            NSArray *visbleCells = [self.galleryView visibleCells];
            UICollectionViewCell *firstCell = (UICollectionViewCell*)[visbleCells firstObject];
            UICollectionViewCell *secondCell = (UICollectionViewCell*)[visbleCells lastObject];
            if (firstCell.frame.origin.x>secondCell.frame.origin.x) {
                firstCell = (UICollectionViewCell*)[visbleCells lastObject];
                secondCell = (UICollectionViewCell*)[visbleCells firstObject];
            }
            if (progress>0.2) {
                NSIndexPath *cellIndexPath = [self.galleryView indexPathForCell:firstCell];
                [self.galleryView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
            }else{
                NSIndexPath *cellIndexPath = [self.galleryView indexPathForCell:secondCell];
                [self.galleryView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            }
        }
    }else{
        if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == 5) {
            NSArray *visbleCells = [self.galleryView visibleCells];
            UICollectionViewCell *firstCell = (UICollectionViewCell*)[visbleCells firstObject];
            UICollectionViewCell *secondCell = (UICollectionViewCell*)[visbleCells lastObject];
            if (firstCell.frame.origin.x>secondCell.frame.origin.x) {
                firstCell = (UICollectionViewCell*)[visbleCells lastObject];
                secondCell = (UICollectionViewCell*)[visbleCells firstObject];
            }
            if (progress<-0.2) {
                NSIndexPath *cellIndexPath = [self.galleryView indexPathForCell:secondCell];
                [self.galleryView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            }else{
                NSIndexPath *cellIndexPath = [self.galleryView indexPathForCell:firstCell];
                [self.galleryView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
            }
        }
    }
    

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 320);
}

@end
