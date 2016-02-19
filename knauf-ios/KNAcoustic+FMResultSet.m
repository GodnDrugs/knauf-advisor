//
//  KNAcoustic+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNAcoustic+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNAcoustic (FMResultSet)

+ (KNAcoustic *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNAcoustic *acoustic = [[KNAcoustic alloc] init];
    
    acoustic.iD = @([resultSet intForColumn:@"id"]);
    acoustic.manufacturer = [resultSet stringForColumn:@"manufacturer"];
    acoustic.name = [resultSet stringForColumn:@"name"];
    acoustic.perforation = [resultSet stringForColumn:@"perforation"];
    acoustic.size = [resultSet stringForColumn:@"size"];
    acoustic.pendant = [resultSet stringForColumn:@"pendant"];
    acoustic.f100 = @([resultSet doubleForColumn:@"f100"]);
    acoustic.f125 = @([resultSet doubleForColumn:@"f125"]);
    acoustic.f250 = @([resultSet doubleForColumn:@"f250"]);
    acoustic.f500 = @([resultSet doubleForColumn:@"f500"]);
    acoustic.f1000 = @([resultSet doubleForColumn:@"f1000"]);
    acoustic.f2000 = @([resultSet doubleForColumn:@"f2000"]);
    acoustic.f4000 = @([resultSet doubleForColumn:@"f4000"]);
    acoustic.f5000 = @([resultSet doubleForColumn:@"f5000"]);
    acoustic.absorber = @([resultSet intForColumn:@"absorber"]);
    acoustic.coating = [resultSet stringForColumn:@"coating"];
    acoustic.grafics = [resultSet stringForColumn:@"grafics"];
    acoustic.keys = [resultSet stringForColumn:@"keys"];
    acoustic.descriptions = [resultSet stringForColumn:@"description"];
    acoustic.productLink = [resultSet stringForColumn:@"product_link"];
    
    return acoustic;
}

@end
