//
//  FmcYJViewController.h
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcBaseViewController.h"

@interface FmcYJViewController : FmcBaseViewController<UITextViewDelegate,UIAlertViewDelegate>
@property(nonatomic, strong) NSDictionary* user;
@property(nonatomic, strong) UITextView* tv;
@property(nonatomic) BOOL isEmpty;

@end
