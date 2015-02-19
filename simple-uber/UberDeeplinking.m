//
//  UberDeeplinking.m
//  SimpleUberApp
//
//  Created by Leo Angelo Quigao on 2/19/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import "UberDeeplinking.h"
#import "NSMutableDictionary+ExtraMethods.h"
#import "NSDictionary+URLParameters.h"

NSString * const kUberDropOffLatitude = @"dropoff[latitude]";
NSString * const kUberDropOffLongitude = @"dropoff[longitude]";
NSString * const kUberDropOffAddress = @"dropoff[formatted_address]";
NSString * const kUberDropOffLocNickname = @"dropoff[nickname]"; // name of the place
NSString * const kUberUserFirstName = @"first_name";
NSString * const kUberUserFirstLastName = @"last_name";
NSString * const kUberUserFirstEmail = @"email";

NSString * const kUberClientID = @"client_id";
NSString * const kUberDropOffLatitudeWeb = @"dropoff_latitude";
NSString * const kUberDropOffLongitudeWeb = @"dropoff_longitude";
NSString * const kUberDropOffNicknameWeb = @"dropoff_nickname";
NSString * const kUberDropOffAddressWeb = @"dropoff_address";

NSString * const kUberMobileApp = @"uber://action=setPickup&pickup=my_location&";
NSString * const kUberWebApp = @"https://m.uber.com/sign-up?";

@interface UberDeeplinking ()

@property (nonatomic, strong) NSString *clientID;

@end

@implementation UberDeeplinking


- (instancetype)initWithClientID:(NSString *)clientID
{
    self = [super init];
    if (self) {
        self.clientID = clientID;
    }
    return self;
}


- (void)openUber:(NSMutableDictionary *)dropOffParams
{
    [self insertClientID:dropOffParams];
    
    NSString *urlString;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"uber://"]]) {
        // Do something awesome - the app is installed! Launch App.
        urlString = [self composeURL:kUberMobileApp params:dropOffParams];
    }
    else {
        // No Uber app! Open Mobile Website.
        [self updateToWebAppFormat:dropOffParams];
        urlString = [self composeURL:kUberWebApp params:dropOffParams];
    }
    NSLog(@"Opening URL: %@", urlString);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}


- (void)insertClientID:(NSMutableDictionary *)params
{
    params[kUberClientID] = self.clientID;
}


// Some parameters used for the web app are different from the iOS app, so we need to replace some keys' names
- (void)updateToWebAppFormat:(NSMutableDictionary *)params
{
    NSArray *allKeys = [params allKeys];
    for (NSString *key in allKeys) {
        
        if ([key isEqualToString:kUberDropOffLatitude]) {
            [params exchangeKey:key withKey:kUberDropOffLatitudeWeb];
        }
        else if ([key isEqualToString:kUberDropOffLongitude]) {
            [params exchangeKey:key withKey:kUberDropOffLongitudeWeb];
        }
        else if ([key isEqualToString:kUberDropOffLocNickname]) {
            [params exchangeKey:key withKey:kUberDropOffNicknameWeb];
        }
        else if ([key isEqualToString:kUberDropOffAddress]) {
            [params exchangeKey:key withKey:kUberDropOffAddressWeb];
        }        
    }
}


- (NSString *)composeURL:(NSString *)baseUrl params:(NSMutableDictionary *)params
{
    return [NSString stringWithFormat:@"%@%@", baseUrl, [params convertToURLParameters]];
}

@end
