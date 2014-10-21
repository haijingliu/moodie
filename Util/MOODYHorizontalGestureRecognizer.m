//
//  MOODYHorizontalGestureRecognizer.m
//  moody
//
//  Created by Ran Ma on 13-10-07.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import "MOODYHorizontalGestureRecognizer.h"

#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation MOODYHorizontalGestureRecognizer

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    startTouchPoint = [[touches anyObject] locationInView:nil];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    currentTouchPoint = [[touches anyObject] locationInView:nil];
    
    if ( !isPanningHorizontally ) {
        
        float touchSlope = fabsf((currentTouchPoint.y - startTouchPoint.y) / (currentTouchPoint.x - startTouchPoint.x));
        
        if ( touchSlope < 1 ) {
            self.state = UIGestureRecognizerStateBegan;
            isPanningHorizontally = YES;
            [self.view touchesCancelled:touches withEvent:event];
        } else {
            self.state = UIGestureRecognizerStateCancelled;
            [self.view touchesCancelled:touches withEvent:event];
        }
        
    } else {
        self.state = UIGestureRecognizerStateChanged;
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.state = UIGestureRecognizerStateCancelled;
    [self.view touchesCancelled:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.state = UIGestureRecognizerStateCancelled;
}

-(void)reset
{
    [super reset];
    startTouchPoint = CGPointZero;
    currentTouchPoint = CGPointZero;
    isPanningHorizontally = NO;
}

@end
