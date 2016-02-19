//
//  KNChoiceViewController.m
//  knauf-ios
//
//  Created by User on 21.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNChoiceViewController.h"
#import "KNChSystemViewController.h"
#import "KNAcusticViewController.h"

@interface KNChoiceViewController ()

@end

@implementation KNChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

-(IBAction)isolutionButton:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KNChSystemViewController *dialogVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([KNChSystemViewController class])];
    [self.navigationController pushViewController:dialogVC animated:YES];
}

-(IBAction)acusticButton:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KNAcusticViewController *dialogVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([KNAcusticViewController class])];
    [self.navigationController pushViewController:dialogVC animated:YES];
}

@end
