//
//  KNChSystemViewController.m
//  knauf-ios
//
//  Created by User on 21.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNChSystemViewController.h"
#import "KNTypeBuildingViewController.h"
#import "KNInsulationViewController.h"

@interface KNChSystemViewController ()

@end

@implementation KNChSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view.
}

#pragma mark IBAction

-(IBAction)typeBildButton:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KNTypeBuildingViewController *dialogVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([KNTypeBuildingViewController class])];
    [self.navigationController pushViewController:dialogVC animated:YES];
}

-(IBAction)depth:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KNInsulationViewController *dialogVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([KNInsulationViewController class])];
    [self.navigationController pushViewController:dialogVC animated:YES];
}

- (IBAction)back:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
