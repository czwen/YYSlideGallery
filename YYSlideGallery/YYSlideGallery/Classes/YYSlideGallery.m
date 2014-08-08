//
//  YYSlideGallery.m
//  YYSlideGallery
//
//  Created by ChenZhiWen on 8/8/14.
//  Copyright (c) 2014 CZWEN. All rights reserved.
//

#import "YYSlideGallery.h"

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
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.delegate = self;
    [self.galleryView addGestureRecognizer:panGesture];
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


- (void)handlePanGesture:(UIPanGestureRecognizer*)recognizer
{

    CGFloat progress = [recognizer translationInView:self.galleryView].x / (self.galleryView.bounds.size.width * 1.0);
    NSLog(@"%f",progress);
    //大于0向右
    if (progress>0) {
        if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
            NSArray *visbleCells = [self.galleryView visibleCells];
            UICollectionViewCell *firstCell = (UICollectionViewCell*)[visbleCells firstObject];
            UICollectionViewCell *secondCell = (UICollectionViewCell*)[visbleCells lastObject];
            if (firstCell.frame.origin.x>secondCell.frame.origin.x) {
                firstCell = (UICollectionViewCell*)[visbleCells lastObject];
                secondCell = (UICollectionViewCell*)[visbleCells firstObject];
            }
            if (progress>0.2) {
                NSIndexPath *cellIndexPath = [self.galleryView indexPathForCell:firstCell];
                [self.galleryView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            }else{
                NSIndexPath *cellIndexPath = [self.galleryView indexPathForCell:secondCell];
                [self.galleryView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            }
        }
    }else{
        if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
            NSArray *visbleCells = [self.galleryView visibleCells];
            UICollectionViewCell *firstCell = (UICollectionViewCell*)[visbleCells firstObject];
            UICollectionViewCell *secondCell = (UICollectionViewCell*)[visbleCells lastObject];
            if (firstCell.frame.origin.x>secondCell.frame.origin.x) {
                firstCell = (UICollectionViewCell*)[visbleCells lastObject];
                secondCell = (UICollectionViewCell*)[visbleCells firstObject];
            }
            if ((abs(progress))<0.2) {
                NSIndexPath *cellIndexPath = [self.galleryView indexPathForCell:secondCell];
                [self.galleryView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            }else{
                NSIndexPath *cellIndexPath = [self.galleryView indexPathForCell:firstCell];
                [self.galleryView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            }
        }
    }
    

}

//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//    NSArray *visbleCells = [self.galleryView visibleCells];
//    UICollectionViewCell *firstCell = (UICollectionViewCell*)[visbleCells firstObject];
//    UICollectionViewCell *secondCell = (UICollectionViewCell*)[visbleCells lastObject];
//    CGRect firstCellRect = [scrollView convertRect:firstCell.frame toView:scrollView.superview];
//    if (visbleCells.count>1) {
//        if (abs(firstCellRect.origin.x)>scrollView.superview.frame.size.width/4) {
//            NSIndexPath *cellIndexPath = [self.galleryView indexPathForCell:secondCell];
//            [self.galleryView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//        }else{
//            NSIndexPath *cellIndexPath = [self.galleryView indexPathForCell:firstCell];
//            [self.galleryView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//        }
//    }else{
//        
//    }
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSArray *visbleCells = [self.galleryView visibleCells];
//    UICollectionViewCell *firstCell = (UICollectionViewCell*)[visbleCells firstObject];
//    UICollectionViewCell *secondCell = (UICollectionViewCell*)[visbleCells lastObject];
//    CGRect firstCellRect = [scrollView convertRect:firstCell.frame toView:scrollView.superview];
//    if (visbleCells.count>1) {
//            if (abs(firstCellRect.origin.x)>scrollView.superview.frame.size.width/4) {
//                NSIndexPath *cellIndexPath = [self.galleryView indexPathForCell:secondCell];
//                [self.galleryView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//            }else{
//                NSIndexPath *cellIndexPath = [self.galleryView indexPathForCell:firstCell];
//                [self.galleryView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//            }
//    }else{
//        
//    }
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    NSArray *visbleCells = [self.galleryView visibleCells];
//    UICollectionViewCell *firstCell = (UICollectionViewCell*)[visbleCells firstObject];
//    UICollectionViewCell *secondCell = (UICollectionViewCell*)[visbleCells lastObject];
//    CGRect firstCellRect = [scrollView convertRect:firstCell.frame toView:scrollView.superview];
//    if (visbleCells.count>1) {
//        if (abs(firstCellRect.origin.x)>scrollView.superview.frame.size.width/4) {
//            NSIndexPath *cellIndexPath = [self.galleryView indexPathForCell:secondCell];
//            [self.galleryView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//        }else{
//            NSIndexPath *cellIndexPath = [self.galleryView indexPathForCell:firstCell];
//            [self.galleryView scrollToItemAtIndexPath:cellIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//        }
//    }else{
//        
//    }
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 320);
}


@end
