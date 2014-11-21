/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 */

#import "TiUIiOSNavWindowProxy+Extended.h"

@implementation TiUIiOSNavWindowProxy (Extended)

-(void)popToRoot:(id)args
{
    ENSURE_UI_THREAD(popToRoot,args);
    [navController popToRootViewControllerAnimated:YES];
}

@end
