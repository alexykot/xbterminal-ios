//
//  XBTPaymentViewController.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 07.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTPaymentViewController.h"
#import "XBTPaymentsManager.h"

#define kSuccessfulViewControllerSegueId @"kSuccessfulViewControllerSegueId"

@interface XBTPaymentViewController ()

@property (weak, nonatomic) IBOutlet UILabel *fiatLabel;
@property (weak, nonatomic) IBOutlet UILabel *btcLabel;
@property (weak, nonatomic) IBOutlet UILabel *exchangeRateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (assign, nonatomic) BOOL isNeedCheck;

@end

@implementation XBTPaymentViewController

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
    
    [_cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startCheck];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self stopCheck];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

- (void)settingsUpdated
{
    [super settingsUpdated];
    
    [self reloadData];
}

#pragma mark - Private

- (void)updateForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    [super updateForInterfaceOrientation:interfaceOrientation];
    
    CGFloat minWidthHeight = MIN(self.view.height, self.view.width);
    
    CGRect fiatLabelFrame = _fiatLabel.frame;
    CGRect btcLabelFrame = _btcLabel.frame;
    CGRect exchangeRateLabelFrame = _exchangeRateLabel.frame;
    CGRect qrImageViewFrame = _qrImageView.frame;
    CGRect cancelButtonFrame = _cancelButton.frame;
    
    CGFloat fiatBtcDiff = btcLabelFrame.origin.x - fiatLabelFrame.origin.x;
    CGFloat fiatBtcOffset = fiatBtcDiff - btcLabelFrame.size.width;
    
    if(UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        qrImageViewFrame.origin.x = ForIPhoneOrIPad(kPaymentQrIPhoneLandscapeX, kPaymentQrIPadLandscapeX);
        qrImageViewFrame.origin.y = ForIPhoneOrIPad(kPaymentQrIPhoneLandscapeY, kPaymentQrIPadLandscapeY);
        qrImageViewFrame.size.height = qrImageViewFrame.size.width = ForIPhoneOrIPad(kPaymentQrIPhoneLandscapeWidthHeight, kPaymentQrIPadLandscapeWidthHeight);
        
        fiatLabelFrame.origin.x = ForIPhoneOrIPad(kPaymentCurrencyIPhoneLandscapeX, kPaymentCurrencyIPadLandscapeX);
        
        cancelButtonFrame.origin.x = ForIPhoneOrIPad(kPaymentButtonIPhoneLandscapeX, kPaymentButtonIPadLandscapeX);
        cancelButtonFrame.origin.y = ForIPhoneOrIPad(kPaymentButtonIPhoneLandscapeY, kPaymentButtonIPadLandscapeY);
        
        btcLabelFrame.size.width = fiatLabelFrame.size.width = ForIPhoneOrIPad(btcLabelFrame.size.width, (kPaymentCurrencyIPadLandscapeWidth - fiatBtcOffset) / 2);
    }
    else
    {
        qrImageViewFrame.origin.y = ForIPhoneOrIPad(kPaymentQrIPhoneY, kPaymentQrIPadY);
        qrImageViewFrame.size.height = qrImageViewFrame.size.width = ForIPhoneOrIPad(kPaymentQrIPhoneWidthHeight, kPaymentQrIPadWidthHeight);
        qrImageViewFrame.origin.x = (minWidthHeight - qrImageViewFrame.size.width) / 2;
        
        fiatLabelFrame.origin.x = ForIPhoneOrIPad(kPaymentCurrencyIPhoneX, kPaymentCurrencyIPadX);
        
        cancelButtonFrame.origin.x = (minWidthHeight - cancelButtonFrame.size.width) / 2;
        cancelButtonFrame.origin.y = ForIPhoneOrIPad(kPaymentButtonIPhoneY, kPaymentButtonIPadY);
        
        btcLabelFrame.size.width = fiatLabelFrame.size.width = ForIPhoneOrIPad(btcLabelFrame.size.width, (kPaymentCurrencyIPadWidth - fiatBtcOffset) / 2);
    }
    
    if([XBTSettings sharedInstance].isIPad)
    {
        btcLabelFrame.origin.x = ForIPhoneOrIPad(btcLabelFrame.origin.x, fiatLabelFrame.origin.x + fiatLabelFrame.size.width + fiatBtcOffset);
        
        fiatBtcDiff = btcLabelFrame.origin.x - fiatLabelFrame.origin.x;
        fiatBtcOffset = fiatBtcDiff - btcLabelFrame.size.width;
    }
    
    btcLabelFrame.origin.x = fiatLabelFrame.origin.x + fiatBtcDiff;
    exchangeRateLabelFrame.origin.x = fiatLabelFrame.origin.x;
    exchangeRateLabelFrame.size.width = fiatLabelFrame.size.width * 2 + fiatBtcOffset;
    
    _fiatLabel.frame = fiatLabelFrame;
    _btcLabel.frame = btcLabelFrame;
    _exchangeRateLabel.frame = exchangeRateLabelFrame;
    _qrImageView.frame = qrImageViewFrame;
    _cancelButton.frame = cancelButtonFrame;
}

- (void)reloadData
{
    XBTPayment *payment = [XBTPaymentsManager sharedInstance].payment;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.locale = [XBTSettings sharedInstance].locale;
    
    formatter.positiveFormat = @"0.00";
    _fiatLabel.text = [NSString stringWithFormat:@"%@ %@ %@", [XBTSettings sharedInstance].signPrefix, [formatter stringFromNumber:payment.fiatAmount], [XBTSettings sharedInstance].signPostfix];
    
    formatter.positiveFormat = @"0.#####";
    _btcLabel.text = [NSString stringWithFormat:@"m฿ %@", [formatter stringFromNumber:@([payment.btcAmount doubleValue] * 1000)]];
    
    formatter.positiveFormat = @"0.##";
    _exchangeRateLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Exchange rate", nil), [formatter stringFromNumber:payment.exchangeRate]];
    _qrImageView.image = payment.qrImage;
}

- (void)startCheck
{
    self.isNeedCheck = YES;
    [self paymentCheck];
}

- (void)stopCheck
{
    self.isNeedCheck = NO;
}

- (void)paymentCheck
{
    XBTPayment *payment = [XBTPaymentsManager sharedInstance].payment;
    
    if(payment)
    {
        [[XBTPaymentsManager sharedInstance] checkPayment:payment completion:^(NSError *error, XBTPayment *payment) {
            
            if(!error)
            {
                if(payment.paid.boolValue)
                {
                    self.isNeedCheck = NO;
                    [self performSegueWithIdentifier:kSuccessfulViewControllerSegueId sender:nil];
                }
            }
            if(!payment.paid.boolValue && _isNeedCheck)
            {
                [self performSelector:@selector(paymentCheck) withObject:nil afterDelay:kCheckPaymentTimeInterval];
            }
            
        }];
    }
}

#pragma mark - Actions

- (IBAction)cancelButtonPressed:(id)sender
{
    [XBTPaymentsManager sharedInstance].payment = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
