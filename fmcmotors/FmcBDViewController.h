//
//  FmcBDViewController.h
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcBaseViewController.h"
#import "MBProgressHUD.h"

@interface FmcBDViewController : FmcBaseViewController<MBProgressHUDDelegate>{
    MBProgressHUD* HUD;
}
@property(nonatomic, strong) UIWebView* webView;
@property(nonatomic, strong) NSDictionary* user;
@property(nonatomic, strong) NSArray* bpmUsers;

@end
