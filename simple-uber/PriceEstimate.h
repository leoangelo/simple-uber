//
//  PriceEstimate.h
//  SimpleUberApp
//
//  Created by Leo Angelo Quigao on 2/20/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceEstimate : NSObject

@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *estimate;
@property (nonatomic, strong) NSNumber *duration; // in seconds

+ (PriceEstimate *)parseFromDictionary:(NSDictionary *)dictionary;

@end
