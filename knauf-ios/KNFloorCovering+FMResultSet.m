//
//  KNFloorCovering+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNFloorCovering+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNFloorCovering (FMResultSet)

+ (KNFloorCovering*)featureWithResultSet:(FMResultSet *)resultSet
{
    KNFloorCovering *floorCovering = [[KNFloorCovering alloc] init];
    
    floorCovering.iD = @([resultSet intForColumn:@"id"]);
    floorCovering.name = [resultSet stringForColumn:@"name"];
    floorCovering.f100 = @([resultSet doubleForColumn:@"f100"]);
    floorCovering.f125 = @([resultSet doubleForColumn:@"f125"]);
    floorCovering.f250 = @([resultSet doubleForColumn:@"f250"]);
    floorCovering.f500 = @([resultSet doubleForColumn:@"f500"]);
    floorCovering.f1000 = @([resultSet doubleForColumn:@"f1000"]);
    floorCovering.f2000 = @([resultSet doubleForColumn:@"f2000"]);
    floorCovering.f4000 = @([resultSet doubleForColumn:@"f4000"]);;
    floorCovering.f5000 = @([resultSet doubleForColumn:@"f5000"]);
    
    return floorCovering;
}

@end
