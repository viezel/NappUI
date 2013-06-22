/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 *
 * Inspired by KATAOKA,Atsushi
 */


#import "TiUtils.h"
#import "TiUIView+Gestures.h"

@interface GESTURES_FIXCATEGORYBUG_TIUIVIEW @end
@implementation GESTURES_FIXCATEGORYBUG_TIUIVIEW @end

#define RECOGNIZE_SIMULTANEOUSLY_ROTATE (1 << 16)
#define RECOGNIZE_SIMULTANEOUSLY_PAN    (1 << 15)
#define RECOGNIZE_SIMULTANEOUSLY_PINCH  (1 << 14)
#define RECOGNIZE_SIMULTANEOUSLY_ALL    (RECOGNIZE_SIMULTANEOUSLY_ROTATE|RECOGNIZE_SIMULTANEOUSLY_PAN|RECOGNIZE_SIMULTANEOUSLY_PINCH)

@implementation TiUIView (Gestures)

- (void)setRecognizeSimultaneously_:(id)value
{
    if([value isKindOfClass:[NSNumber class]]){
        BOOL value_ = [value boolValue];
        
        if(value_)
        {
            NSLog(@"[DEBUG] RecognizeSimultaneously to true.");
            for(UIGestureRecognizer *gesture in self.gestureRecognizers)
            {
                gesture.delegate = self;
            }
            self.tag |= RECOGNIZE_SIMULTANEOUSLY_ALL;
        }
        else
        {
            NSLog(@"[DEBUG] RecognizeSimultaneously to false.");
            for(UIGestureRecognizer *gesture in self.gestureRecognizers)
            {
                gesture.delegate = nil;
            }
            self.tag &= ~RECOGNIZE_SIMULTANEOUSLY_ALL;
        }        
    }else if([value isKindOfClass:[NSString class]]){
        self.tag &= ~RECOGNIZE_SIMULTANEOUSLY_ALL;
        NSArray *components = [value componentsSeparatedByString:@","];
        for(NSString *component in components){
            if([component isEqualToString:@"pinching"]){
                self.tag |= RECOGNIZE_SIMULTANEOUSLY_PINCH;
                NSLog(@"[DEBUG] RecognizeSimultaneously to pinch.");
            }
            if([component isEqualToString:@"pan"]){
                self.tag |= RECOGNIZE_SIMULTANEOUSLY_PAN;
                NSLog(@"[DEBUG] RecognizeSimultaneously to pan.");
            }
            if([component isEqualToString:@"rotate"]){
                self.tag |= RECOGNIZE_SIMULTANEOUSLY_ROTATE;
                NSLog(@"[DEBUG] RecognizeSimultaneously to rotate.");
            }
        }
    }else{
        NSLog(@"[WARN] recognizeSimultaneously property is invalid.");
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    BOOL result = NO;
    if([otherGestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]){
        result = (self.tag & RECOGNIZE_SIMULTANEOUSLY_PINCH) ? YES : NO;
    }
    
    if([otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
        result = (self.tag & RECOGNIZE_SIMULTANEOUSLY_PAN) ? YES : NO;        
    }

    if([otherGestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]]){
        result = (self.tag & RECOGNIZE_SIMULTANEOUSLY_ROTATE) ? YES : NO;
    }
    
    //NSLog(@"[DEBUG] recognizer:%@ other:%@ result:%d tag:%d", [gestureRecognizer class], [otherGestureRecognizer class], result, self.tag);
    return result;
}

- (void)handleRotationGesture:(UIRotationGestureRecognizer *)sender
{
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:
               [NSNumber numberWithFloat:[sender rotation]], @"rotation",
               [NSNumber numberWithFloat:[sender velocity]], @"velocity", nil];
    if([self.proxy _hasListeners:@"rotate"]){
        [self.proxy fireEvent:@"rotate" withObject:args];
    }
    
    if(sender.state == UIGestureRecognizerStateEnded && 
       [self.proxy _hasListeners:@"rotateend"]){
        [self.proxy fireEvent:@"rotateend"];
    }
}
    
- (void)setRotateGesture_:(id)value
{
    ENSURE_SINGLE_ARG(value, NSNumber);
    BOOL value_ = [value boolValue];
    
    if(value_){
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIRotationGestureRecognizer class]]){
                return;
            }
        }
        
        UIRotationGestureRecognizer *rotationGesture =[[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(handleRotationGesture:)];
        [self addGestureRecognizer:rotationGesture];
        
        if(self.tag & RECOGNIZE_SIMULTANEOUSLY_ROTATE)
        {
            rotationGesture.delegate = self;
        }
        
        [rotationGesture release];
    } else{
        UIGestureRecognizer *rotationGesture = nil;
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIRotationGestureRecognizer class]]){
                rotationGesture = gesure;
                break;
            }
        }
        
        rotationGesture.delegate = nil;
        
        if(rotationGesture){
            [self removeGestureRecognizer:rotationGesture];
        }
    }    
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender
{
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithFloat:[sender scale]], @"scale",
                          [NSNumber numberWithFloat:[sender velocity]], @"velocity", nil];
    if([self.proxy _hasListeners:@"pinching"]){
        [self.proxy fireEvent:@"pinching" withObject:args];
    }
    
    if(sender.state == UIGestureRecognizerStateEnded && 
       [self.proxy _hasListeners:@"pinchingend"]){
        [self.proxy fireEvent:@"pinchingend"];
    }
}

- (void)setPinchingGesture_:(id)value
{
    ENSURE_SINGLE_ARG(value, NSNumber);
    BOOL value_ = [value boolValue];
    
    if(value_){
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIPinchGestureRecognizer class]]){
                return;
            }
        }
        
        
        UIPinchGestureRecognizer *pinchGesture =[[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(handlePinchGesture:)];
        [self addGestureRecognizer:pinchGesture];
        
        if(self.tag & RECOGNIZE_SIMULTANEOUSLY_PINCH)
        {
            pinchGesture.delegate = self;
        }
        [pinchGesture release];
    } else{
        UIGestureRecognizer *pinchGesture = nil;
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIPinchGestureRecognizer class]]){
                pinchGesture = gesure;
                break;
            }
        }
        
        pinchGesture.delegate = self;
        
        if(pinchGesture){
            [self removeGestureRecognizer:pinchGesture];
        }
    }        
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self.superview];
    CGPoint velocity = [sender velocityInView:self.superview];
    
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:
                          [[[TiPoint alloc] initWithPoint:translation] autorelease], @"translation",
                          [[[TiPoint alloc] initWithPoint:velocity] autorelease], @"velocity", nil];
    if([self.proxy _hasListeners:@"pan"]){
        [self.proxy fireEvent:@"pan" withObject:args];
    }
    
    if(sender.state == UIGestureRecognizerStateEnded && 
       [self.proxy _hasListeners:@"panend"]){
        [self.proxy fireEvent:@"panend"];
    }
}

- (void)setPanGesture_:(id)value
{
    ENSURE_SINGLE_ARG(value, NSNumber);
    BOOL value_ = [value boolValue];
    
    if(value_){
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIPanGestureRecognizer class]]){
                return;
            }
        }
        
        UIPanGestureRecognizer *panGesture =[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handlePanGesture:)];
        [self addGestureRecognizer:panGesture];
        
        if(self.tag & RECOGNIZE_SIMULTANEOUSLY_PAN)
        {
            panGesture.delegate = self;
        }
        [panGesture release];
    } else{
        UIGestureRecognizer *panGesture = nil;
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIPanGestureRecognizer class]]){
                panGesture = gesure;
                break;
            }
        }
        
        panGesture.delegate = nil;
        
        if(panGesture){
            [self removeGestureRecognizer:panGesture];
        }
    }        
}
@end
