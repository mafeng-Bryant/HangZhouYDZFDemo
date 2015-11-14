//
//  TypeStatisticsView.h
//  PollutionStatistics
//
//  Created by hejunhua on 11-9-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLMView.h"
#import "NTChartView.h"
#import "StatisticsItem.h"

@interface TypeStatisticsView : UIViewController {
	UISegmentedControl *segCtrl;
	CLMView *pieView;
	NTChartView *chartView;
	
	NSArray *pollution;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *segCtrl;
@property (nonatomic, retain) CLMView *pieView;
@property (nonatomic, retain) NTChartView *chartView;

@property (nonatomic, retain) NSArray *pollution;

- (IBAction)segmentValueChanged:(id)sender;
- (void)addView:(int)type;

@end
