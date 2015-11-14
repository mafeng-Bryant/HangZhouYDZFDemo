//
//  DetailsItemViewController.m
//  EPad
//
//  Created by chen on 11-5-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailsItemViewController.h"


@implementation DetailsItemViewController
@synthesize itemsAry,delegate,itemsIndex,myTableView;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle
-(void)OKClicked:(id)sender{
    

    NSMutableString *strReasons = [[NSMutableString alloc] initWithCapacity:100];
  
    NSMutableArray *aryDetailItems = [[NSMutableArray alloc] initWithCapacity:5];
    int count = [itemsAry count];
    [strReasons appendString:@""];
	for (int i=0; i < count; i++) {
		if (bSelected[i]) {
            [strReasons appendFormat:@"%@;",[itemsAry objectAtIndex:i]];
			[aryDetailItems addObject:[NSString stringWithFormat:@"%d",(itemsIndex+1)*100+i+1]];			
		}
	}
        
	[delegate returnReasons:strReasons 
              andItemsIndex:aryDetailItems
                  withIndex:itemsIndex];
	[strReasons release];
    [aryDetailItems release];
    
}

-(void)clearContents
{
	for (int i=0;i<10;i++) {
		bSelected[i] = NO;
	}
	

}


- (void)viewDidLoad {
    [super viewDidLoad];

	self.contentSizeForViewInPopover = CGSizeMake(300, 460);	
   // self.navigationItem.leftBarButtonItem = aButtonItem;
	//[aButtonItem release];
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *baritem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
																style:UIBarButtonItemStyleBordered
															   target:self
															   action:@selector(OKClicked:)];
								
	self.navigationItem.rightBarButtonItem = baritem;
	[baritem release];
	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [itemsAry count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	if (bSelected[indexPath.row]) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	//[cell addSubview:segCtrl];
    // Configure the cell...
    cell.textLabel.text = [itemsAry objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    
	bSelected[indexPath.row] = !bSelected[indexPath.row];
	[self.myTableView reloadData];
		
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

