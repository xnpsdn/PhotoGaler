//
//  MemeData.h
//  PhotoGaler
//
//  Created by Arifin Luthfi P on 26/6/15.
//  Copyright (c) 2015 Himaci Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemeData : NSObject

@property (nonatomic, retain) NSURL* imageUrl;
@property (nonatomic, retain) NSString* displayName;
@property (nonatomic, assign) NSInteger totalVotesScore;

- (id)initWithData:(NSDictionary*)data;
- (void)readFromDictionary:(NSDictionary *)data;

@end
