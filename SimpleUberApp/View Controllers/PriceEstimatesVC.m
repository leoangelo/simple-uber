//
//  PriceEstimatesVC.m
//  SimpleUberApp
//
//  Created by Leo Angelo Quigao on 2/19/15.
//  Copyright (c) 2015 Leo Angelo Quigao. All rights reserved.
//

#import "PriceEstimatesVC.h"
#import "UberEndpoints.h"

@interface PriceEstimatesVC ()

@property (nonatomic, weak) IBOutlet UITextField *startLat;
@property (nonatomic, weak) IBOutlet UITextField *startLng;
@property (nonatomic, weak) IBOutlet UITextField *endLat;
@property (nonatomic, weak) IBOutlet UITextField *endLng;
@property (nonatomic, weak) IBOutlet UITextView *responseView;

@property (nonatomic, strong) UberEndpoints *uberEndpoint;

@end

@implementation PriceEstimatesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getEstimateTapped:(id)sender
{
    if (!self.uberEndpoint) {
        NSString *serverToken = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Uber Server Token"];
        self.uberEndpoint = [[UberEndpoints alloc] initWithServerToken:serverToken];
    }
    
    NSDictionary *params = @{ kUberStartLatitude: self.startLat.text,
                              kUberStartLongitude: self.startLng.text,
                              kUberEndLatitude: self.endLat.text,
                              kUberEndLongitude: self.endLng.text
                              };
    self.responseView.text = @"Loading...";
    [self.uberEndpoint getPriceEstimates:params success:^(NSArray *prices) {
        self.responseView.text = [prices description];
    } failure:^(NSError *error) {
        self.responseView.text = [error localizedDescription];
    }];
}

- (IBAction)tapSpaceTapped:(id)sender
{
    [self.startLat resignFirstResponder];
    [self.startLng resignFirstResponder];
    [self.endLat resignFirstResponder];
    [self.endLng resignFirstResponder];
}

@end
