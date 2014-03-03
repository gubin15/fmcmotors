//
//  FmcXSViewController.m
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import "FmcXSViewController.h"
#import "VRGCalendarView.h"
#import "FmcXSNRViewController.h"
#import "BaiduMobStat.h"

@interface FmcXSViewController ()

@end

@implementation FmcXSViewController
@synthesize dateSplit;
@synthesize mCalendars;
@synthesize strDate;

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
	UIView* xsView = [[UIView alloc] init];
    xsView.backgroundColor = [UIColor whiteColor];
    self.view = xsView;
	VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate=self;
    [self.view addSubview:calendar];
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate* nowDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    strDate = [dateFormatter stringFromDate:nowDate];
    FmcXSNRViewController* xsnrView = [[FmcXSNRViewController alloc] init];
    xsnrView.calendarDate = strDate;
    [self.navigationController pushViewController:xsnrView animated:YES];
}

-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(void) viewDidAppear:(BOOL)animated{
    NSString* mName = @"行事历--FmcXSViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

-(void) viewDidDisappear:(BOOL)animated{
    NSString* mName = @"行事历--FmcXSViewController";
    [[BaiduMobStat defaultStat] pageviewStartWithName:mName];
}

@end
