    //
//  TypeStatisticsView.m
//  PollutionStatistics
//
//  Created by hejunhua on 11-9-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TypeStatisticsView.h"
#import "ChartItem.h"

@implementation TypeStatisticsView
@synthesize pollution;
@synthesize pieView, chartView, segCtrl;

-(IBAction)segmentValueChanged:(id)sender {
	UISegmentedControl *segController = (UISegmentedControl *)sender;
	[self addView:segController.selectedSegmentIndex];
}

- (void)addView:(int)type {
	[chartView clearItems];

	StatisticsItem *aSItem = [pollution objectAtIndex:0];
	
	switch (type) {
		case 0:
		{
			NSMutableArray *itemArray = [[NSMutableArray alloc] init];
            
            ChartItem *aItem;
            UIColor *aColor;
            
            aColor = [[UIColor alloc] initWithRed:(0x00/255.0f) green:(0xb0/255.0f) blue:(0xf0/255.0f) alpha:1.0];
			aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:0] intValue]*1.0f Name:[aSItem.tj objectAtIndex:0] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            aColor = [[UIColor alloc] initWithRed:(0xff/255.0f) green:(0xff/255.0f) blue:(0x00/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:1] intValue]*1.0f Name:[aSItem.tj objectAtIndex:1] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
			
            
            /*for (int i=0; i<[tradeType count]; i++) {
                ChartItem *aItem = [ChartItem itemWithValue:psCount[i] Name:[tradeType objectAtIndex:i] Color:[UIColor yellowColor].CGColor];
                [itemArray addObject:aItem];
                [aItem release];
            }*/
            
			[chartView addGroupArray:itemArray withGroupName:@""];
			[chartView setHidden:NO];
			[pieView setHidden:YES];
			[chartView setNeedsDisplay];
            [itemArray release];
		}
			break;
			
		case 1:
		{
			pieView.titleArr = aSItem.tj;
			
			NSMutableArray *countArray = [[NSMutableArray alloc] init];
			for (int n = 0; n<[aSItem.tj count]; n++) {
				[countArray addObject:[NSNumber numberWithFloat:[[aSItem.count objectAtIndex:n] intValue]*1.0f]];
			}
			
			pieView.valueArr = countArray;
            [countArray release];
			pieView.colorArr = [NSArray arrayWithObjects:[UIColor colorWithRed:(0x00/255.0f) green:(0xb0/255.0f) blue:(0xf0/255.0f) alpha:1.0],[UIColor colorWithRed:(0x00/255.0f) green:(0x00/255.0f) blue:(0x00/255.0f) alpha:1.0],nil];
			
			[chartView setHidden:YES];
			[pieView setHidden:NO];
			[pieView setNeedsDisplay];
		}
			break;

		default:
			break;
	}
}

- (void)viewDidLoad {
    self.title = @"按单位类型统计";
    self.view.backgroundColor = [UIColor colorWithRed:(0xee/255.0f) green:(0xf4/255.0f) blue:(0xfd/255.0f) alpha:1.0];
    self.contentSizeForViewInPopover = CGSizeMake(740, 800);
	NTChartView *chart = [[NTChartView alloc] initWithFrame:CGRectMake(0, 80, 740, 600)];
	[self.view addSubview:chart];
	self.chartView = chart;
    [chart release];
	
	CLMView *pie = [[CLMView alloc] initWithFrame:CGRectMake(0, 80, 740, 700)];
	[self.view addSubview:pie];
	self.pieView = pie;
    [pie release];
	
	[self addView:0];
    [super viewDidLoad];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[pollution release];
	[pieView release];
	[chartView release];
	[segCtrl release];
    [super dealloc];
}


@end
