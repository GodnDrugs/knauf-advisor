//
//  ResultsTableViewCell.m
//  knauf-ios
//
//  Created by User on 19.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "ResultsTableViewCell.h"
#import "KNCustomView.h"

@implementation ResultsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)heightWithTableView:(UITableView *)tableView
{
    return 133;
}

@end
