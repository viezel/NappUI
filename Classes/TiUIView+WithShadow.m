/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 *
 * Inspired by Javier Rayon
 */

#import "TiUIView+WithShadow.h"
#import "TiProxy.h"
#import "JRSwizzle.h"


@interface TiUIView ()
-(void)checkBounds;
@end
 

@implementation TiUIView (WithShadow)

+(void)load
{    
    NSError *error = nil;
    
    [TiUIView jr_swizzleMethod:@selector(checkBounds) withMethod:@selector(checkBoundsAlt) error:&error];
    if (error != nil) {
        NSLog(@"[ERROR] %@", [error localizedDescription]);
    }
}

-(void)checkBoundsAlt
{
    [self checkBoundsAlt];

    NSDictionary *shadowProps = [self.proxy valueForUndefinedKey:@"shadow"];
   
    if (shadowProps == nil)
        return;
    
    NSNumber *radius = [self.proxy valueForUndefinedKey:@"borderRadius"];;
    UIBezierPath *shadowPath = nil;
    if (radius != nil) 
    {
        shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[radius floatValue]];
    }
    else 
    {
        shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    }
    
    [self.layer setShadowPath:[shadowPath CGPath]];
}

-(void)setClipsToBounds:(BOOL)clipsToBounds
{
    if (self.layer.shadowOpacity > 0) {
        // if there is shadow, we regret to clip
        [super setClipsToBounds:NO];
    } else {
        [super setClipsToBounds:clipsToBounds];
    }
}


-(void)setShadow_:(id)args
{
    if(args != nil)
    {
        self.layer.masksToBounds = NO; 
        self.clipsToBounds = NO;
        
        //Support for retina display
        CGFloat scale;
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            scale=[[UIScreen mainScreen] scale];
        } else {
            scale=1; //only called on iPad.
        }
        
        self.layer.rasterizationScale = scale;

        [self.layer setShouldRasterize:YES];
        
        if ([args objectForKey:@"shadowOffset"] != nil) {
            CGPoint p = [TiUtils pointValue: [args objectForKey:@"shadowOffset"]];
            CGSize shadowOffset = {p.x,p.y};
            
            self.layer.shadowOffset = shadowOffset;
        }
        if ([args objectForKey:@"shadowOpacity"] != nil) {
            self.layer.shadowOpacity = [TiUtils floatValue:[args objectForKey:@"shadowOpacity"]];            
        }
        if ([args objectForKey:@"shadowRadius"] != nil) {
            self.layer.shadowRadius = [TiUtils floatValue:[args objectForKey:@"shadowRadius"]];
        }

        if ([args objectForKey:@"shadowColor"] != nil) {
            UIColor * shadowColor = [[TiUtils colorValue:[args objectForKey:@"shadowColor"]] _color];
            [self.layer setShadowColor:[shadowColor CGColor]];            
        }
             
    }
}

@end
