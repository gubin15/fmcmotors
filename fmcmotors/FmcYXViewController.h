//
//  FmcYXViewController.h
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcBaseViewController.h"
#import "MBProgressHUD.h"

#define idTag          1
#define subjectTag     2
#define dateTag        3

#define fontSize       16

@interface FmcYXViewController : FmcBaseViewController<UITableViewDataSource, UITableViewDelegate,MBProgressHUDDelegate>{
    UITableView* _tableView;
    MBProgressHUD* HUD;
}
@property(nonatomic, strong) NSArray*  listMails;
@property(nonatomic, strong) NSString* mail_title;
@property(nonatomic, strong) NSString* mail_id;
@property(nonatomic, strong) NSString* mail_subject;
@property(nonatomic, strong) NSString* mail_date;
@property(nonatomic, strong) NSDictionary* user;

@end
