//
//  XBTServerAccessManager.h
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 07.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTSingleton.h"
#import "XBTRequest.h"

@interface XBTServerAccessManager : XBTSingleton

@property (strong, nonatomic) NSURL *baseUrl;

- (void)sendRequest:(XBTRequest *)request;

@end
