//
//  ImgDrawingInfo.h
//  GMEPS_HZ
//
//  Created by zhang on 11-10-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drawable.h"

@interface ImgDrawingInfo : NSObject <Drawable> {
    CGPoint location;
    UIImage *image;

}

@property (assign, nonatomic) CGPoint location;
@property (assign, nonatomic) CGSize imgSize;

@property (retain, nonatomic) UIImage *image;

- (id)initWithLocation:(CGPoint)pt andImage:(UIImage *)img ;

- (id)initWithLocation:(CGPoint)pt andSize:(CGSize)size andImage:(UIImage *)img ;
@end
