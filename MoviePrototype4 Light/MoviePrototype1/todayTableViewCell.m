//
//  todayTableViewCell.m
//  MoviePrototype1
//
//  Created by TIVA on 10/19/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import "todayTableViewCell.h"

// import Collection cell view
#import "todayCellView.h"

@interface todayTableViewCell()

@property (strong, nonatomic) todayCellView *todayCellView;

@end


@implementation todayTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.todayCellView = [[NSBundle mainBundle] loadNibNamed:@"todayCellView"
                                                         owner:self
                                                       options:nil][0];
        self.todayCellView.frame = self.bounds;
        [self.contentView addSubview:self.todayCellView];
    }
    return self;
}

@end
