//
//  FmcSYNRViewController.m
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcSYNRViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "BaiduMobStat.h"


@interface FmcSYNRViewController ()

@end

@implementation FmcSYNRViewController
@synthesize notice;
@synthesize scrollView;
@synthesize webView;
@synthesize attachs;
@synthesize progressView;

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
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(3.0f, 30.0f, ScreenWidth-6, ScreenHeight)];
    scrollView.contentSize = CGSizeMake(314,700);
    [self.view addSubview:scrollView];
    
    
    NSString* activesn = [notice objectForKey:@"activesn"];
    NSString* activename = [notice objectForKey:@"activename"];
    NSString* recdate = [notice objectForKey:@"recdate"];
    NSString* fromno = [notice objectForKey:@"fromno"];
    NSString* empname = [notice objectForKey:@"empname"];
    NSString* classification = [notice objectForKey:@"classification"];
    NSString* fromunit = [notice objectForKey:@"fromunit"];
    NSString* tounit = [notice objectForKey:@"tounit"];
    NSString* docsubject = [notice objectForKey:@"docsubject"];
    NSString* docdirection = [notice objectForKey:@"docdirection"];
    NSString* bfd1 = [notice objectForKey:@"bfd1"];
    //通告类型
    UILabel* titleLable = [[UILabel alloc] init];
    [titleLable setFont:[UIFont boldSystemFontOfSize:20]];
    CGSize titleLableSize = [activename sizeWithFont:[UIFont boldSystemFontOfSize:20]];
    [titleLable setFrame:CGRectMake(ScreenWidth/2 - titleLableSize.width/2, 0.0f, titleLableSize.width, 30.0f)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.text = activename;
    [self.view addSubview:titleLable];
    
    NSArray* noticeTitle = @[@"受文单位", @"承办者", @"发文单位", @"主旨", @"布告类别", @"发文编号", @"填单日期"];
    for (int i=0; i< noticeTitle.count; i++) {
        UILabel* lableTitle = [[UILabel alloc] init];
        [lableTitle setFont:[UIFont systemFontOfSize:14]];
        [lableTitle setFrame:CGRectMake(0.0f, 30.0f*i, ScreenWidth/3, 30.0f)];
        lableTitle.backgroundColor = [[UIColor alloc] initWithRed:1.0/255 green:72.0/255 blue:152.0/255 alpha:1];
        lableTitle.text = noticeTitle[i];
        lableTitle.textAlignment = NSTextAlignmentCenter;
        lableTitle.textColor = [UIColor whiteColor];
        [scrollView addSubview:lableTitle];
        
    }
    NSArray* noticeContent = @[tounit, empname, fromunit, docsubject, classification, fromno, recdate];
    for (int j=0; j< noticeContent.count; j++) {
        UILabel* lableContent = [[UILabel alloc] init];
        [lableContent setFont:[UIFont systemFontOfSize:14]];
        [lableContent setFrame:CGRectMake(ScreenWidth/3, 30.0f*j+1, ScreenWidth-ScreenWidth/3, 30.0f)];
        lableContent.backgroundColor = [[UIColor alloc] initWithRed:253.0/255 green:252.0/255 blue:223.0/255 alpha:1];
        lableContent.text = noticeContent[j];
        lableContent.textAlignment = NSTextAlignmentCenter;
        lableContent.textColor = [UIColor blackColor];
        [scrollView addSubview:lableContent];
    }
    
    for (int k=1; k< noticeContent.count; k++) {
        UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 30.0f*k+1, ScreenWidth, 1.0f)];
        lineView.backgroundColor = [[UIColor alloc] initWithRed:217.0/255 green:224.0f/255 blue:233.0/255 alpha:1];
        [scrollView addSubview:lineView];
    }
    
    webView = [[UIWebView alloc] init];
    [webView setFrame:CGRectMake(0.0f, 211.0f, ScreenWidth, 220.0f)];
    [self.webView loadHTMLString:docdirection baseURL:nil];
    [scrollView addSubview:webView];
    //发布者
    UILabel* fabuLable = [[UILabel alloc] init];
    [fabuLable setFont:[UIFont boldSystemFontOfSize:16]];
    NSString* fabu1 = [fromunit stringByAppendingString:@"   "];
    NSString* fabu2 = [fabu1 stringByAppendingString:bfd1];
    CGSize fabuLableSize = [fabu2 sizeWithFont:[UIFont boldSystemFontOfSize:16]];
    [fabuLable setFrame:CGRectMake(ScreenWidth/2 - fabuLableSize.width/2, 440.0f, ScreenWidth, 30.0f)];
    fabuLable.backgroundColor = [UIColor clearColor];
    fabuLable.text = fabu2;
    [scrollView addSubview:fabuLable];
    
    NSURL* getNoticeUrl = [NSURL URLWithString:@"http://www.fmcmotors.com.cn/ios/getNoticeUrl.php"];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:getNoticeUrl];
    FmcAppDelegate* fmcApp = [[UIApplication sharedApplication] delegate];
    [request setDownloadCache:fmcApp.fmcCache];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setPostValue:activesn forKey:@"activesn"];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString* responseString = [request responseString];
    attachs = [responseString objectFromJSONString];
    if (attachs == nil) {
    }else{
        for (int m = 0; m<attachs.count; m++) {
            UIButton* attachBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            attachBtn.frame = CGRectMake(0.0f, 480.0f+m*40.0f, ScreenWidth-20, 40.0f);
            attachBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
            NSDictionary* attachUrl = attachs[m];
            NSString* url = [attachUrl objectForKey:@"attachurl"];
            NSArray* fSplit = [url componentsSeparatedByString:@"\\"];
            NSString* fileName = [@"★相关附件:" stringByAppendingString:fSplit[2]];
            [attachBtn addTarget:self action:@selector(downloadFile:) forControlEvents:UIControlEventTouchUpInside];
            [attachBtn setTitle:fileName forState:UIControlStateNormal];
            attachBtn.tag = 100+m;
            [scrollView addSubview:attachBtn];
            
        }
    }
    
}

-(void) downloadFile:(id)sender{
    //int i = [sender tag];
    UIButton* attachBtn = (UIButton*)sender;
    NSString* strFileName = [attachBtn titleForState:UIControlStateNormal];
    NSString* fileNameDownload = nil;
    NSString* baseUrl = @"http://www.fmcmotors.com.cn/BPMFlow/Attach/";
    for (int m = 0; m<attachs.count; m++) {
        NSDictionary* attachUrl = attachs[m];
        NSString* url = [attachUrl objectForKey:@"attachurl"];
        NSArray* fSplit = [url componentsSeparatedByString:@"\\"];
        NSString* filePath = [url stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
        fileNameDownload = [@"★相关附件:" stringByAppendingString:fSplit[2]];
        if([strFileName isEqualToString:fileNameDownload]){
            NSString* savePath=[ NSSearchPathForDirectoriesInDomains ( NSDocumentDirectory , NSUserDomainMask , YES ) objectAtIndex : 0 ];
            savePath = [savePath stringByAppendingPathComponent : fSplit[2]];
            NSString* downloadStr  = [baseUrl stringByAppendingString:filePath];
            NSURL* downloadUrl = [NSURL URLWithString:downloadStr];
            progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0.0f, 480.0f+m*40.0f, ScreenWidth-20, 20.0f)];
            [progressView setProgressViewStyle:UIProgressViewStyleDefault];
            ASIHTTPRequest* downloadRequest = [ASIHTTPRequest requestWithURL:downloadUrl];
            FmcAppDelegate* fmcApp = [[UIApplication sharedApplication] delegate];
            [downloadRequest setDownloadCache:fmcApp.fmcCache];
            [downloadRequest setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
            [downloadRequest setDownloadProgressDelegate:progressView];
            [downloadRequest setDownloadDestinationPath:savePath];
            [scrollView addSubview:progressView];
            [downloadRequest setDelegate:self];
            [downloadRequest setDidFinishSelector:@selector(requestSuccess:)];
            [downloadRequest setDidFailSelector:@selector(requestError:)];
            [downloadRequest startAsynchronous];
            
        }
    }
}

-(void)requestSuccess:(ASIHTTPRequest *)downloadRequest{
    progressView.hidden = YES;
}

-(void)requestError:(ASIHTTPRequest *)downloadRequest{
    progressView.hidden = YES;
    NSLog(@"下载失败");
}

-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSString* mName = @"首页公告内容--FmcSYNRViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

-(void) viewDidDisappear:(BOOL)animated{
    NSString* mName = @"首页公告内容--FmcSYNRViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}


@end
