//
//  FmcGDViewController.m
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcGDViewController.h"
#import "BaiduMobStat.h"

@interface FmcGDViewController ()

@end

@implementation FmcGDViewController

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
	UIView* gdView = [[UIView alloc] init];
    gdView.backgroundColor = [UIColor whiteColor];
    self.view = gdView;
    UILabel* gdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    gdLabel.text = @"敬请期待";
    [gdLabel setFont:[UIFont boldSystemFontOfSize:24]];
    [self.view addSubview:gdLabel];
}

-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSString* mName = @"更多--FmcGDViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

-(void) viewDidDisappear:(BOOL)animated{
    NSString* mName = @"更多--FmcGDViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}


@end
