//
//  AnyouTableView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AnyouTableView.h"
#import "GMEPS_HZAppDelegate.h"
extern sqlite3 *data_db;

@implementation AnyouTableView
@synthesize anyouAry,delegate,filteredAry;

#pragma mark -
#pragma mark View lifecycle


 - (void)viewDidLoad {
     [super viewDidLoad];
 
     UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 580.0, 0.0)];
     searchBar.delegate = self;

     // Create a bar button item using the search bar as its view.
     UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
     // Create a space item and set it and the search bar as the items for the toolbar.
          
     self.navigationItem.leftBarButtonItem =searchItem;
     [searchItem release];
     [searchBar release];

     
     //案由表属性数组建立
     NSMutableString *sqlStr = [NSMutableString stringWithString:@"select * from T_COMN_GGDMZ where DMJBH='HZ_XZCF'"];
     
     const char *utfsql = [sqlStr cStringUsingEncoding:NSUTF8StringEncoding];
     
     sqlite3_stmt *statement; 
     if (sqlite3_prepare_v2(data_db, utfsql, -1, &statement, nil)==SQLITE_OK) { 

     }
     
     NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:256];
     
     char *name;
     NSString *text;
     while (sqlite3_step(statement)==SQLITE_ROW) { 
         
         name=(char *)sqlite3_column_text(statement, 2); 
         text = [NSString stringWithCString:name  encoding:NSUTF8StringEncoding];
         [ary addObject:text];
         
     }
     
     sqlite3_finalize(statement);
     self.anyouAry = ary;
     [ary release];
     self.filteredAry = [NSMutableArray arrayWithArray:anyouAry];
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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [filteredAry count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [filteredAry objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[delegate returnSelectedAnyou:[filteredAry objectAtIndex:indexPath.row] andRow:indexPath.row];
    
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [filteredAry removeAllObjects];
    if ([searchText isEqualToString:@""]) {
        self.filteredAry = [NSMutableArray arrayWithArray:anyouAry];
        [self.tableView reloadData];
        return;
    }
    int dataCount = [anyouAry count];

    NSString *tmp;
    for (int i = 0; i < dataCount; i++) {
        tmp = [anyouAry objectAtIndex:i];

        if ([tmp rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound) {
            [filteredAry addObject:tmp];
            
        }
    }
    [self.tableView reloadData];
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
