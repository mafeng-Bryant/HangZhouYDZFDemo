//
//  industrialClassificationView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "industrialClassificationView.h"
#import "ChartItem.h"

@implementation industrialClassificationView
@synthesize chartView,pieView,pollution;

- (IBAction)segmentValueChanged:(id)sender {
	UISegmentedControl *segController = (UISegmentedControl *)sender;
	[self addView:segController.selectedSegmentIndex];
}


- (void)addView:(int)type {
	[chartView clearItems];
	
    int i;
	StatisticsItem *aSItem = [pollution objectAtIndex:0];
	
	
	switch (type) {
		case 0:
		{
			NSMutableArray *itemArray = [[NSMutableArray alloc] init];
			
			ChartItem *aItem;
            UIColor *aColor;
            
            aColor = [[UIColor alloc] initWithRed:(0x00/255.0f) green:(0xb0/255.0f) blue:(0xf0/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:1] intValue]*1.0f Name:[aSItem.tj objectAtIndex:1] Color:aColor.CGColor];
            [itemArray addObject:aItem];
           [aColor release];
            
            aColor = [[UIColor alloc] initWithRed:(0xff/255.0f) green:(0xff/255.0f) blue:(0x00/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:0] intValue]*1.0f Name:[aSItem.tj objectAtIndex:0] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            aColor = [[UIColor alloc] initWithRed:(0xff/255.0f) green:(0x00/255.0f) blue:(0x00/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:2] intValue]*1.0f Name:[aSItem.tj objectAtIndex:2] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
            
            aColor = [[UIColor alloc] initWithRed:(0x0c/255.0f) green:(0xde/255.0f) blue:(0x5c/255.0f) alpha:1.0];
            aItem = [ChartItem itemWithValue:[[aSItem.count objectAtIndex:3] intValue]*1.0f Name:[aSItem.tj objectAtIndex:3] Color:aColor.CGColor];
            [itemArray addObject:aItem];
            [aColor release];
                      
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
			for (i = 0; i<[aSItem.tj count]; i++) {
				[countArray addObject:[NSNumber numberWithFloat:[[aSItem.count objectAtIndex:i] intValue]*1.0f]];
			}
			
			pieView.valueArr = countArray;
            [countArray release];
			pieView.colorArr = [NSArray arrayWithObjects:[UIColor colorWithRed:(0x00/255.0f) green:(0x00/255.0f) blue:(0x00/255.0f) alpha:1.0],[UIColor colorWithRed:(0x00/255.0f) green:(0xb0/255.0f) blue:(0xf0/255.0f) alpha:1.0],[UIColor colorWithRed:(0xff/255.0f) green:(0x00/255.0f) blue:(0x00/255.0f) alpha:1.0],[UIColor colorWithRed:(0x0c/255.0f) green:(0xde/255.0f) blue:(0x5c/255.0f) alpha:1.0],/*[UIColor colorWithRed:(0x3c/255.0f) green:(0x8d/255.0f) blue:(0xa3/255.0f) alpha:1.0],[UIColor colorWithRed:(0xdb/255.0f) green:(0x14/255.0f) blue:(0x6f/255.0f) alpha:1.0],[UIColor colorWithRed:(0xff/255.0f) green:(0xff/255.0f) blue:(0x00/255.0f) alpha:1.0],[UIColor colorWithRed:(0x26/255.0f) green:(0xfa/255.0f) blue:(0x3f/255.0f) alpha:1.0],[UIColor colorWithRed:(0xff/255.0f) green:(0x00/255.0f) blue:(0x00/255.0f) alpha:1.0],[UIColor colorWithRed:(0xf7/255.0f) green:(0x96/255.0f) blue:(0x46/255.0f) alpha:1.0],[UIColor colorWithRed:(0x4b/255.0f) green:(0xac/255.0f) blue:(0xc6/255.0f) alpha:1.0],[UIColor colorWithRed:(0x9b/255.0f) green:(0xbb/255.0f) blue:(0x59/255.0f) alpha:1.0],[UIColor colorWithRed:(0x7f/255.0f) green:(0x9a/255.0f) blue:(0x48/255.0f) alpha:1.0],[UIColor colorWithRed:(0x40/255.0f) green:(0x69/255.0f) blue:(0x9c/255.0f) alpha:1.0],*/nil];
			
			[chartView setHidden:YES];
			[pieView setHidden:NO];
			[pieView setNeedsDisplay];
		}
			break;
            
		default:
			break;
	}
}

/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
 {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 
 - (void)dealloc
 {
 [super dealloc];
 }
 
 - (void)didReceiveMemoryWarning
 {
 // Releases the view if it doesn't have a superview.
 [super didReceiveMemoryWarning];
 
 // Release any cached data, images, etc that aren't in use.
 }
 */
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.title = @"按工业污染源分类管理统计";
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
