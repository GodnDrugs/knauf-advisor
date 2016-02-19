//
//  KNReactance+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNReactance+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNReactance (FMResultSet)

+ (KNReactance *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNReactance *reactance = [[KNReactance alloc] init];
    
    reactance.iD = @([resultSet intForColumn:@"id"]);
    reactance.name = [resultSet stringForColumn:@"name"];
    reactance.f100 = @([resultSet doubleForColumn:@"f100"]);
    reactance.f125 = @([resultSet doubleForColumn:@"f125"]);
    reactance.f250 = @([resultSet doubleForColumn:@"f250"]);
    reactance.f500 = @([resultSet doubleForColumn:@"f500"]);
    reactance.f1000 = @([resultSet doubleForColumn:@"f1000"]);
    reactance.f2000 = @([resultSet doubleForColumn:@"f2000"]);
    reactance.f4000 = @([resultSet doubleForColumn:@"f4000"]);;
    reactance.f5000 = @([resultSet doubleForColumn:@"f5000"]);

    return reactance;
}

@end
