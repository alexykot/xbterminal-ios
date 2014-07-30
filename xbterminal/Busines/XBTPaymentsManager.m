//
//  XBTPaymentsManager.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 08.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTPaymentsManager.h"
#import "XBTServerAccessManager.h"
#import "XBTPayment+PaymentsManagerAdditions.h"

@implementation XBTPaymentsManager

- (void)initPaymentWithAmount:(NSNumber *)amount deviceKey:(NSString *)deviceKey completion:(void (^)(NSError *error, XBTPayment *payment))completion
{
    XBTRequest *request = [[XBTRequest alloc] initWithPath:@"/api/payments/init" params:@{@"amount": amount, @"device_key": deviceKey} method:@"POST"];
    [request startWithCompletion:^(XBTRequest *request) {
       
        XBTPayment *payment = nil;
        if(!request.error)
        {
            payment = [[XBTPayment alloc] initWithDictionary:request.responseObject];
            self.payment = payment;
        }
        else
        {
            self.payment = nil;
        }
        
        if(completion)
        {
            completion(request.error, payment);
        }
        
    }];
}

- (void)checkPayment:(XBTPayment *)payment completion:(void (^)(NSError *error, XBTPayment *payment))completion
{
    XBTRequest *request = [[XBTRequest alloc] initWithPath:payment.checkUrl];
    request.isPathFullUrl = YES;
    [request startWithCompletion:^(XBTRequest *request) {
        
        if(!request.error)
        {
            [payment updateWithCheckDictionary:request.responseObject];
        }
        
        if(completion)
        {
            completion(request.error, payment);
        }
        
    }];
}

@end
