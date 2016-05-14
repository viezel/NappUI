/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 */

#import "TiUITextField+Extended.h"

@implementation TiUITextField (Extended)

- (void) setHintTextColor_:(id)color
{
    self.textWidgetView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[TiUtils stringValue:[[self proxy] valueForKey:@"hintText"]] attributes:@{NSForegroundColorAttributeName: [[TiUtils colorValue:value] _color]}];
}



@end

