//
//  WasteCategoryViewController.m
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-6-20.
//
//

#import "WasteCategoryViewController.h"
#import "WasteItemViewController.h"
#import "FMDatabase.h"
@interface WasteCategoryViewController ()
@end

@implementation WasteCategoryViewController

#pragma mark - ViewController lifecycle
- (void)dealloc {
    [_wasteBHAry release];
    [_wasteCGAry release];
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
    return [_wasteBHAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, (50-3)/2, 100, 3)];
        lineImageView.image = [UIImage imageNamed:@"bilu_line.png"];
        [cell.contentView addSubview:lineImageView];
        [lineImageView release];
        
        UILabel *bhLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 400, 50)];
        bhLabel.textAlignment = UITextAlignmentLeft;
        bhLabel.font = [UIFont systemFontOfSize:24];
        bhLabel.backgroundColor = [UIColor clearColor];
        bhLabel.tag = 101;
        [cell.contentView addSubview:bhLabel];
        [bhLabel release];
    }
    
    NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row%2 == 0) ? @"lightblue" : @"white" ofType:@"png"];
	UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
	cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
	cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	cell.backgroundView.frame = cell.bounds;
	cell.textLabel.backgroundColor = [UIColor clearColor];
	
    cell.textLabel.font  = [UIFont systemFontOfSize:24];
    
    cell.textLabel.text =[self.wasteBHAry objectAtIndex:indexPath.row];
    
    UILabel *bhLable = (UILabel *)[cell.contentView viewWithTag:101];
    bhLable.text = [self.wasteCGAry objectAtIndex:indexPath.row];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    if ([self.wasteBHAry count] == 0) {
        cell.textLabel.text = @"无查询结果显示";
    }
    // Configure the cell...
    
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
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *bhStr = [self.wasteBHAry objectAtIndex:indexPath.row];
    NSString *cgStr = [self.wasteCGAry objectAtIndex:indexPath.row];
    //获取数据库文件
    NSString *dbFilePath = [[NSBundle mainBundle] pathForResource:@"wrydata" ofType:@"db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbFilePath];
    if (![database open]) {
        NSLog(@"Open database failed");
        return;
    }
    
    NSString *queryStr =[NSString stringWithFormat:@"select  DMNR,DMBH,FWTX,HYLY from dangerwaste  where sjdmbh = \'%@\' ",bhStr];
    
    FMResultSet *resultSet =[database executeQuery:queryStr];
    
    NSMutableArray *describeAry = [NSMutableArray array];
    NSMutableArray *bhAry       = [NSMutableArray array];
    NSMutableArray *featureAry  = [NSMutableArray array];
    NSMutableArray *sourAry     = [NSMutableArray array];
    NSMutableArray *categoryAry = [NSMutableArray array];
    
    while([resultSet next]) {
        NSString *wasteDescribe = [resultSet stringForColumn:@"DMNR"];
        NSString *wasteBH       = [resultSet stringForColumn:@"DMBH"];
        NSString *wasteFeature  = [resultSet stringForColumn:@"FWTX"];
        NSString *wasteSource   = [resultSet stringForColumn:@"HYLY"];
        NSString *wasteCategory = [NSString stringWithFormat:@"%@<br/>%@",bhStr,cgStr];
        
        [describeAry addObject:wasteDescribe];
        [bhAry       addObject:wasteBH];
        [featureAry  addObject:wasteFeature];
        [sourAry     addObject:wasteSource];
        [categoryAry addObject:wasteCategory];
    }
    
    
    
    
    [database close];
    
    WasteItemViewController *wasteItemViewController = [[WasteItemViewController alloc] initWithStyle:UITableViewStylePlain];
    wasteItemViewController.title = cgStr;
    wasteItemViewController.wasteDeAry = describeAry;
    wasteItemViewController.wasteBHAry = bhAry;
    wasteItemViewController.wasteFeAry = featureAry;
    wasteItemViewController.wasteHlAry = sourAry;
    wasteItemViewController.wasteCgAry = categoryAry;
    
    [self.navigationController pushViewController:wasteItemViewController animated:YES];
    [wasteItemViewController release];
}

@end
