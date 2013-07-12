/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 */

#import "TiUISearchBar+Extended.h"

@implementation TiUISearchBar (Extended)

//Helper function to get the TextField of the SearchBar 
-(UITextField*)searchTextField
{
    UISearchBar *search = [self searchBar];
    NSUInteger numViews = [[search subviews] count];
    for(int i = 0; i < numViews; i++) {
        if([[[search subviews] objectAtIndex:i] isKindOfClass:[UITextField class]]) {
            return [[search subviews] objectAtIndex:i];
        }
    }
    return nil;
}


-(void)setFont_:(id)fontValue
{
    UIFont *font = nil;
	if (fontValue!=nil){
		font = [[TiUtils fontValue:fontValue] font];
	} else {
		font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
	}
    UITextField *searchTextField = [self searchTextField];
    [searchTextField setFont:font];
}

-(void)setColor_:(id)color
{
	UIColor * newColor = [[TiUtils colorValue:color] _color];
    UITextField *searchTextField = [self searchTextField];
    [searchTextField setTextColor:(newColor != nil)?newColor:[UIColor darkTextColor]];
}

-(void)setShowsScopeBar_:(id)value
{
    [[self searchBar] setShowsScopeBar:value];
}

-(void)setScopeButtonTitles_:(id)array
{
    ENSURE_TYPE_OR_NIL(array,NSArray);
    if(array != nil)
        [[self searchBar] setScopeButtonTitles:array];
}

-(void)setCustomCancel_:(id)args
{
    ENSURE_SINGLE_ARG_OR_NIL(args, NSDictionary);
    if(args != nil){
        if ([args objectForKey:@"title"] != nil) {
            [[UIButton appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:[TiUtils stringValue:@"title" properties:args] forState:UIControlStateNormal];
        }
        
        if ([args objectForKey:@"barColor"] != nil) {
            UIColor * newColor = [[TiUtils colorValue:@"barColor" properties:args] _color];
            [[UIButton appearanceWhenContainedIn:[UISearchBar class], nil] setTintColor:(newColor != nil) ? newColor : [UIColor blackColor]];
        }
        
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        
        if ([args objectForKey:@"color"] != nil) {
            UIColor * textColor = [[TiUtils colorValue:@"color" properties:args] _color];
            [attributes setObject:(textColor != nil) ? textColor : [UIColor whiteColor] forKey:UITextAttributeTextColor];
        }
        
        if ([args objectForKey:@"font"] != nil) {
            NSDictionary * fontValue = [args objectForKey:@"font"];
            UIFont *font =  [[TiUtils fontValue:fontValue] font];
            [attributes setObject:font forKey:UITextAttributeFont];
        }
        
        //add values to searchbar cancel button
        if([[attributes allKeys] count] > 0){
            [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:attributes forState:UIControlStateNormal];
        }
        
        [[self searchBar] sizeToFit];
    }
}

-(void)setDisableSearchIcon_:(id)value
{
    //to remove search icon. Note that objectAtIndex = 0 because background layer is already removed
    UITextField *searchTextField = [self searchTextField];
    searchTextField.leftView = nil;
}


-(void)setBorderStyle_:(id)value
{
	UITextField *searchTextField = [self searchTextField];
    [searchTextField setBorderStyle:[TiUtils intValue:value]];
}

-(void)setSearchFieldBackgroundImage_:(id)image
{
    UITextField *searchTextField = [self searchTextField];
    [searchTextField setBackground: [UIImage imageNamed:[TiUtils stringValue:image]]];
}

//extend setBarColor
-(void)setBarColor_:(id)value
{
    NSString * color = [TiUtils stringValue:value];
    if( [color isEqualToString:@"transparent"] ){
        // Find SearchBar background and hide it.
        UISearchBar *search = [self searchBar];
        for( UIView *subview in [search subviews] ){
            if( [subview isKindOfClass:NSClassFromString( @"UISearchBarBackground" )] ){
                [subview setAlpha:0.0F];
                [subview setUserInteractionEnabled:FALSE];
                break;
            }
        }
    } else {
        TiColor * newBarColor = [TiUtils colorValue:value];
        UISearchBar *search = [self searchBar];
        [search setBarStyle:[TiUtils barStyleForColor:newBarColor]];
        [search setTintColor:[TiUtils barColorForColor:newBarColor]];
        [search setTranslucent:[TiUtils barTranslucencyForColor:newBarColor]];
    }
}

-(void)setAppearance_:(id)value
{
    UITextField *searchTextField = [self searchTextField];
	[searchTextField setKeyboardAppearance:[TiUtils intValue:value]];
}

@end