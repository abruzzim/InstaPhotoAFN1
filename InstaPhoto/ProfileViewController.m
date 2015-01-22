//
//  ProfileViewController.m
//  InstaPhoto
//
//  Created by abruzzim on 12/30/14.
//  Copyright (c) 2014 Mario Abruzzi. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFJSONRequestOperation.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Profile";
        NSLog(@"%%ProfileViewController-I-DEBUG, 'title' property set.");
        self.tabBarItem.image = [UIImage imageNamed:@"Profile"];
        NSLog(@"%%ProfileViewController-I-DEBUG, 'tabBarItem.image' property set.");
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Custom view controller behavior.
    self.view.backgroundColor = [UIColor yellowColor];
    NSLog(@"%%ProfileViewController-I-DEBUG, 'backgroundColor' property set.");
    
    /** Setup Scroll View **/

    // Scroll View - class supports displaying content that is
    // larger than the size of the application's window.
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    // Set the integer bit mask that determines how the receiver resizes
    // itself when its superview's bounds change.
    self.scrollView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
    // Set the size of the content view.
    // The scroll view height is "y" + "height of last view" + "padding"
    // In this case: 700 + 40 + 100 = 840
    self.scrollView.contentSize = CGSizeMake(320, 840);
    
    /** Get Profile JSON data from the Internet **/
    
    // Create the URL object set to the JSON endpoint.
    // Note: jsontest.com loops back JSON data specified
    //       in a URL. Not all user profile fields were
    //       able to be looped back because of jsontest.com
    //       limitations.
    NSString *testDataURL = @"http://echo.jsontest.com/fName/Mario/lName/Ziecheck/city/New_York/bio/Bio_Placeholder/mbrSince/December-2014";
    NSURL *url = [[NSURL alloc] initWithString:testDataURL];
    
    // Create the URL Load Request using NSURL.
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    // Create the AFJSONRequestOperation to perform the Internet call.
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
      success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
          // If the request succeeds:
          NSLog(@"%%ProfileViewController-S-DEBUG, The object is: %@.", JSON);
          NSLog(@"%%ProfileViewController-S-DEBUG, The object class is: %@.", [JSON class]);
          NSLog(@"%%ProfileViewController-S-DEBUG, The object's keys are: %@.", [JSON allKeys]);
          NSLog(@"%%ProfileViewController-S-DEBUG, The object's values are: %@.", [JSON allValues]);
          // Set the userProfile property to the results of the JSON request.
          self.userProfile = JSON;
          // Call the JSON parse method.
          [self populateUserProfile];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
          // If the request fails:
          NSLog(@"%%ProfileViewController-E-DEBUG, %@.", error.localizedDescription);
    }];
    
    // Start the request operation.
    [operation start];
    
    /** Adds the scroll view to the end of the receiver’s list of subviews. **/
    
    // Add the scrollView as a subview.
    [self.view addSubview:self.scrollView];
    
}

- (void)populateUserProfile {
    NSLog(@"%%ProfileViewController-I-DEBUG, Start populateUserProfile:.");
    
    /** Add Picture from the Internet **/
    
    // Create an image view object to display an image.
    UIImageView *profileImageView = [[UIImageView alloc] init];
    
    // Set the frame, which descibes the view's location and size
    // in its superview's coordinate system.
    profileImageView.frame = CGRectMake(30, 30, 100, 100);
    
    // Get the image from the Internet
    NSString *gravatarURL = @"http://s.gravatar.com/avatar/a2bc40cb59c487b5415d558965ea3fee?s=200";
    NSString *placeholderImage = @"Placeholder.png";
    [profileImageView setImageWithURL:[NSURL URLWithString:gravatarURL]
                     placeholderImage:[UIImage imageNamed:placeholderImage]];
    
    // Add the picture as a subview.
    [self.scrollView addSubview:profileImageView];
    
    /** Add Name **/
    
    // Initialize and return a newly allocated view object.
    UILabel *nameLbl = [[UILabel alloc] init];
    // Specify the frame rectangle.
    nameLbl.frame = CGRectMake(30, 150, 280, 40);
    // Set the text property.
    nameLbl.text = [NSString stringWithFormat:@"Name: %@ %@", self.userProfile[@"fName"], self.userProfile[@"lName"]];
    // Add the label as a subview.
    [self.scrollView addSubview:nameLbl];
    
    /** Add City **/
    
    UILabel *cityLbl = [[UILabel alloc] init];
    cityLbl.frame = CGRectMake(30, 190, 280, 40);
    cityLbl.text = [NSString stringWithFormat:@"City: %@", self.userProfile[@"city"]];
    [self.scrollView addSubview:cityLbl];
    
    /** Add Biography **/
    
    UITextView *bioText = [[UITextView alloc] init];
    bioText.frame = CGRectMake(30, 280, 150, 400);
    // Set the text font.
    bioText.font = [UIFont fontWithName:@"Helvetica" size:15];
    // Boolean value indicating that this receiver is not editable.
    bioText.editable = NO;
    // Add text.
    bioText.text = @"Bio: Mario Abruzzi is coding along with Gregg Pollack, the founder of Envy Labs and teacher of multiple courses at Code School. Code School teaches web programming in the comfort of my browser with video lessons, coding chalenges and screencasts. Currently he is re-doing this whole course to clean up his directories and version control.";
    [self.scrollView addSubview:bioText];
    
    /** Add Membership **/
    
    UILabel *memberSinceLbl = [[UILabel alloc] init];
    memberSinceLbl.frame = CGRectMake(30, 700, 280, 40);
    memberSinceLbl.text = [NSString stringWithFormat:@"Member Since: %@", self.userProfile[@"mbrSince"]];
    [self.scrollView addSubview:memberSinceLbl];
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

@end
