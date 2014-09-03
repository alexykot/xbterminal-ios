//
//  XBTSettings.h
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 07.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTSingleton.h"
#import "XBTSettings+Definitions.h"

#import "UIView+Additions.h"
#import "UIColor+Additions.h"
#import "NSNumber+Additions.h"
#import "NSString+Additions.h"
#import "NSData+Additions.h"
#import "UIImage+Additions.h"

#define kSettingsUpdatedNotificationKey @"kSettingsUpdatedNotificationKey"

@interface XBTSettings : XBTSingleton

@property (strong, nonatomic) NSString *deviceNumber;
@property (assign, nonatomic) BOOL isTestnetActive;
@property (copy, nonatomic) NSString *merchantName;
@property (copy, nonatomic) NSString *merchantDeviceName;
@property (copy, nonatomic) NSString *thousandsSplit;
@property (copy, nonatomic) NSString *fractionalSplit;
@property (copy, nonatomic) NSString *signPrefix;
@property (copy, nonatomic) NSString *signPostfix;
@property (strong, nonatomic, readonly) NSLocale *locale;

- (BOOL)isIPhone;

- (BOOL)isIPad;

- (BOOL)isIOS7;

- (UIFont *)lightFontWithSize:(CGFloat)size;

- (UIFont *)romanFontWithSize:(CGFloat)size;

- (UIFont *)mediumFontWithSize:(CGFloat)size;

- (void)updateSettingsWithCompletion:(void (^)(NSError *error))completion;

@end

float roundToN(float num, int decimals);