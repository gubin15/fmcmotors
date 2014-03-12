//
//  FmcAppDelegate.h
//  fmcmotors
//
//  Created by 顾斌 on 14-3-3.
//  Copyright (c) 2014年 顾斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"
#import "ASIDownloadCache.h"

@interface FmcAppDelegate : UIResponder <UIApplicationDelegate>{
    ASIDownloadCache* fmcCache;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) JASidePanelController *viewController;
@property (strong, nonatomic) ASIDownloadCache* fmcCache;
@property (nonatomic) int bdCount;

@end
