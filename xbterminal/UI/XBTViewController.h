//
//  XBTViewController.h
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 03.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBTViewController : UIViewController

@property (strong, nonatomic) UIImageView *logoView;
@property (strong, nonatomic) UILabel *testnetLabel;
@property (strong, nonatomic) UILabel *copyrightLabel;

- (void)updateCopyrightLabel;

@end
