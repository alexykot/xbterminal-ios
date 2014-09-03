//
//  XBTScanQrViewController.h
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 06.08.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTViewController.h"

#define kScanQrViewControllerId @"kScanQrViewControllerId"

@class XBTScanQrViewController;

@protocol XBTScanQrViewControllerDelegate <NSObject>
@optional
- (void)scanQrViewController:(XBTScanQrViewController *)scanQrViewController didScanText:(NSString *)text;

@end

@interface XBTScanQrViewController : XBTViewController

@property (weak, nonatomic) id<XBTScanQrViewControllerDelegate> delegate;

@end
