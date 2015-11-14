//
//  FirmSizeStatisticsView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTChartView.h"
#import "CLMView.h"
#import "StatisticsItem.h"

@interface FirmSizeStatisticsView : UIViewController {
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
