//
//  KNDesign+FMResultSet.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNDesign.h"

@class FMResultSet;

@interface KNDesign (FMResultSet)

+ (KNDesign *)featureWithResultSet:(FMResultSet *)resultSet;

@end
