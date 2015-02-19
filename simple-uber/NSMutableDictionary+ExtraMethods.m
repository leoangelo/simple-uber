//
//  NSMutableDictionary+ExtraMethods.m
//  SimpleUberApp
//
//  Created by Leo Angelo Quigao on 2/19/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import "NSMutableDictionary+ExtraMethods.h"

@implementation NSMutableDictionary (ExtraMethods)

// http://stackoverflow.com/a/5632377
- (void)exchangeKey:(NSString *)aKey withKey:(NSString *)aNewKey
{
    if (![aKey isEqualToString:aNewKey]) {
        id objectToPreserve = [self objectForKey:aKey];
        [self setObject:objectToPreserve forKey:aNewKey];
        [self removeObjectForKey:aKey];
    }
}

@end
