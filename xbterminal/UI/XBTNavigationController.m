//
//  XBTNavigationController.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 06.08.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTNavigationController.h"

@interface XBTNavigationController ()

@end

@implementation XBTNavigationController

- (BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
