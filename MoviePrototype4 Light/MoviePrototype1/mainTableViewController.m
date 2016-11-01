//
//  mainTableViewController.m
//  MoviePrototype1
//
//  Created by TIVA on 10/19/16.
//  Copyright © 2016 TIVA. All rights reserved.
//

#import "mainTableViewController.h"

// Collection Views
#import "todayTableViewCell.h"
#import "m4uTableViewCell.h"
#import "popularTableViewCell.h"
#import "MovieDetailViewController.h"

@interface mainTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableDictionary *movie;

@end

@implementation mainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"M4U";
    
    // Remove hairline
    UIImage *emptyImage = [UIImage new];
    self.navigationController.navigationBar.shadowImage = emptyImage;
    [self.navigationController.navigationBar setBackgroundImage:emptyImage forBarMetrics:UIBarMetricsDefault];
    
    // Register custom cells
    [self.tableView registerClass:[todayTableViewCell
                                   class] forCellReuseIdentifier:@"todayCell"];

    
    //register to listen for event
    [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(eventHandler:)
         name:@"eventType"
         object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2){
        return 1;
    }
    else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

// Title for Header section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0){
        return @"Today Watch List";
    }
    else if (section == 1){
        return @"Popular Movies";
    }
    else{
        return @"M4U List";
    }
}

// Formatting for Header section
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
//    header.textLabel.textColor = [UIColor darkGrayColor];
//    header.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
//    CGRect headerFrame = header.frame;
//    header.textLabel.frame = headerFrame;
//    header.textLabel.textAlignment = NSTextAlignmentLeft;
//
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        todayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todayCell" forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section == 1) {
        popularTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"popularCell" forIndexPath:indexPath];
        return cell;
    }
    else {
        m4uTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"m4uCell" forIndexPath:indexPath];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect frame = tableView.frame;
    
    UIButton *seeAllButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-70, 10, 60, 20)];
    [seeAllButton setTitle:@"See all" forState:UIControlStateNormal];
    seeAllButton.backgroundColor = [UIColor redColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
    
    if (section == 0) {
        title.text = @"Today Watchlist";
    }
    else if (section == 1) {
        title.text = @"Popular Movies";
    }
    else {
        title.text = @"M4U Selections";
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [headerView addSubview:title];
    [headerView addSubview:seeAllButton];
    
    [seeAllButton addTarget:self action:@selector(sectionTapped:) forControlEvents:UIControlEventTouchDown];
    seeAllButton.tag = section;
    
    return headerView;
}

- (void)sectionTapped:(UIButton *)button
{
    NSLog(@"%ld", (long)button.tag);
    [self performSegueWithIdentifier:@"toDetailVC" sender:self];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self performSegueWithIdentifier:@"toDetailVC" sender:self];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toMovDetailVC"]) {
        MovieDetailViewController *VCtrl = (MovieDetailViewController *)segue.destinationViewController;
        VCtrl.movie = _movie;
    }
}

#pragma mark - Nofitication Center

//event handler when event occurs
- (void)eventHandler:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[NSDictionary class]]){
        NSString *message = [[notification object] valueForKey:@"original_title"];
        NSLog(@"event triggered %@", message);
        
        _movie = notification.object;
        
        [self performSegueWithIdentifier:@"toMovDetailVC" sender:self];
    }
}



@end
