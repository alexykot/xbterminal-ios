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

@interface XBTSettings : XBTSingleton

@property (strong, nonatomic) NSString *deviceNumber;
@property (assign, nonatomic) BOOL isTestnetActive;
@property (strong, nonatomic) NSString *merchantName;
@property (strong, nonatomic) NSString *merchantDeviceName;
@property (strong, nonatomic, readonly) NSLocale *locale;

- (void)updateSettingsWithCompletion:(void (^)(NSError *error))completion;

- (BOOL)isIPhone;

- (BOOL)isIPad;

- (UIFont *)lightFontWithSize:(CGFloat)size;

- (UIFont *)romanFontWithSize:(CGFloat)size;

- (UIFont *)mediumFontWithSize:(CGFloat)size;

@end

float roundToN(float num, int decimals);