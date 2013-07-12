/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 *
 * by ryugoo
 */

#import "TiUITabGroup+Extend.h"
#import "TiUtils.h"

@implementation TiUITabGroup (Extend)

- (void)setCustomBackgroundColor_:(id)color
{
    if([color isKindOfClass:[UIColor class]]) {
        [[UITabBar appearance] setTintColor:color];
    } else {
        TiColor *tintColor = [TiUtils colorValue:color];
        [[UITabBar appearance] setTintColor:[tintColor _color]];
    }
}

- (void)setCustomBackgroundImage_:(id)imageName
{
    UIImage *backImage = [TiUtils loadBackgroundImage:imageName forProxy:self.proxy];
    [[UITabBar appearance] setBackgroundImage:backImage];
}

- (void)setCustomActiveIconColor_:(id)color
{
    if([color isKindOfClass:[UIColor class]]) {
        [[UITabBar appearance] setSelectedImageTintColor:color];
    } else {
        TiColor *activeIconColor = [TiUtils colorValue:color];
        [[UITabBar appearance] setSelectedImageTintColor:[activeIconColor _color]];
    }
}

- (void)setCustomActiveIndicator_:(id)imageName
{
    UIImage *activeImage = [TiUtils loadBackgroundImage:imageName forProxy:self.proxy];
    [[UITabBar appearance] setSelectionIndicatorImage:activeImage];
}

@end