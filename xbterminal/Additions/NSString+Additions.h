//
//  NSString+Additions.h
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 07.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (unsigned)countOccurencesOf:(NSString *)subString;

- (NSNumber *)numberValue;
- (NSString *)stringValue;

@end
