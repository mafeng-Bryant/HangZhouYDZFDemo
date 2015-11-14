//
//  CLMButtonBar.m
//  draw
//
//  Created by cocoa on 12/16/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CLMButtonBar.h"
#define BTNS_HEIGHT 500

@implementation CLMButtonBar
@synthesize btns;
@synthesize selectedIndex;
@synthesize _delegate;

- (CLMButtonBar *)initWithItems:(NSMutableArray *)items  delegate:(id<CLMButtonBarDelegate>)delegate  frame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) 
	{
        // Initialization code
		self.backgroundColor = [UIColor clearColor]; //可以自己定义颜色
		self.btns = items;
		self.selectedIndex = 0;
		self._delegate = delegate;
    }
	return self;
}

-(void)setSelectedIndex:(int)index
{
	selectedIndex = index;
	[self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	
	[super drawRect:rect];
	
	UIColor *bgColor = [UIColor  purpleColor];
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 2.0);
	float minX = CGRectGetMinX(rect), maxX = CGRectGetMaxX(rect);
	float minY	 = CGRectGetMinY(rect), maxY = CGRectGetMaxY(rect) - 1.0;
	float radius = 8.0;
	float height = BTNS_HEIGHT/[btns count];
	float btnwidth = 65;
	
	CGContextMoveToPoint(context, maxX, minY);
	CGContextAddLineToPoint(context, minX, minY);
	
	//CGContextAddLineToPoint(context, 10+width*selectedIndex, maxy);
	CGContextAddArcToPoint(context,minX, 20+height*selectedIndex , minX+radius,20+height*selectedIndex ,radius);
	CGContextAddArcToPoint(context,minX+btnwidth ,20+ height*selectedIndex, minX+btnwidth, 20+height*selectedIndex+radius, radius);

	CGContextAddArcToPoint(context, minX+btnwidth, 20+height*(selectedIndex+1), minX,20+ height*(selectedIndex+1), radius);
	CGContextAddArcToPoint(context,  minX, 20+height*(selectedIndex+1), minX, maxY, radius);
	
	CGContextAddLineToPoint(context,minX, 20+height*(selectedIndex+1));
	CGContextAddLineToPoint(context, minX,maxY );
	CGContextAddLineToPoint(context, maxX, maxY);
	CGContextAddLineToPoint(context, maxX, minY);
	CGContextClosePath(context);
	CGContextSetStrokeColorWithColor(context, bgColor.CGColor);
	CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
	[[UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0] setFill];
	CGContextDrawPath(context,kCGPathFill);
	
	CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
	/*NSString *cc  = [btns objectAtIndex:selectedIndex];
	CGSize sz = [cc sizeWithFont:[UIFont boldSystemFontOfSize:16]];
    [cc drawAtPoint:CGPointMake( 10+width*selectedIndex +(width-sz.width)/2.0  ,maxy -height+(height - sz.height) /2.0)     withFont:[UIFont boldSystemFontOfSize:16]];
	CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	
	for(int i=0;i<[btns count]; i++)
	{
		if(i!= selectedIndex)
		{
			NSString *str = [btns objectAtIndex:i];
			CGSize szz = [str sizeWithFont:[UIFont boldSystemFontOfSize:16]];
			[str  drawAtPoint:CGPointMake(10+width*i +(width-szz.width)/2.0 , maxy -height+(height - szz.height)/ 2.0) withFont:[UIFont boldSystemFontOfSize:16]];
		}
	}*/
	NSString *str =[NSString stringWithFormat:@"tab%d_1.png",selectedIndex+1];
	//CGSize szz = CGSizeMake(60, 60);
	UIImage *image = [UIImage imageNamed:str];
	[image  drawAtPoint:CGPointMake(minX, height*selectedIndex+42)];
	
	CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	
	for(int i=0;i<[btns count]; i++)
	{
		if(i!= selectedIndex)
		{
			NSString *strTmp =[NSString stringWithFormat:@"tab%d.png",(i+1)];
			UIImage *image = [UIImage imageNamed:strTmp];
			[image  drawAtPoint:CGPointMake(minX, height*i+42)];
			
		}
	}
	 
}

- (void)dealloc
{
	[btns release];
    [super dealloc];
}

#pragma mark -
#pragma mark -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint cp = [touch locationInView:self];
	int count = [btns count];
	
	float height = BTNS_HEIGHT/[btns count];
	float btnwidth = 60;
	
	for(int  i=0; i<count; i++)
	{
		if(i != selectedIndex)
		{
			if( CGRectContainsPoint(CGRectMake(0, 20+height*i, btnwidth, height), cp))
			{
				
				selectedIndex = i;
				[self setNeedsDisplay];
				if(_delegate)
				{
					[_delegate valueChange:self];
				}
				break;
			}
		}
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

@end
