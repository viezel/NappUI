/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 */

#import "TiUIiOSToolbarProxy+Extended.h"
#import "Webcolor.h"

@implementation TiUIiOSToolbarProxy (Extended)

- (UIColor *)colorValue:(NSString *)str {
    if ([str hasPrefix:@"#"]) {
        return [Webcolor colorForHex:[str substringFromIndex:1]];
    }
    return [Webcolor webColorNamed:str];
}

- (void)setTintColor_:(id)color {
    ENSURE_UI_THREAD_1_ARG(color);
    self.toolbar.tintColor = [self colorValue:color];
    [self.toolbar setNeedsDisplay];
    [self replaceValue:color forKey:@"tintColor" notification:YES];
}

@end
