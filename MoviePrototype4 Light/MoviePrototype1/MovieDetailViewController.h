//
//  MovieDetailViewController.h
//  MoviePrototype1
//
//  Created by Nay on 10/25/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController

@property (strong, nonatomic) NSMutableDictionary *movie;
@property (weak, nonatomic) IBOutlet UIImageView *backdropImage;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
@property (weak, nonatomic) IBOutlet UILabel *RateLabel;
@property (weak, nonatomic) IBOutlet UITextView *OverviewTextView;
@property (weak, nonatomic) IBOutlet UILabel *GenreLabel;

@end
