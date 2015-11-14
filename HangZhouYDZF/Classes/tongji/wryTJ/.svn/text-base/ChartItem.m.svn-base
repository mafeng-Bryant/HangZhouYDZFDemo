//
//  ChartItem.m
//  MyChartDemo
//
//  Created by chen on 11-7-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChartItem.h"


@implementation ChartItem

@synthesize color = _color;
@synthesize value = _value;
@synthesize name  = _name;
- (id)init
{	
    if ((self = [super init])) {
		_value = 0.0;
	}
	return self;
}

-(void)dealloc{
    CGColorRelease(_color);
    [_name release];
    [super dealloc];
}

- (id)initWithValue:(float)val Name:(NSString*)title Color:(CGColorRef)aColor{
	if ((self = [super init])) {
		_value = val;
		_name = [title copy];
		_color =  CGColorCreateCopy( aColor);
	}
	return self;
}

+(id)itemWithValue:(float)val Name:(NSString*)title Color:(CGColorRef)aColor{
	return [[[self alloc] initWithValue:val Name:title Color:aColor ] autorelease];
}

+ (void)makeColorArray:(NSMutableArray *)colors {
    [colors addObject:[UIColor colorWithRed:(0x00/255.0f) green:(0xb0/255.0f) blue:(0xf0/255.0f) alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:(0xff/255.0f) green:(0xff/255.0f) blue:(0x00/255.0f) alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:(0xff/255.0f) green:(0x00/255.0f) blue:(0x00/255.0f) alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:(0xff/255.0f) green:(0xc0/255.0f) blue:(0x00/255.0f) alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:(0x3c/255.0f) green:(0x8d/255.0f) blue:(0xa3/255.0f) alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:(0xcc/255.0f) green:(0x7b/255.0f) blue:(0x38/255.0f) alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:(0x4f/255.0f) green:(0x81/255.0f) blue:(0xbd/255.0f) alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:(0x00/255.0f) green:(0xb0/255.0f) blue:(0x50/255.0f) alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:(0x9b/255.0f) green:(0xbb/255.0f) blue:(0x59/255.0f) alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:(0x80/255.0f) green:(0x64/255.0f) blue:(0xa2/255.0f) alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:(0x4b/255.0f) green:(0xac/255.0f) blue:(0xc6/255.0f) alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:(0xf7/255.0f) green:(0x96/255.0f) blue:(0x46/255.0f) alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:(0xaa/255.0f) green:(0xba/255.0f) blue:(0xd7/255.0f) alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:(0x72/255.0f) green:(0x00/255.0f) blue:(0xff/255.0f) alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:(0x9e/255.0f) green:(0x1e/255.0f) blue:(0x00/255.0f) alpha:1.0]];

    [colors addObject:[UIColor grayColor]];
    [colors addObject:[UIColor grayColor]];
}
@end

