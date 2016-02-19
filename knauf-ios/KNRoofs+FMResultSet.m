//
//  KNRoofs+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNRoofs+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNRoofs (FMResultSet)

+ (KNRoofs *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNRoofs *roofs = [[KNRoofs alloc] init];
    
    roofs.iD = @([resultSet intForColumn:@"id"]);
    roofs.name = [resultSet stringForColumn:@"name"];
    roofs.rw = @([resultSet intForColumn:@"rw"]);
    roofs.depthGeneral = @([resultSet doubleForColumn:@"depth_general"]);
    roofs.base = [resultSet stringForColumn:@"base"];
    roofs.depthBase = @([resultSet intForColumn:@"depth_base"]);
    roofs.system = [resultSet stringForColumn:@"system"];
    roofs.grafics = [resultSet stringForColumn:@"grafics"];
    roofs.descriptions = [resultSet stringForColumn:@"description"];
    roofs.productLink = [resultSet stringForColumn:@"product_link"];
    
    return roofs;
}

@end
