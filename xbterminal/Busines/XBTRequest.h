//
//  XBTRequest.h
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 07.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XBTRequest;

typedef void(^XBTCompletionBlock)(XBTRequest *request);
typedef void(^XBTProgressBlock)(XBTRequest *request);

typedef NS_ENUM(NSUInteger, XBTRequestResponseType)
{
    XBTRequestResponseTypeData,
    XBTRequestResponseTypeJSON,
    XBTRequestResponseTypeXML
};

@interface XBTRequest : NSObject

@property (copy, nonatomic) NSString *path;
@property (assign, nonatomic) BOOL isPathFullUrl;
@property (strong, nonatomic) NSDictionary *params;
@property (copy, nonatomic) NSString *method;
@property (assign, nonatomic) XBTRequestResponseType responseType;

@property (copy, nonatomic) XBTCompletionBlock completionBlock;
@property (copy, nonatomic) XBTProgressBlock progressBlock;

@property (assign, nonatomic) CGFloat progress;
@property (strong, nonatomic) NSError *error;
@property (strong, nonatomic) id responseObject;

- (id)initWithPath:(NSString *)path;
- (id)initWithPath:(NSString *)path params:(NSDictionary *)params;
- (id)initWithPath:(NSString *)path params:(NSDictionary *)params method:(NSString *)method;
- (id)initWithPath:(NSString *)path params:(NSDictionary *)params method:(NSString *)method responseType:(XBTRequestResponseType)responseType;

- (void)start;
- (void)startWithCompletion:(XBTCompletionBlock)completionBlock;
- (void)startWithProgress:(XBTProgressBlock)progressBlock completion:(XBTCompletionBlock)completionBlock;

- (void)responsedWithProgress:(CGFloat)progress;
- (void)responsedWithError:(NSError *)error responseObject:(id)responseObject;

- (void)handleResponseObject;
- (void)handleProgress;

@end
