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

NSString * const kUberStartLatitude = @"start_latitude";
NSString * const kUberStartLongitude = @"start_longitude";
NSString * const kUberEndLatitude = @"end_latitude";
NSString * const kUberEndLongitude = @"end_longitude";

NSString * const kUberAPI = @"https://api.uber.com";

NSString * const kUberPriceEstimatePath = @"/v1/estimates/price";

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


- (AFHTTPRequestOperationManager *)getManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Token %@", self.serverToken] forHTTPHeaderField:@"Authorization"];
    
    return manager;
}

@end
