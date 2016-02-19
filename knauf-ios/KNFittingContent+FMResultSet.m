//
//  KNFittingContent+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNFittingContent+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNFittingContent (FMResultSet)

+ (KNFittingContent *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNFittingContent *fittingContent = [[KNFittingContent alloc] init];
    
    fittingContent.iD = @([resultSet intForColumn:@"id"]);
    fittingContent.name = [resultSet stringForColumn:@"name"];
    fittingContent.f100 = @([resultSet doubleForColumn:@"f100"]);
    fittingContent.f125 = @([resultSet doubleForColumn:@"f125"]);
    fittingContent.f250 = @([resultSet doubleForColumn:@"f250"]);
    fittingContent.f500 = @([resultSet doubleForColumn:@"f500"]);
    fittingContent.f1000 = @([resultSet doubleForColumn:@"f1000"]);
    fittingContent.f2000 = @([resultSet doubleForColumn:@"f2000"]);
    fittingContent.f4000 = @([resultSet doubleForColumn:@"f4000"]);
    fittingContent.f5000 = @([resultSet doubleForColumn:@"f5000"]);
    
    return fittingContent;
}

@end
