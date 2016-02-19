//
//  KNPartition+FMResultSet.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNPartition.h"

@class FMResultSet;

@interface KNPartition (FMResultSet)

+ (KNPartition *)featureWithResultSet:(FMResultSet *)resultSet;

@end
