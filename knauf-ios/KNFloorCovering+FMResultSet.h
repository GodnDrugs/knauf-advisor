//
//  KNFloorCovering+FMResultSet.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNFloorCovering.h"

@class FMResultSet;

@interface KNFloorCovering (FMResultSet)

+ (KNFloorCovering *)featureWithResultSet:(FMResultSet *)resultSet;

@end
