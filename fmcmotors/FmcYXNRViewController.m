//
//  FmcYXNRViewController.m
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcYXNRViewController.h"
#import "AJGlobalUICommon.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "BaiduMobStat.h"
#import "GTMBase64.h"

@interface FmcYXNRViewController ()

@end

@implementation FmcYXNRViewController
@synthesize scrollView;
@synthesize webView;
@synthesize user;
@synthesize mails;
@synthesize mail;
@synthesize mMailsFrom;
@synthesize mMailsTo;
@synthesize mMailsContent;
@synthesize mMailsSubject;

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
	UIView* synrView = [[UIView alloc] init];
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_gg"]];
    synrView.backgroundColor = bgColor;
    self.view = synrView;
    
    NSString* username = [user objectForKey:@"username"];
    NSString* mail_file_name   = [[NSString alloc] initWithData:[GTMBase64 decodeString:[mail objectForKey:@"mailName"]]
                                                       encoding:NSUTF8StringEncoding];
    NSString* mail_file_folder = [[NSString alloc] initWithData:[GTMBase64 decodeString:[mail objectForKey:@"mailPath"]]
                                                       encoding:NSUTF8StringEncoding];
    NSURL* getMailUrl = [NSURL URLWithString:@"http://mail.30888.com.cn/android/getMail2.php"];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:getMailUrl];
    FmcAppDelegate* fmcApp = [[UIApplication sharedApplication] delegate];
    [request setDownloadCache:fmcApp.fmcCache];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setPostValue:username forKey:@"username"];
    [request setPostValue:mail_file_name forKey:@"mail_file_name"];
    [request setPostValue:mail_file_folder forKey:@"mail_file_folder"];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString* responseString = [request responseString];
    mails = [responseString objectFromJSONString];
    mMailsFrom = [[NSString alloc] initWithData:[GTMBase64 decodeString:[mails objectForKey:@"mailFrom"]]
                                       encoding:NSUTF8StringEncoding];
    mMailsTo = [[NSString alloc] initWithData:[GTMBase64 decodeString:[mails objectForKey:@"mailTo"]]
                                     encoding:NSUTF8StringEncoding];
    mMailsSubject = [[NSString alloc] initWithData:[GTMBase64 decodeString:[mails objectForKey:@"mailSubject"]]
                                          encoding:NSUTF8StringEncoding];
    NSString* mMailsDate = [[NSString alloc] initWithData:[GTMBase64 decodeString:[mail objectForKey:@"mailDate"]]
                                                 encoding:NSUTF8StringEncoding];
    mMailsContent = [[NSString alloc] initWithData:[GTMBase64 decodeString:[mails objectForKey:@"mailContent"]]
                                          encoding:NSUTF8StringEncoding];
    
    UILabel* titleLable = [[UILabel alloc] init];
    [titleLable setFont:[UIFont boldSystemFontOfSize:20]];
    CGSize size = CGSizeMake(320,2000);
    CGSize titleLabelSize = [mMailsSubject sizeWithFont:[UIFont boldSystemFontOfSize:20] constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    [titleLable setFrame:CGRectMake(ScreenWidth/2 - titleLabelSize.width/2, 0, titleLabelSize.width, titleLabelSize.height)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = mMailsSubject;
    [titleLable setNumberOfLines:0];
    titleLable.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:titleLable];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(3.0f, titleLabelSize.height, ScreenWidth-6, ScreenHeight)];
    scrollView.contentSize = CGSizeMake(314,700);
    [self.view addSubview:scrollView];
    
    NSArray* mmMailsTitle = @[@"日期", @"寄件人", @"收件人"];
    for (int i=0; i< mmMailsTitle.count; i++) {
        UILabel* lableTitle = [[UILabel alloc] init];
        [lableTitle setFont:[UIFont systemFontOfSize:14]];
        [lableTitle setFrame:CGRectMake(0.0f, 30.0f*i, ScreenWidth/4.5, 30.0f)];
        lableTitle.backgroundColor = [[UIColor alloc] initWithRed:1.0/255 green:72.0/255 blue:152.0/255 alpha:1];
        lableTitle.text = mmMailsTitle[i];
        lableTitle.textAlignment = NSTextAlignmentCenter;
        lableTitle.textColor = [UIColor whiteColor];
        [scrollView addSubview:lableTitle];
    }
    
    NSArray* mmMailsContent = @[mMailsDate, mMailsFrom, mMailsTo];
    for (int j=0; j< mmMailsContent.count; j++) {
        UILabel* lableContent = [[UILabel alloc] init];
        [lableContent setFont:[UIFont systemFontOfSize:14]];
        [lableContent setFrame:CGRectMake(ScreenWidth/4.5, 30.0f*j+1, ScreenWidth-ScreenWidth/4.5, 30.0f)];
        lableContent.backgroundColor = [[UIColor alloc] initWithRed:253.0/255 green:252.0/255 blue:223.0/255 alpha:1];
        lableContent.text = mmMailsContent[j];
        lableContent.textAlignment = NSTextAlignmentCenter;
        lableContent.textColor = [UIColor blackColor];
        [scrollView addSubview:lableContent];
    }
    
    for (int k=1; k< mmMailsContent.count; k++) {
        UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 30.0f*k+1, ScreenWidth, 1.0f)];
        lineView.backgroundColor = [[UIColor alloc] initWithRed:217.0/255 green:224.0f/255 blue:233.0/255 alpha:1];
        [scrollView addSubview:lineView];
    }
    
    webView = [[UIWebView alloc] init];
    [webView setFrame:CGRectMake(0.0f, 90.0f, ScreenWidth, 320.0f)];
    [self.webView loadHTMLString:mMailsContent baseURL:nil];
    webView.scalesPageToFit = YES;
    [scrollView addSubview:webView];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    UIAlertView* userErrorAlert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                            message:@"加载失败，请返回"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
    [userErrorAlert show];
}

-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSString* mName = @"大陆邮箱内容--FmcYXNRViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

-(void) viewDidDisappear:(BOOL)animated{
    NSString* mName = @"大陆邮箱内容--FmcYXNRViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}


@end
