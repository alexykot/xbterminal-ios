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

#define ForIPhoneOrIPad(forIPhone, forIPad) ([XBTSettings sharedInstance].isIPhone ? forIPhone : forIPad)

#define SafeValue(val) ([val isEqual:[NSNull null]] ? nil : val)

#define XBTAlert(TITLE, MSG) [[[UIAlertView alloc] initWithTitle:(TITLE) \
                                                         message:(MSG) \
                                                        delegate:nil \
                                               cancelButtonTitle:@"OK" \
                                               otherButtonTitles:nil] show]
#define XBTErrorAlert(MSG) XBTAlert(@"Error", (MSG))
#define XBTSuccessAlert(MSG) XBTAlert(nil, (MSG))

// CONSTANS
#define kBaseUrlString @"http://stage.xbterminal.com/"
#define kDefaultDeviceNumber @"e676348c42cb4701870f69dbe79108d9"
#define kCheckPaymentTimeInterval 1.0

// UI CONSTANS
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

#define kColorBgHEX 0xe6e6e6
#define kColorTestnetHEX 0xa61212
#define kColorTextFieldBorderHEX 0xbfbfbf