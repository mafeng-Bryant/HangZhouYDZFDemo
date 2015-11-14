//
//  CategoryItemViewController.m
//  handbook
//
//  Created by chen on 11-4-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoryItemViewController.h"
#import "SearchDetaiViewController.h"
#import "GMEPS_HZAppDelegate.h"
extern sqlite3 *data_db;

extern NSArray *tableColumn;

@implementation CategoryItemViewController
@synthesize dataResultArray;
@synthesize kindcode;
#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 0.0)];
    _searchBar.delegate = self;
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:_searchBar];
    self.navigationItem.rightBarButtonItem = searchItem;
    [searchItem release];
    
    NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:130];	
	self.dataResultArray = ary;
	[ary release];
    
    NSMutableArray *ary1 = [[NSMutableArray alloc] initWithCapacity:130];	
	dataNameArray = ary1;
	[ary1 release];
	
	NSString *sqlStr = [NSString stringWithFormat:@"select * from dangerchem where kindcode = %d",kindcode];
	const char *utfsql = [sqlStr cStringUsingEncoding:NSUTF8StringEncoding];
	
	sqlite3_stmt *statement; 
	if (sqlite3_prepare_v2(data_db, utfsql, -1, &statement, nil)==SQLITE_OK) { 
		////NSLog(@"select ok."); 
	}
    else
    {
        //NSLog(@"erroe");
    }
	
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:20];
	
	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);  
	int i =0;
	char *name;
	NSString *text;
	[dataResultArray removeAllObjects];
	while (sqlite3_step(statement)==SQLITE_ROW) { 
		
		for ( i= 0; i<6; i++) {
			name=(char *)sqlite3_column_text(statement,i ); 		  
			text = [NSString stringWithCString:name  encoding:enc];
			[dictionary setObject:text forKey:[tableColumn objectAtIndex:i]];
			
		}
		
		for ( i= 7; i<19; i++) {
			name=(char *)sqlite3_column_text(statement, i); 		  
			text = [NSString stringWithCString:name  encoding:enc];
			[dictionary setObject:text forKey:[tableColumn objectAtIndex:i]];
			
		}
		
		[dataResultArray addObject:[dictionary copy]];
		//NSString *text=[NSString stringWithCString:name encoding:NSUTF8StringEncoding];
		
	}
    dataNameArray = [dataResultArray mutableCopy];
    //NSLog(@"duoshao:%@",dataResultArray);
	[dictionary release];
	
	sqlite3_finalize(statement);
	
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
    return [dataResultArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    // Configure the cell...
	NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row%2 == 0) ? @"lightblue" : @"white" ofType:@"png"];
	UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
	cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
	cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	cell.backgroundView.frame = cell.bounds;
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.detailTextLabel.backgroundColor = [UIColor clearColor];
	
	NSDictionary *dic =[dataResultArray objectAtIndex:[indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",
						   [dic objectForKey:[tableColumn objectAtIndex:3]],
						   [dic objectForKey:[tableColumn objectAtIndex:4]]];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"  国标编号%@ cas编号%@ 危险标记：%@ ",
								 [dic objectForKey:[tableColumn objectAtIndex:1]],
								 [dic objectForKey:[tableColumn objectAtIndex:2]],
								 [dic objectForKey:[tableColumn objectAtIndex:11]]];
    
	cell.textLabel.font  = [UIFont systemFontOfSize:22];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    SearchDetaiViewController *detailViewController = [[SearchDetaiViewController alloc] initWithNibName:@"SearchDetaiViewController" bundle:nil];
	detailViewController.titleDic = [dataResultArray objectAtIndex:[indexPath row]];
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 72;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //dataNameArray = [dataResultArray mutableCopy];
    [dataResultArray removeAllObjects];
    if ([searchText isEqualToString:@""]) {
        
        NSMutableArray *copyDataAry = [dataNameArray mutableCopy];
        self.dataResultArray = copyDataAry;
        [myTableView reloadData];
        [copyDataAry release];
        return;
    }
    int dataCount = [dataNameArray count];
    NSDictionary *dic;
    NSString *tmp;
    for (int i = 0; i < dataCount; i++) {
        dic = [dataNameArray objectAtIndex:i];
        tmp = [NSString stringWithFormat:@"%@(%@)",
               [dic objectForKey:[tableColumn objectAtIndex:3]],
               [dic objectForKey:[tableColumn objectAtIndex:4]]];
        if ([tmp rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound) {
            NSDictionary *copyDic = [dic copy];
            [dataResultArray addObject:copyDic];
            [copyDic release];
            
        }
    }
    [myTableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
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

