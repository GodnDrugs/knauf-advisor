//
//  KNRiessler+FMResultSet.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNRiessler.h"

@class FMResultSet;

@interface KNRiessler (FMResultSet)

+ (KNRiessler *)featureWithResultSet:(FMResultSet *)resultSet;

@end
