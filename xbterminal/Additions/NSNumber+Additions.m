//
//  NSNumber+Additions.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 07.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "NSNumber+Additions.h"

@implementation NSNumber (Additions)

+ (NSNumber *)numberWithString:(NSString *)string
{
    if([string isKindOfClass:[NSNumber class]])
    {
        return (NSNumber *)string;
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return  [formatter numberFromString:string];
}

- (NSNumber *)numberValue
{
    return self;
}

@end
