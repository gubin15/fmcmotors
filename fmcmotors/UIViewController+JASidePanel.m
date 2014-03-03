#import "UIViewController+JASidePanel.h"

#import "JASidePanelController.h"

@implementation UIViewController (JASidePanel)

- (JASidePanelController *)sidePanelController {
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[JASidePanelController class]]) {
            return (JASidePanelController *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

@end
