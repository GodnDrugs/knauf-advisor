//
//  KNSpecial+FMResultSet.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNSpecial.h"

@class FMResultSet;

@interface KNSpecial (FMResultSet)

+ (KNSpecial *)featureWithResultSet:(FMResultSet *)resultSet;

@end
