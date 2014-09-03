//
//  XBTTextField.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 07.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTTextField.h"

@implementation XBTTextField

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    bounds.origin.x += 8;
    bounds.size.width -= 8;
    return bounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGSize boundsSize = self.bounds.size;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(c, [UIColor whiteColor].CGColor);
    CGContextFillRect(c, rect);
    
    CGContextSetStrokeColorWithColor(c, UIColorRGBHex(kColorTextFieldBorderHEX).CGColor);
    
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, 0.0f, 0.0f);
    CGContextAddLineToPoint(c, boundsSize.width, 0.0f);
    CGContextAddLineToPoint(c, boundsSize.width, boundsSize.height);
    CGContextAddLineToPoint(c, 0.0f, boundsSize.height);
    CGContextAddLineToPoint(c, 0.0f, 0.0f);
    CGContextStrokePath(c);
}

@end
