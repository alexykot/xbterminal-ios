//
//  XBTSettings+Definitions.h
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 07.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

// TYPEDEFS

// MACROSES
#define UIColorRGBA(r, g, b, alpha) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(alpha)]
#define UIColorRGB(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define UIColorRGBHex(hex) [UIColor colorWithRGBHex:(hex)]
#define UIColorRGBAHex(hex, alpha) [UIColor colorWithRGBHex:(hex) alpha:(alpha)]

#define ForIPhoneOrIPad(forIPhone, forIPad) ([XBTSettings sharedInstance].isIPhone ? (forIPhone) : (forIPad))

#define SafeValue(val) ([val isEqual:[NSNull null]] ? nil : val)

#define XBTAlert(TITLE, MSG) [[[UIAlertView alloc] initWithTitle:(TITLE) \
                                                         message:(MSG) \
                                                        delegate:nil \
                                               cancelButtonTitle:@"OK" \
                                               otherButtonTitles:nil] show]
#define XBTErrorAlert(MSG) XBTAlert(@"Error", (MSG))
#define XBTSuccessAlert(MSG) XBTAlert(nil, (MSG))

// CONSTANS
#define kBaseUrlString @"https://xbterminal.io/"
#define kCheckPaymentTimeInterval 1.0
#define kRegistrationUrlString @"https://xbterminal.io/registration/"

// UI CONSTANS
// VIEW CONROLLER
#define kLogoIPhoneY 25.0f
#define kLogoIPhoneWidth 152.0f
#define kLogoIPhoneHeight 33.0f

#define kLogoIPadY 75.0f
#define kLogoIPadWidth 295.0f
#define kLogoIPadHeight 64.0f

#define kTestnetIPhoneY 65.0f
#define kTestnetIPhoneHeight 21.0f
#define kTestnetIPhoneFontSize 11.0f

#define kTestnetIPadY 160.0f
#define kTestnetIPadFontSize 20.0f

#define kCopyrightFontSize 11.0f
#define kCopyrightIPhoneBottomOffset 10.0f
#define kCopyrightIPhoneHeight 41.0f

// START CONTROLLER
#define kStartLogoIPhoneY 160.0f
#define kStartLogoIPhoneLandscapeY 75.0f

#define kStartLogoIPadY 315.0f
#define kStartLogoIPadLandscapeY 230.0f

#define kStartTapIPhoneY 305.0f
#define kStartTapIPhoneLandscapeY 185.0f

#define kStartTapIPadY 600.0f
#define kStartTapIPadLandscapeY 470.0f

// MAIN CONTROLLER
#define kMainFuntIPhoneY 165.0f
#define kMainFuntIPhoneLandscapeY 115.0f

#define kMainFuntIPadY 365.0f
#define kMainFuntIPadLandscapeY 275.0f

#define kMainFuntIPadX 70.0f
#define kMainFuntIPadLandscapeX 50.0f

#define kMainAmountIPhoneY 135.0f
#define kMainAmountIPhoneLandscapeY 85.0f

#define kMainAmountIPadY 320.0f
#define kMainAmountIPadLandscapeY 230.0f

#define kMainAmountTextFieldIPhoneY 155.0f
#define kMainAmountTextFieldIPhoneLandscapeY 105.0f

#define kMainAmountTextFieldIPadY 350.0f
#define kMainAmountTextFieldIPadLandscapeY 260.0f

#define kMainAmountTextFieldIPhoneWidth 240.0f
#define kMainAmountTextFieldIPhoneLandscapeWidth 325.0f

#define kMainAmountTextFieldIPadWidth 540.0f
#define kMainAmountTextFieldIPadLandscapeWidth 605.0f

#define kMainPayButtonIPhoneY 230.0f
#define kMainPayButtonIPhoneLandscapeY 105.0f

#define kMainPayButtonIPadY 491.0f
#define kMainPayButtonIPadLandscapeY 268.0f

#define kMainPayButtonIPhoneLandscapeX 385.0f

#define kMainPayButtonIPadLandscapeX 725.0f

#define kMainPayButtonIPhoneWidth 175.0f
#define kMainPayButtonIPhoneLandscapeWidth 160.0f

#define kMainPayButtonIPadWidth 327.0f
#define kMainPayButtonIPadLandscapeWidth 250.0f

#define kMainPayButtonIPhoneHeight 40.0f
#define kMainPayButtonIPhoneLandscapeHeight 45.0f

#define kMainPayButtonIPadHeight 60.0f
#define kMainPayButtonIPadLandscapeHeight 71.0f

// PAYMENT CONTROLLER
#define kPaymentQrIPhoneLandscapeX 46.0f

#define kPaymentQrIPadLandscapeX 56.0f

#define kPaymentQrIPhoneY 215.0f
#define kPaymentQrIPhoneLandscapeY 99.0f

#define kPaymentQrIPadY 417.0f
#define kPaymentQrIPadLandscapeY 245.0f

#define kPaymentQrIPhoneWidthHeight 190.0f
#define kPaymentQrIPhoneLandscapeWidthHeight 170.0f

#define kPaymentQrIPadWidthHeight 362.0f
#define kPaymentQrIPadLandscapeWidthHeight 385.0f

#define kPaymentCurrencyIPhoneX 25.0f
#define kPaymentCurrencyIPhoneLandscapeX 240.0f

#define kPaymentCurrencyIPadX 90.0f
#define kPaymentCurrencyIPadLandscapeX 490.0f

#define kPaymentCurrencyIPadWidth 588.0f
#define kPaymentCurrencyIPadLandscapeWidth 490.0f

#define kPaymentButtonIPhoneLandscapeX 300.0f

#define kPaymentButtonIPadLandscapeX 580.0f

#define kPaymentButtonIPhoneY 455.0f
#define kPaymentButtonIPhoneLandscapeY 215.0f

#define kPaymentButtonIPadY 864.0f
#define kPaymentButtonIPadLandscapeY 540.0f

// SUCCESSFUL CONTROLLER
#define kSuccessfulQrIPhoneY 265.0f

#define kSuccessfulQrIPadY 490.0f
#define kSuccessfulQrIPadLandscapeY 245.0f

#define kSuccessfulQrIPhoneWidthHeight 132.0f

#define kSuccessfulQrIPadWidthHeight 250.0f
#define kSuccessfulQrIPadLandscapeWidthHeight 390.0f

#define kSuccessfulLabelIPhoneX 20.0f
#define kSuccessfulLabelIPhoneLandscapeX 260.0f

#define kSuccessfulLabelIPadX 90.0f
#define kSuccessfulLabelIPadLandscapeX 465.0f

#define kSuccessfulScanQrCodeIPhoneX 83.0f

#define kSuccessfulScanQrCodeIPadX 90.0f

#define kSuccessfulScanQrCodeIPhoneWidth 154.0f
#define kSuccessfulScanQrCodeIPhoneLandscapeWidth 280.0f

#define kSuccessfulScanQrCodeIPadWidth 588.0f
#define kSuccessfulScanQrCodeIPadLandscapeWidth 588.0f

#define kSuccessfulScanQrCodeIPhoneY 190.0f
#define kSuccessfulScanQrCodeIPhoneLandscapeY 155.0f

#define kSuccessfulScanQrCodeIPadY 360.0f
#define kSuccessfulScanQrCodeIPadLandscapeY 395.0f

#define kSuccessfulCloseIPhoneY 461.0f
#define kSuccessfulCloseIPhoneLandscapeY 210.0f

#define kSuccessfulCloseIPadY 857.0f
#define kSuccessfulCloseIPadLandscapeY 535.0f

// DEVICE CONTROLLER
#define kDeviceIPhoneWidth 266.0f
#define kDeviceIPhoneHeight 281.0f

#define kDeviceIPadWidth 480.0f
#define kDeviceIPadHeight 508.0f

// COLORS
#define kColorBgHEX 0xe6e6e6
#define kColorTestnetHEX 0xa61212
#define kColorTextFieldBorderHEX 0xbfbfbf