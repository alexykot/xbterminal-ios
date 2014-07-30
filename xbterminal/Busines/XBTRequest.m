//
//  XBTRequest.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 07.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTRequest.h"
#import "XBTServerAccessManager.h"

@implementation XBTRequest

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if(self)
    {
        _responseType = XBTRequestResponseTypeJSON;
    }
    return self;
}

- (id)initWithPath:(NSString *)path
{
    return [self initWithPath:path params:nil];
}

- (id)initWithPath:(NSString *)path params:(NSDictionary *)params
{
    return [self initWithPath:path params:params method:nil];
}

- (id)initWithPath:(NSString *)path params:(NSDictionary *)params method:(NSString *)method
{
    return [self initWithPath:path params:params method:(method.length ? method : @"GET") responseType:XBTRequestResponseTypeJSON];
}

- (id)initWithPath:(NSString *)path params:(NSDictionary *)params method:(NSString *)method responseType:(XBTRequestResponseType)responseType
{
    self = [self init];
    if(self)
    {
        _path = path;
        _params = params;
        _method = method;
        _responseType = responseType;
    }
    return self;
}

#pragma mark - Public

- (void)start
{
    [self startWithCompletion:nil];
}

- (void)startWithCompletion:(XBTCompletionBlock)completionBlock
{
    [self startWithProgress:nil completion:completionBlock];
}

- (void)startWithProgress:(XBTProgressBlock)progressBlock completion:(XBTCompletionBlock)completionBlock
{
    self.completionBlock = completionBlock;
    self.progressBlock = progressBlock;
    
    [[XBTServerAccessManager sharedInstance] sendRequest:self];
}

- (void)responsedWithProgress:(CGFloat)progress
{
    self.progress = progress;
    
    [self handleProgress];
}

- (void)responsedWithError:(NSError *)error responseObject:(id)responseObject
{
    self.error = error;
    self.responseObject = responseObject;
    
    [self handleResponseObject];
}

- (void)handleProgress
{
    if(_progressBlock)
    {
        _progressBlock(self);
    }
}

- (void)handleResponseObject
{
    NSLog(@"%@: %@", _path, _responseObject);
    if(_completionBlock)
    {
        _completionBlock(self);
    }
    
    self.completionBlock = self.progressBlock = nil;
}

@end
