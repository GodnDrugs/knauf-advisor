//
//  KNRiessler.h
//  knauf-ios
//
//  Created by User on 25.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNRiessler : NSObject

@property (nonatomic, strong) NSNumber *iD;
@property (nonatomic, copy) NSString *datei;
@property (nonatomic, copy) NSString *perforation;
@property (nonatomic, strong) NSNumber *pleniumDepth;
@property (nonatomic, strong) NSNumber *mineralWool;
@property (nonatomic, strong) NSNumber *perforationRate;
@property (nonatomic, copy) NSString *kurztext;
@property (nonatomic, strong) NSNumber *aS;
@property (nonatomic, strong) NSNumber *f100;
@property (nonatomic, strong) NSNumber *f125;
@property (nonatomic, strong) NSNumber *f250;
@property (nonatomic, strong) NSNumber *f500;
@property (nonatomic, strong) NSNumber *f1000;
@property (nonatomic, strong) NSNumber *f2000;
@property (nonatomic, strong) NSNumber *f4000;
@property (nonatomic, strong) NSNumber *f5000;
@property (nonatomic, strong) NSNumber *rlfL;
@property (nonatomic, strong) NSNumber *tL;
@property (nonatomic, strong) NSNumber *pL;
@property (nonatomic, strong) NSNumber *rlfM;
@property (nonatomic, strong) NSNumber *tM;
@property (nonatomic, strong) NSNumber *pM;
@property (nonatomic, strong) NSNumber *vol;
@property (nonatomic, strong) NSNumber *pruffl;
@property (nonatomic, strong) NSNumber *absorber;
@property (nonatomic, copy) NSString *coating;
@property (nonatomic, copy) NSString *grafics;
@property (nonatomic, copy) NSString *keys;
@property (nonatomic, copy) NSString *descriptions;
@property (nonatomic, copy) NSString *productLink;


@end
