//
//  KNProperty+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNProperty+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNProperty (FMResultSet)

+ (KNProperty *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNProperty *property = [[KNProperty alloc] init];
    
    property.iD = @([resultSet intForColumn:@"id"]);
    property.name = [resultSet stringForColumn:@"name"];
    property.rt60500 = @([resultSet doubleForColumn:@"rt60500"]);
    
    return property;
}

@end
