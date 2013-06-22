/**
 * Module developed by Napp
 * Author Mads Møller
 * www.napp.dk
 */

#import "TiUIView+Animation.h"

@implementation TiUIView (animation)

/*

WORK IN PROGRESS !
 
- (void)fadeInWithDelay:(CGFloat)delay duration:(CGFloat)duration{
    
	[UIView beginAnimations:@"fadeIn" context:nil];
	[UIView setAnimationDelay:delay];
	[UIView setAnimationDuration:duration];
	self.alpha=1;
	[UIView commitAnimations];
}

- (void)fadeOutWithDelay:(CGFloat)delay duration:(CGFloat)duration{
	
	[UIView beginAnimations:@"fadeOut" context:nil];
	[UIView setAnimationDelay:delay];
	[UIView setAnimationDuration:duration];
	self.alpha=0;
	[UIView commitAnimations];
	
}

- (void)translateToFrame:(CGRect)aFrame delay:(CGFloat)delay duration:(CGFloat)duration{
	
	[UIView beginAnimations:@"slide" context:nil];
	[UIView setAnimationDelay:delay];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	self.frame=aFrame;
	[UIView commitAnimations];
	
}

-(void)shrinkToSize:(CGSize)aSize withDelay:(CGFloat)delay duration:(CGFloat)duration{
	
	CGRect myNewFrame= self.frame;
	myNewFrame.size=aSize;
	myNewFrame.origin=CGPointMake(self.frame.origin.x+self.frame.size.width/2-myNewFrame.size.width/2,self.frame.origin.y+self.frame.size.height/2-myNewFrame.size.height/2);
	
	[UIView beginAnimations:@"shrink" context:nil];
	[UIView setAnimationDuration:.5];
	self.frame=myNewFrame;
	[UIView commitAnimations];
	
}


- (void)changeColor:(UIColor *)aColor withDelay:(CGFloat)delay duration:(CGFloat)duration{
	
	[UIView beginAnimations:@"changeColor" context:nil];
	[UIView setAnimationDelay:delay];
	[UIView setAnimationDuration:duration];
	[self setBackgroundColor:[UIColor lightGrayColor]];
	[UIView commitAnimations];
	
}

- (void)rotate:(float)degrees{
	
	CGAffineTransform rotateTransform = self.transform;
	rotateTransform = CGAffineTransformRotate(rotateTransform, degreesToRadians(degrees));
	self.transform = rotateTransform;
    
}
*/

@end

