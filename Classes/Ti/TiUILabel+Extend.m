/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 *
 * TiUILabel+Extend by @dezinezync
 * Author: Nikhil Nigade
 * dezinezync.com
 */

#import "TiUILabel+Extend.h"
#import "TiUtils.h"

@implementation TiUILabel (Extend)

-(void)setAttributedText_:(id)args
{
    //Check if attributedText is supported. (iOS6 +)
    if (![[self label] respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    
    NSString *text = [TiUtils stringValue:[args objectForKey:@"text"]];
    
    NSMutableAttributedString *attrS = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSArray *attributes = [args objectForKey:@"attributes"];
    
    for(id object in attributes) {
        
        NSString *str = [TiUtils stringValue:[object valueForKey:@"text"]];
        NSRange range = [text rangeOfString:str options:(NSCaseInsensitiveSearch)];
        
        NSMutableDictionary *_attr = [[NSMutableDictionary alloc] init];
        
        if([object valueForKey:@"font"] != nil) {
            [_attr setObject:[[TiUtils fontValue:[object valueForKey:@"font"]] font] forKey:NSFontAttributeName];
        }
        
        if([object valueForKey:@"color"] != nil) {
            [_attr setObject:[[TiUtils colorValue:[object valueForKey:@"color"]] _color] forKey:NSForegroundColorAttributeName];
        }

        [attrS setAttributes:_attr range:range];
        
        [_attr release];
        [str release];
        
    }
    
    [[self label] setAttributedText:attrS];
    [(TiViewProxy *)[self proxy] contentsWillChange];
}

@end
