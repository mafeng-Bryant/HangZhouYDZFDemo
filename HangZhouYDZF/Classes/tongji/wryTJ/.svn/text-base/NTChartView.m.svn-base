//
//  NTChartView.m
//  chart
//
//  Created by lee jory on 09-10-15.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NTChartView.h"
#import "ChartItem.h"
static int MARGIN_LEFT = 50;
static int MARGIN_BOTTOM = 100;
static int MARGIN_TOP = 20;
static int SHOW_SCALE_NUM = 5; 



@interface NTChartView()
-(void)drawColumn:(CGContextRef)context rect:(CGRect)_rect;
-(void)drawScale:(CGContextRef)context rect:(CGRect)_rect;
-(void)calcScales:(CGRect)_rect;
@end

@implementation NTChartView
@synthesize groupData,groupNames;


- (void) dealloc
{
	[groupData release];
	[groupNames release];
	[super dealloc];
}

- (void)clearItems 
{
	if( groupData ) {
		[groupData removeAllObjects];	
	}
	
	if( groupNames ) {
		[groupNames removeAllObjects];	
	}
}

- (void)addGroupArray:(NSArray*)itemAry withGroupName:(NSString*)name
{
	
	if( !groupData ) {
		groupData = [[NSMutableArray alloc] initWithCapacity:3];
		groupNames= [[NSMutableArray alloc] initWithCapacity:3];
	}
	
	[groupData addObject:itemAry];
	if (name) {
		[groupNames addObject:name];
	}
	else {
		[groupNames addObject:@""];
	}

	

}

-(void)drawRect:(CGRect)_rect{
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [UIColor colorWithRed:(0xee/255.0f) green:(0xf4/255.0f) blue:(0xfd/255.0f) alpha:1.0].CGColor);
	CGContextFillRect(context, _rect);
	
	//计算刻度
	[self calcScales:_rect];
	
	//画刻度
	[self drawScale:context rect:_rect];
	
	//画柱
	[self drawColumn:context rect:_rect];
	
	
	
	
	
}

-(void)drawScale:(CGContextRef)context rect:(CGRect)_rect{
	CGPoint points[3];
	points[0] = CGPointMake(MARGIN_LEFT - 10, MARGIN_TOP);
	points[1] = CGPointMake(MARGIN_LEFT -10, _rect.size.height - MARGIN_BOTTOM + 1);
	points[2] = CGPointMake(_rect.size.width - 10, _rect.size.height - MARGIN_BOTTOM + 1);
	CGContextSetAllowsAntialiasing(context, NO);
	CGContextAddLines(context, points, 3);
	
	
	CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor); 
	
	for(int i=0;i<SHOW_SCALE_NUM + 1; i++){
		maxScaleHeight = (_rect.size.height - MARGIN_BOTTOM) * ( i ) / (SHOW_SCALE_NUM + 1);
		int vScal = ceil(1.0 * maxScaleValue / (SHOW_SCALE_NUM ) * (i ));
		float y = (_rect.size.height - MARGIN_BOTTOM) -
			maxScaleHeight;
		
		NSString *scaleStr = [NSString stringWithFormat:@"%d",vScal];
		[scaleStr
			drawAtPoint:CGPointMake(MARGIN_LEFT - 20 - [scaleStr sizeWithFont:[UIFont systemFontOfSize:12]].width, y - 10) withFont:[UIFont systemFontOfSize:12]];
		points[0] = CGPointMake(MARGIN_LEFT - 10, y);
		points[1] = CGPointMake(MARGIN_LEFT - 13, y);
		CGContextSetLineDash(context, 0, NULL, 0);
		CGContextAddLines(context, points, 2);
		CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);

		CGContextDrawPath(context, kCGPathStroke);

		
		points[0] = CGPointMake(MARGIN_LEFT - 10, y);
		points[1] = CGPointMake(_rect.size.width - 10 , y);
		float partren[] = {2,3};
		CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1].CGColor);

		CGContextSetLineDash(context, 0,partren , 2);
		CGContextAddLines(context, points, 2);
		CGContextDrawPath(context, kCGPathStroke);
		
	}
	
	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);

	CGContextDrawPath(context, kCGPathStroke);
	CGContextSetAllowsAntialiasing(context, YES);

	
}

-(void)drawColumn:(CGContextRef)context rect:(CGRect)_rect{
	int vNumber = 0,gNumber = 0;
	int baseGroundY = _rect.size.height - MARGIN_BOTTOM, baseGroundX = MARGIN_LEFT;
	CGPoint points[4];
	

	BOOL bGrouped = [groupData count] > 1;
	BOOL bDrawItemLable = NO;
	for(NSArray *g in groupData){
		//如果分组 那么就在整个柱子分组下面画分组的名字 
		if (bGrouped) {
			NSString *str = [groupNames objectAtIndex:gNumber];
			CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
			CGRect txtRect = CGRectMake(baseGroundX+(groupWidth+sideWidth)*vNumber, baseGroundY+10, (columnWidth+sideWidth)*[g count], 60);
			[str drawInRect:txtRect withFont:[UIFont fontWithName:@"Helvetica" size:17]];
			
		}

		for(ChartItem *aItem in g){

			
			
			float columnHeight = aItem.value / maxScaleValue * maxScaleHeight ;
			
			//值为0也要画
			if(columnHeight < 3){
				//vNumber++;
				//continue;
				columnHeight = 3;
			}
			//画正面
			CGRect rect = CGRectMake(vNumber * 5 + baseGroundX + groupWidth * vNumber
									 , baseGroundY - columnHeight 
									 , columnWidth
									 , columnHeight);
			CGContextSetFillColorWithColor(context, aItem.color);
			CGContextAddRect(context,rect );
			CGContextDrawPath(context, kCGPathFill);
			////NSLog(@"columnHeight:%f, (_rect.size.height - MARGIN_TOP - MARGIN_BOTTOM ):%f",columnHeight,(_rect.size.height - MARGIN_TOP - MARGIN_BOTTOM ));

	
			
			
			//画右侧面
			const float* rgba = CGColorGetComponents(aItem.color);
			UIColor *rightColor = [UIColor colorWithRed:rgba[0]*0.9 green:rgba[1]*0.9 blue:rgba[2]*0.9 alpha:1];
			CGContextSetFillColorWithColor(context, rightColor.CGColor);
			points[0] = CGPointMake(vNumber * 5 + baseGroundX + groupWidth * vNumber + columnWidth, baseGroundY - columnHeight -10);
			points[1] = CGPointMake(vNumber * 5 + baseGroundX + groupWidth * vNumber + columnWidth + sideWidth, baseGroundY - columnHeight -10 );
			points[2] = CGPointMake(vNumber * 5 + baseGroundX + groupWidth * vNumber + columnWidth + sideWidth, baseGroundY );
			points[3] = CGPointMake(vNumber * 5 + baseGroundX + groupWidth * vNumber + columnWidth, baseGroundY );
			
			CGContextAddLines(context, points, 4);
			CGContextDrawPath(context, kCGPathFill);
			
			//画上面
			UIColor *topColor = [UIColor colorWithRed:rgba[0] green:rgba[1]*0.4 blue:rgba[2]*0.4 alpha:1];
			CGContextSetFillColorWithColor(context, topColor.CGColor);
			points[0] = CGPointMake(vNumber * 5 + baseGroundX + groupWidth * vNumber , baseGroundY - columnHeight );
			points[1] = CGPointMake(vNumber * 5 + baseGroundX + groupWidth * vNumber + sideWidth, baseGroundY - columnHeight -10 );
			points[2] = CGPointMake(vNumber * 5 + baseGroundX + groupWidth * vNumber + columnWidth + sideWidth , baseGroundY - columnHeight -10 );
			points[3] = CGPointMake(vNumber * 5 + baseGroundX + groupWidth * vNumber + columnWidth, baseGroundY - columnHeight );
			
			CGContextAddLines(context, points, 4);
			CGContextDrawPath(context, kCGPathFill);
			
			//画数值
			NSString *valStr = [NSString stringWithFormat:@"%d",(int)aItem.value];
			CGRect valRect = CGRectMake(vNumber * 5 + baseGroundX + groupWidth * vNumber + 5, baseGroundY - columnHeight-30, columnWidth, 20);
			[valStr drawInRect:valRect withFont:[UIFont systemFontOfSize:12] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
			//如果没有分组 那么就在柱子下面画各个柱子的label	
			if (!bGrouped) {
				CGRect txtRect = CGRectMake(rect.origin.x, baseGroundY+10, columnWidth, 100);
				[aItem.name drawInRect:txtRect withFont:[UIFont fontWithName:@"Helvetica" size:12]];
			}
			else {//画颜色标识 在此默认不痛分组的 同意、不同意、退档的颜色否分别相同
				if (!bDrawItemLable) {//只画一次
					CGContextSetFillColorWithColor(context, aItem.color);
					CGContextFillRect(context, CGRectMake(baseGroundX+vNumber*150, baseGroundY+10+60, 40, 20));
					CGContextDrawPath(context, kCGPathFill);
					[aItem.name drawAtPoint:CGPointMake(baseGroundX + vNumber*150+50, baseGroundY+10+60) withFont:[UIFont systemFontOfSize:16]];
					
				}
			}

			vNumber++;
		}
		bDrawItemLable = YES;
		vNumber++; 
		gNumber++;
	}
	

	
}

-(void)calcScales:(CGRect)_rect{
	int columnCount = 0;
	int groupCount = -1;
	for(NSArray *g in groupData){
		groupCount++;
		for(ChartItem *aItem in g){
			if(maxValue< aItem.value) maxValue = aItem.value;
			if(minValue> aItem.value) minValue = aItem.value;
			columnCount++;
		}
	}
	
	maxScaleValue = ((int)ceil(maxValue) + (SHOW_SCALE_NUM - (int)ceil(maxValue) % SHOW_SCALE_NUM));
	
	/*
	columnWidth = (_rect.size.width - MARGIN_LEFT * 2) / (columnCount + 1);
	sideWidth = columnWidth *.2;
	columnWidth *= .8;	*/
	
	columnWidth = (_rect.size.width - MARGIN_LEFT * 2) / (columnCount + 1 + groupCount);
    if (columnWidth > ((_rect.size.width - MARGIN_LEFT * 2)/16))
        columnWidth = (_rect.size.width - MARGIN_LEFT * 2)/16;
    
	groupWidth = (_rect.size.width - MARGIN_LEFT * 2) / (columnCount + 1 + groupCount);
	sideWidth = columnWidth *.2;
	columnWidth *= .8;
	
	
}

@end
