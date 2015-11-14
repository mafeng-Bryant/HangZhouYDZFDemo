//
//  ArrowDashLine.m
//  GMEPS_HZ
//
//  Created by Apple on 12-3-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ArrowDashLine.h"
#import "PathDrawingInfo.h"

#import "SynthesizeSingleton.h"
@implementation ArrowDashLine

@synthesize delegate;

SYNTHESIZE_SINGLETON_FOR_CLASS(ArrowDashLine);

- init {
    if ((self = [super init])) {
        trackingTouches = [[NSMutableArray arrayWithCapacity:100] retain];
        startPoints = [[NSMutableArray arrayWithCapacity:100] retain];
    }
    return self;
}
- (void)activate {
}

-(void)deleteLastPoint:(BOOL)isDelete{
}

- (void)deactivate {
    [trackingTouches removeAllObjects];
    [startPoints removeAllObjects];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UIView *touchedView = [delegate viewForUseWithTool:self];
    for (UITouch *touch in [event allTouches]) {
        // remember the touch, and its original start point, for future
        [trackingTouches addObject:touch];
        ////NSLog(@"shuliang:%@",trackingTouches);
        CGPoint location = [touch locationInView:touchedView];
        [startPoints addObject:[NSValue valueWithCGPoint:location]];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

-(void)AddDashStyleToPath:(UIBezierPath*)thePath
{
    // Set the line dash pattern.
    float lineDash[6];
    
    lineDash[0] = 8.0;
    lineDash[1] = 8.0;
    lineDash[2] = 8.0;
    lineDash[3] = 8.0;
    lineDash[4] = 8.0;
    lineDash[5] = 8.0;
    
    [thePath setLineDash:lineDash count:6 phase:0.0];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UIView *touchedView = [delegate viewForUseWithTool:self];
    for (UITouch *touch in [event allTouches]) {
        // make a line from the start point to the current point
        NSUInteger touchIndex = [trackingTouches indexOfObject:touch];
        // only if we actually remember the start of this touch...
        if (touchIndex != NSNotFound) {
            
            CGPoint startPoint = [[startPoints objectAtIndex:touchIndex] CGPointValue];
            CGPoint endPoint = [touch locationInView:touchedView];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:startPoint];
            [path addLineToPoint:endPoint];
            [self AddDashStyleToPath:path];
            /*[path moveToPoint:startPoint];
             [path addLineToPoint:endPoint];
             [self AddDashStyleToPath:path];
             */
            //[path stroke];
            
            
            double slopy , cosy , siny;
            double Par = 15.0;  //length of Arrow (>)
            slopy = atan2( ( endPoint.y - startPoint.y),
                          ( endPoint.x - startPoint.x) );
            cosy = cos( slopy );
            siny = sin( slopy ); //need math.h for these functions
            
            
            
            
            /*/-------------similarly the the other end-------------/*/
            [path moveToPoint:endPoint];
            [path addLineToPoint:CGPointMake( endPoint.x - ( Par * cosy - ( Par / 2.0 * siny )),
                                             endPoint.y - ( Par * siny + ( Par / 2.0 * cosy)))];
            [path addLineToPoint:CGPointMake( endPoint.x -( Par * cosy + Par / 2.0 * siny ),
                                             endPoint.y + (Par / 2.0 * cosy - Par * siny ))];
            [path addLineToPoint:endPoint];
            [path fill];
            PathDrawingInfo *info = [PathDrawingInfo pathDrawingInfoWithPath:path fillColor:[UIColor blackColor] strokeColor:delegate.strokeColor];
            [delegate addDrawable:info];
            [trackingTouches removeObjectAtIndex:touchIndex];
            [startPoints removeObjectAtIndex:touchIndex];
            
        }
    }
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)drawTemporary {
    UIView *touchedView = [delegate viewForUseWithTool:self];
    
    for (int i = 0; i<[trackingTouches count]; i++) {
        UITouch *touch = [trackingTouches objectAtIndex:i];
        CGPoint startPoint = [[startPoints objectAtIndex:i] CGPointValue];
        CGPoint endPoint = [touch locationInView:touchedView];
        /* UIBezierPath *path = [UIBezierPath bezierPath];
         [self AddDashStyleToPath:path];
         [path moveToPoint:startPoint];
         [path addLineToPoint:endPoint];
         [path stroke];
         */
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:startPoint];
        [path addLineToPoint:endPoint];
        [self AddDashStyleToPath:path];
        
        /*[path moveToPoint:startPoint];
         [path addLineToPoint:endPoint];
         [self AddDashStyleToPath:path];
         */
        //[path stroke];
        
        
        double slopy , cosy , siny;
        double Par = 15.0;  //length of Arrow (>)
        slopy = atan2( ( endPoint.y - startPoint.y),
                      ( endPoint.x - startPoint.x) );
        cosy = cos( slopy );
        siny = sin( slopy ); //need math.h for these functions
        
        /*/-------------similarly the the other end-------------/*/
        [path moveToPoint:endPoint];
        [path addLineToPoint:CGPointMake( endPoint.x - ( Par * cosy - ( Par / 2.0 * siny )),
                                         endPoint.y - ( Par * siny + ( Par / 2.0 * cosy)))];
        [path addLineToPoint:CGPointMake( endPoint.x -( Par * cosy + Par / 2.0 * siny ),
                                         endPoint.y + (Par / 2.0 * cosy - Par * siny ))];
        [path addLineToPoint:endPoint];
        
        
        
        [delegate.strokeColor setStroke];
        [path stroke];
        [[UIColor blackColor] setFill];
        [path fill];
    }
    
}

- (void)dealloc {
    [trackingTouches release];
    [startPoints release];
    self.delegate = nil;
    [super dealloc];
}


@end
