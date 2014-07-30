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
}

- (void)viewWillAppear:(BOOL)animated
{
    _amountTextField.text = @"0.00";
    [_amountTextField becomeFirstResponder];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

#pragma mark - Private

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
    NSString *candidateString = [[textField.text stringByReplacingOccurrencesOfString:@"," withString:@""] stringByReplacingOccurrencesOfString:@"." withString:@""];
    
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
    
    NSUInteger indexToSubstring = candidateString.length - 2;
    candidateString = [NSString stringWithFormat:@"%@.%@", [candidateString substringToIndex:indexToSubstring], [candidateString substringFromIndex:indexToSubstring]];
    
    textField.text = candidateString;
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
