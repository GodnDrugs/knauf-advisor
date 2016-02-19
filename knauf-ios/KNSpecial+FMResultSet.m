
//
//  KNSpecial+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNSpecial+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNSpecial (FMResultSet)

+ (KNSpecial *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNSpecial *special = [[KNSpecial alloc] init];
    
    special.iD = @([resultSet intForColumn:@"id"]);
    special.volume = @([resultSet intForColumn:@"id"]);
    special.rt60tab = @([resultSet doubleForColumn:@"id"]);
    
    return special;
}

@end
