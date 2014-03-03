//
//  FmcSYViewController.h
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcBaseViewController.h"
#import "MBProgressHUD.h"

#define dateTag        3
#define subjectTag     2
#define fontSize       16

@interface FmcSYViewController : FmcBaseViewController<UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>{
    UITableView* _tableView;
    MBProgressHUD* HUD;
}
@property(nonatomic, strong) NSArray* notices;
@property(nonatomic, strong) NSString* notice_date;
@property(nonatomic, strong) NSString* notice_subject;
@property(nonatomic, strong) UILabel* showLabel;

@end
