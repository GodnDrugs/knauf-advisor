//
//  KNFloors.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNFloors : NSObject

@property (nonatomic, strong) NSNumber *iD;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) NSNumber *rw;
@property (nonatomic, strong) NSNumber *lnw;
@property (nonatomic, strong) NSNumber *depth;
@property (nonatomic, copy) NSString *base;
@property (nonatomic, strong) NSNumber *depthBase;
@property (nonatomic, copy) NSString *system;
@property (nonatomic, copy) NSString *typeMaterial;
@property (nonatomic, copy) NSString *grafics;
@property (nonatomic, strong) NSNumber *depthMaterial;
@property (nonatomic, copy) NSString *descriptions;
@property (nonatomic, copy) NSString *productLink;

@end
