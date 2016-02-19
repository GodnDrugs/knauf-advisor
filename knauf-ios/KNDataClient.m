//
//  KNDataClient.m
//  knauf-ios
//
//  Created by User on 19.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNDataClient.h"
#import "FMDatabase.h"

#import "KNAbsorption+FMResultSet.h"
#import "KNAcoustic+FMResultSet.h"
#import "KNBuilding+FMResultSet.h"
#import "KNDanoline+FMResultSet.h"
#import "KNDesign+FMResultSet.h"
#import "KNFacing+FMResultSet.h"
#import "KNFittingContent+FMResultSet.h"
#import "KNFloorCovering+FMResultSet.h"
#import "KNFloors+FMResultSet.h"
#import "KNPartition+FMResultSet.h"
#import "KNProperty+FMResultSet.h"
#import "KNReactance+FMResultSet.h"
#import "KNRiessler+FMResultSet.h"
#import "KNRoofs+FMResultSet.h"
#import "KNSpecial+FMResultSet.h"
#import "KNWallsCovering+FMResultSet.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface KNDataClient ()

@property (strong, nonatomic) FMDatabase *database;

@end

@implementation KNDataClient

+(id)sharedInstance
{
    static KNDataClient *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(id)init
{
    if (self = [super init]) {
        self.resaultsArray = [[NSArray alloc] init];
        [self openData];
    }
    return self;
}

-(void)openData
{
    [self allocInitArray];
    
    self.constructions = [[NSArray alloc] initWithObjects:@"Пол",@"Перегородка",@"Облицовка",@"Потолок",nil];
    
    NSString *const DatabaseFileName = nameBD;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:DatabaseFileName];
    if(![fileManager fileExistsAtPath:databasePath]){
        NSString *defaultDatabsePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:DatabaseFileName];
        [fileManager copyItemAtPath:defaultDatabsePath toPath:databasePath error:nil];
    }
    
   self.database = [FMDatabase databaseWithPath:databasePath];
    if (![self.database open]){
        self.database = nil;
        NSLog(@"Failed to open database");
    }
    else {
        [self answerResponseAbsorption];
    }
}

-(void) answerResponseAbsorption
{
    NSMutableSet *set = [[NSMutableSet alloc] init];
    
    NSString *response = @"select * from absorption";
    FMResultSet *resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNAbsorption *absorption = [KNAbsorption featureWithResultSet:resultSet];
        [self.absorption addObject:absorption];
    }
    
    
    response = @"select * from acoustic";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNAcoustic *acoustic = [KNAcoustic featureWithResultSet:resultSet];
        [set addObject:acoustic.grafics];
        [self.acoustic addObject:acoustic];
    }
    
    response = @"select * from building";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNBuilding *building = [KNBuilding featureWithResultSet:resultSet];
        [self.building addObject:building];
    }
    
    response = @"select * from danoline";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNDanoline *danoline = [KNDanoline featureWithResultSet:resultSet];
        [set addObject:danoline.grafics];
        [self.danoline addObject:danoline];
    }
    
    response = @"select * from design";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNDesign *design = [KNDesign featureWithResultSet:resultSet];
        [self.design addObject:design];
    }
    
    response = @"select * from facing";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNFacing *facing = [KNFacing featureWithResultSet:resultSet];
        [self.facing addObject:facing];
    }
    
    response = @"select * from fitting_content";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNFittingContent *fittingContent = [KNFittingContent featureWithResultSet:resultSet];
        [self.fittingContent addObject:fittingContent];
    }
    
    response = @"select * from floor_covering";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNFloorCovering *floorCovering = [KNFloorCovering featureWithResultSet:resultSet];
        [self.floorCovering addObject:floorCovering]; 
    }
    
    response = @"select * from floors";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNFloors *floors = [KNFloors featureWithResultSet:resultSet];
        [self.floors addObject:floors];
    }
    
    response = @"select * from partition";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNPartition *partition = [KNPartition featureWithResultSet:resultSet];
        [self.partition addObject:partition];
    }
    
    response = @"select * from property";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNProperty *property = [KNProperty featureWithResultSet:resultSet];
        [self.property addObject:property];
    }
    
    response = @"select * from reactance";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNReactance *reactance = [KNReactance featureWithResultSet:resultSet];
        [self.reactance addObject:reactance];
    }
    
    response = @"select * from riessler";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNRiessler *riessler = [KNRiessler featureWithResultSet:resultSet];
        [set addObject:riessler.grafics];
        [self.riessler addObject:riessler];
    }
    
    response = @"select * from roofs";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNRoofs *roofs = [KNRoofs featureWithResultSet:resultSet];
        [self.roofs addObject:roofs];
    }
    
    response = @"select * from special_rt60";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNSpecial *special = [KNSpecial featureWithResultSet:resultSet];
        [self.special addObject:special];
    }

    response = @"select * from walls_covering";
    resultSet = [self.database executeQuery:response];
    while([resultSet next]) {
        KNWallsCovering *wallsCovering = [KNWallsCovering featureWithResultSet:resultSet];
        [self.wallsCovering addObject:wallsCovering];
    }
 
    [self loadImages:[set allObjects]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(loadData)]) {
            [self.delegate loadData];
        } else {
            NSLog(@"Warning - delegate method not called");
        }
    });

}

-(void)allocInitArray
{
    self.absorption = [[NSMutableArray alloc] init];
    self.acoustic = [[NSMutableArray alloc] init];
    self.building = [[NSMutableArray alloc] init];
    self.danoline = [[NSMutableArray alloc] init];
    self.design = [[NSMutableArray alloc] init];
    self.facing = [[NSMutableArray alloc] init];
    self.fittingContent = [[NSMutableArray alloc] init];
    self.floorCovering = [[NSMutableArray alloc] init];
    self.floors = [[NSMutableArray alloc] init];
    self.partition = [[NSMutableArray alloc] init];
    self.property = [[NSMutableArray alloc] init];
    self.reactance = [[NSMutableArray alloc] init];
    self.riessler = [[NSMutableArray alloc] init];
    self.roofs = [[NSMutableArray alloc] init];
    self.special = [[NSMutableArray alloc] init];
    self.wallsCovering = [[NSMutableArray alloc] init];
}

-(void) loadImages:(NSArray *)array
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    for (NSString *name in array) {

        [manager downloadImageWithURL:[NSURL URLWithString:name]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 NSLog(@"progress %ld", (long)receivedSize);
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                NSLog(@"Canceel");
//                                [self.imagesLink addObject:name];
//                                if (image) {
//                                }
//                                if (self.imagesLink.count == sum) {
//                                    if ([self.delegate respondsToSelector:@selector(loadData)]) {
//                                        [self.delegate loadData];
//                                    } else {
//                                        NSLog(@"Warning - delegate method not called");
//                                    }
//                                }
                            }];
    }
}

@end
