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
    
    _qrImageView.image = payment.qrImage;
}

#pragma mark - Actions

- (IBAction)closeButtonPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
