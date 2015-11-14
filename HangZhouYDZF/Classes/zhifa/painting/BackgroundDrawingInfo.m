//
//  BackgroundDrawingInfo.m
//  GMEPS_HZ
//
//  Created by  on 11-11-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "BackgroundDrawingInfo.h"

@implementation BackgroundDrawingInfo
@synthesize image;

- (id)initWithImage:(UIImage *)img {
    if ((self = [self init])) {
        image = [img retain];
        
    }
    return self;
}

- (void)draw {
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect imageRect;
	imageRect.origin = CGPointMake(0.0f, 
                                   0.0f);
	imageRect.size = image.size;
	
    [image drawInRect:imageRect];
	//CGContextDrawImage(context, imageRect, image.CGImage);
}

@end

