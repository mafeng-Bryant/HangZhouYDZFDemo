//
//  BackgroundDrawingInfo.h
//  GMEPS_HZ
//
//  Created by  on 11-11-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drawable.h"

@interface BackgroundDrawingInfo : NSObject <Drawable> {
    UIImage *image;
}
@property (retain, nonatomic) UIImage *image;

- (id)initWithImage:(UIImage *)img ;
@end
