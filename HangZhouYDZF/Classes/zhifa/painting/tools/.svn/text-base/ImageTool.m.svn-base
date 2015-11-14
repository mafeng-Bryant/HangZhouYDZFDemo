//
//  ImageTool.m
//  GMEPS_HZ
//
//  Created by zhang on 11-10-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ImageTool.h"
#import "PathDrawingInfo.h"
#import "SynthesizeSingleton.h"
#import "ImgDrawingInfo.h"

@implementation ImageTool
@synthesize delegate,bAnotherImg;

SYNTHESIZE_SINGLETON_FOR_CLASS(ImageTool);

- init {
	if ((self = [super init])) {
		trackingTouches = [[NSMutableArray array] retain];
		startPoints = [[NSMutableArray array] retain];

        
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
    if (!bAnotherImg) {
        return;
    }
	imgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xuexiao.png"]] autorelease];
     UIView *touchedView = [delegate viewForUseWithTool:self];
     UITouch *touch = [[event allTouches] anyObject];
     CGPoint location = [touch locationInView:touchedView];
    imgView.center = location;
    [touchedView addSubview:imgView];

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!bAnotherImg) {
        return;
    }
    bAnotherImg = NO;
    UIView *touchedView = [delegate viewForUseWithTool:self];
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touchedView];
    imgView.center = location;
    ImgDrawingInfo *info = [[ImgDrawingInfo alloc] initWithLocation:location andSize:imgView.frame.size andImage:imgView.image];
    [delegate addDrawable:info];
    [info release];
   //  [imgView removeFromSuperview];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!bAnotherImg) {
        return;
    }
    UIView *touchedView = [delegate viewForUseWithTool:self];
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touchedView];
    imgView.center = location;
}

- (void)drawTemporary {
    
}

- (void)dealloc {
	[trackingTouches release];
	[startPoints release];
	self.delegate = nil;
	[super dealloc];
}

@end
