//
//  CLMView.m
//  DrawTest
//
//  Created by cocoa on 10-9-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CLMView.h"



#define K_PI 3.1415
#define KDGREED(x) ((x)  * K_PI * 2)


@implementation CLMView
@synthesize spaceHeight, scaleY;
@synthesize titleArr, valueArr, colorArr;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.backgroundColor = [UIColor colorWithRed:(0xee/255.0f) green:(0xf4/255.0f) blue:(0xfd/255.0f) alpha:1.0];
		
		spaceHeight = 90;
		scaleY = 0.4;
		
				
    }
    return self;
}


- (void)drawRect:(CGRect)rect 
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	//cgcontextsets
	CGPoint centerPoint = CGPointMake(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height/2);
	CGFloat radius = 240;
	//抗锯齿
	CGContextSetAllowsAntialiasing(context, TRUE);
	
//	int arr[5] = {20, 15, 35, 85 ,60};
	
	float sum = 0;
	
	
	for(int j=0;j< [valueArr count]; j++)
	{
		sum	 += [[valueArr objectAtIndex:j] floatValue];
	}
	
	
	CGContextMoveToPoint(context, centerPoint.x, centerPoint.y);
	
	float currentangel = 0;
	
	//饼图
	CGContextSaveGState(context);
	CGContextScaleCTM(context, 1.0, scaleY);

	currentangel = 0;
	
	for(int i = 0; i< [valueArr count]; i++)
	{

		float startAngle = KDGREED(currentangel);
		
		currentangel += [[valueArr objectAtIndex:i] floatValue] / sum;
		
		float endAngle = KDGREED(currentangel);
		
		
		//绘制上面的扇形
		CGContextMoveToPoint(context, centerPoint.x, centerPoint.y);
		
		[[colorArr objectAtIndex:i %  [valueArr count]] setFill];
		
		[[UIColor colorWithWhite:1.0 alpha:1] setStroke];
		
		CGContextAddArc(context, centerPoint.x, centerPoint.y, radius, startAngle, endAngle, 0);
		
		CGContextClosePath(context);
		CGContextDrawPath(context, kCGPathFill);

		
		//绘制侧面
		
		//只有弧度《 3.14 的才会画前面的厚度
		if(startAngle >= K_PI)
			continue;
		//大于K_PI的不画 只画到180
		if (endAngle > K_PI) {
			endAngle = K_PI;
		}
		
		float starx = cos(startAngle) * radius  + centerPoint.x;
		float stary = sin(startAngle) * radius + centerPoint.y;

		//CGContextSetBlendMode(context, kCGBlendModeMultiply);
		
		
		//绘制厚度
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint(path, nil, starx, stary);
		CGPathAddArc(path, nil, centerPoint.x, centerPoint.y, radius, startAngle, endAngle, 0);

		CGPathAddArc(path, nil, centerPoint.x, centerPoint.y+ spaceHeight,radius, endAngle, startAngle, 1);

		CGContextAddPath(context, path);
		
		[[colorArr objectAtIndex:i %  [valueArr count]] setFill];
		[[UIColor colorWithWhite:0.9 alpha:1.0] setStroke];
		
		CGContextDrawPath(context, kCGPathFill);
		
		[[UIColor colorWithWhite:0.1 alpha:0.4] setFill];
		CGContextAddPath(context, path);
		CGContextDrawPath(context, kCGPathFill);
        CGPathRelease(path);

	}
	
	
	
	//整体渐变
/*	CGFloat componets [] = {0.0, 0.0, 0.0, 0.5,0.0,0.0,0.0,0.1};
	
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, componets, nil, 2);
	
	CGContextDrawRadialGradient(context, gradient,centerPoint, 0,centerPoint, radius, 0 );
	
	CFRelease(colorspace);
	CGGradientRelease(gradient);*/
	
	
	CGContextRestoreGState(context);
	
	//绘制文字
    
	for(int i = 0; i< [valueArr count]; i++)
	{
		float origionx = 30 ;
		float origiony = i * 30 + 240;
		
		[[colorArr objectAtIndex:i %  [valueArr count]] setFill];
		
		CGContextFillRect(context, CGRectMake(origionx, origiony, 20, 20));
		CGContextDrawPath(context, kCGPathFill);
		
		
		if(i< [titleArr count])
		{
            CGFloat valPercent= [[valueArr objectAtIndex:i] floatValue] / sum;
			NSString *title = [NSString stringWithFormat:@"%@:%.2f%%", [titleArr objectAtIndex:i],valPercent*100];
			[title drawAtPoint:CGPointMake(origionx + 30, origiony) withFont:[UIFont systemFontOfSize:16]];
		}
		
	}
	
}


- (void)dealloc {
	[titleArr release];
	[valueArr release];
	[colorArr release];
    [super dealloc];
}


@end
