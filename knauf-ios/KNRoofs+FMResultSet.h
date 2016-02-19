//
//  KNRoofs+FMResultSet.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNRoofs.h"

@class FMResultSet;

@interface KNRoofs (FMResultSet)

+ (KNRoofs *)featureWithResultSet:(FMResultSet *)resultSet;

@end
