//
//  RSGraphView.h
//  drawGraph
//
//  Created by chen on 11-7-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
// 画曲线

#import <UIKit/UIKit.h>


@interface RSGraphView : UIView {
	//最大值，最小值, 列宽度, 
	float maxValue,minValue,columnWidth,maxScaleValue,maxScaleHeight;
	
	NSMutableArray *groupData;
}

@property(retain,nonatomic) NSMutableArray *groupData;

- (void)clearItems;
- (void)addGroupArray:(NSArray*)itemAry withGroupName:(NSString*)name andColor:(CGColorRef)aColor;


@end
