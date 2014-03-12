//
//  FmcYJViewController.m
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcYJViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "BaiduMobStat.h"

@interface FmcYJViewController ()

@end

@implementation FmcYJViewController
@synthesize user;
@synthesize tv;
@synthesize isEmpty;

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
	UIView* yjView = [[UIView alloc] init];
    yjView.backgroundColor = [UIColor whiteColor];
    self.view = yjView;
    UILabel* titleLable = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, 314, 35)];
    titleLable.text = @"用户反馈";
    titleLable.textAlignment = NSTextAlignmentCenter;
    [titleLable setFont:[UIFont boldSystemFontOfSize:24]];
    [titleLable setTextColor:[UIColor whiteColor]];
    titleLable.backgroundColor = [UIColor blueColor];
    [self.view addSubview:titleLable];
    
    UIView* bkView = [[UIView alloc] initWithFrame:CGRectMake(3, 35, 314, 150)];
    bkView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bkView];
    
    tv = [[UITextView alloc] initWithFrame:CGRectMake(4, 35, 312, 149)];
    tv.backgroundColor = [UIColor whiteColor];
    tv.text = @"请输入您的反馈信息，帮助我们改善APP，感谢您的支持！（限250字）";
    [tv setFont:[UIFont systemFontOfSize:16]];
    tv.textColor = [UIColor lightGrayColor];
    isEmpty = YES;
    tv.delegate = self;
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    [topView setItems:buttonsArray];
    [tv setInputAccessoryView:topView];
    [self.view addSubview:tv];
    
    UIButton* submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 185, 310, 40)];
    [submitBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitContent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
}

//关闭键盘
-(void) dismissKeyBoard{
    [tv resignFirstResponder];
}

-(void) submitContent:(id)sender{
    NSString* contentStr = tv.text;
    if ([contentStr isEqualToString:@"请输入您的反馈信息，帮助我们改善APP，感谢您的支持！（限250字）"]) {
        UIAlertView* contentAlert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                              message:@"反馈意见不能为空"
                                                             delegate:nil
                                                    cancelButtonTitle:@"确定"
                                                    otherButtonTitles:nil];
        [contentAlert show];
    }else if ([contentStr isEqualToString:@""]){
        UIAlertView* contentAlert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                              message:@"反馈意见不能为空"
                                                             delegate:nil
                                                    cancelButtonTitle:@"确定"
                                                    otherButtonTitles:nil];
        [contentAlert show];
    }else{
        NSString* idStr = @"";
        NSString* usernameStr = [user objectForKey:@"username"];
        NSString* realnameStr = [user objectForKey:@"realname"];
        
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *currentStr = [formatter stringFromDate:[NSDate date]];
        
        NSURL* insertOpinionUrl = [NSURL URLWithString:@"http://210.5.29.85/sh/sum/mobile/upload_opinion.php"];
        ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:insertOpinionUrl];
        FmcAppDelegate* fmcApp = [[UIApplication sharedApplication] delegate];
        [request setDownloadCache:fmcApp.fmcCache];
        [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
        [request setPostValue:idStr forKey:@"opinion_id"];
        [request setPostValue:usernameStr forKey:@"opinion_username"];
        [request setPostValue:realnameStr forKey:@"opinion_realname"];
        [request setPostValue:currentStr forKey:@"opinion_date"];
        [request setPostValue:@"IOS" forKey:@"opinion_version"];
        [request setPostValue:contentStr forKey:@"opinion_content"];
        [request setDelegate:self];
        [request startAsynchronous];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    UIAlertView* opinionAlert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                          message:@"提交反馈成功，感谢您提出宝贵的意见"
                                                         delegate:self
                                                cancelButtonTitle:@"确定"
                                                otherButtonTitles:nil];
    [opinionAlert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        UIView* fhView = [[UIView alloc] init];
        fhView.backgroundColor = [UIColor whiteColor];
        self.view = fhView;
        UILabel* fhLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        fhLabel.text = @"提交成功，请返回";
        [self.view addSubview:fhLabel];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (isEmpty) {
        tv.text = @"";
        tv.textColor = [UIColor blackColor];
        isEmpty = NO;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if(tv.text.length == 0){
        tv.textColor = [UIColor lightGrayColor];
        tv.text = @"请输入您的反馈信息，帮助我们改善APP，感谢您的支持！（限250字）";
        isEmpty = YES;
    }
}

-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSString* mName = @"意见建议--FmcYJViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

-(void) viewDidDisappear:(BOOL)animated{
    NSString* mName = @"意见建议--FmcYJViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}


@end
