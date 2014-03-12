//
//  FmcXSNRViewController.m
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcXSNRViewController.h"
#import "AJGlobalUICommon.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "FmcXSViewController.h"
#import "BaiduMobStat.h"

@interface FmcXSNRViewController ()

@end

@implementation FmcXSNRViewController
@synthesize scrollView;
@synthesize dateSplit;
@synthesize calendarDate;
@synthesize calendarList;

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
	UIView* xsNrView = [[UIView alloc] init];
    xsNrView.backgroundColor = [UIColor whiteColor];
    self.view = xsNrView;
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(3.0f, 30.0f, ScreenWidth-6, ScreenHeight)];
    scrollView.contentSize = CGSizeMake(314,700);
    [self.view addSubview:scrollView];
    
    UILabel* titleLable = [[UILabel alloc] init];
    [titleLable setFont:[UIFont boldSystemFontOfSize:20]];
    NSString* xsl = @"详细行事历";
    NSString* xslTitle = [calendarDate stringByAppendingString:xsl];
    CGSize titleLableSize = [xslTitle sizeWithFont:[UIFont boldSystemFontOfSize:20]];
    [titleLable setFrame:CGRectMake(ScreenWidth/2 - titleLableSize.width/2, 0.0f, titleLableSize.width, 30.0f)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.text = xslTitle;
    [self.view addSubview:titleLable];
    
    dateSplit = [calendarDate componentsSeparatedByString:@"-"];
    NSString* datey = [dateSplit objectAtIndex:0];
    NSString* datem = [dateSplit objectAtIndex:1];
    NSString* dated = [dateSplit objectAtIndex:2];
    //网络异步请求数据
    NSURL* getSearchCalendarUrl = [NSURL URLWithString:@"http://www.fmcmotors.com.cn/ios/getSearchCalendar.php"];
    ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:getSearchCalendarUrl];
    FmcAppDelegate* fmcApp = [[UIApplication sharedApplication] delegate];
    [request setDownloadCache:fmcApp.fmcCache];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setPostValue:datey forKey:@"sdatey"];
    [request setPostValue:datem forKey:@"sdatem"];
    [request setPostValue:dated forKey:@"sdated"];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString* responseString = [request responseString];
    calendarList = [responseString objectFromJSONString];
    if (calendarList == nil) {
        UIAlertView* calendarAlert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"本日暂无待办事项"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
        [calendarAlert show];
    }else{
        NSArray* calendarTitle = @[@"日期", @"时间", @"行事内容", @"补充说明", @"张贴/联络人"];
        for (int i=0; i<calendarList.count; i++) {
            for (int j=0; j<calendarTitle.count; j++) {
                UILabel* lableTitle = [[UILabel alloc] init];
                [lableTitle setFont:[UIFont systemFontOfSize:14]];
                [lableTitle setFrame:CGRectMake(0.0f, (j*3+i*17)*10, ScreenWidth/3, 30.0f)];
                lableTitle.backgroundColor = [[UIColor alloc] initWithRed:1.0/255 green:72.0/255 blue:152.0/255 alpha:1];
                lableTitle.text = calendarTitle[j];
                lableTitle.textAlignment = NSTextAlignmentCenter;
                lableTitle.textColor = [UIColor whiteColor];
                [scrollView addSubview:lableTitle];
            }
            
            NSDictionary* calendarOne = [calendarList objectAtIndex:i];
            NSString* content = [calendarOne objectForKey:@"content"];
            NSString* dateid = [calendarOne objectForKey:@"dateid"];
            NSString* subject = [calendarOne objectForKey:@"subject"];
            NSString* times = [calendarOne objectForKey:@"timeid"];
            NSString* timee = [calendarOne objectForKey:@"timeid_end"];
            NSString* timeTemp = [times stringByAppendingString:@"-"];
            NSString* timeid = [timeTemp stringByAppendingString:timee];
            NSString* worker = [calendarOne objectForKey:@"worker"];
            
            NSArray* calendarContent = @[dateid, timeid, subject, content, worker];
            for (int m=0; m< calendarContent.count; m++) {
                UILabel* lableContent = [[UILabel alloc] init];
                [lableContent setFont:[UIFont systemFontOfSize:14]];
                [lableContent setFrame:CGRectMake(ScreenWidth/3, (m*3+i*17)*10, ScreenWidth-ScreenWidth/3, 30.0f)];
                lableContent.backgroundColor = [[UIColor alloc] initWithRed:253.0/255 green:252.0/255 blue:223.0/255 alpha:1];
                lableContent.text = calendarContent[m];
                lableContent.textAlignment = NSTextAlignmentCenter;
                lableContent.textColor = [UIColor blackColor];
                [scrollView addSubview:lableContent];
            }
            
            for (int n=0; n< calendarTitle.count+1; n++) {
                UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, (n*3+i*17)*10, ScreenWidth, 1.0f)];
                lineView.backgroundColor = [[UIColor alloc] initWithRed:217.0/255 green:224.0f/255 blue:233.0/255 alpha:1];
                [scrollView addSubview:lineView];
            }
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    UIAlertView* userErrorAlert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                            message:@"加载失败，请返回"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
    [userErrorAlert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSString* mName = @"行事历内容--FmcXSNRViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

-(void) viewDidDisappear:(BOOL)animated{
    NSString* mName = @"行事历内容--FmcXSNRViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}


@end
