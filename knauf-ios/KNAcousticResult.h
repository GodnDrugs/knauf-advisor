//
//  KNComputResult.h
//  knauf-ios
//
//  Created by User on 27.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNAcousticResult : NSObject

@property (nonatomic,strong) NSArray *designArray;
@property (nonatomic,strong) NSMutableSet *manufacturerArray;

+ (id)sharedInstance;

-(NSArray *)getResultsWithoutFilterTypeBuild:(NSInteger)typeBuild TypeRoom:(NSInteger)typeRoom Length:(CGFloat)length Widht:(CGFloat)widht Height:(CGFloat)height;
-(NSArray *)getResultsWithFilter:(NSString *)type :(NSInteger) designID;

@end
