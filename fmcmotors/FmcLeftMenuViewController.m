//
//  FmcLeftMenuViewController.m
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcLeftMenuViewController.h"
#import "FmcBDViewController.h"
#import "FmcYXViewController.h"
#import "FmcXSViewController.h"
#import "FmcYJViewController.h"
#import "FmcGDViewController.h"
#import "FmcSYViewController.h"
#import "FmcYXTWViewController.h"
#import "FmcCLOUDViewController.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "BaiduMobStat.h"

@interface FmcLeftMenuViewController ()

@end

@implementation FmcLeftMenuViewController
@synthesize listMenu;
@synthesize listMenuImage;
@synthesize user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIView* leftMenuView = [[UIView alloc] init];
    leftMenuView.backgroundColor = [UIColor colorWithRed:43/255 green:43/255 blue:43/255 alpha:1];
    self.view = leftMenuView;
    listMenu = @[@"首页公告", @"电子表单", @"WEB邮箱", @"行事历", @"意见建议", @"台湾邮箱", @"FMC Cloud", @"更多内容"];
    listMenuImage = @[@"sy_40x40_sel.png", @"bd_40x40_sel.png", @"yx_40x40_sel.png", @"xs_40x40_sel.png", @"yj_40x40_sel.png", @"yx_40x40_sel.png", @"cloud_40x40_sel.png", @"gd_40x40_sel.png"];
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listMenu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIndentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.textLabel.text = listMenu[indexPath.row];
        
        UIImage* image = [UIImage imageNamed:listMenuImage[indexPath.row]];
        cell.imageView.image = image;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FmcBDViewController* bdView = [[FmcBDViewController alloc] init];
    FmcYXViewController* yxView = [[FmcYXViewController alloc] init];
    FmcYJViewController* yjView = [[FmcYJViewController alloc] init];
    switch (indexPath.row) {
        case 0:
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[FmcSYViewController alloc] init]];
            break;
            
        case 1:
            bdView.user = user;
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:bdView];
            break;
            
        case 2:
            yxView.user = user;
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:yxView];
            break;
            
        case 3:
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[FmcXSViewController alloc] init]];
            break;
            
        case 4:
            yjView.user = user;
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:yjView];
            break;
            
        case 5:
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[FmcYXTWViewController alloc] init]];
            break;
            
        case 6:
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[FmcCLOUDViewController alloc] init]];
            break;
            
        case 7:
            self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[FmcGDViewController alloc] init]];
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSString* mName = @"左侧按钮--FmcLeftMenu2ViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

-(void) viewDidDisappear:(BOOL)animated{
    NSString* mName = @"左侧按钮--FmcLeftMenu2ViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

@end
