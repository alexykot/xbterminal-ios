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
    [super viewWillAppear:animated];
    
    [self updateForInterfaceOrientation:self.interfaceOrientation];
    
    [self updateLabels];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsUpdated) name:kSettingsUpdatedNotificationKey object:nil];
    [self settingsUpdated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
       
        [self updateForInterfaceOrientation:toInterfaceOrientation];
        
    }];
}

#pragma mark - Public

- (void)settingsUpdated
{
    [self updateLabels];
}

#pragma mark - Private

- (void)updateLabels
{
    if([XBTSettings sharedInstance].merchantName || [XBTSettings sharedInstance].merchantDeviceName)
    {
        _copyrightLabel.text = [NSString stringWithFormat:@"%@\n%@", [XBTSettings sharedInstance].merchantName, [XBTSettings sharedInstance].merchantDeviceName];
    }
    else
    {
        _copyrightLabel.text = @"";
    }
    
    if([XBTSettings sharedInstance].isTestnetActive)
    {
        _testnetLabel.text = NSLocalizedString(@"testnet active", nil);
    }
    else
    {
        _testnetLabel.text = @"";
    }
}

- (void)setupLogo
{
    self.logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    
    [self.view addSubview:_logoView];
}

- (void)setupTestnet
{
    self.testnetLabel = [[UILabel alloc] init];
    
    _testnetLabel.font = [[XBTSettings sharedInstance] romanFontWithSize:ForIPhoneOrIPad(kTestnetIPhoneFontSize, kTestnetIPadFontSize)];
    
    _testnetLabel.textAlignment = NSTextAlignmentCenter;
    _testnetLabel.textColor = UIColorRGBHex(kColorTestnetHEX);
    _testnetLabel.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_testnetLabel];
}

- (void)setupCopyright
{
    self.copyrightLabel = [[UILabel alloc] init];
    
    _copyrightLabel.font = [[XBTSettings sharedInstance] romanFontWithSize:kCopyrightFontSize];
    _copyrightLabel.textAlignment = NSTextAlignmentCenter;
    _copyrightLabel.numberOfLines = 2;
    _copyrightLabel.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_copyrightLabel];
}

- (void)updateForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    CGFloat maxWidthHeight = MAX(self.view.height, self.view.width);
    CGFloat minWidthHeight = MIN(self.view.height, self.view.width);
    
    CGRect logoViewFrame = _logoView.frame;
    logoViewFrame.origin.y = ForIPhoneOrIPad(kLogoIPhoneY, kLogoIPadY);
    logoViewFrame.size.width = ForIPhoneOrIPad(kLogoIPhoneWidth, kLogoIPadWidth);
    logoViewFrame.size.height = ForIPhoneOrIPad(kLogoIPhoneHeight, kLogoIPadHeight);
    
    CGRect testnetLabelFrame = _testnetLabel.frame;
    testnetLabelFrame.size.width = self.view.width;
    testnetLabelFrame.size.height = kTestnetIPhoneHeight;
    testnetLabelFrame.origin.y = ForIPhoneOrIPad(kTestnetIPhoneY, kTestnetIPadY);
    
    CGRect copyrightLabelFrame = _copyrightLabel.frame;
    copyrightLabelFrame.size.width = self.view.width;
    copyrightLabelFrame.size.height = kCopyrightIPhoneHeight;
    
    if(UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        logoViewFrame.origin.x = (maxWidthHeight - logoViewFrame.size.width) / 2;
        
        testnetLabelFrame.origin.x = (maxWidthHeight - testnetLabelFrame.size.width) / 2;
        
        copyrightLabelFrame.origin.x = (maxWidthHeight - copyrightLabelFrame.size.width) / 2;
        copyrightLabelFrame.origin.y = minWidthHeight - copyrightLabelFrame.size.height - kCopyrightIPhoneBottomOffset;
    }
    else
    {
        logoViewFrame.origin.x = (minWidthHeight - logoViewFrame.size.width) / 2;
        
        testnetLabelFrame.origin.x = (minWidthHeight - testnetLabelFrame.size.width) / 2;
        
        copyrightLabelFrame.origin.x = (minWidthHeight - copyrightLabelFrame.size.width) / 2;
        copyrightLabelFrame.origin.y = maxWidthHeight - copyrightLabelFrame.size.height - kCopyrightIPhoneBottomOffset;
    }
    
    if(![XBTSettings sharedInstance].isIOS7)
    {
        testnetLabelFrame.origin.y -= 15;
    }
    _logoView.frame = logoViewFrame;
    _testnetLabel.frame = testnetLabelFrame;
    _copyrightLabel.frame = copyrightLabelFrame;
}

@end
