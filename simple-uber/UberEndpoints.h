//
//  UberEndpoints.h
//  SimpleUberApp
//
//  Created by Leo Angelo Quigao on 2/20/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kUberStartLatitude;
extern NSString * const kUberStartLongitude;
extern NSString * const kUberEndLatitude;
extern NSString * const kUberEndLongitude;

extern NSString * const kUberResultFareEstimate;
extern NSString * const kUberResultPickupTime; // is returned in seconds.

@interface UberEndpoints : NSObject

- (instancetype)initWithServerToken:(NSString *)serverToken;

- (void)getPriceEstimates:(NSDictionary *)params
                  success:(void (^)(NSArray *prices))success
                  failure:(void (^)(NSError *error))failure;

- (void)getTimeEstimates:(NSDictionary *)params
                 success:(void (^)(NSArray *times))success
                 failure:(void (^)(NSError *error))failure;



// Determines the nearest uber near you and how much will you have to pay for it
// If done correctly, returns the keys:
// kUberResultFareEstimate
// kUberResultPickupTime
- (void)getSummary:(NSDictionary *)params
           success:(void (^)(NSDictionary *result))success
           failure:(void (^)(NSError *error))failure;

@end
