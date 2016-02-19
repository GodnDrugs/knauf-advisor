//
//  KNAcusticViewController.h
//  knauf-ios
//
//  Created by User on 22.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDownPicker.h"

@interface KNAcusticViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDownPicker *typeDown;
@property (weak, nonatomic) IBOutlet UIDownPicker *roomDown;
@property (weak, nonatomic) IBOutlet UITextField *length;
@property (weak, nonatomic) IBOutlet UITextField *widht;
@property (weak, nonatomic) IBOutlet UITextField *height;
@property (weak, nonatomic) IBOutlet UILabel *result;
@property (weak, nonatomic) IBOutlet UILabel *maxVolume;

-(IBAction)resultsButton:(id)sender;

@end
