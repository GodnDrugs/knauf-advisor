//
//  KNRiessler+FMResultSet.m
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNRiessler+FMResultSet.h"
#import <FMDB/FMResultSet.h>

@implementation KNRiessler (FMResultSet)

+ (KNRiessler *)featureWithResultSet:(FMResultSet *)resultSet
{
    KNRiessler *riessler = [[KNRiessler alloc] init];
    
    riessler.iD = @([resultSet intForColumn:@"id"]);
    riessler.datei = [resultSet stringForColumn:@"datei"];
    riessler.perforation = [resultSet stringForColumn:@"perforation"];
    riessler.kurztext = [resultSet stringForColumn:@"kurztext"];
    riessler.pleniumDepth = @([resultSet intForColumn:@"plenium_depth"]);
    riessler.perforationRate = @([resultSet doubleForColumn:@"perforation_rate"]);
    riessler.mineralWool = @([resultSet intForColumn:@"mineral_wool"]);
    riessler.aS = @([resultSet doubleForColumn:@"a_s"]);
    riessler.f100 = @([resultSet doubleForColumn:@"f100"]);
    riessler.f125 = @([resultSet doubleForColumn:@"f125"]);
    riessler.f250 = @([resultSet doubleForColumn:@"f250"]);
    riessler.f500 = @([resultSet doubleForColumn:@"f500"]);
    riessler.f1000 = @([resultSet doubleForColumn:@"f1000"]);
    riessler.f2000 = @([resultSet doubleForColumn:@"f2000"]);
    riessler.f4000 = @([resultSet doubleForColumn:@"f4000"]);;
    riessler.f5000 = @([resultSet doubleForColumn:@"f5000"]);
    riessler.rlfL = @([resultSet doubleForColumn:@"rlf_l"]);
    riessler.tL = @([resultSet doubleForColumn:@"t_l"]);
    riessler.pL = @([resultSet intForColumn:@"p_l"]);
    riessler.rlfM = @([resultSet doubleForColumn:@"rlf_m"]);
    riessler.tM = @([resultSet doubleForColumn:@"t_m"]);
    riessler.pM = @([resultSet doubleForColumn:@"p_m"]);
    riessler.vol = @([resultSet doubleForColumn:@"vol"]);
    riessler.pruffl = @([resultSet doubleForColumn:@"pruffl"]);
    riessler.absorber = @([resultSet intForColumn:@"absorber"]);
    riessler.coating = [resultSet stringForColumn:@"coating"];
    riessler.grafics = [resultSet stringForColumn:@"grafics"];
    riessler.keys = [resultSet stringForColumn:@"keys"];
    riessler.descriptions = [resultSet stringForColumn:@"description"];
    riessler.productLink = [resultSet stringForColumn:@"product_link"];
    
    return riessler;
}

@end
