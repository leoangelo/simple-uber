//
//  TimeEstimate.h
//  SimpleUberApp
//
//  Created by Leo Angelo Quigao on 3/2/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeEstimate : NSObject

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSNumber *estimate; // in seconds

+ (TimeEstimate *)parseFromDictionary:(NSDictionary *)dictionary;

@end
