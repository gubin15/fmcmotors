//
//  FmcXSNRViewController.h
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcBaseViewController.h"

@interface FmcXSNRViewController : FmcBaseViewController<UIAlertViewDelegate>

@property(nonatomic, strong) UIScrollView* scrollView;
@property(nonatomic, strong) NSArray* dateSplit;
@property(nonatomic, strong) NSString* calendarDate;
@property(nonatomic, strong) NSArray* calendarList;

@end
