//
//  KNPartition.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNPartition : NSObject

@property (nonatomic, strong) NSNumber *iD;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *rw;
@property (nonatomic, strong) NSNumber *lnw;
@property (nonatomic, strong) NSNumber *depth;
@property (nonatomic, copy) NSString *grafics;
@property (nonatomic, copy) NSString *system;
@property (nonatomic, copy) NSString *descriptions;
@property (nonatomic, copy) NSString *productLink;

@end
