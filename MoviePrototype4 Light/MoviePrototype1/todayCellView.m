//
//  TodayCellView.m
//  MoviePrototype1
//
//  Created by Nay on 10/19/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import "todayCellView.h"
#import "todayCollectionViewCell.h"

@interface todayCellView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation todayCellView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(100, 150);
    flowLayout.minimumInteritemSpacing = 10;
    [self.collectionView setCollectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"todayCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"todayCollectionViewCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    todayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"todayCollectionViewCell" forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"%d.jpg", 0];
    cell.posterImage.image = [UIImage imageNamed:imageName];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected: %@", indexPath);
}


@end
