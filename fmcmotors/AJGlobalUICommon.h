//
//  AJGlobalUICommon.h
//  WXMovie
//
//  Created by xiongbiao on 12-12-11.
//  Copyright (c) 2012年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AJ_ROW_HEIGHT                 AJkDefaultRowHeight
#define AJ_TOOLBAR_HEIGHT             AJkDefaultPortraitToolbarHeight
#define AJ_LANDSCAPE_TOOLBAR_HEIGHT   AJkDefaultLandscapeToolbarHeight

#define AJ_KEYBOARD_HEIGHT                 AJkDefaultPortraitKeyboardHeight
#define AJ_LANDSCAPE_KEYBOARD_HEIGHT       AJkDefaultLandscapeKeyboardHeight
#define AJ_IPAD_KEYBOARD_HEIGHT            AJkDefaultPadPortraitKeyboardHeight
#define AJ_IPAD_LANDSCAPE_KEYBOARD_HEIGHT  AJkDefaultPadLandscapeKeyboardHeight

#define STATEBAR_HEIGHT 20             //状态栏高度
#define TABBAR_HEIGHT 49               //自定义TABBAR高度
#define TABBAR_TAP_BUTTON_WIDTH   64   //tabbar按钮的高度
#define ScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define NAV_BAR_HEIGHT        44              //导航栏高度
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]    //自定义颜色宏





//安全释放对象
#define RELEASE_SAFELY(__POINTER) { if(__POINTER){[__POINTER release]; __POINTER = nil; }}

/**
 * @返回当前iPhone OS 运行的版本
 */
float AJOSVersion();

/**
 *
 */
BOOL AJOSVersionIsAtLeast(float version);

/**
 * @返回YES 键盘是可视化的
 */
BOOL AJIsKeyboardVisible();

/**
 * @返回YES，设备支持iPhone
 */
BOOL AJIsPhoneSupported();

/**
 * @返回YES，设备是iPad
 */
BOOL AJIsPad();

/**
 * @返回当前设备方向
 */
UIDeviceOrientation AJDeviceOrientation();

/**
 * 在iPhone/iPad touch上
 * 检查如果屏幕是portrait, landscape left, or landscape right.
 * 这个方法帮你忽略home按钮朝上的方向
 *
 * 在iPad上，一直返回YES
 */
BOOL AJIsSupportedOrientation(UIInterfaceOrientation orientation);

/**
 * @指定方法返回旋转的transform
 */
CGAffineTransform AJRotateTransformForOrientation(UIInterfaceOrientation orientation);

/**
 * @返回应用程序物理屏幕大小
 *
 */
CGRect AJApplicationBounds();
/**
 * @返回应用程序去掉状态栏高度的大小
 *
 */
CGRect AJApplicationFrame();

/**
 * @返回指定方向toolBar的高度
 *
 */
CGFloat AJToolbarHeightForOrientation(UIInterfaceOrientation orientation);

/**
 * @ 返回指定方向的键盘的高度
 */
CGFloat AJKeyboardHeightForOrientation(UIInterfaceOrientation orientation);

/**
 * @ 返回分组表格视图cell与屏幕之间的间距，iPad的间距会更大
 */
CGFloat AJGroupedTableCellInset();

///////////////////////////////////////////////////////////////////////////////////////////////////
// Dimensions of common iPhone OS Views

/**
 * 标准的tableview行高
 * @const 44 pixels
 */
extern const CGFloat AJkDefaultRowHeight;

/**
 * 标准的toolBar竖屏的高度The standard height of a toolbar in portrait orientation.
 * @const 44 pixels
 */
extern const CGFloat AJkDefaultPortraitToolbarHeight;

/**
 * 标准的toolBar横屏的高度
 * @const 33 pixels
 */
extern const CGFloat AJkDefaultLandscapeToolbarHeight;

/**
 * 标准的键盘竖屏的高度
 * @const 216 pixels
 */
extern const CGFloat AJkDefaultPortraitKeyboardHeight;

/**
 * 标准的键盘横屏的高度
 * @const 160 pixels
 */
extern const CGFloat AJkDefaultLandscapeKeyboardHeight;

/**
 * 分组的表格视图cell边界与屏幕的间距
 * @const 10 pixels
 */
extern const CGFloat AJkGroupedTableCellInset;
