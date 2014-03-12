//
//  FmcYXTWViewController.h
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcBaseViewController.h"
#import "MBProgressHUD.h"

@interface FmcYXTWViewController : FmcBaseViewController<MBProgressHUDDelegate,UIWebViewDelegate>{
    MBProgressHUD* HUD;
}
@property(nonatomic, strong) UIWebView* webView;
@property(nonatomic, strong) UIScrollView* scrollView;

@end
