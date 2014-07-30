//
//  NSData+Additions.h
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 08.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Additions)

+ (id)dataWithBase64String:(NSString *)string;
- (NSString *)base64String;

@end
