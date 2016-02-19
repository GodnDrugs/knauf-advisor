//
//  KNDesign+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNDesign+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNDesign (FMResultSet)

+ (KNDesign *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNDesign *design = [[KNDesign alloc] init];
    
    design.iD = @([resultSet intForColumn:@"id"]);
    design.buildingID = @([resultSet intForColumn:@"building_id"]);
    design.propertyID = @([resultSet intForColumn:@"property_id"]);
    design.floorCoveringID = @([resultSet intForColumn:@"floor_covering_id"]);
    design.wallCoveringID = @([resultSet intForColumn:@"wall_covering_id"]);
    design.fittingContentID = @([resultSet intForColumn:@"fitting_content_id"]);
    design.floorage = @([resultSet doubleForColumn:@"floorage"]);
    design.rw = @([resultSet intForColumn:@"rw"]);
    design.lnw = @([resultSet intForColumn:@"lnw"]);
    design.snr1 = @([resultSet doubleForColumn:@"snr1"]);
    design.reactanceID = @([resultSet intForColumn:@"reactance_id"]);
    design.snr5 = @([resultSet doubleForColumn:@"snr5"]);
    design.a = @([resultSet doubleForColumn:@"a"]);
    design.b = @([resultSet doubleForColumn:@"b"]);
    design.volumeLimiter = @([resultSet doubleForColumn:@"volume_limiter"]);
    
    return design;
}

@end
