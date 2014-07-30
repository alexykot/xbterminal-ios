//
//  XBTPayment+PaymentsManagerAdditions.h
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 08.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTPayment.h"

@interface XBTPayment (PaymentsManagerAdditions)

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (void)updateWithCheckDictionary:(NSDictionary *)dictionary;

@end
