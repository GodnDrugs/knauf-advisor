//
//  KNTypeBuildingViewController.m
//  knauf-ios
//
//  Created by User on 21.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNTypeBuildingViewController.h"
#import "KNInsulationViewController.h"
#import "KNResultsViewController.h"
#import "KNDataClient.h"
#import "KNDesign.h"
#import "KNProperty.h"
#import "KNBuilding.h"
#import "KNFloors.h"
#import "KNPartition.h"
#import "KNRoofs.h"
#import "KNFacing.h"
#import "KNInsulationResult.h"
#import "KNResultsInsulation.h"

#import <math.h>

@interface KNTypeBuildingViewController () <DownPickerDelegate>

@property (nonatomic, strong) KNDataClient *dataClient;
@property (nonatomic, strong) KNInsulationResult *insulationResult;
@property (nonatomic, strong) NSMutableArray *buildingArray;
@property (nonatomic, strong) NSMutableArray *RoomArray;
@property (nonatomic, strong) NSMutableArray *resultsArray;

@end

@implementation KNTypeBuildingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataClient = [KNDataClient sharedInstance];
    self.dataClient.depth = 0;
    self.dataClient.resoultsAcustic = [[NSArray alloc] init];
    self.buildingArray = [[NSMutableArray alloc] init];
    self.RoomArray = [[NSMutableArray alloc] init];
    self.resultsArray = [[NSMutableArray alloc] init];
    
    for (KNBuilding *building in self.dataClient.building) {
        [self.buildingArray addObject:building.name];
    }
    NSArray *el = [self.buildingArray copy];
    
    NSArray *el2 = [[self getTypeRoom:self.buildingArray[0]] copy];
    NSArray *el3 = [self.dataClient.constructions copy];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    [self.typeDown initWithData:el];
    [self.typeDown setText:el[0]];
    self.typeDown.DownPicker.delegate = self;
    self.typeDown.DownPicker.name = @"typeDown";
    [self.roomDown initWithData:el2];
    [self.roomDown.DownPicker setValueAtIndex:0];
    [self.designDown initWithData:el3];
    [self.designDown.DownPicker setValueAtIndex:0];

}

-(void)getResults
{
    NSInteger iD =  [self.typeDown.DownPicker selectedIndex];
    NSString *type = self.buildingArray[iD];
    NSPredicate *p = [NSPredicate predicateWithFormat: @"name == %@", type];
    KNBuilding *build = [[self.dataClient.building copy] filteredArrayUsingPredicate:p].firstObject;
    NSInteger buildID = build.iD.intValue;
    iD =  [self.roomDown.DownPicker selectedIndex];
    type = self.RoomArray[iD];
    p = [NSPredicate predicateWithFormat: @"name == %@", type];
    KNProperty *property = [[self.dataClient.property copy] filteredArrayUsingPredicate:p].firstObject;
    NSInteger propertyID = property.iD.intValue;
    NSString *buildingPredicate = [@"buildingID == " stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)buildID]];
    NSString *propertyPredicate = [@"propertyID == " stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)propertyID]];
    NSPredicate *p1 = [NSPredicate predicateWithFormat: buildingPredicate];
    NSPredicate *p2 = [NSPredicate predicateWithFormat: propertyPredicate];
    NSPredicate *pred = [NSCompoundPredicate andPredicateWithSubpredicates: @[p1, p2]];
    KNDesign *myDesign = [[self.dataClient.design copy] filteredArrayUsingPredicate:pred].firstObject;
    NSString *design = [self.designDown.DownPicker getTextField].text;
    
    [self.resultsArray removeAllObjects];

    
    if ([design isEqualToString:@"Пол"]) {
        for (KNFloors *floors in self.dataClient.floors) {

            if ((roundf(floors.rw.doubleValue) == myDesign.rw.doubleValue) && (roundf(floors.lnw.doubleValue) == myDesign.lnw.doubleValue)) {
                KNResultsInsulation *result = [[KNResultsInsulation alloc] init];
                result.name = floors.key;
                result.depth = floors.depth;
                result.graficsLink = floors.grafics;
                result.descriptions = floors.descriptions;
                result.type = @"Пол";
                [self.resultsArray addObject:result];
            }
        }
    } else if ([design isEqualToString:@"Потолок"]) {
        for (KNRoofs *roofs in self.dataClient.roofs) {
            if (roofs.rw.doubleValue == myDesign.rw.doubleValue) {
                KNResultsInsulation *result = [[KNResultsInsulation alloc] init];
                result.name = roofs.name;
                result.depth = roofs.depthGeneral;
                result.graficsLink = roofs.grafics;
                result.descriptions = roofs.descriptions;
                result.type = @"Потолок";
                [self.resultsArray addObject:result];
            }
        }
    } else if ([design isEqualToString:@"Облицовка"]) {
        for (KNFacing *facing in self.dataClient.facing) {
            if (facing.rw.doubleValue == myDesign.rw.doubleValue) {
                KNResultsInsulation *result = [[KNResultsInsulation alloc] init];
                result.name = facing.name;
                result.depth = facing.depthGeneral;
                result.graficsLink = facing.grafics;
                result.descriptions = facing.descriptions;
                result.type = @"Облицовка";
                [self.resultsArray addObject:result];
            }
        }
    } else if ([design isEqualToString:@"Перегородка"]) {
        for (KNPartition *partition in self.dataClient.partition) {
            if (partition.rw.doubleValue == myDesign.rw.doubleValue) {
                KNResultsInsulation *result = [[KNResultsInsulation alloc] init];
                result.name = partition.name;
                result.depth = partition.depth;
                result.graficsLink = partition.grafics;
                result.descriptions = partition.descriptions;
                result.type = @"Перегородка";
                [self.resultsArray addObject:result];
            }
        }
    }
    self.dataClient.resoultsInsulation = [self.resultsArray copy];
    self.dataClient.resaultsArray = [self.resultsArray copy];
}

-(NSArray *) getTypeRoom:(NSString *)buildingType
{
    NSPredicate *p = [NSPredicate predicateWithFormat: @"name == %@", buildingType];
    KNBuilding *build = [[self.dataClient.building copy] filteredArrayUsingPredicate:p].firstObject;
    NSString *propertyPredicate = [@"buildingID == " stringByAppendingString:[NSString stringWithFormat: @"%@",  build.iD]];
    NSPredicate *p1 = [NSPredicate predicateWithFormat: propertyPredicate];
    NSArray *array = [[self.dataClient.design copy] filteredArrayUsingPredicate:p1];
    NSMutableSet *set = [[NSMutableSet alloc] init];
    for (KNDesign *design in array) {
        [set addObject:design.propertyID];
    }
    NSMutableArray *array1 = [[NSMutableArray alloc] init];
    for (NSNumber *number in set) {
        propertyPredicate = [@"iD == " stringByAppendingString:[NSString stringWithFormat: @"%@",  number]];
        p1 = [NSPredicate predicateWithFormat: propertyPredicate];
        KNProperty *property = [[self.dataClient.property copy] filteredArrayUsingPredicate:p1].firstObject;
        [array1 addObject:property.name];
    }
    self.RoomArray = [array1 mutableCopy];
    return [array1 copy];
}

#pragma mark IBAction

-(IBAction)parametrsButton:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KNInsulationViewController *dialogVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([KNInsulationViewController class])];
    dialogVC.isConstruction = YES;
    dialogVC.type = [self.designDown.DownPicker getTextField].text;
    [self.navigationController pushViewController:dialogVC animated:YES];
}

-(IBAction)resultsButton:(id)sender
{
    [self getResults];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KNResultsViewController *dialogVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([KNResultsViewController class])];
    dialogVC.isFiltred = NO;
    [self.navigationController pushViewController:dialogVC animated:YES];
}

- (IBAction)back:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void)dismissKeyboard:(UITapGestureRecognizer *)recog
{
    [self.view endEditing:YES];
}

- (void)changeValue:(NSString *)name
{
    if ([name isEqualToString:@"typeDown"]) {
        NSInteger iD =  [self.typeDown.DownPicker selectedIndex];
        NSArray *el2 = [[self getTypeRoom:self.buildingArray[iD]] copy];
        [self.roomDown.DownPicker setData:el2];
        [self.roomDown.DownPicker setValueAtIndex:0];
    }
}
@end
