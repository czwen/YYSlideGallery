//
//  ViewController.m
//  YYSlideGallery
//
//  Created by ChenZhiWen on 8/8/14.
//  Copyright (c) 2014 CZWEN. All rights reserved.
//

#import "ViewController.h"
#import "YYSlideGallery.h"
@interface ViewController ()<YYSlideGalleryDelegate>
@property (nonatomic,strong) YYSlideGallery *gallery;
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.gallery = [[YYSlideGallery alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
        self.gallery.delegate = self;
        [self.view addSubview:self.gallery];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)galleryCellImage:(UIImageView *)cellImageView forIndexPath:(NSIndexPath *)indexPath
{
    [cellImageView setImage:[UIImage imageNamed:@"1385573490525.jpg"]];
}

- (NSInteger)numbersOfImageInGallery
{
    return 10;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
