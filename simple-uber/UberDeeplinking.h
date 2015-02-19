//
//  UberDeeplinking.h
//  SimpleUberApp
//
//  Created by Leo Angelo Quigao on 2/19/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kUberDropOffLatitude;
extern NSString * const kUberDropOffLongitude;
extern NSString * const kUberDropOffAddress;
extern NSString * const kUberDropOffLocNickname; // name of the place
extern NSString * const kUberUserFirstName;
extern NSString * const kUberUserFirstLastName;
extern NSString * const kUberUserFirstEmail;

@interface UberDeeplinking : NSObject

- (instancetype)initWithClientID:(NSString *)clientID;
- (void)openUber:(NSMutableDictionary *)dropOffParams;

@end
