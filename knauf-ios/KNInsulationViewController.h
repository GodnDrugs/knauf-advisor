//
//  KNInsulationViewController.h
//  knauf-ios
//
//  Created by User on 22.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDownPicker.h"

@interface KNInsulationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDownPicker *depthDown;
@property (weak, nonatomic) IBOutlet UILabel *depthLabel;
@property (weak, nonatomic) IBOutlet UISlider *depthSlider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *depthDownConstraint;

@property (nonatomic) BOOL isConstruction;
@property (nonatomic, copy) NSString *type;

-(IBAction)resultsButton:(id)sender;

@end
