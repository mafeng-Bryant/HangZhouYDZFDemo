    //
//  EnNameViewController.m
//  handbook
//
//  Created by chen on 11-4-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EnNameViewController.h"

#import "GMEPS_HZAppDelegate.h"
#import "SearchDetaiViewController.h"

extern sqlite3 *data_db;
extern NSArray *tableColumn;

@implementation EnNameViewController
@synthesize dataResultArray;
@synthesize mytableview;

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

-(void)searchByLetter:(NSInteger)tag{
	char letter = 'a'+tag-1;
	printf("%c",letter);
	
	NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM dangerchem WHERE ENAME LIKE '%%-%c%%' OR ENAME LIKE '%c%%'",letter,letter];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	const char *utfsql = [sqlStr cStringUsingEncoding:enc];

	sqlite3_stmt *statement; 
	if (sqlite3_prepare_v2(data_db, utfsql, -1, &statement, nil)==SQLITE_OK) { 
		NSLog(@"select ok."); 
	}
	
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:20];
	 
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
	[dictionary release];
	
	sqlite3_finalize(statement);
	
	[self.mytableview reloadData];
	
	
}

-(IBAction)buttonPressed:(id)sender{
	UIButton *btn = (UIButton *)sender;
	[self searchByLetter:btn.tag];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"英文字母";
	
	NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:130];	
	self.dataResultArray = ary;
	[ary release];
	
	//默认查询A
	[self searchByLetter:1];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
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
    [super dealloc];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [dataResultArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"查询结果"; 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 72;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row%2 == 0) ? @"lightblue" : @"white" ofType:@"png"];
	UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
	cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
	cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	cell.backgroundView.frame = cell.bounds;
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.detailTextLabel.backgroundColor = [UIColor clearColor];
	
	// Configure the cell...
	NSDictionary *dic =[dataResultArray objectAtIndex:[indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",
						   [dic objectForKey:[tableColumn objectAtIndex:4]],
						   [dic objectForKey:[tableColumn objectAtIndex:3]]];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"  国标编号%@ cas编号%@ 危险标记：%@ ",
								 [dic objectForKey:[tableColumn objectAtIndex:1]],
								 [dic objectForKey:[tableColumn objectAtIndex:2]],
								 [dic objectForKey:[tableColumn objectAtIndex:11]]];
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


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


@end
