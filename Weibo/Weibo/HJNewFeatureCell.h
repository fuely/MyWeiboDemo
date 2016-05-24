//
//  HJNewFeatureCell.h
//  Weibo
//
//  Created by 傅韩建 on 16/5/24.
//  Copyright © 2016年 HanJian-F. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJNewFeatureCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imageName;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

- (void)setIndexPath:(NSIndexPath *)indexPath pagecount:(NSInteger)pagecount;

@end
