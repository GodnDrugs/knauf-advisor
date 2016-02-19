//
//  KNDanoline+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNDanoline+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNDanoline (FMResultSet)

+ (KNDanoline *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNDanoline *danoline = [[KNDanoline alloc] init];
    
    danoline.iD = @([resultSet intForColumn:@"id"]);
    danoline.products = [resultSet stringForColumn:@"products"];
    danoline.perforation = [resultSet stringForColumn:@"perforation"];
    danoline.size = [resultSet stringForColumn:@"size"];
    danoline.perfPercent = @([resultSet doubleForColumn:@"perf_percent"]);
    danoline.suspension = @([resultSet doubleForColumn:@"suspension"]);
    danoline.mineralWool = @([resultSet doubleForColumn:@"mineral_wool"]);
    danoline.f100 = @([resultSet doubleForColumn:@"f100"]);
    danoline.f125 = @([resultSet doubleForColumn:@"f125"]);
    danoline.f250 = @([resultSet doubleForColumn:@"f250"]);
    danoline.f500 = @([resultSet doubleForColumn:@"f500"]);
    danoline.f1000 = @([resultSet doubleForColumn:@"f1000"]);
    danoline.f2000 = @([resultSet doubleForColumn:@"f2000"]);
    danoline.f4000 = @([resultSet doubleForColumn:@"f4000"]);;
    danoline.f5000 = @([resultSet doubleForColumn:@"f5000"]);
    danoline.absorber = @([resultSet intForColumn:@"absorber"]);
    danoline.coating = [resultSet stringForColumn:@"coating"];
    danoline.grafics = [resultSet stringForColumn:@"grafics"];
    danoline.keys = [resultSet stringForColumn:@"keys"];
    danoline.descriptions = [resultSet stringForColumn:@"description"];
    danoline.productLink = [resultSet stringForColumn:@"product_link"];

    return danoline;
}

@end
