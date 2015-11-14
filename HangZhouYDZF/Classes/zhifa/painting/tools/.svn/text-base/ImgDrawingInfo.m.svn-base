//
//  ImgDrawingInfo.m
//  GMEPS_HZ
//
//  Created by zhang on 11-10-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ImgDrawingInfo.h"


@implementation ImgDrawingInfo
@synthesize location,image,imgSize;
    
- (id)initWithLocation:(CGPoint)pt andImage:(UIImage *)img {
    if ((self = [self init])) {
        location = pt;
        image = [img retain];

    }
    return self;
}

- (id)initWithLocation:(CGPoint)pt andSize:(CGSize)size andImage:(UIImage *)img{
    if ((self = [self init])) {
        location = pt;
        imgSize = size;
        image = [img retain];
        
    }
    return self;
}

- (void)draw {
//    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect imageRect;
	imageRect.origin = CGPointMake(location.x - imgSize.width/2, 
                                   location.y - imgSize.height/2);
	imageRect.size = imgSize;
	
    [image drawInRect:imageRect];
	//CGContextDrawImage(context, imageRect, image.CGImage);
}

@end
