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
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "BadgeLabel.h"
#import "BadgeTableViewCell.h"


@interface FmcLeftMenuViewController (){
    NSMutableArray *cells;
}

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
    listMenuImage = @[@"sy_40x40_sel.png", @"bd_40x40_sel.png", @"yx_40x40_sel.png", @"xs_40x40_sel.png", @"yj_40x40_sel.png", @"yx_40x40_sel.png", @"cloud_40x40_sel.png", @"gd_40x40_sel.png"];
    listMenu = @[@"首页公告", @"电子表单", @"WEB邮箱", @"行事历", @"意见建议", @"台湾邮箱", @"FMC Cloud", @"更多内容"];
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_tableView];
    
    [self initCells];
    
}


#pragma mark - Table View




- (void)initCells
{
    FmcAppDelegate* fmcApp = [[UIApplication sharedApplication] delegate];

    int listNumber[] = {0, fmcApp.bdCount, 0, 0, 0, 0, 0, 0};
    cells = [[NSMutableArray alloc] initWithCapacity:listMenu.count];
    BadgeTableViewCell *cell;
    for (int i = 0; i < listMenu.count; ++i) {
        cell = [[BadgeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text = listMenu[i];
        UIImage* image = [UIImage imageNamed:listMenuImage[i]];
        cell.imageView.image = image;
        cell.badgeNumber = listNumber[i];
        [cells addObject:cell];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [cells objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BadgeTableViewCell *cell = [cells objectAtIndex:indexPath.row];
    UIColor *cellBadgeColor = cell.badge.backgroundColor;
    [UIView animateWithDuration:0.5
                     animations:^{ cell.badge.backgroundColor = [UIColor orangeColor]; }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.5
                                          animations:^{ cell.badge.backgroundColor = cellBadgeColor; }
                                          completion:^(BOOL finished){
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
                          ];
                     }
     ];
}

-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSString* mName = @"左侧按钮--FmcLeftMenuViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

-(void) viewDidDisappear:(BOOL)animated{
    NSString* mName = @"左侧按钮--FmcLeftMenuViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

@end
