/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 */

#import "TiUITextField+Extended.h"

@implementation TiUITextField (Extended)

- (void) setHintTextColor_:(id)color
{
    /*
	if([TiUtils isIOS6OrGreater]){
        UIColor *color = [UIColor redColor];
        self.textWidgetView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"text" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        [self.textWidgetView setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    */
    color = [TiUtils colorValue:color];
    [self.textWidgetView setValue:[color _color] forKeyPath:@"_placeholderLabel.textColor"];
}

@end
