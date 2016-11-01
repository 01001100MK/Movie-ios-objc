//
//  MovieDetailViewController.m
//  MoviePrototype1
//
//  Created by Nay on 10/25/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "ApiCalls.h"
#import "SimilarCollectionViewCell.h"

@interface MovieDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *movieList;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(62, 100);
    flowLayout.minimumInteritemSpacing = 10;
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    self.TitleLabel.text = [_movie valueForKey:@"title"];
    self.DateLabel.text = [_movie valueForKey:@"release_date"];
    self.RateLabel.text = [NSString stringWithFormat:@"%@", [_movie valueForKey:@"vote_average"]];
    self.OverviewTextView.text = [_movie valueForKey:@"overview"];
    
    NSString *backdropPath = [_movie valueForKey:@"backdrop_path"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *imageData = [ApiCalls GetBackdropImageDataForMovieUrl:backdropPath];
        _movieList = [[ApiCalls GetSimilarMovies:[_movie valueForKey:@"id"]] objectForKey:@"results"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *Image = [UIImage imageWithData:imageData];
            self.backdropImage.image = Image;
            [self.collectionView reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    SimilarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SimilarCollectionViewCell" forIndexPath:indexPath];
    
    NSString *posterPath = [NSString stringWithString:[[_movieList objectAtIndex:indexPath.row] valueForKey:@"poster_path"]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *imageData = [ApiCalls GetImageDataForMovieUrl:posterPath];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *posterImage = [UIImage imageWithData:imageData];
            cell.SimilarImage.image = posterImage;
        });
    });
    
    return cell;
}

@end
