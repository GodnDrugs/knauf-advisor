//
//  KNAbsorption+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNAbsorption+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNAbsorption (FMResultSet)

+ (KNAbsorption *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNAbsorption *absorption = [[KNAbsorption alloc] init];
    
    absorption.iD = @([resultSet intForColumn:@"id"]);
    absorption.f100 = @([resultSet doubleForColumn:@"f100"]);
    absorption.f125 = @([resultSet doubleForColumn:@"f125"]);
    absorption.f250 = @([resultSet doubleForColumn:@"f250"]);
    absorption.f500 = @([resultSet doubleForColumn:@"f500"]);
    absorption.f1000 = @([resultSet doubleForColumn:@"f1000"]);
    absorption.f2000 = @([resultSet doubleForColumn:@"f2000"]);
    absorption.f4000 = @([resultSet doubleForColumn:@"f4000"]);
    absorption.f5000 = @([resultSet doubleForColumn:@"f5000"]);
    
    return absorption;
}

@end
