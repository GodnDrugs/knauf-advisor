//
//  KNComputResult.m
//  knauf-ios
//
//  Created by User on 27.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNAcousticResult.h"
#import "KNDesign.h"
#import "KNDataClient.h"
#import "KNReactance.h"
#import "KNAbsorption.h"
#import "KNFloorCovering.h"
#import "KNWallsCovering.h"
#import "KNFittingContent.h"
#import "KNDanoline.h"
#import "KNRiessler.h"
#import "KNAcoustic.h"
#import "KNResultsAcoustic.h"

#import <math.h>

@interface KNAcousticResult ()

@property (nonatomic,strong) KNDataClient *dataClient;
@property (nonatomic) CGFloat delKor;
@property (nonatomic,strong) NSNumber *Pfurn;
@property (nonatomic,strong) NSMutableArray *stekloArray;
@property (nonatomic,strong) NSMutableArray *dveriArray;
@property (nonatomic,strong) NSMutableArray *absorptionArray;
@property (nonatomic,strong) NSMutableArray *RT60x;
@property (nonatomic,strong) NSMutableArray *RT60r;
@property (nonatomic,strong) NSMutableArray *floorArray;
@property (nonatomic,strong) NSMutableArray *wallsArray;
@property (nonatomic,strong) NSMutableArray *fittingArray;
@property (nonatomic,strong) NSMutableArray *danolineArray;
@property (nonatomic,strong) NSMutableArray *acousticArray;

@property (nonatomic) NSInteger typeBuild;
@property (nonatomic) NSInteger typeRoom;
@property (nonatomic) NSInteger typeDesign;
@property (nonatomic) NSInteger typeManufacturer;
@property (nonatomic) CGFloat length;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat widht;
@property (nonatomic, strong) NSMutableSet *results;

@end

@implementation KNAcousticResult

+(id)sharedInstance
{
    static KNAcousticResult *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(id)init
{
    if (self = [super init]) {
        self.results = [[NSMutableSet alloc] init];
        self.dataClient = [KNDataClient sharedInstance];
        [self addDataToArray];
        self.floorArray = [[NSMutableArray alloc] init];
        self.wallsArray = [[NSMutableArray alloc] init];
        self.fittingArray = [[NSMutableArray alloc] init];
        self.danolineArray = [[NSMutableArray alloc] init];
        self.manufacturerArray = [[NSMutableSet alloc] init];
        self.RT60r = [[NSMutableArray alloc] init];
        self.RT60x = [[NSMutableArray alloc] init];
        self.delKor = 0.05;
    }
    return self;
}

-(NSArray *)getResultsWithoutFilterTypeBuild:(NSInteger)typeBuild TypeRoom:(NSInteger)typeRoom Length:(CGFloat)length Widht:(CGFloat)widht Height:(CGFloat)height
{
    [self.results removeAllObjects];
    self.designArray = [[NSArray alloc] init];
    self.typeBuild = typeBuild;
    self.typeRoom = typeRoom;
    self.length = length;
    self.widht = widht;
    self.height = height;
    
    CGFloat V = self.length * self.widht * self.height;
    
    NSString *buildingPredicate = [@"buildingID == " stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)self.typeBuild]];
    NSString *propertyPredicate = [@"propertyID == " stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)self.typeRoom]];
    NSPredicate *p1 = [NSPredicate predicateWithFormat: buildingPredicate];
    NSPredicate *p2 = [NSPredicate predicateWithFormat: propertyPredicate];
    NSPredicate *p = [NSCompoundPredicate andPredicateWithSubpredicates: @[p1, p2]];
    self.designArray = [[self.dataClient.design copy] filteredArrayUsingPredicate:p];
    
    KNDesign *myDesign = (KNDesign *)  self.designArray.firstObject;
    CGFloat RT60c = V * myDesign.a.doubleValue + myDesign.b.doubleValue;
    self.Pfurn = myDesign.floorage;
    
    NSInteger type = myDesign.reactanceID.intValue;
    [self addDataToRT60x:type:RT60c];
   
    NSInteger z = 0;
    
    for (KNDesign *design in  self.designArray) {
        
        NSInteger ID = design.floorCoveringID.intValue;
        NSString *predicate = [@"iD == " stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)ID]];
        p = [NSPredicate predicateWithFormat:predicate];
        KNFloorCovering *floorCovering = [[self.dataClient.floorCovering copy] filteredArrayUsingPredicate:p].firstObject;
       
        ID = design.wallCoveringID.intValue;
        predicate = [@"iD == " stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)ID]];
        p = [NSPredicate predicateWithFormat:predicate];
        KNWallsCovering *wallCovering = [[self.dataClient.wallsCovering copy] filteredArrayUsingPredicate:p].firstObject;
        
        ID = design.fittingContentID.intValue;
        predicate = [@"iD == " stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)ID]];
        p = [NSPredicate predicateWithFormat:predicate];
        KNFittingContent *fittingCovering = [[self.dataClient.fittingContent copy] filteredArrayUsingPredicate:p].firstObject;
        
        [self addMutableDataFloorCovering:floorCovering WallsCoverind:wallCovering FittingContent:fittingCovering];

        for (KNAcoustic *acoustic in self.dataClient.acoustic) {
            [self computing:acoustic :@"Acoustic":z];
        }
        [self.manufacturerArray addObject:@"Acoustic"];
        
        for (KNDanoline *danoline in self.dataClient.danoline) {
            [self computing:danoline :@"Danoline":z];
        }
        [self.manufacturerArray addObject:@"Danoline"];
        
        for (KNRiessler *riessler in self.dataClient.riessler) {
            [self computing:riessler :@"Riessler":z];
        }
        [self.manufacturerArray addObject:@"Riessler"];
        z += 1;
    }
    self.dataClient.resoultsAcustic = [self.results allObjects];
    return [self.results allObjects];
}

-(CGFloat) RT60Mu:(NSNumber *)mu Fpol:(NSNumber *)Fpol Fst:(NSNumber *)Fst Fok:(NSNumber *)Fok Fdv:(NSNumber *)Fdv Ffu:(NSNumber *)Ffu Fpot:(NSNumber *)Fpot Pfu:(NSNumber *)Pfu
{
    CGFloat a = self.length;
    CGFloat b = self.widht;
    CGFloat c = self.height;

    CGFloat Sfu = a * b * Pfu.doubleValue/100;
    CGFloat Spol = a * b - Sfu;
    CGFloat Sok = a * b * 0.11;
    CGFloat Sdv = 8;
    if (a * b <= 100) {
        Sdv = 2;
    } else if (a * b <= 1000) {
        Sdv = 4;
    }
    CGFloat Sst = 2 * (a + b) * c - Sok - Sdv;
    CGFloat Spot = a * b;
    CGFloat Sum1 = Spol * Fpol.doubleValue + Sst * Fst.doubleValue + Sok * Fok.doubleValue + Sdv * Fdv.doubleValue + Sfu * Ffu.doubleValue + Spot * Fpot.doubleValue;
    CGFloat Sum2 = Spol + Sst + Sok + Sdv + Sfu + Spot;
    CGFloat RT60rs = 0.164 * a * b * c / (4*mu.doubleValue * a * b * c - 2 * (a * b + (a + b) * c)* log(1 - Sum1/Sum2));
    return RT60rs;
}

-(void)addDataToArray
{
    self.stekloArray = [[NSMutableArray alloc] init];
    self.dveriArray = [[NSMutableArray alloc] init];
    self.absorptionArray = [[NSMutableArray alloc] init];
    
    NSNumber *koef = [NSNumber numberWithDouble:0.12];
    [self.stekloArray addObject:koef];
    koef = [NSNumber numberWithDouble:0.1];
    [self.stekloArray addObject:koef];
    koef = [NSNumber numberWithDouble:0.07];
    [self.stekloArray addObject:koef];
    koef = [NSNumber numberWithDouble:0.05];
    [self.stekloArray addObject:koef];
    koef = [NSNumber numberWithDouble:0.03];
    [self.stekloArray addObject:koef];
    koef = [NSNumber numberWithDouble:0.02];
    [self.stekloArray addObject:koef];
    koef = [NSNumber numberWithDouble:0.02];
    [self.stekloArray addObject:koef];
    koef = [NSNumber numberWithDouble:0.015];
    [self.stekloArray addObject:koef];
    
    koef = [NSNumber numberWithDouble:0.08];
    [self.dveriArray addObject:koef];
    koef = [NSNumber numberWithDouble:0.098];
    [self.dveriArray addObject:koef];
    koef = [NSNumber numberWithDouble:0.11];
    [self.dveriArray addObject:koef];
    koef = [NSNumber numberWithDouble:0.061];
    [self.dveriArray addObject:koef];
    koef = [NSNumber numberWithDouble:0.081];
    [self.dveriArray addObject:koef];
    koef = [NSNumber numberWithDouble:0.082];
    [self.dveriArray addObject:koef];
    koef = [NSNumber numberWithDouble:0.11];
    [self.dveriArray addObject:koef];
    koef = [NSNumber numberWithDouble:0.15];
    [self.dveriArray addObject:koef];
    
    KNAbsorption *abs = self.dataClient.absorption[0];
    koef = abs.f100;
    [self.absorptionArray addObject:koef];
    koef = abs.f125;
    [self.absorptionArray addObject:koef];
    koef = abs.f250;
    [self.absorptionArray addObject:koef];
    koef = abs.f500;
    [self.absorptionArray addObject:koef];
    koef = abs.f1000;
    [self.absorptionArray addObject:koef];
    koef = abs.f2000;
    [self.absorptionArray addObject:koef];
    koef = abs.f4000;
    [self.absorptionArray addObject:koef];
    koef = abs.f5000;
    [self.absorptionArray addObject:koef];

}

-(void)addDataToRT60x:(NSInteger) type :(CGFloat) RT60c
{
    KNReactance *reactance =(KNReactance *) self.dataClient.design[0];
    
    if (type == 2) {
        reactance = (KNReactance *) self.dataClient.reactance[1];
    }
    
    [self.RT60x removeAllObjects];
    [self.RT60x addObject:[NSNumber numberWithDouble: RT60c * reactance.f100.doubleValue]];
    [self.RT60x addObject:[NSNumber numberWithDouble: RT60c * reactance.f125.doubleValue]];
    [self.RT60x addObject:[NSNumber numberWithDouble: RT60c * reactance.f250.doubleValue]];
    [self.RT60x addObject:[NSNumber numberWithDouble: RT60c * reactance.f500.doubleValue]];
    [self.RT60x addObject:[NSNumber numberWithDouble: RT60c * reactance.f1000.doubleValue]];
    [self.RT60x addObject:[NSNumber numberWithDouble: RT60c * reactance.f2000.doubleValue]];
    [self.RT60x addObject:[NSNumber numberWithDouble: RT60c * reactance.f4000.doubleValue]];
    [self.RT60x addObject:[NSNumber numberWithDouble: RT60c * reactance.f5000.doubleValue]];
}

-(void) addMutableDataFloorCovering:(KNFloorCovering *)floorCovering WallsCoverind:(KNWallsCovering *)wallsCovering FittingContent:(KNFittingContent *)fittingContent
{
    [self.floorArray removeAllObjects];
    [self.wallsArray removeAllObjects];
    [self.fittingArray removeAllObjects];
    
    NSNumber *koef = floorCovering.f100;
    [self.floorArray addObject:koef];
    koef = floorCovering.f125;
    [self.floorArray addObject:koef];
    koef = floorCovering.f250;
    [self.floorArray addObject:koef];
    koef = floorCovering.f500;
    [self.floorArray addObject:koef];
    koef = floorCovering.f1000;
    [self.floorArray addObject:koef];
    koef = floorCovering.f2000;
    [self.floorArray addObject:koef];
    koef = floorCovering.f4000;
    [self.floorArray addObject:koef];
    koef = floorCovering.f5000;
    [self.floorArray addObject:koef];
    
    koef = wallsCovering.f100;
    [self.wallsArray addObject:koef];
    koef = wallsCovering.f125;
    [self.wallsArray addObject:koef];
    koef = wallsCovering.f250;
    [self.wallsArray addObject:koef];
    koef = wallsCovering.f500;
    [self.wallsArray addObject:koef];
    koef = wallsCovering.f1000;
    [self.wallsArray addObject:koef];
    koef = wallsCovering.f2000;
    [self.wallsArray addObject:koef];
    koef = wallsCovering.f4000;
    [self.wallsArray addObject:koef];
    koef = wallsCovering.f5000;
    [self.wallsArray addObject:koef];
    
    koef = fittingContent.f100;
    [self.fittingArray addObject:koef];
    koef = fittingContent.f125;
    [self.fittingArray addObject:koef];
    koef = fittingContent.f250;
    [self.fittingArray addObject:koef];
    koef = fittingContent.f500;
    [self.fittingArray addObject:koef];
    koef = fittingContent.f1000;
    [self.fittingArray addObject:koef];
    koef = fittingContent.f2000;
    [self.fittingArray addObject:koef];
    koef = fittingContent.f4000;
    [self.fittingArray addObject:koef];
    koef = fittingContent.f5000;
    [self.fittingArray addObject:koef];
}

-(void)addDataToDanoline:(id)danoline1
{
    KNDanoline *danoline = danoline1;
    [self.danolineArray removeAllObjects];
    NSNumber *koef = danoline.f100;
    [self.danolineArray addObject:koef];
    koef = danoline.f125;
    [self.danolineArray addObject:koef];
    koef = danoline.f250;
    [self.danolineArray addObject:koef];
    koef = danoline.f500;
    [self.danolineArray addObject:koef];
    koef = danoline.f1000;
    [self.danolineArray addObject:koef];
    koef = danoline.f2000;
    [self.danolineArray addObject:koef];
    koef = danoline.f4000;
    [self.danolineArray addObject:koef];
    koef = danoline.f5000;
    [self.danolineArray addObject:koef];
}

-(void)addDataToAcoustic:(KNAcoustic *)acoustic
{
    [self.acousticArray removeAllObjects];
    NSNumber *koef = acoustic.f100;
    [self.acousticArray addObject:koef];
    koef = acoustic.f125;
    [self.acousticArray addObject:koef];
    koef = acoustic.f250;
    [self.acousticArray addObject:koef];
    koef = acoustic.f500;
    [self.acousticArray addObject:koef];
    koef = acoustic.f1000;
    [self.acousticArray addObject:koef];
    koef = acoustic.f2000;
    [self.acousticArray addObject:koef];
    koef = acoustic.f4000;
    [self.acousticArray addObject:koef];
    koef = acoustic.f5000;
    [self.acousticArray addObject:koef];
}

-(void)computing:(id) design :(NSString *)type :(NSInteger) designID
{
    KNDanoline *danoline = design;
    [self addDataToDanoline:danoline];
    [self.RT60r removeAllObjects];
    for (NSInteger i = 0; i < self.danolineArray.count; i++) {
        NSNumber *mu = self.absorptionArray[i];
        NSNumber *Fpol = self.floorArray[i];
        NSNumber *Fst = self.wallsArray[i];
        NSNumber *Fok = self.stekloArray[i];
        NSNumber *Fdv = self.dveriArray[i];
        NSNumber *Ffu = self.fittingArray[i];
        NSNumber *Fpot = self.danolineArray[i];
        NSNumber *Pfu = self.Pfurn;
        CGFloat delta = [self RT60Mu:mu Fpol:Fpol Fst:Fst Fok:Fok Fdv:Fdv Ffu:Ffu Fpot:Fpot Pfu:Pfu];
        NSNumber *deltaR = [NSNumber numberWithDouble: (double)delta];
        [self.RT60r addObject:deltaR];
    }
    CGFloat deltaRez = 0;
    for (NSInteger i = 1; i<7; i++) {
        NSNumber *a = self.RT60x[i];
        NSNumber *b = self.RT60r[i];
        deltaRez += fabs(a.doubleValue - b.doubleValue);
    }
    
    if (2 * self.delKor > deltaRez/6) {
        KNResultsAcoustic *result = [[KNResultsAcoustic alloc] init];
        result.iD = danoline.iD;
        result.descriptions = danoline.descriptions;
        result.graficsLink = danoline.grafics;
        result.typePanel = type;
        result.designID = [NSNumber numberWithInteger:designID];
        [self.results addObject:result];
    }
}

-(NSArray *)getResultsWithFilter:(NSString *)type :(NSInteger) designID
{
    NSString *propertyPredicate = [@"designID == " stringByAppendingString:[NSString stringWithFormat: @"%ld",  designID]];
    NSPredicate *p1 = [NSPredicate predicateWithFormat: @"self.typePanel == %@", type];
    NSPredicate *p2 = [NSPredicate predicateWithFormat: propertyPredicate];
    NSPredicate *p = [NSCompoundPredicate andPredicateWithSubpredicates: @[p1, p2]];
    NSArray *array = [[self.dataClient.resoultsAcustic copy] filteredArrayUsingPredicate:p];
    return array;
}


@end
