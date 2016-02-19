//
//  KNWallsCovering+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNWallsCovering+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNWallsCovering (FMResultSet)

+ (KNWallsCovering *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNWallsCovering *wallsCovering = [[KNWallsCovering alloc] init];
    
    wallsCovering.iD = @([resultSet intForColumn:@"id"]);
    wallsCovering.name = [resultSet stringForColumn:@"name"];
    wallsCovering.f100 = @([resultSet doubleForColumn:@"f100"]);
    wallsCovering.f125 = @([resultSet doubleForColumn:@"f125"]);
    wallsCovering.f250 = @([resultSet doubleForColumn:@"f250"]);
    wallsCovering.f500 = @([resultSet doubleForColumn:@"f500"]);
    wallsCovering.f1000 = @([resultSet doubleForColumn:@"f1000"]);
    wallsCovering.f2000 = @([resultSet doubleForColumn:@"f2000"]);
    wallsCovering.f4000 = @([resultSet doubleForColumn:@"f4000"]);;
    wallsCovering.f5000 = @([resultSet doubleForColumn:@"f5000"]);
    
    return wallsCovering;
}

@end
