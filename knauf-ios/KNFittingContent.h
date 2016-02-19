//
//  KNFittingContent.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNFittingContent : NSObject

@property (nonatomic, strong) NSNumber *iD;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *f100;
@property (nonatomic, strong) NSNumber *f125;
@property (nonatomic, strong) NSNumber *f250;
@property (nonatomic, strong) NSNumber *f500;
@property (nonatomic, strong) NSNumber *f1000;
@property (nonatomic, strong) NSNumber *f2000;
@property (nonatomic, strong) NSNumber *f4000;
@property (nonatomic, strong) NSNumber *f5000;

@end
