//
//  NTChartView.h
//  chart
//
//  Created by lee jory on 09-10-15.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NTChartView : UIView {
	

	NSMutableArray *groupData;
	NSMutableArray *groupNames;
	
	//最大值，最小值, 列宽度, 
	float maxValue,minValue,columnWidth,sideWidth,maxScaleValue,maxScaleHeight;
	float groupWidth;//组之间的间隔
	
}

@property(retain,nonatomic) NSMutableArray *groupData;
@property(retain,nonatomic) NSMutableArray *groupNames;
- (void)clearItems;
- (void)addGroupArray:(NSArray*)itemAry withGroupName:(NSString*)name;

@end
