//
//  MemeData.m
//  PhotoGaler
//
//  Created by Arifin Luthfi P on 26/6/15.
//  Copyright (c) 2015 Himaci Studio. All rights reserved.
//

#import "MemeData.h"

@implementation MemeData

@synthesize imageUrl = _imageUrl;
@synthesize displayName = _displayName;
@synthesize totalVotesScore = _totalVotesScore;

- (id)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        [self readFromDictionary:data];
    }
    return self;
}

- (void)readFromDictionary:(NSDictionary *)data {
    if (!data) return;
    _imageUrl = [data objectForKey:@"imageUrl"] != [NSNull null] ? [NSURL URLWithString:[data objectForKey:@"imageUrl"]] : nil;
    _displayName = [data objectForKey:@"displayName"] != [NSNull null] ? [data objectForKey:@"displayName"] : nil;
    _totalVotesScore = [data objectForKey:@"totalVotesScore"] != [NSNull null] ? [[data objectForKey:@"totalVotesScore"] integerValue] : 0;
}

@end
