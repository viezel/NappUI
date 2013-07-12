/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 */

#import "TiUIView+TiUIWindow+Blurred.h"

@implementation TiUIView (WithShadow)

-(void)setBlurred_:(id)value {
    if ([TiUtils boolValue:value]) {
        [self.layer setRasterizationScale:0.5];
        [self.layer setShouldRasterize:YES];    
    } else {
        [self.layer setRasterizationScale:1.0];
        [self.layer setShouldRasterize:NO];
    }
}
@end

@implementation TiUIWindow (WindowWithShadow)

-(void)setBlurred_:(id)value {
    if ([TiUtils boolValue:value]) {
        [self.layer setRasterizationScale:0.5];
        [self.layer setShouldRasterize:YES];    
    } else {
        [self.layer setRasterizationScale:1.0];
        [self.layer setShouldRasterize:NO];
    }
}

@end