//
//  m4uTableViewCell.m
//  MoviePrototype1
//
//  Created by TIVA on 10/19/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import "m4uTableViewCell.h"
#import "M4UCollectionView.h"
#import "M4UCollectionViewCell.h"
#import "ApiCalls.h"


@interface m4uTableViewCell() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation m4uTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(100, 150);
    flowLayout.minimumInteritemSpacing = 10;
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        _movieList = [[ApiCalls GetUserCreatedList:@"338"] objectForKey:@"items"];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    });
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_movieList count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    M4UCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"M4UCollectionViewCell" forIndexPath:indexPath];
    
    NSString *posterPath = [NSString stringWithString:[[_movieList objectAtIndex:indexPath.row] valueForKey:@"poster_path"]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *imageData = [ApiCalls GetImageDataForMovieUrl:posterPath];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *posterImage = [UIImage imageWithData:imageData];
            cell.PosterImage.image = posterImage;
        });
    });
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSData *movieObj = [_movieList objectAtIndex:indexPath.row];

    //trigger event
    [[NSNotificationCenter defaultCenter]
         postNotificationName:@"eventType"
         object:movieObj];
}



@end
