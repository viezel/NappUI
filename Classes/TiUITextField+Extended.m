/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 */

#import "TiUITextField+Extended.h"

@implementation TiUITextField (Extended)

- (void) setHintTextColor_:(id)color
{
    TiColor *newColor = [TiUtils colorValue:color];
    self.textWidgetView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"text" attributes:@{NSForegroundColorAttributeName: [TiUtils barColorForColor:newColor]}];
    
    /*
	if([TiUtils isIOS6OrGreater]){
        self.textWidgetView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"text" attributes:@{NSForegroundColorAttributeName: newColor}];
    } else {
        [self.textWidgetView setValue:[newColor _color] forKeyPath:@"_placeholderLabel.textColor"];
    }
    
*/    
    //[self.textWidgetView setValue:[color _color] forKeyPath:@"_placeholderLabel.textColor"];
}



@end

