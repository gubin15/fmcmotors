//
//  FmcSYNRViewController.h
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcBaseViewController.h"

@interface FmcSYNRViewController : FmcBaseViewController<UIScrollViewDelegate>
@property NSDictionary* notice;
@property UIScrollView* scrollView;
@property UIWebView* webView;
@property NSArray* attachs;
@property UIProgressView* progressView;

@end
