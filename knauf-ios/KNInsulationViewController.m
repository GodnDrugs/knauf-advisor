//
//  KNInsulationViewController.m
//  knauf-ios
//
//  Created by User on 22.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNInsulationViewController.h"
#import "KNResultsViewController.h"
#import "KNDataClient.h"
#import "KNFloors.h"
#import "KNRoofs.h"
#import "KNFacing.h"
#import "KNPartition.h"
#import "KNResultsInsulation.h"


@interface KNInsulationViewController () <DownPickerDelegate>

@property (nonatomic) CGFloat max;
@property (nonatomic) CGFloat min;
@property (nonatomic) CGFloat result;
@property (nonatomic,strong) KNDataClient *dataClient;

@end

@implementation KNInsulationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataClient = [KNDataClient sharedInstance];
    self.dataClient.resoultsAcustic = [[NSArray alloc] init];
    
    if (self.isConstruction) {
        self.depthDownConstraint.constant = 0;
    }
    else {
        NSArray *el = [self.dataClient.constructions copy];
        [self.depthDown initWithData:el];
        [self.depthDown.DownPicker setValueAtIndex:0];
        self.depthDown.DownPicker.delegate = self;
        self.type = self.depthDown.DownPicker.text;
    }

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    [self setMaxValue];
}

-(void)setMaxValue
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"depth"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    if ([self.type isEqualToString:@"Пол"]) {

        NSArray *sortedArray = [self.dataClient.floors sortedArrayUsingDescriptors:sortDescriptors];
        KNFloors *floors = sortedArray.lastObject;
        self.max = floors.depth.doubleValue;
        floors = sortedArray.firstObject;
        self.min = floors.depth.doubleValue;
    } else if ([self.type isEqualToString:@"Потолок"]) {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"depthGeneral"
                                                     ascending:YES];
        sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray = [self.dataClient.roofs sortedArrayUsingDescriptors:sortDescriptors];
        KNRoofs *roofs = sortedArray.lastObject;
        self.max = roofs.depthGeneral.doubleValue;
        roofs = sortedArray.firstObject;
        self.min = roofs.depthGeneral.doubleValue;
    } else if ([self.type isEqualToString:@"Облицовка"]) {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"depthGeneral"
                                                     ascending:YES];
        sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray = [self.dataClient.facing sortedArrayUsingDescriptors:sortDescriptors];
        KNFacing *facing = sortedArray.lastObject;
        self.max = facing.depthGeneral.doubleValue;
        facing = sortedArray.firstObject;
        self.min = facing.depthGeneral.doubleValue;
    } else if ([self.type isEqualToString:@"Перегородка"]) {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"depth"
                                                     ascending:YES];
        sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray = [self.dataClient.partition sortedArrayUsingDescriptors:sortDescriptors];
        KNPartition *partition = sortedArray.lastObject;
        self.max = partition.depth.doubleValue;
        partition = sortedArray.firstObject;
        self.min = partition.depth.doubleValue;
    }

    self.depthLabel.text = [[NSString stringWithFormat: @"%.2f", self.max] stringByAppendingString:@" м."];
    
    self.result = self.max;
    [self.depthSlider setValue:1 animated:NO];
}


-(void)dismissKeyboard:(UITapGestureRecognizer *)recog
{
    [self.view endEditing:YES];
}

#pragma mark IBAction

-(IBAction)resultsButton:(id)sender
{
    if (self.isConstruction) {
        self.dataClient.depth = self.result;
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (KNResultsInsulation *result in self.dataClient.resoultsInsulation) {
            if (result.depth.doubleValue <= self.result) {
                [array addObject:result];
            }
        }
        self.dataClient.resaultsArray = [array copy];
    } else {
        [self getResultArray];
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KNResultsViewController *dialogVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([KNResultsViewController class])];
    [self.navigationController pushViewController:dialogVC animated:YES];
}

- (IBAction)back:(id)sender
{
    if (self.isConstruction) {
        UIAlertController * view = [UIAlertController
                                    alertControllerWithTitle:@"!!!"
                                    message:@"При переходе Back доп. параметры не сохранятся. Продолжить?"
                                    preferredStyle:UIAlertControllerStyleAlert ];
        UIAlertAction * cancel= [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                 }];
        UIAlertAction * ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {

                                     [[self navigationController] popViewControllerAnimated:YES];
                                 }];
        [view   addAction: ok];
        [view   addAction: cancel];
        [self presentViewController:view animated:YES completion:nil];
    } else {
        [[self navigationController] popViewControllerAnimated:YES];
    }

}

-(void)getResultArray
{
    NSMutableArray *resultsArray = [[NSMutableArray alloc] init];
    if ([self.type isEqualToString:@"Пол"]) {
        for (KNFloors *floors in self.dataClient.floors) {
            KNResultsInsulation *result = [[KNResultsInsulation alloc] init];
            if (self.result >= floors.depth.doubleValue) {
                result.name = floors.key;
                result.depth = floors.depth;
                result.graficsLink = floors.grafics;
                result.descriptions = floors.descriptions;
                result.type = @"Пол";
                [resultsArray addObject:result];
            }
        }
    } else if ([self.type isEqualToString:@"Потолок"]) {
        for (KNRoofs *roofs in self.dataClient.roofs) {
            KNResultsInsulation *result = [[KNResultsInsulation alloc] init];
            if (self.result >= roofs.depthGeneral.doubleValue) {
                result.name = roofs.name;
                result.depth = roofs.depthGeneral;
                result.graficsLink = roofs.grafics;
                result.descriptions = roofs.descriptions;
                result.type = @"Потолок";
                [resultsArray addObject:result];
            }
        }
    } else if ([self.type isEqualToString:@"Облицовка"]) {
        for (KNFacing *facing in self.dataClient.facing) {
            if (self.result >= facing.depthGeneral.doubleValue) {
                KNResultsInsulation *result = [[KNResultsInsulation alloc] init];
                result.name = facing.name;
                result.depth = facing.depthGeneral;
                result.graficsLink = facing.grafics;
                result.descriptions = facing.descriptions;
                result.type = @"Облицовка";
                [resultsArray addObject:result];
            }
        }
    } else if ([self.type isEqualToString:@"Перегородка"]) {
        for (KNPartition *partition in self.dataClient.partition) {
            if (self.result >= partition.depth.doubleValue) {
                KNResultsInsulation *result = [[KNResultsInsulation alloc] init];
                result.name = partition.name;
                result.depth = partition.depth;
                result.graficsLink = partition.grafics;
                result.descriptions = partition.descriptions;
                result.type = @"Перегородка";
                [resultsArray addObject:result];
            }
        }
    }
    self.dataClient.resoultsInsulation = [resultsArray copy];
    self.dataClient.resaultsArray = [resultsArray copy];
}

- (void)changeValue:(NSString *)name
{
    self.type = self.depthDown.DownPicker.text;
    [self setMaxValue];
}

- (IBAction)sliderValueChanged:(id)sender
{
    self.result = self.min + (self.max - self.min) * self.depthSlider.value;
    self.depthLabel.text = [[NSString stringWithFormat: @"%.2f",self.result] stringByAppendingString:@" м."];
}

@end
