//
//  XBTSettings.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 07.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTSettings.h"
#import "XBTServerAccessManager.h"
#import "AFNetworkActivityIndicatorManager.h"

#define kDeviceNumberKey @"kDeviceNumberKey"
#define kUpdateTimeInterval 60.0

float roundToN(float num, int decimals)
{
    int tenpow = 1;
    for (; decimals; tenpow *= 10, decimals--);
    return round(tenpow * num) / tenpow;
}

@interface XBTSettings ()

@end

@implementation XBTSettings

@synthesize locale = _locale;

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if(self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [XBTServerAccessManager sharedInstance].baseUrl = [NSURL URLWithString:kBaseUrlString];
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

#pragma mark - Public

- (void)updateSettingsWithCompletion:(void (^)(NSError *error))completion
{
    XBTRequest *request = [[XBTRequest alloc] initWithPath:[@"/api/devices/" stringByAppendingString:self.deviceNumber]];
    
    [request startWithCompletion:^(XBTRequest *request) {
        
        if(!request.error)
        {
            self.isTestnetActive = [SafeValue(request.responseObject[@"BITCOIN_NETWORK"]) isEqual:@"testnet"];
            self.merchantName = SafeValue(request.responseObject[@"MERCHANT_NAME"]);
            self.merchantDeviceName = SafeValue(request.responseObject[@"MERCHANT_DEVICE_NAME"]);
            self.thousandsSplit = SafeValue(request.responseObject[@"OUTPUT_DEC_THOUSANDS_SPLIT"]);
            self.fractionalSplit = SafeValue(request.responseObject[@"OUTPUT_DEC_FRACTIONAL_SPLIT"]);
            self.signPrefix = SafeValue(request.responseObject[@"MERCHANT_CURRENCY_SIGN_PREFIX"]);
            self.signPostfix = SafeValue(request.responseObject[@"MERCHANT_CURRENCY_SIGN_POSTFIX"]);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kSettingsUpdatedNotificationKey object:nil];
            [self performSelector:@selector(updateSettingsWithCompletion:) withObject:nil afterDelay:kUpdateTimeInterval];
        }
        if(completion)
        {
            completion(request.error);
        }
        
    }];
}

- (NSString *)deviceNumber
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceNumberKey];
}

- (void)setDeviceNumber:(NSString *)deviceNumber
{
    [[NSUserDefaults standardUserDefaults] setObject:deviceNumber forKey:kDeviceNumberKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isIPhone
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

- (BOOL)isIPad
{
    return !self.isIPhone;
}

- (BOOL)isIOS7
{
    return [[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedDescending;
}

- (UIFont *)lightFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}

- (UIFont *)romanFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

- (UIFont *)mediumFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}

- (NSLocale *)locale
{
    if(!_locale)
    {
        _locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    }
    return _locale;
}

#pragma mark - Private

@end
