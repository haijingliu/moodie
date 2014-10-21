//
//  MOODYHorizontalGestureRecognizer.h
//  moody
//
//  Created by Ran Ma on 13-10-07.
//  Copyright (c) 2013 contextmix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOODYHorizontalGestureRecognizer : UIGestureRecognizer
{
    CGPoint startTouchPoint;
    CGPoint currentTouchPoint;
    BOOL isPanningHorizontally;
}

- (void)reset;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end