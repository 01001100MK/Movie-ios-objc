//
//  popularTableViewCell.m
//  MoviePrototype1
//
//  Created by User on 10/31/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import "popularTableViewCell.h"
#import "PopularCollectionView.h"
#import "PopularCollectionViewCell.h"
#import "ApiCalls.h"

@interface popularTableViewCell() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation popularTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(100, 150);
    flowLayout.minimumInteritemSpacing = 10;
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        _movieList = [[ApiCalls GetPopularMovies] objectForKey:@"results"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    });
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_movieList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PopularCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PopularCollectionViewCell" forIndexPath:indexPath];
    
    NSString *posterPath = [NSString stringWithString:[[_movieList objectAtIndex:indexPath.row] valueForKey:@"poster_path"]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *imageData = [ApiCalls GetImageDataForMovieUrl:posterPath];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *posterImage = [UIImage imageWithData:imageData];
            cell.posterImage.image = posterImage;
        });
    });
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSData *movieObj = [_movieList objectAtIndex:indexPath.row];
    
    [[NSNotificationCenter defaultCenter]
        postNotificationName:@"eventType"
        object:movieObj];
}

@end
