/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 */

#import <QuartzCore/QuartzCore.h>
#import "TiUIPicker+Extended.h"

@implementation TiUIPicker (Extended)

-(void)setMask_:(id)args{
    ENSURE_SINGLE_ARG_OR_NIL(args, NSDictionary);
    
    CALayer* mask = [[CALayer alloc] init];
    [mask setBackgroundColor: [UIColor blackColor].CGColor];
    [mask setFrame:  CGRectMake(
                                [TiUtils floatValue:[args objectForKey:@"left"]],
                                [TiUtils floatValue:[args objectForKey:@"top"]],
                                [TiUtils floatValue:[args objectForKey:@"width"]],
                                [TiUtils floatValue:[args objectForKey:@"height"]]
                                )];
    //[mask setFrame:  CGRectMake(14.0f, 10.0f, 293.0f, 196.0f)];
    [mask setCornerRadius: 5.0f];
    [picker.layer setMask: mask];
    [mask release];
}




@end
