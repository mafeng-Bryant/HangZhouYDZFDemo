//
//  RSGraphView.m
//  drawGraph
//
//  Created by chen on 11-7-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RSGraphView.h"
static int MARGIN_LEFT = 50;
static int MARGIN_BOTTOM = 180;
static int MARGIN_TOP = 20;
static int SHOW_SCALE_NUM = 5; 

@interface GraphChartItem : NSObject
{
	CGColorRef _color;
	NSArray* _values;
	NSString *_name;
}

@property (nonatomic, assign) CGColorRef color;
@property (nonatomic, retain) NSArray * values;
@property (nonatomic, copy) NSString *name;
@end




@implementation GraphChartItem

- (id)init
{	
    if (self = [super init]) {

	}
	return self;
}

@synthesize color = _color;
@synthesize values = _values;
@synthesize name  = _name;
@end

@interface RSGraphView()
-(void)drawColumn:(CGContextRef)context rect:(CGRect)_rect;
-(void)drawScale:(CGContextRef)context rect:(CGRect)_rect;
-(void)calcScales:(CGRect)_rect;
@end

@implementation RSGraphView
@synthesize groupData;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)clearItems 
{
	if( groupData ) {
		[groupData removeAllObjects];	
	}
	
}

- (void)addGroupArray:(NSArray*)itemAry withGroupName:(NSString*)name andColor:(CGColorRef)aColor
{
	GraphChartItem *item = [[GraphChartItem alloc] init];
	
	item.values = itemAry;
	item.color = aColor;
	item.name  = name;
	if( !groupData ) {
		groupData = [[NSMutableArray alloc] initWithCapacity:3];
	}
	
	[groupData addObject:item];
	
	[item release];

}

-(void)drawRect:(CGRect)_rect{
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextFillRect(context, _rect);
	
	//计算刻度
	[self calcScales:_rect];
	CGContextSaveGState(context);
	//画刻度
	[self drawScale:context rect:_rect];
	CGContextRestoreGState(context);
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
	
	NSArray *names = [NSArray arrayWithObjects:@"一月",@"二月",@"三月",@"四月",
					  @"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月",nil];
	
	int baseGroundY = _rect.size.height - MARGIN_BOTTOM;
	int xPos = MARGIN_LEFT- 10;
	for (NSString *name in names) {
		CGRect txtRect = CGRectMake(xPos, baseGroundY+10, columnWidth, 60);
		[name drawInRect:txtRect withFont:[UIFont fontWithName:@"Helvetica" size:17]];
		xPos += columnWidth;
	}
	
}

-(void)drawColumn:(CGContextRef)context rect:(CGRect)_rect{
	int vNumber = 0,gNumber = 0;
	int baseGroundY = _rect.size.height - MARGIN_BOTTOM, baseGroundX = MARGIN_LEFT;
	
	int labelXpos =baseGroundX ,labelYpos = baseGroundY +50,labelWidth = 130,labelHeight = 60,colorRectWidth= 30;
	// Draw them with a 2.0 stroke width so they are a bit more visible.

	CGContextSetLineWidth(context, 2.0);
	
	for(GraphChartItem *g in groupData){
		
		
		CGContextSetStrokeColorWithColor(context, g.color);
		for(NSNumber *v  in g.values){
			float columnHeight = [v floatValue]  / maxScaleValue * maxScaleHeight ;
			CGPoint point = CGPointMake( MARGIN_LEFT + columnWidth * vNumber,baseGroundY - columnHeight);

			if (vNumber == 0) {
				CGContextAddEllipseInRect(context,CGRectMake(MARGIN_LEFT- 10 -3, point.y-3, 8, 8));
				CGContextMoveToPoint (context, MARGIN_LEFT- 10, point.y);
			}
			else {
				CGContextAddLineToPoint(context, point.x, point.y);
				CGContextAddEllipseInRect(context,CGRectMake(point.x -3, point.y-3, 8, 8));
				CGContextMoveToPoint (context,point.x, point.y);
				
			}
			
			vNumber++;
		}
		CGContextStrokePath(context);
		vNumber = 0; 
		
		CGContextSetFillColorWithColor(context, g.color);
		CGContextFillRect(context, CGRectMake(labelXpos,labelYpos, colorRectWidth, 20));
		CGContextDrawPath(context, kCGPathFill);
		CGRect txtRect = CGRectMake(labelXpos+colorRectWidth+10,labelYpos,
									labelWidth, labelHeight);
		[g.name drawInRect:txtRect withFont:[UIFont systemFontOfSize:20]];
		
		
		gNumber++;
		labelXpos += (colorRectWidth + labelWidth+20);
		if (gNumber%4==0) {
			labelXpos = baseGroundX;
			labelYpos +=  labelHeight;
		}
		
	}
	
	
	
	
	
}

-(void)calcScales:(CGRect)_rect{
	int maxColumnCount = 12;

	for(GraphChartItem *g in groupData){
		//if (maxColumnCount < [g.values count])  maxColumnCount = [g.values count];
			
		
		for(NSNumber *v  in g.values){
			if(maxValue < [v floatValue] ) maxValue = [v floatValue];
			if(minValue > [v floatValue] ) minValue = [v floatValue];
			
		}
	}
	
	maxScaleValue = ((int)ceil(maxValue) + (SHOW_SCALE_NUM - (int)ceil(maxValue) % SHOW_SCALE_NUM));
	 columnWidth = (_rect.size.width - MARGIN_LEFT * 2) / (maxColumnCount-1);
	
}

- (void)dealloc {
	[groupData release];
    [super dealloc];
}


@end
