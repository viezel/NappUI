/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 */

#import "TiUIScrollableView+Extend.h"

@implementation TiUIScrollableView (Extend)

-(void)setPagingControlCurrentIndicatorColor_:(id)args
{
    TiColor *val = [TiUtils colorValue:args];
    
    if (val != nil)
    {
        UIPageControl *pg = [self pagecontrol];
        [pg setCurrentPageIndicatorTintColor:[[val _color] retain]];
        pg.currentPageIndicatorTintColor = [[val _color] retain];

        if (showPageControl && (scrollview != nil) && ([[scrollview subviews] count] > 0))
        {
            [self refreshScrollView:[self bounds] readd:NO];
        }
    }
}

-(void)setPagingControlIndicatorColor_:(id)args
{
    TiColor *val = [TiUtils colorValue:args];

    if (val != nil)
    {
        UIPageControl *pg = [self pagecontrol];
        [pg setPageIndicatorTintColor:[[val _color] retain]];
        pg.pageIndicatorTintColor = [[val _color] retain];

        if (showPageControl && (scrollview != nil) && ([[scrollview subviews] count] > 0))
        {
            [self refreshScrollView:[self bounds] readd:NO];
        }
    }
}

@end
