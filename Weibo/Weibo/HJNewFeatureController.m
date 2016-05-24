//
//  HJNewFeatureController.m
//  Weibo
//
//  Created by 傅韩建 on 16/5/24.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import "HJNewFeatureController.h"
#import "HJNewFeatureCell.h"
#define HJNewFeatureCount 4

@interface HJNewFeatureController ()

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation HJNewFeatureController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取消滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    
    // 添加padgeController
    [self setUpPadgeController];
}

- (void)setUpPadgeController
{
    
    UIPageControl *page = [[UIPageControl alloc]init];
    page.center = CGPointMake(self.view.center.x, self.view.height);
    page.numberOfPages = HJNewFeatureCount;
    page.currentPageIndicatorTintColor = [UIColor redColor];
    page.pageIndicatorTintColor = [UIColor blackColor];
    _pageControl = page;
    [self.view addSubview:page];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.width + 0.5;
    
    _pageControl.currentPage = page;
    
    
}


#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return HJNewFeatureCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    HJNewFeatureCell *cell = [HJNewFeatureCell cellWithCollectionView:collectionView indexPath:indexPath];
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
    cell.imageName = imageName;
    [cell setIndexPath:indexPath pagecount:HJNewFeatureCount];
    
    return cell;
}

@end
