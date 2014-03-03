//
//  FmcXSViewController.h
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcBaseViewController.h"
#import "VRGCalendarView.h"

@interface FmcXSViewController : FmcBaseViewController<VRGCalendarViewDelegate>
@property(nonatomic, strong) NSArray* dateSplit;
@property(nonatomic, strong) NSArray* mCalendars;
@property(nonatomic, strong) NSString* strDate;

@end
