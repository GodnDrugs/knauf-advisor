//
//  KNWallsCovering+FMResultSet.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNWallsCovering.h"

@class FMResultSet;

@interface KNWallsCovering (FMResultSet)

+ (KNWallsCovering *)featureWithResultSet:(FMResultSet *)resultSet;

@end
