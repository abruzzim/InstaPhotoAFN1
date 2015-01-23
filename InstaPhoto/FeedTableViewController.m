//
//  FeedTableViewController.m
//  InstaPhoto
//
//  Created by Mario Abruzzi on 1/18/15.
//  Copyright (c) 2015 Mario Abruzzi. All rights reserved.
//

#import "FeedTableViewController.h"
#import "PhotoViewController.h"
#import "AFJSONRequestOperation.h"

@interface FeedTableViewController ()

@end

@implementation FeedTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization.
        self.title = @"Feed";
        NSLog(@"%%FeedTableVC-I-DEBUG, 'title' property set.");
        self.tabBarItem.image = [UIImage imageNamed:@"Feed"];
        NSLog(@"%%FeedTableVC-I-DEBUG, 'tabBarItem.image' property set.");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%%FeedTableVC-I-DEBUG, Inside 'viewDidLoad:'.");

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Get Fake FeedView Data from the Internet
    NSString *fakeFeedDataURL = @"http://jsonplaceholder.typicode.com/photos";
    NSURL *url = [[NSURL alloc] initWithString:fakeFeedDataURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSLog(@"%%FeedTableVC-S-DEBUG, The object's class is: %@.", [JSON class]);
                                                                                            NSLog(@"%%FeedTableVC-S-DEBUG, The object's count is: %lu.", [JSON count]);
                                                                                            self.imageJson = JSON;
                                                                                            // reloadData: is required because by the time this runs,
                                                                                            // tableView:numberOfRowsInSection: has already executed.
                                                                                            [self.tableView reloadData];
                                                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                            NSLog(@"%%FeedTableVC-E-DEBUG, %@.", error.localizedDescription);
                                                                                        }];
    [operation start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSLog(@"%%FeedTableVC-I-DEBUG, Inside 'numberOfSectionsInTableView:'.");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"%%FeedTableVC-I-DEBUG, Inside 'tableView: numberOfRowsInSection:'.");
    return self.imageJson.count;
}

/*
 This method runs one time for each row as it becomes visible.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Initialize and setup each cell in the table view.

    NSLog(@"%%FeedTableVC-I-DEBUG, Inside 'tableView: cellForRowAtIndexPath:'.");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    // If there is no reusable cell with identifier @"CellID" then allocate a new one.
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"CellID"];
    }
    
    /* 
     Set the main text label, secondary text label and the
     thumbnail image of the predefined UITableViewCell instance.
     */
    cell.textLabel.text       = [self.imageJson[indexPath.row][@"albumId"] stringValue];
    cell.detailTextLabel.text = self.imageJson[indexPath.row][@"title"];
    NSURL *thumbnailURL       = [NSURL URLWithString:self.imageJson[indexPath.row][@"thumbnailUrl"]];
    NSData *thumbnailData     = [NSData dataWithContentsOfURL:thumbnailURL];
    cell.imageView.image      = [UIImage imageWithData:thumbnailData];
    NSLog(@"%%FeedTableVC-I-DEBUG, Table view cell processed.");
    
    return cell;
}

/*
 Log the indexPath Row to the Console.
 */
- (void)       tableView:(UITableView *)tableView
 didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%%FeedTableVC-I-DEBUG, Inside 'tableView: didSelectRowAtIndexPath' %ld.", indexPath.row);
    
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];                  // Instantiate photo VC.
    photoVC.imageTitleString = [self.imageJson[indexPath.row][@"albumId"] stringValue]; // Set image title string.
    photoVC.imageUrlString   = self.imageJson[indexPath.row][@"url"];                   // Set image URL string.
    [self.navigationController pushViewController:photoVC animated:YES];                // Push photoVC onto Nav Controller array stack.
    NSLog(@"%%FeedTableVC-I-DEBUG, photoVC pushed to navigation controller stack.");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
