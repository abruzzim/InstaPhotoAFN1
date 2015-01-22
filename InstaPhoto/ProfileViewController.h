//
//  ProfileViewController.h
//  InstaPhoto
//
//  Created by abruzzim on 12/30/14.
//  Copyright (c) 2014 Mario Abruzzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

// Add scroll view capability.
@property (strong, nonatomic) UIScrollView *scrollView;
// Add NSDictionary property to store JSON data.
@property (strong, nonatomic) NSDictionary *userProfile;

@end
