//
//  XBTPaymentsManager.h
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 08.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTSingleton.h"
#import "XBTPayment.h"

@interface XBTPaymentsManager : XBTSingleton

@property (strong, nonatomic) XBTPayment *payment;

- (void)initPaymentWithAmount:(NSNumber *)amount deviceKey:(NSString *)deviceKey completion:(void (^)(NSError *error, XBTPayment *payment))completion;

- (void)checkPayment:(XBTPayment *)payment completion:(void (^)(NSError *error, XBTPayment *payment))completion;

@end
