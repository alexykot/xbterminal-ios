//
//  XBTViewController.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 03.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTViewController.h"

@interface XBTViewController ()

@end

@implementation XBTViewController

#pragma mark - View lidecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorRGBHex(kColorBgHEX);
    if([self.view respondsToSelector:@selector(tintColor)])
    {
        self.view.tintColor = [UIColor blackColor];
    }
    
    [self setupLogo];
    [self setupTestnet];
    [self setupCopyright];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateCopyrightLabel];
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

- (void)updateCopyrightLabel
{
    if([XBTSettings sharedInstance].merchantName || [XBTSettings sharedInstance].merchantDeviceName)
    {
        _copyrightLabel.text = [NSString stringWithFormat:@"%@\n%@", [XBTSettings sharedInstance].merchantName, [XBTSettings sharedInstance].merchantDeviceName];
    }
    else
    {
        _copyrightLabel.text = @"";
    }
}

#pragma mark - Private

- (void)setupLogo
{
    self.logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    
    _logoView.width = ForIPhoneOrIPad(kLogoIPhoneWidth, kLogoIPadWidth);
    _logoView.height = ForIPhoneOrIPad(kLogoIPhoneHeight, kLogoIPadHeight);
    _logoView.y = ForIPhoneOrIPad(kLogoIPhoneY, kLogoIPadY);
    _logoView.x = (self.view.width - _logoView.width) / 2;
    
    [self.view addSubview:_logoView];
}

- (void)setupTestnet
{
    if([XBTSettings sharedInstance].isTestnetActive)
    {
        self.testnetLabel = [[UILabel alloc] init];
        
        _testnetLabel.text = @"testnet active";
        _testnetLabel.font = [[XBTSettings sharedInstance] romanFontWithSize:ForIPhoneOrIPad(kTestnetIPhoneFontSize, kTestnetIPadFontSize)];
        
        _testnetLabel.textAlignment = NSTextAlignmentCenter;
        _testnetLabel.textColor = UIColorRGBHex(kColorTestnetHEX);
        _testnetLabel.backgroundColor = [UIColor clearColor];
        
        _testnetLabel.width = self.view.width;
        _testnetLabel.height = kTestnetIPhoneHeight;
        _testnetLabel.y = ForIPhoneOrIPad(kTestnetIPhoneY, kTestnetIPadY);
        _testnetLabel.x = 0;
        
        [self.view addSubview:_testnetLabel];
    }
}

- (void)setupCopyright
{
    self.copyrightLabel = [[UILabel alloc] init];
    
    _copyrightLabel.font = [[XBTSettings sharedInstance] romanFontWithSize:kCopyrightFontSize];
    _copyrightLabel.textAlignment = NSTextAlignmentCenter;
    _copyrightLabel.numberOfLines = 2;
    _copyrightLabel.backgroundColor = [UIColor clearColor];
    
    _copyrightLabel.width = self.view.width;
    _copyrightLabel.height = kCopyrightIPhoneHeight;
    _copyrightLabel.y = self.view.height - _copyrightLabel.height - kCopyrightIPhoneBottomOffset;
    _copyrightLabel.x = (self.view.width - _copyrightLabel.width) / 2;
    
    [self.view addSubview:_copyrightLabel];
}

@end
