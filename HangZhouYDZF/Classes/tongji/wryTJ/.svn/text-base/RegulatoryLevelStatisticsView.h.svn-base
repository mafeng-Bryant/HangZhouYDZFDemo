//
//  RegulatoryLevelStatisticsView.h
//  PollutionStatistics
//
//  Created by hejunhua on 11-9-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTChartView.h"
#import "CLMView.h"
#import "StatisticsItem.h"

@interface RegulatoryLevelStatisticsView : UIViewController {
	NTChartView *chartView;
	CLMView *pieView;
	
	NSArray *pollution;
}

@property (nonatomic, retain) NTChartView *chartView;
@property (nonatomic, retain) CLMView *pieView;

@property (nonatomic, retain) NSArray *pollution;

- (IBAction)segmentValueChanged:(id)sender;
- (void)addView:(int)type;
@end
