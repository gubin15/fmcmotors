//
//  FmcYXViewController.m
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcYXViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "FmcYXNRViewController.h"
#import "GTMBase64.h"
#import "BaiduMobStat.h"

@interface FmcYXViewController ()

@end

@implementation FmcYXViewController
@synthesize listMails;
@synthesize mail_title;
@synthesize mail_id;
@synthesize mail_date;
@synthesize mail_subject;
@synthesize user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView{
    UIView* yxView = [[UIView alloc] init];
    yxView.backgroundColor = [UIColor whiteColor];
    self.view = yxView;
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	listMails = [[NSArray alloc] init];
    NSString* username = [user objectForKey:@"username"];
    NSURL* getListMailUrl = [NSURL URLWithString:@"http://mail.30888.com.cn/android/getMailList2.php"];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:getListMailUrl];
    FmcAppDelegate* fmcApp = [[UIApplication sharedApplication] delegate];
    [request setDownloadCache:fmcApp.fmcCache];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setPostValue:username forKey:@"username"];
    [request setDelegate:self];
    [request startAsynchronous];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate =  self;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.animationType=MBProgressHUDAnimationZoom;
    HUD.labelText = @"加载中...";
    HUD.alpha = 0.9f;
    [HUD show:YES];
    [self.view addSubview:HUD];
    UILabel* syTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    NSString* sjx = [@"收件箱：" stringByAppendingString: username];
    syTitle.text = sjx;
    syTitle.textAlignment = NSTextAlignmentCenter;
    [syTitle setFont:[UIFont boldSystemFontOfSize:24]];
    syTitle.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:syTitle];
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView];
    
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 45)];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    HUD.hidden = YES;
    NSString* responseString = [request responseString];
    listMails = [responseString objectFromJSONString];
    [_tableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listMails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIndentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        UILabel* idLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 30, 25)];
        idLabel.tag = idTag;
        idLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:idLabel];
        
        UILabel* subjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, 160, 25)];
        subjectLabel.tag = subjectTag;
        subjectLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:subjectLabel];
        
        UILabel* dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 10, 190, 25)];
        dateLabel.tag = dateTag;
        dateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:dateLabel];
        
    }
    NSDictionary* item = [listMails objectAtIndex:indexPath.row];
    
    UILabel* idLabel = (UILabel *)[cell viewWithTag:idTag];
    [idLabel setFont:[UIFont systemFontOfSize:fontSize]];
    NSString* mId = [[NSString alloc] initWithData:[GTMBase64 decodeString:[item objectForKey:@"mailId"]]
                                          encoding:NSUTF8StringEncoding];
    idLabel.text = mId;
    
    UILabel* subjectLabel = (UILabel *)[cell viewWithTag:subjectTag];
    [subjectLabel setFont:[UIFont systemFontOfSize:fontSize]];
    NSString* mSubject = [[NSString alloc] initWithData:[GTMBase64 decodeString:[item objectForKey:@"mailSubject"]]
                                               encoding:NSUTF8StringEncoding];
    
    subjectLabel.text = mSubject;
    
    UILabel* dateLabel = (UILabel *)[cell viewWithTag:dateTag];
    [dateLabel setFont:[UIFont systemFontOfSize:fontSize]];
    NSString* mDate = [[NSString alloc] initWithData:[GTMBase64 decodeString:[item objectForKey:@"mailDate"]]
                                            encoding:NSUTF8StringEncoding];
    dateLabel.text = mDate;
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FmcYXNRViewController* yxnrView = [[FmcYXNRViewController alloc] init];
    NSDictionary* item = [listMails objectAtIndex:indexPath.row];
    yxnrView.mail = item;
    yxnrView.user = user;
    [self.navigationController pushViewController:yxnrView animated:YES];
    
}

-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSString* mName = @"大陆邮箱--FmcYXViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

-(void) viewDidDisappear:(BOOL)animated{
    NSString* mName = @"大陆邮箱--FmcYXViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}


@end
