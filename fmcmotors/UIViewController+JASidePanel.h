#import <Foundation/Foundation.h>

@class JASidePanelController;

@interface UIViewController (JASidePanel)

@property (nonatomic, weak, readonly) JASidePanelController *sidePanelController;

@end
