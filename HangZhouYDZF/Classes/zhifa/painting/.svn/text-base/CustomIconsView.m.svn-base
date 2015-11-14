//
//  CustomIconsView.m
//  GMEPS_HZ
//
//  Created by  on 11-12-6.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CustomIconsView.h"
#import "BarBackgroundLayer.h"
#import "UIIconItem.h"

@implementation CustomIconsView
@synthesize itemCount;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        itemCount = 0;
        [self setBackgroundLayer:[[[BarBackgroundLayer alloc] init] autorelease]];
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

-(void)addIconItem:(UIIconItem*)item{
    
    float btnWidth = 70.0f,btnGap = 15.0f,btnHeight = 70.0f;
    item.tag = itemCount;
    item.frame = CGRectMake(btnWidth*itemCount+btnGap, btnGap, btnWidth, btnHeight);
    [self addSubview:item];
    
    itemCount++;
}

- (void)setBackgroundLayer:(CALayer *)backgroundLayer;
{
    CALayer * oldBackground = [[self.layer sublayers] objectAtIndex:0];
    if (oldBackground)
    {
        [self.layer replaceSublayer:oldBackground with:backgroundLayer];
    }
    else
    {
        [self.layer insertSublayer:backgroundLayer atIndex:0];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
