//
//  CnNameViewController.m
//  handbook
//
//  Created by chen on 11-4-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CnNameViewController.h"
#import "CnNameItemController.h"

@implementation CnNameViewController
@synthesize data;
@synthesize detailDatas;

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"中文笔划";
	
	NSArray *tmpData = [[NSArray alloc] initWithObjects:
						@"一画",@"二画",@"三画",@"四画",@"五画",@"六画",
						@"七画",@"八画",@"九画",@"十画",@"十一画",@"十二画",
						@"十三画",@"十四画",@"十五画",@"十六画",@"十七画",nil];
	self.data = tmpData;
	[tmpData release];
	
	//count
	NSArray *tmpItemData = [[NSArray alloc] initWithObjects:
							@"一、乙",@"二、十、丁、七、八、儿",@"三、、山、己、马、久",
							@"开、无、木、五、内、水、壬、升、化、月、乌、六、火、巴、双",
							@"正、功、丙、艾、石、戊、灭、甲、电、四、生、代、白、乐、发、皮、对",
							@"压、亚、过、西、百、灰、光、吗、吖、氖、仲、全、杀、多、安、次、羊、并、异、防、红、阴",
							@"赤、汞、苄、连、苊、吡、呋、吡、氙、谷、邻、狄、辛、间、汽、沥、阿",
							@"环、苛、苦、苯、茂、松、咔、叔、败、迭、卑、钒、金、乳、庚、沼",
							@"毒、草、茴、茨、荧、残、枯、砒、蚁、哌、钙、钛、钡、钠、氟、氢、香、重、保、胂、除、癸、活",
							@"盐、莰、速、砷、原、橄、钼、钾、铅、铊、铍、氩、氦、氧、氨、敌、笑、臭、害、涕、高、烧、酒",
							@"酞、黄、菲、萘、梯、硅、硒、铝、铜、卢、铬、铯、银、铷、第、偏、假、羟、粗、烯、液、密",
							@"琥、联、软、蒎、硝、硫、喹、锂、锆、锌、锑、锰、智、氰、氮、氯、巯",
							@"蒽、碘、硼、雷、新、溴、福、煤",
							@"碳、蝇、锶、镁、漂、滴",
							@"樟、醋、羰、镉、镍、稻",
							@"燕、薯、磺、噻、膦",
							@"磷、糠",
							nil];
	self.detailDatas = tmpItemData;
	[tmpItemData release];
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
    return [data count];
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
	cell.textLabel.text = [data objectAtIndex:indexPath.row];
	cell.detailTextLabel.text = [detailDatas objectAtIndex:indexPath.row];
    
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
    
    CnNameItemController *detailViewController = [[CnNameItemController alloc] initWithNibName:@"CnNameItemController" bundle:nil];
    detailViewController.fontcode = indexPath.row + 1;
	detailViewController.title = [data objectAtIndex:indexPath.row];
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
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

