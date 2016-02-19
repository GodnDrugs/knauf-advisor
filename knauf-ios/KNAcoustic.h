//
//  KNAcoustic.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNAcoustic : NSObject

@property (nonatomic, strong) NSNumber *iD;
@property (nonatomic, strong) NSString *manufacturer;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *perforation;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *pendant;
@property (nonatomic, strong) NSNumber *f100;
@property (nonatomic, strong) NSNumber *f125;
@property (nonatomic, strong) NSNumber *f250;
@property (nonatomic, strong) NSNumber *f500;
@property (nonatomic, strong) NSNumber *f1000;
@property (nonatomic, strong) NSNumber *f2000;
@property (nonatomic, strong) NSNumber *f4000;
@property (nonatomic, strong) NSNumber *f5000;
@property (nonatomic, strong) NSNumber *absorber;
@property (nonatomic, copy) NSString *coating;
@property (nonatomic, copy) NSString *grafics;
@property (nonatomic, copy) NSString *keys;
@property (nonatomic, copy) NSString *descriptions;
@property (nonatomic, copy) NSString *productLink;

@end
