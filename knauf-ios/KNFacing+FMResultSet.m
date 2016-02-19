//
//  KNFacing+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNFacing+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNFacing (FMResultSet)

+ (KNFacing *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNFacing *facing = [[KNFacing alloc] init];

    facing.iD = @([resultSet intForColumn:@"id"]);
    facing.name = [resultSet stringForColumn:@"name"];
    facing.rw = @([resultSet intForColumn:@"rw"]);
    facing.depthGeneral = @([resultSet doubleForColumn:@"depth_general"]);
    facing.base = [resultSet stringForColumn:@"base"];
    facing.depthBase = @([resultSet intForColumn:@"depth_base"]);
    facing.grafics = [resultSet stringForColumn:@"grafics"];
    facing.system = [resultSet stringForColumn:@"system"];
    facing.descriptions = [resultSet stringForColumn:@"description"];
    facing.productLink = [resultSet stringForColumn:@"product_link"];
    
    return facing;
}

@end
