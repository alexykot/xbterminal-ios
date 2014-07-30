//
//  UIImage+Additions.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 08.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

+ (UIImage *)imageFromBase64String:(NSString *)string
{
    UIImage *image;
    if(string.length > 22)
    {
        NSArray *stringComponents = [string componentsSeparatedByString:@","];
        if(stringComponents.count == 2)
        {
            NSData *data = [NSData dataWithBase64String:stringComponents[1]];
            image = [UIImage imageWithData:data];
        }
    }
    return image;
}

- (NSString *)base64String
{
    NSData *data = UIImagePNGRepresentation(self);
    NSString *s = [data base64String];
    return [@"data:image/png;base64," stringByAppendingString:s];
}

@end
