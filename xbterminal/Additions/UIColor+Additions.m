//
//  UIColor+Additions.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 02.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
	return [self colorWithRGBHex:hex alpha:1.0f];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha
{
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
	
	return [UIColor colorWithRed:r / 255.0f
						   green:g / 255.0f
							blue:b / 255.0f
						   alpha:alpha];
}

- (NSUInteger)RGBHex
{
    CGFloat red, green, blue, alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    NSInteger ired, igreen, iblue;
    ired = roundf(red * 255);
    igreen = roundf(green * 255);
    iblue = roundf(blue * 255);
    NSUInteger result = (ired << 16) | (igreen << 8) | iblue;
    return result;
}

- (UIColor *)blendWithColor:(UIColor *)color2
{
    CGFloat r1, g1, b1, a1, r2, g2, b2, a2;
    [self getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [color2 getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    CGFloat red     = (r1 + r2) / 2;
    CGFloat green   = (g1 + g2) / 2;
    CGFloat blue    = (b1 + b2) / 2;
    CGFloat alpha   = (a1 + a2) / 2;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
