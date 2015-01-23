//
//  PhotoViewController.m
//  InstaPhoto
//
//  Created by Mario Abruzzi on 1/18/15.
//  Copyright (c) 2015 Mario Abruzzi. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSLog(@"%%PhotoVC-I-DEBUG, Inside 'viewDidLoad'.");

    self.view.backgroundColor = [UIColor lightGrayColor];
    NSLog(@"%%PhotoVC-I-DEBUG, 'backgroundColor' property set.");
    
    NSURL *imageURL          = [NSURL URLWithString:self.imageUrlString];
    NSData *imageData        = [NSData dataWithContentsOfURL:imageURL];
    UIImage *imageMain       = [[UIImage alloc] initWithData:imageData];
    UIImageView *imageView   = [[UIImageView alloc] initWithImage:imageMain];
    [imageView setContentMode:UIViewContentModeCenter];
    imageView.frame          = CGRectMake((375/2)-(300/2), 40, 300, 300);
    [self.view addSubview:imageView];
    NSLog(@"%%PhotoVC-I-DEBUG, Image added to subview.");
    
    UILabel *imageTitleLabel = [[UILabel alloc] init];
    imageTitleLabel.text     = self.imageTitleString;
    imageTitleLabel.frame    = CGRectMake((375/2)-(300/2), 350, 300, 40);
    [self.view addSubview:imageTitleLabel];
    NSLog(@"%%PhotoVC-I-DEBUG, Title added to subview.");
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
