//
//  KNFittingContent+FMResultSet.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNFittingContent.h"

@class FMResultSet;

@interface KNFittingContent (FMResultSet)

+ (KNFittingContent *)featureWithResultSet:(FMResultSet *)resultSet;

@end
