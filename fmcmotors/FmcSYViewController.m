//
//  FmcSYViewController.m
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcSYViewController.h"
#import "AJGlobalUICommon.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "FmcSYNRViewController.h"
#import "MBProgressHUD.h"
#import "BaiduMobStat.h"

@interface FmcSYViewController ()

@end

@implementation FmcSYViewController
@synthesize notices;
@synthesize notice_date;
@synthesize notice_subject;
@synthesize showLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView{
    UIView* syView = [[UIView alloc] init];
    syView.backgroundColor = [UIColor whiteColor];
    self.view = syView;
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    NSURL* getMessageeUrl = [NSURL URLWithString:@"http://www.fmcmotors.com.cn/ios/getMessageGD.php"];
    ASIHTTPRequest* messageRequest = [ASIHTTPRequest requestWithURL:getMessageeUrl];
    [messageRequest setRequestMethod:@"POST"];
    [messageRequest setDidFinishSelector:@selector(requestSuccess:)];
    [messageRequest setDidFailSelector:@selector(requestError:)];
    FmcAppDelegate* fmcApp = [[UIApplication sharedApplication] delegate];
    [messageRequest setDownloadCache:fmcApp.fmcCache];
    [messageRequest setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [messageRequest setDelegate:self];
    [messageRequest startAsynchronous];
    
    UILabel* syTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 320, 44)];
    syTitle.text = @"最新公告";
    syTitle.textAlignment = NSTextAlignmentCenter;
    [syTitle setFont:[UIFont boldSystemFontOfSize:24]];
    syTitle.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:syTitle];
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 68, 320, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineView];
    
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 70)];
    
}

-(void)requestSuccess:(ASIHTTPRequest *)messageRequest{
    NSError *error;
    NSData* messageDate = [messageRequest responseData];
    NSArray* messages = [NSJSONSerialization JSONObjectWithData:messageDate options:NSJSONReadingMutableLeaves error:&error];
    NSMutableArray* nmMessages = [[NSMutableArray alloc] init];
    for (int i=0; i<messages.count; i++) {
        NSDictionary* message = [messages objectAtIndex:i];
        NSString* subject = [message objectForKey:@"subject"];
        [nmMessages addObject:subject];
        
    }
    NSTimer* timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:8.8 target:self selector:@selector(handleTime:) userInfo:nmMessages repeats:YES];
    showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 24)];
    UIView* paomaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 24)];
    showLabel.text = nmMessages[0];
    [paomaView addSubview:showLabel];
    CGRect frame = showLabel.frame;
    frame.origin.x = 320;
    showLabel.frame = frame;
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:8.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    frame = showLabel.frame;
    frame.origin.x = -320;
    showLabel.frame = frame;
    [UIView commitAnimations];
    showLabel.backgroundColor = [UIColor clearColor];
    paomaView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:paomaView];
}

-(void)requestError:(ASIHTTPRequest *)messageRequest{
    showLabel.text = @"暂时无法下载数据，请选择其他页面查看";
}

-(void) handleTime:(NSTimer*) timer{
    NSMutableArray* mess = timer.userInfo;
    static int i = 0;
    i++;
    showLabel.text = mess[i];
    if (i == mess.count-1) {
        i = 0;
        [timer invalidate];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	notices = [[NSArray alloc] init];
    NSURL* getNoticeUrl = [NSURL URLWithString:@"http://www.fmcmotors.com.cn/ios/getNotice.php"];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:getNoticeUrl];
    FmcAppDelegate* fmcApp = [[UIApplication sharedApplication] delegate];
    [request setDownloadCache:fmcApp.fmcCache];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
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
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    HUD.hidden = YES;
    NSString* responseString = [request responseString];
    notices = [responseString objectFromJSONString];
    [_tableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return notices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIndentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        UILabel* dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 25)];
        dateLabel.tag = dateTag;
        dateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:dateLabel];
        
        UILabel* subjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 10, 190, 25)];
        subjectLabel.tag = subjectTag;
        subjectLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        [cell.contentView addSubview:subjectLabel];
        
    }
    UILabel* dateLabel = (UILabel *)[cell viewWithTag:dateTag];
    [dateLabel setFont:[UIFont systemFontOfSize:fontSize]];
    NSDictionary* item = [notices objectAtIndex:indexPath.row];
    NSString* recDate = [item objectForKey:@"recdate"];
    dateLabel.text = recDate;
    
    UILabel* subjectLabel = (UILabel *)[cell viewWithTag:subjectTag];
    [subjectLabel setFont:[UIFont systemFontOfSize:fontSize]];
    NSString* subject = [item objectForKey:@"docsubject"];
    subjectLabel.text = subject;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FmcSYNRViewController* synrView = [[FmcSYNRViewController alloc] init];
    NSDictionary* item = [notices objectAtIndex:indexPath.row];
    synrView.notice = item;
    [self.navigationController pushViewController:synrView animated:YES];
    
}

-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSString* mName = @"首页公告--FmcSYViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

-(void) viewDidDisappear:(BOOL)animated{
    NSString* mName = @"首页公告--FmcSYViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}
@end
