//
//  UIColor+Additions.h
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 02.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+ (UIColor *)colorWithRGBHex:(UInt32)hex;

+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha;

- (NSUInteger)RGBHex;

- (UIColor *)blendWithColor:(UIColor *)color2;

@end
