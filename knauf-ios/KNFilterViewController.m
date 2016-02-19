//
//  KNFilterViewController.m
//  knauf-ios
//
//  Created by User on 22.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNFilterViewController.h"
#import "KNAcousticResult.h"
#import "KNDataClient.h"
#import "KNResultsViewController.h"
#import "KNDesign.h"

@interface KNFilterViewController () <DownPickerDelegate>

@property (nonatomic, strong) KNAcousticResult *acousticResult;
@property (nonatomic, strong) KNDataClient *dataClient;

@end

@implementation KNFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.acousticResult = [KNAcousticResult sharedInstance];
    self.dataClient = [KNDataClient sharedInstance];
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger z = 0;
    for (KNDesign *design in self.acousticResult.designArray) {
        NSString *name = [@"design" stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)z]];
        [array addObject:name];
        z += 1;
    }
    NSArray *el = [array copy];
    NSArray *el2 = [self.acousticResult.manufacturerArray allObjects];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    [self.design initWithData:el];
    [self.design.DownPicker setValueAtIndex:0];
    self.design.DownPicker.name = @"design";
    self.design.DownPicker.delegate = self;
    
    [self.manufacturer initWithData:el2];
    [self.manufacturer setText:@" Тип помещения"];
    self.manufacturer.DownPicker.name = @"manufacturer";
    [self.manufacturer.DownPicker setValueAtIndex:0];
    self.manufacturer.DownPicker.delegate = self;
    // Do any additional setup after loading the view.
}

//- (void)changeValue:(NSString *)name
//{
//    NSLog(@"");
//}

-(void)dismissKeyboard:(UITapGestureRecognizer *)recog
{
    [self.view endEditing:YES];
}

#pragma mark IBAction

- (IBAction)back:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(IBAction)resultsButton:(id)sender
{
    NSString *type = [self.manufacturer.DownPicker getTextField].text;
    self.dataClient.resaultsArray = [[self.acousticResult getResultsWithFilter:type :[self.design.DownPicker selectedIndex]] mutableCopy];
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
