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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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

#pragma mark - Private

- (void)reloadData
{
    XBTPayment *payment = [XBTPaymentsManager sharedInstance].payment;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.locale = [XBTSettings sharedInstance].locale;
    
    formatter.positiveFormat = @"0.00";
    _fiatLabel.text = [NSString stringWithFormat:@"£ %@", [formatter stringFromNumber:payment.fiatAmount]];
    
    formatter.positiveFormat = @"0.#####";
    _btcLabel.text = [NSString stringWithFormat:@"m฿ %@", [formatter stringFromNumber:@([payment.btcAmount doubleValue] * 1000)]];
    
    formatter.positiveFormat = @"0.##";
    _exchangeRateLabel.text = [NSString stringWithFormat:@"Exchange rate: %@", [formatter stringFromNumber:payment.exchangeRate]];
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
