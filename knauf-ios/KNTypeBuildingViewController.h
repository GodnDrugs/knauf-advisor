//
//  KNTypeBuildingViewController.h
//  knauf-ios
//
//  Created by User on 21.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDownPicker.h"

@interface KNTypeBuildingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDownPicker *typeDown;
@property (weak, nonatomic) IBOutlet UIDownPicker *roomDown;
@property (weak, nonatomic) IBOutlet UIDownPicker *designDown;

-(IBAction)parametrsButton:(id)sender;
-(IBAction)resultsButton:(id)sender;

@end
