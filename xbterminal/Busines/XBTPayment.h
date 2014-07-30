//
//  XBTPayment.h
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 08.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBTPayment : NSObject

@property (copy, nonatomic) NSString *checkUrl;
@property (strong, nonatomic) NSNumber *fiatAmount;
@property (strong, nonatomic) NSNumber *btcAmount;
@property (strong, nonatomic) NSNumber *exchangeRate;
@property (strong, nonatomic) UIImage *qrImage;
@property (strong, nonatomic) NSNumber *paid;

@end
