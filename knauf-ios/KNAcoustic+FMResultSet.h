//
//  KNAcoustic+FMResultSet.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNAcoustic.h"

@class FMResultSet;

@interface KNAcoustic (FMResultSet)

+ (KNAcoustic *)featureWithResultSet:(FMResultSet *)resultSet;

@end
