//
//  KNFloors+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNFloors+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNFloors (FMResultSet)

+ (KNFloors *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNFloors *floors = [[KNFloors alloc] init];
    
    floors.iD = @([resultSet intForColumn:@"id"]);
    floors.key = [resultSet stringForColumn:@"key"];
    floors.rw = @([resultSet doubleForColumn:@"rw"]);
    floors.lnw = @([resultSet doubleForColumn:@"lnw"]);
    floors.depth = @([resultSet intForColumn:@"depth"]);
    floors.base = [resultSet stringForColumn:@"base"];
    floors.depthBase = @([resultSet intForColumn:@"depth_base"]);
    floors.system = [resultSet stringForColumn:@"system"];
    floors.typeMaterial = [resultSet stringForColumn:@"type_material"];
    floors.grafics = [resultSet stringForColumn:@"grafics"];
    floors.depthMaterial = @([resultSet intForColumn:@"depth_material"]);
    floors.descriptions = [resultSet stringForColumn:@"description"];
    floors.productLink = [resultSet stringForColumn:@"product_link"];
    
    return floors;
}

@end
