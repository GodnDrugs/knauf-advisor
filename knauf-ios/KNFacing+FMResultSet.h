//
//  KNFacing+FMResultSet.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNFacing.h"

@class FMResultSet;

@interface KNFacing (FMResultSet)

+ (KNFacing *)featureWithResultSet:(FMResultSet *)resultSet;

@end
