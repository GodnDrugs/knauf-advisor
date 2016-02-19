//
//  KNAcusticViewController.m
//  knauf-ios
//
//  Created by User on 22.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNAcusticViewController.h"
#import "KNResultsViewController.h"
#import "DownPicker.h"
#import "KNDataClient.h"
#import "KNAcousticResult.h"
#import "KNBuilding.h"
#import "KNDesign.h"
#import "KNProperty.h"

@interface KNAcusticViewController () <UITextFieldDelegate, DownPickerDelegate>

@property (nonatomic) BOOL keyboardClose;
@property (nonatomic) BOOL textFieldEditing;
@property (nonatomic) CGFloat max;
@property (nonatomic) CGFloat resultt;
@property (nonatomic) NSInteger buildID;
@property (nonatomic) NSInteger propertyID;
@property (nonatomic, strong) KNAcousticResult *acousticResult;
@property (nonatomic, strong) KNDataClient *dataClient;
@property (nonatomic, strong) NSMutableArray *buildingArray;
@property (nonatomic, strong) NSMutableArray *RoomArray;

@end

@implementation KNAcusticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.keyboardClose = YES;
    
    self.acousticResult = [KNAcousticResult sharedInstance];
    self.dataClient = [KNDataClient sharedInstance];
    self.dataClient.resoultsInsulation = [[NSArray alloc] init];
    self.buildingArray = [[NSMutableArray alloc] init];
    self.RoomArray = [[NSMutableArray alloc] init];
    
    for (KNBuilding *building in self.dataClient.building) {
        [self.buildingArray addObject:building.name];
    }
    NSArray *el = [self.buildingArray copy];
    
    self.length.delegate = self;
    self.height.delegate = self;
    self.widht.delegate = self;
    
    //self.max = 777;
    self.maxVolume.text = [[@"Максимальный объём " stringByAppendingString: [NSString stringWithFormat: @"%.2f", self.max]]stringByAppendingString:@" куб.м."];
    
    self.result.text = @"Введите три параметра: длину, ширину, высоту";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    [self.length addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
    [self.height addTarget:self
                    action:@selector(textFieldDidChange:)
          forControlEvents:UIControlEventEditingChanged];
    [self.widht addTarget:self
                    action:@selector(textFieldDidChange:)
          forControlEvents:UIControlEventEditingChanged];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardOpen:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardClose:) name:UIKeyboardWillHideNotification object:nil];
    
    NSArray *el2 = [[self getTypeRoom:self.buildingArray[0]] copy];
    
    [self.typeDown initWithData:el];
    self.typeDown.DownPicker.name = @"typeDown";
    [self.typeDown.DownPicker setValueAtIndex:0];
    self.typeDown.DownPicker.delegate = self;
    [self.roomDown initWithData:el2];
    self.roomDown.DownPicker.name = @"roomDown";
    [self.roomDown.DownPicker setValueAtIndex:0];
    self.roomDown.DownPicker.delegate = self;
    
    [self getMaxVol];
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

-(void)getMaxVol
{
    NSInteger iD =  [self.typeDown.DownPicker selectedIndex];
    NSString *type = self.buildingArray[iD];
    NSPredicate *p = [NSPredicate predicateWithFormat: @"name == %@", type];
    KNBuilding *build = [[self.dataClient.building copy] filteredArrayUsingPredicate:p].firstObject;
    self.buildID = build.iD.intValue;
    iD =  [self.roomDown.DownPicker selectedIndex];
    type = self.RoomArray[iD];
    p = [NSPredicate predicateWithFormat: @"name == %@", type];
    KNProperty *property = [[self.dataClient.property copy] filteredArrayUsingPredicate:p].firstObject;
    self.propertyID = property.iD.intValue;
    NSString *buildingPredicate = [@"buildingID == " stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)self.buildID]];
    NSString *propertyPredicate = [@"propertyID == " stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)self.propertyID]];
    NSPredicate *p1 = [NSPredicate predicateWithFormat: buildingPredicate];
    NSPredicate *p2 = [NSPredicate predicateWithFormat: propertyPredicate];
    NSPredicate *pred = [NSCompoundPredicate andPredicateWithSubpredicates: @[p1, p2]];
    KNDesign *myDesign = [[self.dataClient.design copy] filteredArrayUsingPredicate:pred].firstObject;
    self.max = myDesign.volumeLimiter.doubleValue;
    self.maxVolume.text = [[@"Максимальный объём " stringByAppendingString: [NSString stringWithFormat: @"%.2f", self.max]]stringByAppendingString:@" куб.м."];
    if (self.resultt > 0) {
        self.result.text = [[NSString stringWithFormat: @"%.2f", self.resultt]stringByAppendingString:@" куб.м."];
        if (self.resultt > self.max ) {
            self.maxVolume.backgroundColor = [UIColor redColor];
        } else {
            self.maxVolume.backgroundColor = [UIColor clearColor];
        }
    }
}


-(void)dismissKeyboard:(UITapGestureRecognizer *)recog
{
    [self.view endEditing:YES];
}

#pragma mark IBAction

-(IBAction)resultsButton:(id)sender
{
    if (self.resultt > 0) {
        if (self.resultt > self.max) {
            [self errorMessage:@"Максимальный объём привышен"];
        } else {
            NSArray *array = [self.acousticResult getResultsWithoutFilterTypeBuild:self.buildID TypeRoom:self.propertyID Length:self.length.text.doubleValue Widht:self.widht.text.doubleValue Height:self.height.text.doubleValue];
            self.dataClient.resaultsArray = [array copy];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            KNResultsViewController *dialogVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([KNResultsViewController class])];
            dialogVC.isFiltred = true;

            [self.navigationController pushViewController:dialogVC animated:YES];
        }
    } else {
        [self errorMessage:@"Введены не все данные"];
    }

}

- (IBAction)back:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark handleKeyboard

- (void)handleKeyboardOpen:(NSNotification *)sender
{
    if ((self.keyboardClose) && (self.textFieldEditing)) {
        CGRect rect = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect frame = self.view.frame;
        frame.origin.y -= rect.size.height - 45;
        [UIView animateWithDuration:0.25 animations:^{
            self.view.frame = frame;
        }];
        self.keyboardClose = NO;
    }
}

- (void)handleKeyboardClose:(NSNotification *)sender
{
    if ((!self.keyboardClose) && (self.textFieldEditing)) {
        CGRect rect = [sender.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect frame = self.view.frame;
        frame.origin.y += rect.size.height - 45;
        [UIView animateWithDuration:0.25 animations:^{
            self.view.frame = frame;
        }];
        self.keyboardClose = YES;
        self.textFieldEditing = NO;
    }
}

#pragma mark textViewDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.textFieldEditing = YES;
}

-(void)textFieldDidChange:(UITextField *)textField
{
    NSScanner * scanner = [NSScanner scannerWithString: textField.text];
    double dummy;
    
    BOOL isNumber = [scanner scanDouble: & dummy];
    
    if ([textField.text isEqualToString:@""]) {
        textField.backgroundColor = [UIColor clearColor];
        self.maxVolume.backgroundColor = [UIColor clearColor];
        self.result.text = @"Введите три параметра: длину, ширину, высоту";
    } else {
            if (isNumber && [scanner isAtEnd]) {
                self.resultt = self.length.text.doubleValue * self.height.text.doubleValue * self.widht.text.doubleValue;
                if (self.resultt > 0) {
                    self.result.text = [[NSString stringWithFormat: @"%.2f", self.resultt]stringByAppendingString:@" куб.м."];
                    if (self.resultt > self.max ) {
                        self.maxVolume.backgroundColor = [UIColor redColor];
                    } else {
                       self.maxVolume.backgroundColor = [UIColor clearColor]; 
                    }
                } else {
                    self.maxVolume.backgroundColor = [UIColor clearColor];
                    self.result.text = @"Введите три параметра: длину, ширину, высоту";
                }
                textField.backgroundColor = [UIColor greenColor];
            } else {
                textField.backgroundColor = [UIColor redColor];
            }
        }
}

-(void)errorMessage: (NSString *) text
{
    UIAlertController * view = [UIAlertController
                                alertControllerWithTitle:@"!!!"
                                message:text
                                preferredStyle:UIAlertControllerStyleAlert ];
    UIAlertAction * cancel= [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action) {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                             }];
    [view   addAction: cancel];
    
    //проверка есть ли база
    [self presentViewController:view animated:YES completion:nil];
}

- (void)changeValue:(NSString *)name
{
    if ([name isEqualToString:@"typeDown"]) {
        NSInteger iD =  [self.typeDown.DownPicker selectedIndex];
        NSArray *el2 = [[self getTypeRoom:self.buildingArray[iD]] copy];
        [self.roomDown.DownPicker setData:el2];
        [self.roomDown.DownPicker setValueAtIndex:0];
    }
    [self getMaxVol];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
@end
