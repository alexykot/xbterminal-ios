//
//  XBTStartViewController.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 07.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTStartViewController.h"
#import "XBTMainViewController.h"
#import "MBProgressHUD.h"
#import "XBTDeviceViewController.h"
#import "MZFormSheetController.h"
#import "XBTScanQrViewController.h"

#define kScanQrViewControllerSegueId @"kScanQrViewControllerSegueId"

@interface XBTStartViewController () <XBTDeviceViewControllerDelegate, XBTScanQrViewControllerDelegate>

@property (assign, nonatomic) BOOL isSignInSuccessed;

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *tapLabel;

@property (weak, nonatomic) XBTDeviceViewController *deviceViewController;

@end

@implementation XBTStartViewController

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.logoView.hidden = self.testnetLabel.hidden = YES;
    
    _tapLabel.text = NSLocalizedString(@"Tap screen to begin", nil);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    XBTDeviceViewController *deviceViewController = [self.storyboard instantiateViewControllerWithIdentifier:kDeviceViewControllerId];
    deviceViewController.delegate = self;
    self.deviceViewController = deviceViewController;
    
    MZFormSheetController *formSheetController = [[MZFormSheetController alloc] initWithSize:CGSizeMake(ForIPhoneOrIPad(kDeviceIPhoneWidth, kDeviceIPadWidth), ForIPhoneOrIPad(kDeviceIPhoneHeight, kDeviceIPadHeight)) viewController:deviceViewController];
    formSheetController.cornerRadius = 0.0f;
    formSheetController.shouldCenterVertically = YES;
    [formSheetController presentAnimated:YES completionHandler:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:kScanQrViewControllerSegueId])
    {
        XBTScanQrViewController *scanQrViewController = segue.destinationViewController;
        
        scanQrViewController.delegate = self;
    }
}

#pragma mark - Private

- (void)updateForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    [super updateForInterfaceOrientation:interfaceOrientation];
    
    CGFloat maxWidthHeight = MAX(self.view.height, self.view.width);
    CGFloat minWidthHeight = MIN(self.view.height, self.view.width);
    
    CGRect logoImageViewFrame = _logoImageView.frame;
    CGRect tapLabelFrame = _tapLabel.frame;
    
    if(UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        logoImageViewFrame.origin.x = (maxWidthHeight - logoImageViewFrame.size.width) / 2;
        logoImageViewFrame.origin.y = ForIPhoneOrIPad(kStartLogoIPhoneLandscapeY, kStartLogoIPadLandscapeY);
        
        tapLabelFrame.origin.x = (maxWidthHeight - tapLabelFrame.size.width) / 2;
        tapLabelFrame.origin.y = ForIPhoneOrIPad(kStartTapIPhoneLandscapeY, kStartTapIPadLandscapeY);
    }
    else
    {
        logoImageViewFrame.origin.x = (minWidthHeight - logoImageViewFrame.size.width) / 2;
        logoImageViewFrame.origin.y = ForIPhoneOrIPad(kStartLogoIPhoneY, kStartLogoIPadY);
        
        tapLabelFrame.origin.x = (minWidthHeight - tapLabelFrame.size.width) / 2;
        tapLabelFrame.origin.y = ForIPhoneOrIPad(kStartTapIPhoneY, kStartTapIPadY);
    }
    
    _logoImageView.frame = logoImageViewFrame;
    _tapLabel.frame = tapLabelFrame;
}

#pragma mark - Actions

- (IBAction)selfTapped:(id)sender
{
    if(_isSignInSuccessed)
    {
        [self.navigationController setViewControllers:@[[self.storyboard instantiateViewControllerWithIdentifier:kMainViewControllerId]] animated:YES];
    }
}

#pragma mark - XBTDeviceViewControllerDelegate

- (void)deviceNumberRightInDeviceViewController:(XBTDeviceViewController *)deviceViewController
{
    self.isSignInSuccessed = YES;
    [deviceViewController mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
}

- (void)scanQrButtonPressedInDeviceViewController:(XBTDeviceViewController *)deviceViewController
{
    [_deviceViewController mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
    [self performSegueWithIdentifier:kScanQrViewControllerSegueId sender:nil];
}

#pragma mark - XBTScanQrViewControllerDelegate

- (void)scanQrViewController:(XBTScanQrViewController *)scanQrViewController didScanText:(NSString *)text
{
    [XBTSettings sharedInstance].deviceNumber = text;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
