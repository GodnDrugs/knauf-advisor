//
//  KNReactance+FMResultSet.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNReactance.h"

@class FMResultSet;

@interface KNReactance (FMResultSet)

+ (KNReactance *)featureWithResultSet:(FMResultSet *)resultSet;

@end
