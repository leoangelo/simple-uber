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

@interface UberEndpoints : NSObject

- (instancetype)initWithServerToken:(NSString *)serverToken;

- (void)getPriceEstimates:(NSDictionary *)params
                  success:(void (^)(NSArray *prices))success
                  failure:(void (^)(NSError *error))failure;

@end
