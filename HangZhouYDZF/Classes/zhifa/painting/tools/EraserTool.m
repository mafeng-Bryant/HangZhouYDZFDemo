//
//  EraserTool.m
//  Dudel
//
//  Created by chen on 11-6-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EraserTool.h"
#import "PathDrawingInfo.h"

#import "SynthesizeSingleton.h"


@implementation EraserTool




@synthesize delegate;

SYNTHESIZE_SINGLETON_FOR_CLASS(EraserTool);

- init {
	if ((self = [super init])) {
		trackingTouches = [[NSMutableArray array] retain];
		startPoints = [[NSMutableArray array] retain];
		paths = [[NSMutableArray array] retain];

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
	[paths removeAllObjects];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UIView *touchedView = [delegate viewForUseWithTool:self];
	for (UITouch *touch in [event allTouches]) {
		// remember the touch, and its original start point, for future
		[trackingTouches addObject:touch];
		CGPoint location = [touch locationInView:touchedView];
		[startPoints addObject:[NSValue valueWithCGPoint:location]];
		
		UIBezierPath *path = [UIBezierPath bezierPath];
		path.lineCapStyle = kCGLineCapRound;
		[path moveToPoint:location];
		[path setLineWidth:20];
		[path addLineToPoint:location];
		
		[paths addObject:path];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	for (UITouch *touch in [event allTouches]) {
		// make a line from the start point to the current point
		NSUInteger touchIndex = [trackingTouches indexOfObject:touch];
		// only if we actually remember the start of this touch...
		if (touchIndex != NSNotFound) {
			UIBezierPath *path = [paths objectAtIndex:touchIndex];
			PathDrawingInfo *info = [PathDrawingInfo pathDrawingInfoWithPath:path fillColor:[UIColor clearColor]  strokeColor:[UIColor  whiteColor]];
			[delegate addDrawable:info];
			[trackingTouches removeObjectAtIndex:touchIndex];
			[startPoints removeObjectAtIndex:touchIndex];
			[paths removeObjectAtIndex:touchIndex];
		}
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UIView *touchedView = [delegate viewForUseWithTool:self];
	for (UITouch *touch in [event allTouches]) {
		// make a line from the start point to the current point
		NSUInteger touchIndex = [trackingTouches indexOfObject:touch];
		// only if we actually remember the start of this touch...
		if (touchIndex != NSNotFound) {
			CGPoint location = [touch locationInView:touchedView];
			UIBezierPath *path = [paths objectAtIndex:touchIndex];
			[path addLineToPoint:location];
		}
	}
}

- (void)drawTemporary {
	for (UIBezierPath *path in paths) {
		[delegate.strokeColor setStroke];
		[path stroke];
	}
}

- (void)dealloc {
	[trackingTouches release];
	[startPoints release];
	[paths release];
	self.delegate = nil;
	[super dealloc];
}

@end

