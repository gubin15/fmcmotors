//
//  FmcBaseViewController.m
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcBaseViewController.h"

@interface FmcBaseViewController ()

@end

@implementation FmcBaseViewController

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
	UINavigationBar* navBar = self.navigationController.navigationBar;
    self.navigationController.navigationBar.translucent = NO;
    #define kSCNavBarImageTag 10
    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [navBar setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    }else{
        UIImageView *imageView = (UIImageView *)[navBar viewWithTag:kSCNavBarImageTag];
        if (imageView == nil) {
            imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"navbar"]];
            [imageView setTag:kSCNavBarImageTag];
            [navBar insertSubview:imageView atIndex:0];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
