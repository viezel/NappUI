/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 *
 * by ryugoo
 */

#import "TiUIWebView+Extend.h"
#import "TiUtils.h"

@implementation TiUIWebView (Extend)

- (void)setNormalScrollSpeed_:(id)args
{
    BOOL normalSpeed = [TiUtils boolValue:args def:NO];
    if (normalSpeed == YES) {
        // Same TableView, ScrollView scroll speed.
        [[self scrollview] setDecelerationRate:UIScrollViewDecelerationRateNormal];
    } else {
        // Default scroll speed.
        [[self scrollview] setDecelerationRate:UIScrollViewDecelerationRateFast];
    }
}

- (void)setRemoveShadow_:(id)args
{
    BOOL removeFlag = [TiUtils boolValue:args def:NO];
    if (removeFlag == YES)
    {
        for (UIView *shadowView in [[self scrollview] subviews]) {
            if ([shadowView isKindOfClass:[UIImageView class]]) {
                [shadowView setHidden:YES];
            }
        }
    }
}

- (void)setRemoveScrollDelay_:(id)args
{
    BOOL removeFlag = [TiUtils boolValue:args def:NO];
    if (removeFlag == YES)
    {
        [[self scrollview] setDelaysContentTouches:NO];
    }
}

- (void)setUserAgentForiOS_:(id)args
{
    NSDictionary *dict = @{@"UserAgent": args};
    [[NSUserDefaults standardUserDefaults] registerDefaults:dict];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // Get request URL
    NSURL *url = [request URL];
    // Get scheme information
    NSString *scheme = [[url scheme] lowercaseString];
    // Get URL path information
    NSString *path = [url path];
    // If the path begins with "/"
    if([path hasPrefix:@"/"]) {
        // Remove the head of the "/"
        path = [path substringWithRange:NSMakeRange(1, path.length - 1)];
    }
    // If the scheme begins with "extendwebview"
    if ([scheme isEqualToString:@"extendwebview"]) {
        // Get event name from host
        NSString *eventName = [url host];
        // The same as the event name if it has been registered in the event listener
        if ([self.proxy _hasListeners:eventName]){
            NSLog(@"[DEBUG] fire: %@",eventName);
            // Get event information
            NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:path, @"path", eventName, @"event", nil];
            // Execute
            [self.proxy fireEvent:eventName withObject:event];
        }
        return NO;
    }
    return YES;
}

@end