//
//  ResultsTableViewCell.h
//  knauf-ios
//
//  Created by User on 19.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

+(CGFloat)heightWithTableView:(UITableView *)tableView;

@end
