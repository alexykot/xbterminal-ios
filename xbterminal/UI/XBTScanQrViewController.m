//
//  XBTScanQrViewController.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 06.08.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "XBTScanQrViewController.h"
#import "ZBarReaderView.h"

@interface XBTScanQrViewController () <ZBarReaderViewDelegate>

@property (weak, nonatomic) IBOutlet ZBarReaderView *scanQrView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation XBTScanQrViewController

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
    
    [self setupScanQrView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _scanQrView.readerDelegate = self;
    [_scanQrView start];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _scanQrView.readerDelegate = nil;
    [_scanQrView stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

#pragma mark - Public

#pragma mark - Private

- (void)setupScanQrView
{
    
}

#pragma mark - Actions

- (IBAction)cancelButtonPressed:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ZBarReaderViewDelegate

- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    if(symbols.count)
    {
        NSString *text = nil;
        
        for(ZBarSymbol *symbol in symbols)
        {
            if(symbol.data.length)
            {
                text = symbol.data;
                break;
            }
        }
        
        if(text.length)
        {
            if([_delegate respondsToSelector:@selector(scanQrViewController:didScanText:)])
            {
                [_delegate scanQrViewController:self didScanText:text];
            }
        }
    }
}

@end
