//
//  KNFacing.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNFacing : NSObject

@property (nonatomic, strong) NSNumber *iD;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *rw;
@property (nonatomic, strong) NSNumber *depthGeneral;
@property (nonatomic, copy) NSString *base;
@property (nonatomic, strong) NSNumber *depthBase;
@property (nonatomic, copy) NSString *grafics;
@property (nonatomic, copy) NSString *system;
@property (nonatomic, copy) NSString *descriptions;
@property (nonatomic, copy) NSString *productLink;

@end
