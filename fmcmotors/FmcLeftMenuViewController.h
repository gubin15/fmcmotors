//
//  FmcLeftMenuViewController.h
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcBaseViewController.h"

@interface FmcLeftMenuViewController : FmcBaseViewController<UITableViewDelegate, UITableViewDataSource>{
    UITableView* _tableView;
}
@property(nonatomic, strong) NSArray* listMenu;
@property(nonatomic, strong) NSArray* listMenuImage;
@property(nonatomic, strong) NSDictionary* user;

@end
