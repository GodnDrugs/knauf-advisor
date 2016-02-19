//
//  KNPartition+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNPartition+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNPartition (FMResultSet)

+ (KNPartition *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNPartition *partition = [[KNPartition alloc] init];
    
    partition.iD = @([resultSet intForColumn:@"id"]);
    partition.name = [resultSet stringForColumn:@"name"];
    partition.rw = @([resultSet intForColumn:@"rw"]);
    partition.depth = @([resultSet intForColumn:@"depth"]);
    partition.grafics = [resultSet stringForColumn:@"grafics"];
    partition.system = [resultSet stringForColumn:@"system"];
    partition.descriptions = [resultSet stringForColumn:@"description"];
    partition.productLink = [resultSet stringForColumn:@"product_link"];
    
    return partition;
}

@end
