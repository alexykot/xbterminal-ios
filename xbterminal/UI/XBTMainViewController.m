//
//  XBTMainViewController.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 07.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTMainViewController.h"
#import "MBProgressHUD.h"
#import "XBTPaymentsManager.h"

#define kPaymentViewControllerSegueId @"kPaymentViewControllerSegueId"

@interface XBTMainViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *funtLabel;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;

@end

@implementation XBTMainViewController

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
    
    _amountLabel.text = NSLocalizedString(@"amount", nil);
    [_payButton setTitle:NSLocalizedString(@"Pay now", nil) forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _amountTextField.text = @"0.00";
    [_amountTextField becomeFirstResponder];
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
    
    [self updateAmountTextField];
    _funtLabel.text = [XBTSettings sharedInstance].signPrefix;
}

#pragma mark - Private

- (void)updateForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    [super updateForInterfaceOrientation:interfaceOrientation];
    
    CGFloat minWidthHeight = MIN(self.view.height, self.view.width);
    
    CGRect funtLabelFrame = _funtLabel.frame;
    CGRect amountLabelFrame = _amountLabel.frame;
    CGRect amountTextFieldFrame = _amountTextField.frame;
    CGRect payButtonFrame = _payButton.frame;
    
    CGFloat amountFuntDiff = amountLabelFrame.origin.x - funtLabelFrame.origin.x;
    
    if(UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        funtLabelFrame.origin.y = ForIPhoneOrIPad(kMainFuntIPhoneLandscapeY, kMainFuntIPadLandscapeY);
        funtLabelFrame.origin.x = ForIPhoneOrIPad(funtLabelFrame.origin.x, kMainFuntIPadLandscapeX);
        amountLabelFrame.origin.y = ForIPhoneOrIPad(kMainAmountIPhoneLandscapeY, kMainAmountIPadLandscapeY);
        amountTextFieldFrame.origin.y = ForIPhoneOrIPad(kMainAmountTextFieldIPhoneLandscapeY, kMainAmountTextFieldIPadLandscapeY);
        amountTextFieldFrame.size.width = ForIPhoneOrIPad(kMainAmountTextFieldIPhoneLandscapeWidth, kMainAmountTextFieldIPadLandscapeWidth);
        
        payButtonFrame.origin.y = ForIPhoneOrIPad(kMainPayButtonIPhoneLandscapeY, kMainPayButtonIPadLandscapeY);
        payButtonFrame.origin.x = ForIPhoneOrIPad(kMainPayButtonIPhoneLandscapeX, kMainPayButtonIPadLandscapeX);
        payButtonFrame.size.width = ForIPhoneOrIPad(kMainPayButtonIPhoneLandscapeWidth, kMainPayButtonIPadLandscapeWidth);
        payButtonFrame.size.height = ForIPhoneOrIPad(kMainPayButtonIPhoneLandscapeHeight, kMainPayButtonIPadLandscapeHeight);
    }
    else
    {
        funtLabelFrame.origin.y = ForIPhoneOrIPad(kMainFuntIPhoneY, kMainFuntIPadY);
        funtLabelFrame.origin.x = ForIPhoneOrIPad(funtLabelFrame.origin.x, kMainFuntIPadX);
        amountLabelFrame.origin.y = ForIPhoneOrIPad(kMainAmountIPhoneY, kMainAmountIPadY);
        amountTextFieldFrame.origin.y = ForIPhoneOrIPad(kMainAmountTextFieldIPhoneY, kMainAmountTextFieldIPadY);
        amountTextFieldFrame.size.width = ForIPhoneOrIPad(kMainAmountTextFieldIPhoneWidth, kMainAmountTextFieldIPadWidth);
        
        payButtonFrame.origin.y = ForIPhoneOrIPad(kMainPayButtonIPhoneY, kMainPayButtonIPadY);
        payButtonFrame.origin.x = (minWidthHeight - _payButton.width) / 2;
        payButtonFrame.size.width = ForIPhoneOrIPad(kMainPayButtonIPhoneWidth, kMainPayButtonIPadWidth);
        payButtonFrame.size.height = ForIPhoneOrIPad(kMainPayButtonIPhoneHeight, kMainPayButtonIPadHeight);
    }
    
    amountLabelFrame.origin.x = amountTextFieldFrame.origin.x = ForIPhoneOrIPad(amountTextFieldFrame.origin.x, funtLabelFrame.origin.x + amountFuntDiff);
    
    if(![XBTSettings sharedInstance].isIOS7)
    {
        funtLabelFrame.origin.y -= 20;
        amountLabelFrame.origin.y -= 20;
        amountTextFieldFrame.origin.y -= 20;
        payButtonFrame.origin.y -= 20;
    }
    
    _funtLabel.frame = funtLabelFrame;
    _amountLabel.frame = amountLabelFrame;
    _amountTextField.frame = amountTextFieldFrame;
    _payButton.frame = payButtonFrame;
}

- (NSNumberFormatter *)numberFormatterForAmmountTextField
{
    static NSNumberFormatter *numberFormatter = nil;
    if(!numberFormatter)
    {
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.locale = [XBTSettings sharedInstance].locale;
    }
    return numberFormatter;
}

- (NSNumberFormatter *)numberFormatterForGrouppingInAmmountTextField
{
    static NSNumberFormatter *numberFormatter = nil;
    if(!numberFormatter)
    {
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.groupingSize = 3;
        numberFormatter.usesGroupingSeparator = YES;
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.maximumFractionDigits = 2;
        numberFormatter.minimumFractionDigits = 2;
    }
    return numberFormatter;
}

- (void)pay
{
    NSNumber *amount = [self.numberFormatterForAmmountTextField numberFromString:_amountTextField.text];
    amount = @(roundToN(amount.floatValue, 2));
    if(amount.floatValue > 0.0f)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[XBTPaymentsManager sharedInstance] initPaymentWithAmount:amount deviceKey:[XBTSettings sharedInstance].deviceNumber completion:^(NSError *error, XBTPayment *payment) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if(!error)
            {
                [self performSegueWithIdentifier:kPaymentViewControllerSegueId sender:nil];
            }
            else
            {
                XBTErrorAlert(error.localizedDescription);
            }
            
        }];
    }
    else
    {
        [_amountTextField shake];
    }
}

- (NSString *)numbersStringFromAmountTextField
{
    return [[_amountTextField.text stringByReplacingOccurrencesOfString:@"," withString:@""] stringByReplacingOccurrencesOfString:@"." withString:@""];
}

- (void)updateAmountTextField
{
    NSString *candidateString = [self numbersStringFromAmountTextField];
    //0.00
    NSString *nullsString = @"";
    for(int i = 3; i > candidateString.length; i--)
    {
        nullsString = [nullsString stringByAppendingString:@"0"];
    }
    candidateString = [nullsString stringByAppendingString:candidateString];
    
    //00.01
    if(candidateString.length == 4)
    {
        if([candidateString rangeOfString:@"000"].location == 0 || [candidateString rangeOfString:@"00"].location == 0 || [candidateString rangeOfString:@"0"].location == 0)
        {
            candidateString = [candidateString substringFromIndex:1];
        }
    }
    
    double candidateNumber = [candidateString doubleValue] / 100;
    
    NSNumberFormatter *numberFormatter = [self numberFormatterForGrouppingInAmmountTextField];
    numberFormatter.groupingSeparator = [XBTSettings sharedInstance].thousandsSplit;
    numberFormatter.decimalSeparator = [XBTSettings sharedInstance].fractionalSplit;
    candidateString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:candidateNumber]];
    
    _amountTextField.text = candidateString;
}

#pragma mark - Actions

- (IBAction)payButtonPressed:(id)sender
{
    [self pay];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound && string.length)
    {
        return NO;
    }
    NSString *candidateString = [self numbersStringFromAmountTextField];;
    
    if(range.length == 0) //adding
    {
        candidateString = [candidateString stringByAppendingString:string];
    }
    else if(range.length == 1) //deleting
    {
        if(candidateString.length)
        {
            candidateString = [candidateString substringToIndex:candidateString.length - 1];
        }
    }
    
    textField.text = candidateString;
    [self updateAmountTextField];
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
