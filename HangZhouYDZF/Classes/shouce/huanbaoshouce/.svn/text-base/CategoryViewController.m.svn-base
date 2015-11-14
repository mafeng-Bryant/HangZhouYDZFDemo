//
//  CategoryViewController.m
//  handbook
//
//  Created by chen on 11-4-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryItemViewController.h"

@implementation CategoryViewController

@synthesize data;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"分类查询";
	
	NSArray *tmpData = [[NSArray alloc] initWithObjects:
						@"胺类",@"烃类",@"卤代烃类",@"芳烃类",@"酯类",@"醛和酮类",
						@"醇和醚类",@"酚及杂环类",@"硅烷、酰氯及肼类",@"腈及氰化物类",@"酸及酸酐类",@"氧化物及硫化物类",
						@"卤化物类",@"盐类",@"有机金属类",@"无机金属及非金属类",@"农药类",@"其它",nil];
	self.data = tmpData;
	[tmpData release];
	
	//count
    /*
	NSArray *tmpItemData = [[NSArray alloc] initWithObjects:
							@"129",@"121",@"104",@"110",@"128",@"59",
							@"90",@"73",@"57",@"33",@"61",@"43",
							@"61",@"93",@"18",@"49",@"76",@"40",nil];
	self.itemCountDatas = tmpItemData;
	[tmpItemData release];
     */
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/


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
   return 18;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row%2 == 0) ? @"lightblue" : @"white" ofType:@"png"];
	UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
	cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
	cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	cell.backgroundView.frame = cell.bounds;
	cell.textLabel.backgroundColor = [UIColor clearColor];
	
    cell.textLabel.font  = [UIFont systemFontOfSize:24];
    // Configure the cell...
    cell.textLabel.text = [data objectAtIndex:indexPath.row];

    return cell;
}


/*
// Override to support conditional editing of the table view.
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    
    CategoryItemViewController *detailViewController = [[CategoryItemViewController alloc] initWithNibName:@"CategoryItemViewController" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
	detailViewController.kindcode = [indexPath row] +1;
	detailViewController.title = [data objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
	[data release];
	
    [super dealloc];
}


@end

