//
//  XBTSingleton.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 02.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTSingleton.h"

@implementation XBTSingleton

static NSMutableDictionary *instances = nil;

+ (void)initialize
{
    if(!instances)
    {
        instances = [NSMutableDictionary dictionary];
    }
}

+ (instancetype)sharedInstance
{
    id instance = nil;
    
	@synchronized(self)
    {
        NSString *selfClassString = NSStringFromClass(self);
        
		if (instances[selfClassString] == nil)
        {
			instances[selfClassString] = [[self alloc] init];
		}
        instance = instances[selfClassString];
	}
    
	return instance;
}

@end
