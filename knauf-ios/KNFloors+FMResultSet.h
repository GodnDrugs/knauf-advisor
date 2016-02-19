//
//  KNFloors+FMResultSet.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNFloors.h"

@class FMResultSet;

@interface KNFloors (FMResultSet)

+ (KNFloors *)featureWithResultSet:(FMResultSet *)resultSet;

@end
