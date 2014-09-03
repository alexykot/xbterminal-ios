//
//  XBTDeviceViewController.h
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 05.08.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTViewController.h"

#define kDeviceViewControllerId @"kDeviceViewControllerId"

@class XBTDeviceViewController;

@protocol XBTDeviceViewControllerDelegate <NSObject>
@optional
- (void)deviceNumberRightInDeviceViewController:(XBTDeviceViewController *)deviceViewController;
- (void)scanQrButtonPressedInDeviceViewController:(XBTDeviceViewController *)deviceViewController;

@end

@interface XBTDeviceViewController : XBTViewController

@property (weak, nonatomic) id<XBTDeviceViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *deviceNumber;

@end
