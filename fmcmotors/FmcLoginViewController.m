//
//  FmcLoginViewController.m
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcLoginViewController.h"
#import "AJGlobalUICommon.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "JASidePanelController.h"
#import "FmcLeftMenuViewController.h"
#import "FmcSYViewController.h"
#import "BaiduMobStat.h"

@interface FmcLoginViewController ()

@end

@implementation FmcLoginViewController
@synthesize usernameField;
@synthesize passwordField;
@synthesize users;


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
	UIView* loginView = [[UIView alloc] init];
    loginView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg"]];
    self.view = loginView;
    
    UIImageView* login_topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_title_top"]];
    login_topView.frame = CGRectMake(5, ScreenHeight/2-140, 310, 35);
    [self.view addSubview:login_topView];
    
    UILabel* titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, ScreenHeight/2-138, 310, 35)];
    titleLable.text = @"汇丰汽车  企业网站登录";
    titleLable.font = [UIFont systemFontOfSize:16];
    [titleLable setTextColor:[UIColor whiteColor]];
    titleLable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleLable];
    
    
    UIImageView* login_middleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_title_middle"]];
    login_middleView.frame = CGRectMake(5, ScreenHeight/2-105, 310, 100);
    [self.view addSubview:login_middleView];
    
    UIImageView* login_bottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_title_bottom"]];
    login_bottomView.frame = CGRectMake(5, ScreenHeight/2-10, 310, 40);
    [self.view addSubview:login_bottomView];
    
    UILabel* usernameLable = [[UILabel alloc] initWithFrame:CGRectMake(75, ScreenHeight/2-75, 90, 20)];
    usernameLable.text = @"USERNAME:";
    usernameLable.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:usernameLable];
    
    usernameField = [[UITextField alloc] initWithFrame:CGRectMake(175, ScreenHeight/2-80, 120, 20)];
    usernameField.background = [UIImage imageNamed:@"input"];
    usernameField.keyboardType = UIKeyboardTypeNumberPad;
    usernameField.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:usernameField];
    
    UILabel* passwordLable = [[UILabel alloc] initWithFrame:CGRectMake(75, ScreenHeight/2-42, 90, 20)];
    passwordLable.text = @"PASSWORD:";
    passwordLable.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:passwordLable];
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(175, ScreenHeight/2-47, 120, 20)];
    passwordField.background = [UIImage imageNamed:@"input"];
    passwordField.secureTextEntry = YES;
    passwordField.textAlignment = NSTextAlignmentCenter;
    
    //-------------
    //    usernameField.text = @"0930062";
    //    passwordField.text = @"gubin1982";
    
    [self.view addSubview:passwordField];
    
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    
    self.usernameField.returnKeyType = UIReturnKeyNext;
    self.passwordField.returnKeyType = UIReturnKeyDefault;
    
    [self.usernameField addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.passwordField addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
    
    UIButton* loginButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-100, ScreenHeight/2-5, 100, 30)];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UILabel* copyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight-80, ScreenWidth, 20)];
    copyLabel.text = @"COPYRIGHT © 2014 汇丰汽车";
    copyLabel.textAlignment = NSTextAlignmentCenter;
    [copyLabel setFont:[UIFont systemFontOfSize:14]];
    copyLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:copyLabel];
    
    UILabel* messLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight-60, ScreenWidth, 20)];
    messLabel.text = @"大陆总管理处 资讯部";
    messLabel.textAlignment = NSTextAlignmentCenter;
    [messLabel setFont:[UIFont systemFontOfSize:14]];
    messLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:messLabel];
    
    UILabel* versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ScreenHeight-40, ScreenWidth, 20)];
    NSString* version = [@"版本号：" stringByAppendingString: IosAppVersion];
    versionLabel.text = version;
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [versionLabel setFont:[UIFont systemFontOfSize:14]];
    versionLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:versionLabel];
    
}

-(void) login:(id)sender{
    if (usernameField.text.length == 0) {
        UIAlertView* usernameAlert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"员工编号不能为空"
                                                              delegate:nil
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
        [usernameAlert show];
    }else if (passwordField.text.length == 0){
        UIAlertView* passwordAlert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"密码不能为空"
                                                              delegate:nil
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
        [passwordAlert show];
        
    }else{
        NSURL* getUserUrl = [NSURL URLWithString:@"http://www.fmcmotors.com.cn/ios/getUser.php"];
        ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:getUserUrl];
        [request setPostValue:usernameField.text forKey:@"username"];
        [request setPostValue:passwordField.text forKey:@"password"];
        [request setDelegate:self];
        [request startAsynchronous];
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate =  self;
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.animationType=MBProgressHUDAnimationZoom;
        HUD.labelText = @"查询中...";
        HUD.alpha = 0.1f;
        [HUD show:YES];
        [self.view addSubview:HUD];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    HUD.hidden = YES;
    NSString* responseString = [request responseString];
    users = [responseString objectFromJSONString];
    NSDictionary* user = [users objectAtIndex:0];
    NSString* usernameStr = [user objectForKey:@"Cal_User_Username"];
    NSString* passwordStr = [user objectForKey:@"Cal_User_Password"];
    NSString* realnameStr = [user objectForKey:@"Cal_User_FirstName"];
    
    if ([usernameStr isEqualToString:usernameField.text]) {
        
    }else if ([passwordStr isEqualToString:passwordField.text]){
        UIAlertView* loginAlert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                            message:@"登录成功"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [loginAlert show];
        NSDictionary* user = [[NSDictionary alloc] initWithObjectsAndKeys: usernameField.text,@"username", realnameStr, @"realname", nil];
        JASidePanelController* mainView = [[JASidePanelController alloc] init];
        mainView.user = user;
        FmcLeftMenuViewController* leftMenu = [[FmcLeftMenuViewController alloc] init];
        leftMenu.user = user;
        mainView.shouldDelegateAutorotateToVisiblePanel = NO;
        mainView.leftPanel = leftMenu;
        mainView.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[FmcSYViewController alloc] init]];
        
        [self presentViewController:mainView  animated:YES completion:^{
            NSLog(@"OK");
        }];
        
    }else{
        UIAlertView* passwordAlert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"请检查员工编号或密码"
                                                              delegate:nil
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
        [passwordAlert show];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    UIAlertView* loginErrorAlert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                             message:@"查询失败，请检查员编或密码"
                                                            delegate:nil
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil];
    [loginErrorAlert show];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect=CGRectMake(0.0f,-30,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
    return YES;
}

-(void)resumeView
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    float Y = 20.0f;
    CGRect rect=CGRectMake(0.0f,Y,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
}

-(void)hidenKeyboard
{
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self resumeView];
}

-(IBAction)nextOnKeyboard:(UITextField *)sender
{
    if (sender == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    }else if (sender == self.passwordField){
        [self hidenKeyboard];
    }
}

-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSString* mName = @"登录--FmcLoginViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

-(void) viewDidDisappear:(BOOL)animated{
    NSString* mName = @"登录--FmcLoginViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

@end
