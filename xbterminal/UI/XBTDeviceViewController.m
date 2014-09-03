//
//  XBTDeviceViewController.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 05.08.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTDeviceViewController.h"
#import "MBProgressHUD.h"

@interface XBTDeviceViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *linkDeviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *haveAccountLabel;
@property (weak, nonatomic) IBOutlet UILabel *orLabel;
@property (weak, nonatomic) IBOutlet UITextField *keyTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *createAccountButton;
@property (weak, nonatomic) IBOutlet UIButton *scanQrButton;

@end

@implementation XBTDeviceViewController

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
    
    [self setup];
    
    [self reloadData];
    
    _linkDeviceLabel.text = NSLocalizedString(@"Link device to account", nil);
    _haveAccountLabel.text = [NSLocalizedString(@"Have account?", nil) stringByAppendingFormat:@"\n%@", NSLocalizedString(@"Paste key or scan QR code", nil)];
    _orLabel.text = NSLocalizedString(@"or", nil);
    [_doneButton setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
- (void)setup
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.logoView.hidden = self.testnetLabel.hidden = self.copyrightLabel.hidden = YES;
    
    NSAttributedString *underlinedCreateAccountTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Create account online", nil) attributes:@{NSForegroundColorAttributeName: self.createAccountButton.titleLabel.textColor, NSFontAttributeName: self.createAccountButton.titleLabel.font, NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}];
    [self.createAccountButton setAttributedTitle:underlinedCreateAccountTitle forState:UIControlStateNormal];
}

#pragma mark - Public

- (void)setDeviceNumber:(NSString *)deviceNumber
{
    _keyTextField.text = deviceNumber;
}

- (NSString *)deviceNumber
{
    return _keyTextField.text;
}

#pragma mark - Private

- (void)reloadData
{
    self.keyTextField.text = [XBTSettings sharedInstance].deviceNumber;
}

#pragma mark - Actions

- (IBAction)doneButtonPressed:(id)sender
{
    [self.keyTextField resignFirstResponder];
    [XBTSettings sharedInstance].deviceNumber = self.keyTextField.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[XBTSettings sharedInstance] updateSettingsWithCompletion:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if(!error)
        {
            if([_delegate respondsToSelector:@selector(deviceNumberRightInDeviceViewController:)])
            {
                [_delegate deviceNumberRightInDeviceViewController:self];
            }
        }
        else
        {
            XBTErrorAlert(error.localizedDescription);
        }
        
    }];
}

- (IBAction)createAccountButtonPressed:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kRegistrationUrlString]];
}

- (IBAction)scanQrButtonPressed:(id)sender
{
    if([_delegate respondsToSelector:@selector(scanQrButtonPressedInDeviceViewController:)])
    {
        [_delegate scanQrButtonPressedInDeviceViewController:self];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
