//
//  KNResultsAcoustic.m
//  knauf-ios
//
//  Created by User on 28.01.16.
//  Copyright © 2016 User. All rights reserved.
//

#import "KNResultsAcoustic.h"

@implementation KNResultsAcoustic

- (NSUInteger)hash
{
    return [[self iD] hash] ^ [self.graficsLink hash];
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[KNResultsAcoustic class]]) {
        return (!self.iD && ![(KNResultsAcoustic *)object iD]) ||
        [self.iD isEqual:[(KNResultsAcoustic *)object iD]];
    }
    if ([object isKindOfClass:[KNResultsAcoustic class]]) {
        return (!self.graficsLink && ![(KNResultsAcoustic *)object graficsLink]) ||
        [self.graficsLink isEqual:[(KNResultsAcoustic *)object graficsLink]];
    }
    return NO;
}

@end
