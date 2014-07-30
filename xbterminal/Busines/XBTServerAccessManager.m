//
//  XBTServerAccessManager.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 07.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTServerAccessManager.h"
#import "AFNetworking.h"

@implementation XBTServerAccessManager

- (void)sendRequest:(XBTRequest *)request
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSURL *url = request.isPathFullUrl ? [NSURL URLWithString:request.path] : [_baseUrl URLByAppendingPathComponent:request.path];
    
    NSURLRequest *urlRequest = [manager.requestSerializer requestWithMethod:request.method URLString:url.absoluteString parameters:request.params error:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    switch(request.responseType)
    {
        case XBTRequestResponseTypeJSON:
        {
            operation.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
            
        case XBTRequestResponseTypeXML:
        {
            operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
            
        default:
            break;
    }
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [request responsedWithError:nil responseObject:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [request responsedWithError:error responseObject:nil];
        
    }];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
       
        [request responsedWithProgress:(float)totalBytesRead / totalBytesExpectedToRead];
        
    }];
    
    [operation start];
}

@end
