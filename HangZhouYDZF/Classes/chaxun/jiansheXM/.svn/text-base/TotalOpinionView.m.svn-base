//
//  TotalOpinionView.m
//  EPad
//
//  Created by ihumor on 11-9-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TotalOpinionView.h"


@implementation TotalOpinionView
@synthesize opinionText;
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

#pragma mark - View lifecycle
*/
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.contentSizeForViewInPopover = CGSizeMake(620, 400);
	
	opinionText = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 600, 380)];
	opinionText.font = [UIFont fontWithName:@"Helvetica" size:18.0];
	opinionText.editable = NO;
	[self.view addSubview:opinionText];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc {
    [opinionText release];
    [super dealloc];
}
@end
