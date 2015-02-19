//
//  NSDictionary+URLParameters.m
//  SimpleUberApp
//
//  Created by Leo Angelo Quigao on 2/19/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import "NSDictionary+URLParameters.h"

@implementation NSDictionary (URLParameters)

- (NSString *)convertToURLParameters
{
    NSMutableString *stringBuff = [NSMutableString string];
    
    [[self allKeys] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        if (idx > 0) {
            [stringBuff appendString:@"&"];
        }
        [stringBuff appendFormat:@"%@=%@", key, [self[key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }];
    return stringBuff;
}

@end
