//
//  KNResultsViewController.h
//  knauf-ios
//
//  Created by User on 19.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNResultsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL isFiltred;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filtredButton;

@end
