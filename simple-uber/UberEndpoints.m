//
//  UberEndpoints.m
//  SimpleUberApp
//
//  Created by Leo Angelo Quigao on 2/20/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "UberEndpoints.h"
#import "NSDictionary+URLParameters.h"
#import "PriceEstimate.h"
#import "TimeEstimate.h"

NSString * const kUberStartLatitude = @"start_latitude";
NSString * const kUberStartLongitude = @"start_longitude";
NSString * const kUberEndLatitude = @"end_latitude";
NSString * const kUberEndLongitude = @"end_longitude";

NSString * const kUberResultFareEstimate = @"fare_estimate";
NSString * const kUberResultPickupTime = @"pickup_time";

NSString * const kUberAPI = @"https://api.uber.com";

NSString * const kUberPriceEstimatePath = @"/v1/estimates/price";
NSString * const kUberTimeEsimatePath = @"/v1/estimates/time";

@interface UberEndpoints ()

@property (nonatomic, strong) NSString *serverToken;

@end

@implementation UberEndpoints


- (instancetype)initWithServerToken:(NSString *)serverToken
{
    self = [super init];
    if (self) {
        self.serverToken = serverToken;
    }
    return self;
}


- (void)getPriceEstimates:(NSDictionary *)params
                  success:(void (^)(NSArray *))success
                  failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", kUberAPI, kUberPriceEstimatePath];
    
    [[self getManager] GET:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {

        NSMutableArray *estimates = [NSMutableArray array];
        NSArray *responseList = responseObject[@"prices"];
        [responseList enumerateObjectsUsingBlock:^(NSDictionary *aDict, NSUInteger idx, BOOL *stop) {
            [estimates addObject:[PriceEstimate parseFromDictionary:aDict]];
        }];
        
        success(estimates);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);        
    }];
}


- (void)getTimeEstimates:(NSDictionary *)params success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@", kUberAPI, kUberTimeEsimatePath];
    
    [[self getManager] GET:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSMutableArray *estimates = [NSMutableArray array];
        NSArray *responseList = responseObject[@"times"];
        [responseList enumerateObjectsUsingBlock:^(NSDictionary *aDict, NSUInteger idx, BOOL *stop) {
            [estimates addObject:[TimeEstimate parseFromDictionary:aDict]];
        }];
        
        success(estimates);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}


// Technique for blocks: http://stackoverflow.com/a/20910658
- (void)getSummary:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    dispatch_group_t group = dispatch_group_create();
    
    __block NSArray *savedTimes = nil;
    __block NSArray *savedPrices = nil;
    __block NSError *foundError = nil;
    
    dispatch_group_enter(group);
    [self getTimeEstimates:params success:^(NSArray *times) {
        savedTimes = times;
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        foundError = error;
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self getPriceEstimates:params success:^(NSArray *prices) {
        savedPrices = prices;
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        foundError = error;
        dispatch_group_leave(group);
    }];
    
    // Block is called after both API calls are done
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        if ([savedTimes count] > 0 && [savedPrices count] > 0) {
            TimeEstimate *timeEstimate = [self nearestTimeEstimate:savedTimes];
            PriceEstimate *priceEstimate = [self matchingPriceEstimate:timeEstimate prices:savedPrices];
            if (priceEstimate) {
                NSDictionary *result = @{ kUberResultFareEstimate: priceEstimate.estimate,
                                          kUberResultPickupTime: timeEstimate.estimate };
                success(result);
            }
            else {
                // no matching price for the nearest uber
                failure(nil);
            }
        }
        else {
            failure(foundError);
        }
        
    });
}


// Determines the nearest uber type. We sort by the ETA.
- (TimeEstimate *)nearestTimeEstimate:(NSArray *)estimates
{
    if (estimates.count > 0) {
        NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"estimate" ascending:YES];
        NSArray *sorted = [estimates sortedArrayUsingDescriptors:@[sorter]];
        return sorted[0];
    }
    return nil;
}


- (PriceEstimate *)matchingPriceEstimate:(TimeEstimate *)timeEstimate prices:(NSArray *)prices
{
    if (timeEstimate) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productId = %@", timeEstimate.productId];
        NSArray *matching = [prices filteredArrayUsingPredicate:predicate];
        if (matching.count > 0) {
            return matching[0];
        }
    }
    return nil;
}


- (AFHTTPRequestOperationManager *)getManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Token %@", self.serverToken] forHTTPHeaderField:@"Authorization"];
    
    return manager;
}

@end
