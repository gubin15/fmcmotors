//
//  AJGlobalUICommon.m
//  WXMovie
//
//  Created by xiongbiao on 12-12-11.
//  Copyright (c) 2012年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "AJGlobalUICommon.h"

const CGFloat AJkDefaultRowHeight = 44;

const CGFloat AJkDefaultPortraitToolbarHeight   = 44;
const CGFloat AJkDefaultLandscapeToolbarHeight  = 33;

const CGFloat AJkDefaultPortraitKeyboardHeight      = 216;
const CGFloat AJkDefaultLandscapeKeyboardHeight     = 160;
const CGFloat AJkDefaultPadPortraitKeyboardHeight   = 264;
const CGFloat AJkDefaultPadLandscapeKeyboardHeight  = 352;

const CGFloat AJkGroupedTableCellInset = 9;
const CGFloat AJkGroupedPadTableCellInset = 42;

const CGFloat AJkDefaulAJransitionDuration      = 0.3;
const CGFloat AJkDefaultFasAJransitionDuration  = 0.2;
const CGFloat AJkDefaultFlipTransitionDuration  = 0.7;



///////////////////////////////////////////////////////////////////////////////////////////////////
float AJOSVersion()
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL AJOSVersionIsAtLeast(float version)
{
    static const CGFloat kEpsilon = 0.0000001;
#ifdef __IPHONE_6_0
    return 6.0 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_5_1
    return 5.1 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_5_0
    return 5.0 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_4_2
    return 4.2 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_4_1
    return 4.1 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_4_0
    return 4.0 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_3_2
    return 3.2 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_3_1
    return 3.1 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_3_0
    return 3.0 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_2_2
    return 2.2 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_2_1
    return 2.1 - version >= -kEpsilon;
#endif
#ifdef __IPHONE_2_0
    return 2.0 - version >= -kEpsilon;
#endif
    return NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL AJIsKeyboardVisible() {
    // Operates on the assumption that the keyboard is visible if and only if there is a first
    // responder; i.e. a control responding to key events
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    return ![window isFirstResponder];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL AJIsPhoneSupported() {
    NSString* deviceType = [UIDevice currentDevice].model;
    return [deviceType isEqualToString:@"iPhone"];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL AJIsPad() {
#ifdef __IPHONE_3_2
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#else
    return NO;
#endif
}


///////////////////////////////////////////////////////////////////////////////////////////////////
UIDeviceOrientation AJDeviceOrientation() {
    UIDeviceOrientation orient = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationUnknown == orient) {
        return UIDeviceOrientationPortrait;
        
    } else {
        return orient;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL AJIsSupportedOrientation(UIInterfaceOrientation orientation) {
    if (AJIsPad()) {
        return YES;
        
    } else {
        switch (orientation) {
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
                return YES;
            default:
                return NO;
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGAffineTransform AJRotateTransformForOrientation(UIInterfaceOrientation orientation) {
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
        
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2);
        
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
        
    } else {
        return CGAffineTransformIdentity;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////

CGRect AJApplicationBounds()
{
    return [UIScreen mainScreen].bounds;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
CGRect AJApplicationFrame() {
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    return CGRectMake(0, 0, frame.size.width, frame.size.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGFloat AJToolbarHeightForOrientation(UIInterfaceOrientation orientation) {
    if (UIInterfaceOrientationIsPortrait(orientation) || AJIsPad()) {
        return AJ_ROW_HEIGHT;
        
    } else {
        return AJ_LANDSCAPE_TOOLBAR_HEIGHT;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGFloat AJKeyboardHeightForOrientation(UIInterfaceOrientation orientation) {
    if (AJIsPad()) {
        return UIInterfaceOrientationIsPortrait(orientation) ? AJ_IPAD_KEYBOARD_HEIGHT
        : AJ_IPAD_LANDSCAPE_KEYBOARD_HEIGHT;
        
    } else {
        return UIInterfaceOrientationIsPortrait(orientation) ? AJ_KEYBOARD_HEIGHT
        : AJ_LANDSCAPE_KEYBOARD_HEIGHT;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
CGFloat AJGroupedTableCellInset() {
    return AJIsPad() ? AJkGroupedPadTableCellInset : AJkGroupedTableCellInset;
}


