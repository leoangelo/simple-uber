//
//  PriceEstimate.m
//  SimpleUberApp
//
//  Created by Leo Angelo Quigao on 2/20/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import "PriceEstimate.h"

@implementation PriceEstimate

+ (PriceEstimate *)parseFromDictionary:(NSDictionary *)dictionary
{
    PriceEstimate *anEstimate = [PriceEstimate new];
    anEstimate.displayName = dictionary[@"display_name"];
    anEstimate.estimate = dictionary[@"estimate"];
    anEstimate.duration = dictionary[@"duration"];
    return anEstimate;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Price Estimate: %@- %@, %.2f mins", self.displayName, self.estimate, (self.duration.floatValue / 60.0)];
}

@end
