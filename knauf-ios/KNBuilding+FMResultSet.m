//
//  KNBuilding+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNBuilding+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNBuilding (FMResultSet)

+ (KNBuilding *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNBuilding *building = [[KNBuilding alloc] init];
    
    building.iD = @([resultSet intForColumn:@"id"]);
    building.name = [resultSet stringForColumn:@"name"];
    
    return building;
}

@end
