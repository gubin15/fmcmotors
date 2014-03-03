//
//  FmcBDViewController.m
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcBDViewController.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "AJGlobalUICommon.h"
#import "ASIHTTPRequest.h"
#import "BaiduMobStat.h"

@interface FmcBDViewController ()

@end

@implementation FmcBDViewController
@synthesize webView;
@synthesize user;
@synthesize bpmUsers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIView* bdView = [[UIView alloc] init];
    bdView.backgroundColor = [UIColor whiteColor];
    self.view = bdView;
    NSString* username = [user objectForKey:@"username"];
    NSURL* getBmpUserUrl = [NSURL URLWithString:@"http://www.fmcmotors.com.cn/ios/getBpmUser.php"];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:getBmpUserUrl];
    [request setPostValue:username forKey:@"logonid"];
    [request setDelegate:self];
    [request startAsynchronous];
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    
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
    bpmUsers = [responseString objectFromJSONString];
    NSDictionary* bpmUser = [bpmUsers objectAtIndex:0];
    NSString* passwordTmp = [bpmUser objectForKey:@"pwd"];
    NSString* logonidStr = [bpmUser objectForKey:@"logonid"];
    ASIFormDataRequest *formDataRequest = [ASIFormDataRequest requestWithURL:nil];
    NSString* passwordStr = [formDataRequest encodeURL:passwordTmp];
    
    webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    [webView setFrame:CGRectMake(0.0f, 0.0f, ScreenWidth, ScreenHeight)];
    NSString* loadUrlStr = [[NSString alloc] initWithFormat:@"http://www.fmcmotors.com.cn/bpmflow/SignOn.aspx?id=%@&pwd=%@&url=http://www.fmcmotors.com.cn/bpmflow/content/flow_Mobile.aspx",logonidStr,passwordStr];
    NSURL* bdUrl = [NSURL URLWithString:loadUrlStr];
    [webView loadRequest:[NSURLRequest requestWithURL:bdUrl]];
    [self.view addSubview:webView];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    UIAlertView* userErrorAlert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                            message:@"使用人数过多，请稍后再试"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
    [userErrorAlert show];
}

-(void)goBack
{
    [webView goBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSString* mName = @"电子表单--FmcBDViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

-(void) viewDidDisappear:(BOOL)animated{
    NSString* mName = @"电子表单--FmcBDViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}


@end
