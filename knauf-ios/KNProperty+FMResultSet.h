//
//  KNProperty+FMResultSet.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNProperty.h"

@class FMResultSet;

@interface KNProperty (FMResultSet)

+ (KNProperty *)featureWithResultSet:(FMResultSet *)resultSet;

@end
