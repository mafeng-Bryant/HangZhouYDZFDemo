//
//  WasteItemViewController.m
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-6-20.
//
//

#import "WasteItemViewController.h"
#import "WasteDetailViewController.h"
#import "FMDatabase.h"
@interface WasteItemViewController ()

@end

@implementation WasteItemViewController

- (void)dealloc {
    [_wasteDeAry release];
    [_wasteBHAry release];
    [_wasteFeAry release];
    [_wasteHlAry release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_wasteDeAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 600, 30)];
        detailLabel.textAlignment = UITextAlignmentLeft;
        detailLabel.textColor = [UIColor grayColor];
        detailLabel.font = [UIFont systemFontOfSize:16];
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.tag = 101;
        
        [cell.contentView addSubview:detailLabel];
        [detailLabel release];
        
    }
    
    NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row%2 == 0) ? @"lightblue" : @"white" ofType:@"png"];
	UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
	cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
	cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	cell.backgroundView.frame = cell.bounds;
	cell.textLabel.backgroundColor = [UIColor clearColor];
	
    cell.textLabel.font  = [UIFont systemFontOfSize:20];
    
    cell.textLabel.text =[self.wasteDeAry objectAtIndex:indexPath.row];
    
    UILabel *detailLabel = (UILabel *)[cell.contentView viewWithTag:101];
    
    NSString *bhStr = [self.wasteBHAry objectAtIndex:indexPath.row];
    NSString *feStr = [self.wasteFeAry objectAtIndex:indexPath.row];
    NSString *hlStr = [self.wasteHlAry objectAtIndex:indexPath.row];
    NSString *detailStr = [NSString stringWithFormat:@"废物代码：%@  危险特性:%@  行业来源:%@",bhStr,feStr,hlStr];
    detailLabel.text = detailStr;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    WasteDetailViewController *wasteDetailViewController = [[WasteDetailViewController alloc] initWithNibName:@"WasteDetailViewController" bundle:nil];
    NSString *nameStr = [self.wasteDeAry objectAtIndex:indexPath.row];
    NSString *bhStr = [self.wasteBHAry objectAtIndex:indexPath.row];
    NSString *feStr = [self.wasteFeAry objectAtIndex:indexPath.row];
    NSString *hlStr = [self.wasteHlAry objectAtIndex:indexPath.row];
    NSString *cgStr = [self.wasteCgAry objectAtIndex:indexPath.row];
    
    NSDictionary *tmpDict = [NSDictionary dictionaryWithObjectsAndKeys:nameStr,@"name",bhStr,@"bh",feStr,@"feature",hlStr,@"hl",cgStr,@"category",nil];
    wasteDetailViewController.detailDict = tmpDict;
    
    [self.navigationController pushViewController:wasteDetailViewController animated:YES];
    
    [wasteDetailViewController release];
}

@end
