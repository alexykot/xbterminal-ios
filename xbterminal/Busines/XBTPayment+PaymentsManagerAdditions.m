//
//  XBTPayment+PaymentsManagerAdditions.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 08.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTPayment+PaymentsManagerAdditions.h"

@implementation XBTPayment (PaymentsManagerAdditions)

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if(self)
    {
        self.checkUrl = [SafeValue(dictionary[@"check_url"]) stringValue];
        self.fiatAmount = [SafeValue(dictionary[@"fiat_amount"]) numberValue];
        self.btcAmount = [SafeValue(dictionary[@"btc_amount"]) numberValue];
        self.exchangeRate = [SafeValue(dictionary[@"exchange_rate"]) numberValue];
        self.qrImage = [UIImage imageFromBase64String:SafeValue(dictionary[@"qr_code_src"])];
    }
    return self;
}

- (void)updateWithCheckDictionary:(NSDictionary *)dictionary
{
    self.paid = [SafeValue(dictionary[@"paid"]) numberValue];
    if(dictionary[@"qr_code_src"])
    {
        self.qrImage = [UIImage imageFromBase64String:SafeValue(dictionary[@"qr_code_src"])];
    }
}

@end
