//
//  FmcCLOUDViewController.m
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcCLOUDViewController.h"
#import "BaiduMobStat.h"

@interface FmcCLOUDViewController ()

@end

@implementation FmcCLOUDViewController
@synthesize webView;
@synthesize scrollView;

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
	UIView* cloudView = [[UIView alloc] init];
    cloudView.backgroundColor = [UIColor whiteColor];
    self.view = cloudView;
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    scrollView.contentSize = CGSizeMake(ScreenWidth,1500);
    [self.view addSubview:scrollView];
    webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [webView setFrame:CGRectMake(0.0f, 0.0f, ScreenWidth, ScreenHeight)];
    NSString* loadUrlStr = @"http://cloud.30888.com.tw/index.php";
    NSURL* bdUrl = [NSURL URLWithString:loadUrlStr];
    [webView loadRequest:[NSURLRequest requestWithURL:bdUrl]];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    [scrollView addSubview:webView];
    
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

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    HUD.hidden = YES;
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

-(void)goBack
{
    [webView goBack];
}

-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSString* mName = @"台湾云服务--FmcCLOUDViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

-(void) viewDidDisappear:(BOOL)animated{
    NSString* mName = @"台湾云服务--FmcCLOUDViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}


@end
