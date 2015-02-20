//
//  UberDeeplinkVC.m
//  SimpleUberApp
//
//  Created by Leo Angelo Quigao on 2/19/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import "UberDeeplinkVC.h"
#import "UberDeeplinking.h"

@interface UberDeeplinkVC ()

@property (nonatomic, weak) IBOutlet UITextField *latitude;
@property (nonatomic, weak) IBOutlet UITextField *longitude;

@end

@implementation UberDeeplinkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openUberTapped:(id)sender
{
    NSString *clientID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Uber Client ID"];
    UberDeeplinking *deeplinking = [[UberDeeplinking alloc] initWithClientID:clientID];
    
    NSDictionary *params = @{ kUberDropOffLatitude: self.latitude.text,
                              kUberDropOffLongitude: self.longitude.text
                              };
    [deeplinking openUber:[params mutableCopy]];
}

- (IBAction)tapSpaceTapped:(id)sender
{
    [self.latitude resignFirstResponder];
    [self.longitude resignFirstResponder];
}

@end
