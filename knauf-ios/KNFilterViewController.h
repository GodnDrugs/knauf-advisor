//
//  KNFilterViewController.h
//  knauf-ios
//
//  Created by User on 22.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDownPicker.h"

@interface KNFilterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDownPicker *design;
@property (weak, nonatomic) IBOutlet UIDownPicker *manufacturer;

-(IBAction)resultsButton:(id)sender;

@end
