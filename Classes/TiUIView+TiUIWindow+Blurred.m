/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 */

#import "TiUIView+TiUIWindow+Blurred.h"

@implementation TiUIView (WithShadow)

-(void)setBlur_:(id)value {
    CGFloat num = [TiUtils floatValue:value];
    [self.layer setRasterizationScale:num];
    
    if (num == 1.0f) {
        [self.layer setShouldRasterize:NO];
    } else {
        [self.layer setShouldRasterize:YES];
    }
}

@end

@implementation TiUIWindow (WindowWithShadow)

-(void)setBlur_:(id)value {
    CGFloat num = [TiUtils floatValue:value];
    [self.layer setRasterizationScale:num];
    
    if (num == 1.0f) {
        [self.layer setShouldRasterize:NO];
    } else {
        [self.layer setShouldRasterize:YES];
    }
}

@end