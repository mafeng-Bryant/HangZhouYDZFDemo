    //
//  DistrictStatisticsView.m
//  PollutionStatistics
//
//  Created by hejunhua on 11-9-14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DistrictStatisticsView.h"
#import "ChartItem.h"

@implementation DistrictStatisticsView
@synthesize segmentCtrl,chartView,clmView;
@synthesize pollution;

- (void)makeDataStruct:(int)type {
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
           
            
            aColor = [[UIColor alloc] initWithRed:(0xff/255.0f) green:(0x00/255.0f) blue:(0x00/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:2] intValue]*1.0f Name:[aSItem.tj objectAtIndex:2] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            
            aColor = [[UIColor alloc] initWithRed:(0xff/255.0f) green:(0xc0/255.0f) blue:(0x00/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:3] intValue]*1.0f Name:[aSItem.tj objectAtIndex:3] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            
            
            aColor = [[UIColor alloc] initWithRed:(0x3c/255.0f) green:(0x8d/255.0f) blue:(0xa3/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:4] intValue]*1.0f Name:[aSItem.tj objectAtIndex:4] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            
            aColor = [[UIColor alloc] initWithRed:(0xcc/255.0f) green:(0x7b/255.0f) blue:(0x38/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:5] intValue]*1.0f Name:[aSItem.tj objectAtIndex:5] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            
            aColor = [[UIColor alloc] initWithRed:(0x4f/255.0f) green:(0x81/255.0f) blue:(0xbd/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:6] intValue]*1.0f Name:[aSItem.tj objectAtIndex:6] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            
            aColor = [[UIColor alloc] initWithRed:(0x00/255.0f) green:(0xb0/255.0f) blue:(0x50/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:7] intValue]*1.0f Name:[aSItem.tj objectAtIndex:7] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            
            aColor = [[UIColor alloc] initWithRed:(0x9b/255.0f) green:(0xbb/255.0f) blue:(0x59/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:8] intValue]*1.0f Name:[aSItem.tj objectAtIndex:8] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            
            aColor = [[UIColor alloc] initWithRed:(0x80/255.0f) green:(0x64/255.0f) blue:(0xa2/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:9] intValue]*1.0f Name:[aSItem.tj objectAtIndex:9] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            
            aColor = [[UIColor alloc] initWithRed:(0x4b/255.0f) green:(0xac/255.0f) blue:(0xc6/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:10] intValue]*1.0f Name:[aSItem.tj objectAtIndex:10] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            
            aColor = [[UIColor alloc] initWithRed:(0xf7/255.0f) green:(0x96/255.0f) blue:(0x46/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:11] intValue]*1.0f Name:[aSItem.tj objectAtIndex:11] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            
            aColor = [[UIColor alloc] initWithRed:(0xaa/255.0f) green:(0xba/255.0f) blue:(0xd7/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:12] intValue]*1.0f Name:[aSItem.tj objectAtIndex:12] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            
            aColor = [[UIColor alloc] initWithRed:(0x72/255.0f) green:(0x00/255.0f) blue:(0xff/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:13] intValue]*1.0f Name:[aSItem.tj objectAtIndex:13] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            aColor = [[UIColor alloc] initWithRed:(0x9e/255.0f) green:(0x1e/255.0f) blue:(0x00/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:14] intValue]*1.0f Name:[aSItem.tj objectAtIndex:14] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            /*for (i=0; i<[districtsName count]; i++) {
                ChartItem *aItem = [ChartItem itemWithValue:psCount[i] Name:[districtsName objectAtIndex:i] Color:[UIColor yellowColor].CGColor];
                [itemArray addObject:aItem];
                [aItem release];
            }*/
            
			[chartView addGroupArray:itemArray withGroupName:@""];
			[chartView setHidden:NO];
			[clmView setHidden:YES];
			[chartView setNeedsDisplay];
            
            [itemArray release];
		}
			break;
			
		case 1:
		{
			clmView.titleArr = aSItem.tj;
			
			NSMutableArray *countArray = [[NSMutableArray alloc] init];
			for (int i = 0; i<[aSItem.tj count]; i++) {
				[countArray addObject:[NSNumber numberWithInt:[[aSItem.count objectAtIndex:i] intValue]]];
			}
			
			clmView.valueArr = countArray;
            [countArray release];
			clmView.colorArr = [NSArray arrayWithObjects:[UIColor colorWithRed:(0x00/255.0f) green:(0x00/255.0f) blue:(0x00/255.0f) alpha:1.0],[UIColor colorWithRed:(0xff/255.0f) green:(0xff/255.0f) blue:(0x00/255.0f) alpha:1.0],[UIColor colorWithRed:(0xff/255.0f) green:(0x00/255.0f) blue:(0x00/255.0f) alpha:1.0],[UIColor colorWithRed:(0xff/255.0f) green:(0xc0/255.0f) blue:(0x00/255.0f) alpha:1.0],[UIColor colorWithRed:(0x3c/255.0f) green:(0x8d/255.0f) blue:(0xa3/255.0f) alpha:1.0],[UIColor colorWithRed:(0xcc/255.0f) green:(0x7b/255.0f) blue:(0x38/255.0f) alpha:1.0],[UIColor colorWithRed:(0x4f/255.0f) green:(0x81/255.0f) blue:(0xbd/255.0f) alpha:1.0],[UIColor colorWithRed:(0x00/255.0f) green:(0xb0/255.0f) blue:(0x50/255.0f) alpha:1.0],[UIColor colorWithRed:(0x9b/255.0f) green:(0xbb/255.0f) blue:(0x59/255.0f) alpha:1.0],[UIColor colorWithRed:(0x80/255.0f) green:(0x64/255.0f) blue:(0xa2/255.0f) alpha:1.0],[UIColor colorWithRed:(0x4b/255.0f) green:(0xac/255.0f) blue:(0xc6/255.0f) alpha:1.0],[UIColor colorWithRed:(0xf7/255.0f) green:(0x96/255.0f) blue:(0x46/255.0f) alpha:1.0],[UIColor colorWithRed:(0xaa/255.0f) green:(0xba/255.0f) blue:(0xd7/255.0f) alpha:1.0],[UIColor colorWithRed:(0x72/255.0f) green:(0x00/255.0f) blue:(0xff/255.0f) alpha:1.0],[UIColor colorWithRed:(0x9e/255.0f) green:(0x1e/255.0f) blue:(0x00/255.0f) alpha:1.0],nil];
			
			[chartView setHidden:YES];
			[clmView setHidden:NO];
			[clmView setNeedsDisplay];
		}
			break;

		default:
			break;
	}
	
}

- (IBAction)segmentValueChanged:(id)sender {
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
	[self makeDataStruct:segmentedControl.selectedSegmentIndex];
}

- (void)viewDidLoad {
    self.title = @"按所在行政区统计";
    self.view.backgroundColor = [UIColor colorWithRed:(0xee/255.0f) green:(0xf4/255.0f) blue:(0xfd/255.0f) alpha:1.0];
    
	NTChartView *chart = [[NTChartView alloc] initWithFrame:CGRectMake(0, 80, 740, 600)];
	[self.view addSubview:chart];
	self.chartView = chart;
    [chart release];
	
	CLMView *pie = [[CLMView alloc] initWithFrame:CGRectMake(0, 80, 740, 700)];
	[self.view addSubview:pie];
	self.clmView = pie;
    [pie release];
	
	[self makeDataStruct:0];
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
	[segmentCtrl release];
	[chartView release];
	[clmView release];
	[pollution release];
    [super dealloc];
}

@end
