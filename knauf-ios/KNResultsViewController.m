//
//  KNResultsViewController.m
//  knauf-ios
//
//  Created by User on 19.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNResultsViewController.h"
#import "KNFilterViewController.h"
#import "ResultsTableViewCell.h"
#import "KNDataClient.h"
#import "KNResultsAcoustic.h"
#import "KNResultsInsulation.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface KNResultsViewController ()

@property (strong, nonatomic) KNDataClient *dataClient;
@property (strong, nonatomic) NSArray *resaultsArray;

@end

@implementation KNResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataClient = [KNDataClient sharedInstance];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ResultsTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ResultsTableViewCell class])];
    
    if (!self.isFiltred) {
        self.filtredButton.enabled = false;
        self.filtredButton.tintColor = [UIColor clearColor];
    }

}

- (void) viewWillAppear:(BOOL)animated
{
    self.resaultsArray = [self.dataClient.resaultsArray copy];
    [self.tableView reloadData];
}

#pragma mark Override UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resaultsArray.count;
}

#pragma mark Override UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ResultsTableViewCell heightWithTableView:tableView];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ResultsTableViewCell class]) forIndexPath:indexPath];
    
    if (self.dataClient.resoultsAcustic.count > 0) {
        KNResultsAcoustic *resault = self.resaultsArray[indexPath.row];
        [cell.image sd_setImageWithURL:[NSURL URLWithString:resault.graficsLink]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        cell.nameLabel.text = [resault.typePanel stringByAppendingString:resault.iD.stringValue];
        cell.infoLabel.text = resault.descriptions;
    } else {
        KNResultsInsulation *resault = self.resaultsArray[indexPath.row];
        [cell.image sd_setImageWithURL:[NSURL URLWithString:resault.graficsLink]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        cell.nameLabel.text = resault.depth.stringValue;
        cell.infoLabel.text = resault.descriptions;
        NSLog(@"fs");
    }

    return cell;
}

#pragma mark IBAction

- (IBAction)back:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)filter:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KNFilterViewController *dialogVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([KNFilterViewController class])];
    [self.navigationController pushViewController:dialogVC animated:YES];
}

@end
