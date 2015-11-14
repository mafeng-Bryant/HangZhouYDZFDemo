//
//  ChartItem.h
//  MyChartDemo
//
//  Created by chen on 11-7-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ChartItem : NSObject {
	CGColorRef _color;
	float _value;
	NSString *_name;
}
@property (nonatomic, assign) CGColorRef color;
@property (nonatomic, assign) float value;
@property (nonatomic, copy) NSString *name;

+(id)itemWithValue:(float)val Name:(NSString*)title Color:(CGColorRef)aColor;
+ (void)makeColorArray:(NSMutableArray *)colors;
@end
