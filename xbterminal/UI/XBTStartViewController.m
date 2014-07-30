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

@interface XBTStartViewController () <UIAlertViewDelegate>

@property (assign, nonatomic) BOOL isSettingsUpdated;

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
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Device key" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView textFieldAtIndex:0].text = [XBTSettings sharedInstance].deviceNumber;
    [alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)selfTapped:(id)sender
{
    if(_isSettingsUpdated)
    {
        [self.navigationController setViewControllers:@[[self.storyboard instantiateViewControllerWithIdentifier:kMainViewControllerId]] animated:YES];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [XBTSettings sharedInstance].deviceNumber = [alertView textFieldAtIndex:0].text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[XBTSettings sharedInstance] updateSettingsWithCompletion:^(NSError *error) {
       
        if(!error)
        {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            [self updateCopyrightLabel];
        }
        else
        {
            XBTErrorAlert(error.localizedDescription);
        }
        self.isSettingsUpdated = YES;
        
    }];
}

@end
