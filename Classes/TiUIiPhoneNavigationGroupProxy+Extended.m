/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 */

#import "TiUIiPhoneNavigationGroupProxy+Extended.h"

@implementation TiUIiPhoneNavigationGroupProxy (Extended)

//popToRootViewControllerAnimated does not work with Titanium :S
//[self.controller popToRootViewControllerAnimated:YES];

-(void)popToRoot:(id)args
{
    ENSURE_UI_THREAD(popToRoot,args);
    
    UINavigationController * controller = [self controller];
    NSUInteger controllers = [[controller viewControllers] count];
	for (UIViewController * thisVC in [[controller viewControllers] reverseObjectEnumerator])
	{
        // we only want TiViewControllers and not the root ViewController
		if (![thisVC isKindOfClass:[TiViewController class]] || controllers == 1) {
			continue;
		}
        // lets close it
		TiWindowProxy * thisProxy = (TiWindowProxy *)[(TiViewController *)thisVC proxy];
        NSDictionary * animated = @{@"animated": @NO};
        [self close:[[NSArray alloc] initWithObjects:thisProxy,animated, nil]];
        controllers--;
	}
}

@end
