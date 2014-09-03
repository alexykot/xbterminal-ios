//
//  XBTSuccessfulViewController.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 08.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTSuccessfulViewController.h"
#import "XBTPaymentsManager.h"

@interface XBTSuccessfulViewController ()

@property (weak, nonatomic) IBOutlet UILabel *successfulLabel;
@property (weak, nonatomic) IBOutlet UILabel *scanQrCodeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation XBTSuccessfulViewController

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
    
    [self reloadData];
    
    [_closeButton setTitle:NSLocalizedString(@"Close", nil) forState:UIControlStateNormal];
    _successfulLabel.text = NSLocalizedString(@"PAYMENT SUCCESSFUL", nil);
    _scanQrCodeLabel.text = NSLocalizedString(@"SCAN QR CODE FOR RECEIPE", nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

#pragma mark - Private

- (void)updateForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    [super updateForInterfaceOrientation:interfaceOrientation];
    
    CGFloat minWidthHeight = MIN(self.view.height, self.view.width);
    
    CGRect successfulLabelFrame = _successfulLabel.frame;
    CGRect scanQrCodeLabelFrame = _scanQrCodeLabel.frame;
    CGRect qrImageViewFrame = _qrImageView.frame;
    CGRect closeButtonFrame = _closeButton.frame;
    
    if(UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        qrImageViewFrame.origin.x = ForIPhoneOrIPad(kPaymentQrIPhoneLandscapeX, kPaymentQrIPadLandscapeX);
        qrImageViewFrame.origin.y = ForIPhoneOrIPad(kPaymentQrIPhoneLandscapeY, kPaymentQrIPadLandscapeY);
        qrImageViewFrame.size.height = qrImageViewFrame.size.width = ForIPhoneOrIPad(kPaymentQrIPhoneLandscapeWidthHeight, kPaymentQrIPadLandscapeWidthHeight);
        
        successfulLabelFrame.origin.x = ForIPhoneOrIPad(kSuccessfulLabelIPhoneLandscapeX, kSuccessfulLabelIPadLandscapeX);
        
        scanQrCodeLabelFrame.origin.x = successfulLabelFrame.origin.x;
        scanQrCodeLabelFrame.origin.y = ForIPhoneOrIPad(kSuccessfulScanQrCodeIPhoneLandscapeY, kSuccessfulScanQrCodeIPadLandscapeY);
        scanQrCodeLabelFrame.size.width = ForIPhoneOrIPad(kSuccessfulScanQrCodeIPhoneLandscapeWidth, kSuccessfulScanQrCodeIPadLandscapeWidth);
        
        closeButtonFrame.origin.y = ForIPhoneOrIPad(kSuccessfulCloseIPhoneLandscapeY, kSuccessfulCloseIPadLandscapeY);
        closeButtonFrame.origin.x = successfulLabelFrame.origin.x + (successfulLabelFrame.size.width - closeButtonFrame.size.width) / 2;
    }
    else
    {
        qrImageViewFrame.origin.y = ForIPhoneOrIPad(kSuccessfulQrIPhoneY, kSuccessfulQrIPadY);
        qrImageViewFrame.size.height = qrImageViewFrame.size.width = ForIPhoneOrIPad(kSuccessfulQrIPhoneWidthHeight, kSuccessfulQrIPadWidthHeight);
        qrImageViewFrame.origin.x = (minWidthHeight - qrImageViewFrame.size.width) / 2;
        
        successfulLabelFrame.origin.x = ForIPhoneOrIPad(kSuccessfulLabelIPhoneX, kSuccessfulLabelIPadX);
        
        scanQrCodeLabelFrame.origin.x = ForIPhoneOrIPad(kSuccessfulScanQrCodeIPhoneX, kSuccessfulScanQrCodeIPadX);
        scanQrCodeLabelFrame.origin.y = ForIPhoneOrIPad(kSuccessfulScanQrCodeIPhoneY, kSuccessfulScanQrCodeIPadY);
        scanQrCodeLabelFrame.size.width = ForIPhoneOrIPad(kSuccessfulScanQrCodeIPhoneWidth, kSuccessfulScanQrCodeIPadWidth);
        
        closeButtonFrame.origin.y = ForIPhoneOrIPad(kSuccessfulCloseIPhoneY, kSuccessfulCloseIPadY);
        closeButtonFrame.origin.x = (minWidthHeight - closeButtonFrame.size.width) / 2;
    }
    
    _successfulLabel.frame = successfulLabelFrame;
    _scanQrCodeLabel.frame = scanQrCodeLabelFrame;
    _qrImageView.frame = qrImageViewFrame;
    _closeButton.frame = closeButtonFrame;
}

- (void)reloadData
{
    XBTPayment *payment = [XBTPaymentsManager sharedInstance].payment;
    
    _qrImageView.image = payment.qrImage;
}

#pragma mark - Actions

- (IBAction)closeButtonPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
