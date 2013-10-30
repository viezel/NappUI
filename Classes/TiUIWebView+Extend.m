/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 *
 * by ryugoo
 */

#import "TiUIWebView+Extend.h"
#import "TiUtils.h"
#import <objc/runtime.h>

@implementation TiUIWebView (Extend)

#pragma mark
#pragma iVars
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

-(NSDictionary *)customHeaders
{
    return objc_getAssociatedObject(self, @selector(customHeaders));
}

-(void)setCustomHeaders_:(NSDictionary *)headers
{
    objc_setAssociatedObject(self, @selector(customHeaders), headers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSDictionary *)customHeaders_
{
    return objc_getAssociatedObject(self, @selector(customHeaders));
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL headerIsPresent = [[request allHTTPHeaderFields] objectForKey:@"x-adp-app"]!=nil;
    
    // Get request URL
    NSURL *url = [request URL];
    
    if(headerIsPresent) {//|| self.customHeaders.count == 0
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
    else
    {
        // this header is here to determine if the custom headers already has been added or not. this to prevent infinite loop
        [request addValue:@"true" forHTTPHeaderField:@"x-adp-app"];
        
        // set the new headers
        for(NSString *key in [self.customHeaders allKeys]){
            [request addValue:[self.customHeaders objectForKey:key] forHTTPHeaderField:key];
        }
        
		[webView loadRequest:request];
		return NO;
	}
    
	return YES;
}

@end