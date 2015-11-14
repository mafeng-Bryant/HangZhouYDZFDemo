//
//  DistrictStatisticsView.h
//  PollutionStatistics
//
//  Created by hejunhua on 11-9-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTChartView.h"
#import "CLMView.h"
#import "StatisticsItem.h"

@interface DistrictStatisticsView : UIViewController {
	UISegmentedControl *segmentCtrl;
	NTChartView *chartView;
	CLMView *clmView;
	
	NSArray *pollution;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentCtrl;
@property (nonatomic, retain) NTChartView *chartView;
@property (nonatomic, retain) CLMView *clmView;

@property (nonatomic, retain) NSArray *pollution;

- (void)makeDataStruct:(int)type;
- (IBAction)segmentValueChanged:(id)sender;

@end
