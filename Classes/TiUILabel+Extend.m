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
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

static char highlightedRange;
static char highlightColor;

@implementation TiUILabel (Extend)

-(NSString *)highlightedRange
{
    return objc_getAssociatedObject(self, &highlightedRange);
}

-(void)setHighlightedRange:(NSString *)range
{
    objc_setAssociatedObject(self, &highlightedRange, range, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIColor *)highlightColor
{
    return objc_getAssociatedObject(self, &highlightColor);
}

-(void)setHighlightColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &highlightColor, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setAttributedText_:(id)args
{
    //Check if attributedText is supported. (iOS6 +)
    if (![[self label] respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    
    BOOL lpEV = NO;
    
    UILabel *_label = [self label];
    UIColor *_labelColor = [UIColor darkTextColor];
    
    NSString *text = [TiUtils stringValue:[args objectForKey:@"text"]]; //Grabs the text
    if([args objectForKey:@"color"]) {
        _labelColor = [[TiUtils colorValue:[args objectForKey:@"color"]] _color]; //Grabs the color if set
    }
    
    //Checks if there is a highlight color and set's it.
    if([args objectForKey:@"highlightColor"])
    {
        [self setHighlightColor:[[TiUtils colorValue:[args objectForKey:@"highlightColor"]] _color]];
    }
    else {
        [self setHighlightColor:[UIColor lightGrayColor]];
    }
    
    NSMutableAttributedString *attrS = [[NSMutableAttributedString alloc] initWithString:text];
    [attrS setAttributes:@{NSForegroundColorAttributeName:_labelColor} range:NSMakeRange(0, text.length)];
    
    NSArray *attributes = [args objectForKey:@"attributes"]; //Grabs the attributes
    
    //NSMutableArray *linkRanges = [[NSMutableArray alloc] init];
    
    for(id object in attributes) {
        
        NSRange range;
        
        if([object valueForKey:@"text"]) {
            NSString *str = [TiUtils stringValue:[object valueForKey:@"text"]];
            range = [text rangeOfString:str options:(NSCaseInsensitiveSearch)];
            
            [str release];
        }
        else if([object valueForKey:@"range"]) {
            NSArray *_r = [object valueForKey:@"range"];
            range = NSMakeRange([[_r objectAtIndex:0] integerValue], [[_r objectAtIndex:1] integerValue]);
            
            [_r release];
        }
        
        //If the substring or range wasn't found, do nothing.
        if(range.length == 0) {
            continue;
        }
        
        NSMutableDictionary *_attr = [[NSMutableDictionary alloc] init];
        
        //FONT
        if([object valueForKey:@"font"] != nil) {
            [_attr setObject:[[TiUtils fontValue:[object valueForKey:@"font"]] font] forKey:NSFontAttributeName];
        }
        
        //COLOR
        if([object valueForKey:@"color"] != nil) {
            
            UIColor *textColor = [[TiUtils colorValue:[object valueForKey:@"color"]] _color];
            
            [_attr setObject:(textColor !=nil)?textColor:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
        }
        else {
            [_attr setObject:_labelColor forKey:NSForegroundColorAttributeName];
        }
        
        //UNDERLINE
        if([object valueForKey:@"underline"] != nil) {
            int *uls = [[object valueForKey:@"underline"] integerValue];
            
            if(uls != NULL) {
                [_attr setObject:[NSNumber numberWithInt:uls] forKey:NSUnderlineStyleAttributeName];
            }
            
        }
        
        //BACKGROUND
        if([object valueForKey:@"backgroundColor"] != nil) {
            
            UIColor *bgColor = [[TiUtils colorValue:[object valueForKey:@"backgroundColor"]] _color];
            
            [_attr setObject:(bgColor !=nil)?bgColor:[UIColor lightGrayColor] forKey:NSBackgroundColorAttributeName];
            
        }
        
        //LINK
        if([object valueForKey:@"link"] != nil) {
            
            //Set the link on the text's attribute itself
            //We can easily fetch it later.
            [_attr setObject:[object valueForKey:@"link"] forKey:@"link"];
            
            if(!lpEV) {
                lpEV = YES;
                
                UIGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(longpressOnWord:)];
                
                [label  addGestureRecognizer:longPress];
                [label setUserInteractionEnabled:TRUE];
                
            }
            
        }
        
        //SHADOW : Non-working implementation
        /*if([object valueForKey:@"shadow"] != nil) {
            
            NSDictionary *shadowObject = [object valueForKey:@"shadow"];
            
            NSShadow *shadow = [[NSShadow alloc] init];
            
            //Shadow Color
            UIColor *shadowColor = [[TiUtils colorValue:[shadowObject objectForKey:@"shadowColor"]] _color];
            [shadow setShadowColor:(shadowColor != nil)?shadowColor:[UIColor blackColor]];
            
            shadow.shadowColor = (shadowColor != nil)?shadowColor : [UIColor blackColor];
            
            //Shadow Offset
            
            if([shadowObject objectForKey:@"shadowOffset"] != nil) {
                CGPoint p = [TiUtils pointValue:[shadowObject objectForKey:@"shadowOffset"]];
                CGSize shadowOffset = {p.x,p.y};
                shadow.shadowOffset = shadowOffset;
            }
            else {
                CGSize shadowOffset = {0.0,0.0};
                shadow.shadowOffset = shadowOffset;
            }
            
            //Shadow Blur Radius
            if([object valueForKey:@"shadowRadius"] != nil) {
                CGFloat shadowRadius = [[object valueForKey:@"shadowRadius"] floatValue];
                shadow.shadowBlurRadius = shadowRadius;
            }
            else {
                CGFloat shadowRadius = 0.0;
                shadow.shadowBlurRadius = shadowRadius;
            }
            
            [_attr setObject:shadow forKey:NSShadowAttributeName];
            
        }*/
        
        //Setting it all up
        [attrS setAttributes:_attr range:range];
        
        [_attr release];
        
    }
    
    //Set the text. Notify the proxy about contentChange
    [_label setAttributedText:attrS];
    [(TiViewProxy *)[self proxy] contentsWillChange];

}

-(void)longpressOnWord:(UILongPressGestureRecognizer *)gesture
{
    //If we don't have an event listener
    //Do nothing. Save processing power. ;)
    
    if(![self.proxy _hasListeners:@"longpress"]) {
        return;
    }
    
    if(gesture.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchPoint = [gesture locationOfTouch:0 inView:gesture.view];
        // Convert to coordinate system of current view
        touchPoint.y -= self.bounds.size.height;
        touchPoint.y *= -1;
        
        if(CGRectContainsPoint(self.bounds, touchPoint)) {
            
            CFIndex index = [self characterIndexAtPoint:touchPoint];
            
            NSDictionary *attrs = [label.attributedText attributesAtIndex:index effectiveRange:NULL];
            if(attrs != nil && [attrs valueForKey:@"link"] != nil)
            {
                
                NSString *link = [TiUtils stringValue:[attrs valueForKey:@"link"]];
                [self.proxy fireEvent:@"longpress" withObject:@{@"url": link}];
                
            }
            
        }
        
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if(![self.proxy _hasListeners:@"url"]) {
        return;
    }
    
    NSSet *allTouches = [event allTouches];
    
    if ([allTouches count] == 1)
    {
        UITouch *touch = (UITouch *)[allTouches anyObject];
        CGPoint touchPoint = [touch locationInView:self];
        
        // Convert to coordinate system of current view
        touchPoint.y -= self.bounds.size.height;
        touchPoint.y *= -1;
        
        if(CGRectContainsPoint(self.bounds, touchPoint)) {
            
            CFIndex index = [self characterIndexAtPoint:touchPoint];
            
            NSDictionary *attrs = [label.attributedText attributesAtIndex:index effectiveRange:NULL];
            if(attrs != nil && [attrs valueForKey:@"link"] != nil)
            {
                
                [self highlightWordContainingCharacterAtIndex:index];
                
            }
            
        }
        
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if(![self.proxy _hasListeners:@"url"]) {
        return;
    }
    
    NSSet *allTouches = [event allTouches];
    
    if ([allTouches count] == 1)
    {
        UITouch *touch = (UITouch *)[allTouches anyObject];
        CGPoint touchPoint = [touch locationInView:self];
        
        // Convert to coordinate system of current view
        touchPoint.y -= self.bounds.size.height;
        touchPoint.y *= -1;
        
        if(CGRectContainsPoint(self.bounds, touchPoint)) {
            
            CFIndex index = [self characterIndexAtPoint:touchPoint];
            
            NSDictionary *attrs = [label.attributedText attributesAtIndex:index effectiveRange:NULL];
            if(attrs != nil && [attrs valueForKey:@"link"] != nil)
            {

                [self highlightWordContainingCharacterAtIndex:index];
            
            }
            
        }
        
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //If we don't have an event listener
    //Do nothing. Save processing power. ;)
    
    if(![self.proxy _hasListeners:@"url"]) {
        return;
    }
    
    [self removeHighlight];
    
    NSSet *allTouches = [event allTouches];
    
    if ([allTouches count] == 1)
    {
        UITouch *touch = (UITouch *)[allTouches anyObject];
        CGPoint touchPoint = [touch locationInView:self];
        
        // Convert to coordinate system of current view
        touchPoint.y -= self.bounds.size.height;
        touchPoint.y *= -1;
        
        if(CGRectContainsPoint(self.bounds, touchPoint)) {
         
            CFIndex index = [self characterIndexAtPoint:touchPoint];
            
            NSDictionary *attrs = [label.attributedText attributesAtIndex:index effectiveRange:NULL];
            if(attrs != nil && [attrs valueForKey:@"link"] != nil)
            {
                
                NSString *link = [TiUtils stringValue:[attrs valueForKey:@"link"]];
                [self.proxy fireEvent:@"url" withObject:@{@"url": link}];
                
            }
            
        }
        
    }
    
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeHighlight];
}

/*
 * The following code has been adapted from
 * PPLabel by petrpavlik
 * It has been modified to fit the purpose of
 * this module wherever required.
 * https://github.com/petrpavlik/PPLabel/blob/master/PPLabel/PPLabel.m
 */

- (void)highlightWordContainingCharacterAtIndex:(CFIndex)charIndex
{
    if (charIndex==NSNotFound) {
        
        //user did nat click on any word
        [self removeHighlight];
        return;
    }
    
    NSString* string = label.text;
    
    //get the start and end positions
    NSRange end = [string rangeOfString:@" " options:0 range:NSMakeRange(charIndex, string.length - charIndex)];
    NSRange start = [string rangeOfString:@" " options:NSBackwardsSearch range:NSMakeRange(0, charIndex)];
    
    if (start.location == NSNotFound) {
        //We have the first word.
        start.location = 0;
    }
    
    if (end.location == NSNotFound) {
        //We have the last word
        end.location = string.length-1;
    }
    
    NSRange rangeForWord = NSMakeRange(start.location, end.location - start.location);
    
    //Fix word trimming
    if (start.location!=0) {
        rangeForWord.location += 1;
        rangeForWord.length -= 1;
    }
    
    //Check if have a word that is highlighted
    NSRange hr = NSRangeFromString(self.highlightedRange);
    
    if(hr.location != NSNotFound) {
        //We have a highlighted word
        
        //Check if the word is already highlighed
        if(rangeForWord.location == hr.location && rangeForWord.length == hr.length)
        {
            return;
        }
        else
        {
            [self removeHighlight];
        }
        
    }
    
    //Highlight the word
    NSMutableAttributedString* attributedString = [label.attributedText mutableCopy];
    NSDictionary *d = [attributedString attributesAtIndex:rangeForWord.location effectiveRange:NULL];
    UIColor *preColor = [d objectForKey:NSForegroundColorAttributeName];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:rangeForWord];
    [attributedString addAttribute:@"preColor" value:preColor range:rangeForWord];
    label.attributedText = attributedString;
    
    [self setHighlightedRange:NSStringFromRange(rangeForWord)];
    
}

- (void)removeHighlight {
    
    NSRange range = NSRangeFromString(self.highlightedRange);
    
    if (range.location != NSNotFound) {
        
        //remove highlight from previously selected word
        NSMutableAttributedString* attributedString = [label.attributedText mutableCopy];
        NSDictionary *d = [attributedString attributesAtIndex:range.location effectiveRange:NULL];
        UIColor *preColor = [d objectForKey:@"preColor"];
        
        [attributedString removeAttribute:@"preColor" range:range];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:preColor range:range];
        label.attributedText = attributedString;
        
        self.highlightedRange = NSStringFromRange(NSMakeRange(NSNotFound, 0));
    }
    
}

- (CFIndex)characterIndexAtPoint:(CGPoint)point {
    
    ////////
    
    NSMutableAttributedString* optimizedAttributedText = [label.attributedText mutableCopy];
    
    // use label's font and lineBreakMode properties in case the attributedText does not contain such attributes
    [label.attributedText enumerateAttributesInRange:NSMakeRange(0, [label.attributedText length]) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        
        if (!attrs[(NSString*)kCTFontAttributeName]) {
            
            [optimizedAttributedText addAttribute:(NSString*)kCTFontAttributeName value:label.font range:NSMakeRange(0, [label.attributedText length])];
        }
        
        if (!attrs[(NSString*)kCTParagraphStyleAttributeName]) {
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineBreakMode:label.lineBreakMode];
            
            [optimizedAttributedText addAttribute:(NSString*)kCTParagraphStyleAttributeName value:paragraphStyle range:range];
        }
    }];
    
    // modify kCTLineBreakByTruncatingTail lineBreakMode to kCTLineBreakByWordWrapping
    [optimizedAttributedText enumerateAttribute:(NSString*)kCTParagraphStyleAttributeName inRange:NSMakeRange(0, [optimizedAttributedText length]) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        
        NSMutableParagraphStyle* paragraphStyle = [value mutableCopy];
        
        if ([paragraphStyle lineBreakMode] == kCTLineBreakByTruncatingTail) {
            [paragraphStyle setLineBreakMode:kCTLineBreakByWordWrapping];
        }
        
        [optimizedAttributedText removeAttribute:(NSString*)kCTParagraphStyleAttributeName range:range];
        [optimizedAttributedText addAttribute:(NSString*)kCTParagraphStyleAttributeName value:paragraphStyle range:range];
    }];
    
    ////////
    
    if (!CGRectContainsPoint(self.bounds, point)) {
        return NSNotFound;
    }
    
    CGRect textRect = [self textRect];
    
    //NSLog(@"%@", NSStringFromCGRect(textRect));
    
    if (!CGRectContainsPoint(textRect, point)) {
        return NSNotFound;
    }
    
    // Offset tap coordinates by textRect origin to make them relative to the origin of frame
    point = CGPointMake(point.x - textRect.origin.x, point.y - textRect.origin.y);
    // Convert tap coordinates (start at top left) to CT coordinates (start at bottom left)
    point = CGPointMake(point.x, textRect.size.height - point.y);
    
    //////
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)optimizedAttributedText);
    
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, textRect);
    
    
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [label.attributedText length]), path, NULL);
    
    if (frame == NULL) {
        CFRelease(path);
        return NSNotFound;
    }
    
    
    
    CFArrayRef lines = CTFrameGetLines(frame);
    
    NSInteger numberOfLines = label.numberOfLines > 0 ? MIN(label.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines);
    
    //NSLog(@"num lines: %d", numberOfLines);
    
    if (numberOfLines == 0) {
        CFRelease(frame);
        CFRelease(path);
        return NSNotFound;
    }
    
    NSUInteger idx = NSNotFound;
    
    CGPoint lineOrigins[numberOfLines];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), lineOrigins);
    
    for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {
        
        CGPoint lineOrigin = lineOrigins[lineIndex];
        CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
        
        // Get bounding information of line
        CGFloat ascent, descent, leading, width;
        width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        CGFloat yMin = floor(lineOrigin.y - descent);
        CGFloat yMax = ceil(lineOrigin.y + ascent);
        
        // Check if we've already passed the line
        if (point.y > yMax) {
            break;
        }
        
        // Check if the point is within this line vertically
        if (point.y >= yMin) {
            
            // Check if the point is within this line horizontally
            if (point.x >= lineOrigin.x && point.x <= lineOrigin.x + width) {
                
                // Convert CT coordinates to line-relative coordinates
                CGPoint relativePoint = CGPointMake(point.x - lineOrigin.x, point.y - lineOrigin.y);
                idx = CTLineGetStringIndexForPosition(line, relativePoint);
                
                break;
            }
        }
    }
    
    CFRelease(frame);
    CFRelease(path);
    
    return idx;
}

#pragma mark --

- (CGRect)textRect {
    
    CGRect textRect = [label textRectForBounds:self.bounds limitedToNumberOfLines:label.numberOfLines];
    textRect.origin.y = (self.bounds.size.height - textRect.size.height)/2;
    
    if (label.textAlignment == NSTextAlignmentCenter) {
        textRect.origin.x = (self.bounds.size.width - textRect.size.width)/2;
    }
    if (label.textAlignment == NSTextAlignmentRight) {
        textRect.origin.x = self.bounds.size.width - textRect.size.width;
    }
    
    return textRect;
}

@end