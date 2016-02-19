//
//  KNBuilding+FMResultSet.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNBuilding.h"

@class FMResultSet;

@interface KNBuilding (FMResultSet)

+ (KNBuilding *)featureWithResultSet:(FMResultSet *)resultSet;

@end
