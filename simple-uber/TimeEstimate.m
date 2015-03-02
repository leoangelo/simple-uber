//
//  TimeEstimate.m
//  SimpleUberApp
//
//  Created by Leo Angelo Quigao on 3/2/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import "TimeEstimate.h"

@implementation TimeEstimate

+ (TimeEstimate *)parseFromDictionary:(NSDictionary *)dictionary
{
    TimeEstimate *anEstimate = [TimeEstimate new];
    anEstimate.productId = dictionary[@"product_id"];
    anEstimate.displayName = dictionary[@"display_name"];
    anEstimate.estimate = dictionary[@"estimate"];
    return anEstimate;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Time Estimate: %@- %.2f mins", self.displayName, (self.estimate.floatValue / 60.0f)];
}

@end
