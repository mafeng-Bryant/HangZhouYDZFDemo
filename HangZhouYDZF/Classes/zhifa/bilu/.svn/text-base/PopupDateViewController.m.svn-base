    //
//  PopupDateViewController.m
//  EPad
//
//  Created by chen on 11-4-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PopupDateViewController.h"


@implementation PopupDateViewController
@synthesize delegate,myPicker,datePickerMode;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
-(id)initWithPickerMode:(UIDatePickerMode) mode{
	if((self = [super init])){
		datePickerMode = mode;
	}
	return self;
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
-(IBAction)saveDate:(id)sender{

	[delegate PopupDateController:self Saved:YES selectedDate:myPicker.date];
}

-(IBAction)cancelDate:(id)sender{
	
	[delegate PopupDateController:self Saved:NO selectedDate:nil];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	self.contentSizeForViewInPopover = CGSizeMake(370.0, 260.0);
	UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 360, 216)];
	picker.datePickerMode = datePickerMode;
	[self.view addSubview:picker];
	self.myPicker = picker;
	[picker release];
	
	UIBarButtonItem *aButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
									style:UIBarButtonItemStyleBordered target:self action:@selector(cancelDate:)];
    
    self.navigationItem.leftBarButtonItem = aButtonItem;
	[aButtonItem release];
	UIBarButtonItem *aButtonItem2 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered 
																	target:self action:@selector(saveDate:)];
    
    self.navigationItem.rightBarButtonItem = aButtonItem2;
	[aButtonItem2 release];
	
}

-(void)viewWillAppear:(BOOL)animated{
	myPicker.date = [NSDate date];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[myPicker release];
    [super dealloc];
}


@end
