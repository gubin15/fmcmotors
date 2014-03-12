//
//  FmcLoginViewController.h
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcBaseViewController.h"
#import "MBProgressHUD.h"

@interface FmcLoginViewController : FmcBaseViewController<UITextFieldDelegate, UIAlertViewDelegate,MBProgressHUDDelegate>{
    MBProgressHUD* HUD;
}
@property(nonatomic, strong) UITextField* usernameField;
@property(nonatomic, strong) UITextField* passwordField;
@property(nonatomic, strong) NSArray* users;
@end
