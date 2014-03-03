//
//  FmcYXNRViewController.h
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcBaseViewController.h"
#define titleTag           1

@interface FmcYXNRViewController : FmcBaseViewController<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView* scrollView;
@property(nonatomic, strong) UIWebView* webView;
@property(nonatomic, strong) NSDictionary* user;
@property(nonatomic, strong) NSDictionary* mail;
@property(nonatomic, strong) NSDictionary*  mails;
@property(nonatomic, strong) NSString* mMailsFrom;
@property(nonatomic, strong) NSString* mMailsTo;
@property(nonatomic, strong) NSString* mMailsSubject;
@property(nonatomic, strong) NSString* mMailsContent;

@end
