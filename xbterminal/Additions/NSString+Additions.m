//
//  NSString+Additions.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 07.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (unsigned)countOccurencesOf:(NSString *)subString
{
    unsigned count = 0;
    unsigned myLength = [self length];
    NSRange uncheckedRange = NSMakeRange(0, myLength);
    for(;;) {
        NSRange foundAtRange = [self rangeOfString:subString
                                           options:0
                                             range:uncheckedRange];
        if (foundAtRange.location == NSNotFound) return count;
        unsigned newLocation = NSMaxRange(foundAtRange);
        uncheckedRange = NSMakeRange(newLocation, myLength-newLocation);
        count++;
    }
}

- (NSNumber *)numberValue
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return  [formatter numberFromString:self];
}

- (NSString *)stringValue
{
    return self;
}

@end
