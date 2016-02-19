//
//  KNDataClient.h
//  knauf-ios
//
//  Created by User on 19.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KNDataClientDelegate

@optional

-(void)loadData;

@end

@interface KNDataClient : NSObject

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSMutableArray *absorption;
@property (nonatomic, strong) NSMutableArray *acoustic;
@property (nonatomic, strong) NSMutableArray *building;
@property (nonatomic, strong) NSMutableArray *danoline;
@property (nonatomic, strong) NSMutableArray *design;
@property (nonatomic, strong) NSMutableArray *facing;
@property (nonatomic, strong) NSMutableArray *fittingContent;
@property (nonatomic, strong) NSMutableArray *floorCovering;
@property (nonatomic, strong) NSMutableArray *floors;
@property (nonatomic, strong) NSMutableArray *partition;
@property (nonatomic, strong) NSMutableArray *property;
@property (nonatomic, strong) NSMutableArray *reactance;
@property (nonatomic, strong) NSMutableArray *riessler;
@property (nonatomic, strong) NSMutableArray *roofs;
@property (nonatomic, strong) NSMutableArray *special;
@property (nonatomic, strong) NSMutableArray *wallsCovering;
@property (nonatomic, strong) NSArray *resaultsArray;
@property (nonatomic, strong) NSArray *constructions;
@property (nonatomic, strong) NSArray *resoultsAcustic;
@property (nonatomic, strong) NSArray *resoultsInsulation;
@property (nonatomic) CGFloat depth;
//@property (nonatomic) BOOL wasReconnect;

+ (id)sharedInstance;

@end
