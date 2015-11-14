//
//  DubanFullInfoController.m
//  GMEPS_HZ
//
//  Created by chen on 11-10-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DubanFullInfoController.h"


@implementation DubanFullInfoController
@synthesize aItem,itemsToDisplay,itemsValue;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [aItem release];
    [itemsToDisplay release];
    [itemsValue release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.itemsToDisplay = [NSArray arrayWithObjects:@"督办任务类型：",@"督办主题：", 
                           @"督办人：",@"督办单位：",@"接受人：",@"接受单位：", 
                           @"是否关联执法：",@"关联的企业：",@"备注：",@"督办时间：",
                            @"任务完成期限：",@"是否转办：",@"督办人是否办结：",@"督办人办结时间：",
                           @"督办办结人：",@"接收人是否办结：",@"接收人办结时间：",
                           @"接收办结人：",@"督办信息：",nil];
    NSString *tmRWLX;
    if([aItem.RWLX isEqualToString:@"1"])
        tmRWLX = @"现场检查";
    else if([aItem.RWLX isEqualToString:@"2"])
        tmRWLX = @"专项整治";
    else
        tmRWLX = @"信访投诉";
    
    NSString * tmpSFGLZF = aItem.SFGLZF?@"是":@"否";
    NSString *tmpSFZB = aItem.SFZB?@"是":@"否";
    NSString *tmpDBRSFBJ = aItem.DBRSFBJ?@"是":@"否";
    NSString *tmpJSRSFBJ = aItem.JSRSFBJ?@"是":@"否";
    
    self.itemsValue = [NSArray arrayWithObjects:tmRWLX, aItem.ZT,aItem.DBR,aItem.DBRDW,
                       aItem.JSR,aItem.JSRDW,tmpSFGLZF, aItem.DWMC,
                       aItem.YDBZ, aItem.DBSJ,aItem.QX,tmpSFZB,tmpDBRSFBJ,
                       aItem.DBRBJSJ,aItem.DBBJR,tmpJSRSFBJ,aItem.JSRBJSJ,
                       aItem.JSBJR,aItem.DBXX ,nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
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
    return [itemsToDisplay count] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return (indexPath.row == [itemsToDisplay count]-1) ? 200 : 45;
}

- (UITableViewCell*) getCell:(NSString*) CellIdentifier forTablieView:(UITableView*) tableView
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	return cell;
}

-(UITableViewCell*)makeSubCell:(UITableView *)tableView
					 withTitle:(NSString *)aTitle
						 value:(NSString *)aValue

{
	UILabel* lblTitle = nil;
	UILabel* lblValue = nil;
    UITableViewCell* aCell = nil;

    aCell = [self getCell:@"Cell_Detail1" forTablieView:tableView];

	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lblValue = (UILabel *)[aCell.contentView viewWithTag:2];
	}
	
	if (lblTitle == nil) {
		lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 140, 44)]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor grayColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblTitle.textAlignment = UITextAlignmentRight;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
        
		lblValue = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 600, 44)];
        lblValue.tag = 2;
        [lblValue setBackgroundColor:[UIColor clearColor]];
        [lblValue setTextColor:[UIColor blackColor]];
        lblValue.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        lblValue.textAlignment = UITextAlignmentLeft;
        
        [aCell.contentView addSubview:lblValue];
        [lblValue release];

	}
	
	if (lblTitle != nil)	[lblTitle setText:aTitle];
	if (lblValue != nil)	[lblValue setText:aValue];
    aCell.accessoryType = UITableViewCellAccessoryNone;
	return aCell;
}


-(UITableViewCell*)makeSubHighCell:(UITableView *)tableView
					 withTitle:(NSString *)aTitle
						 value:(NSString *)aValue

{
	UILabel* lblTitle = nil;
    UITextView *txtValue = nil;
    UITableViewCell* aCell = nil;
    aCell = [self getCell:@"Cell_Detail2" forTablieView:tableView];
	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
        txtValue = (UITextView *)[aCell.contentView viewWithTag:3];
	}
	
	if (lblTitle == nil) {
		lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 140, 44)]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor grayColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblTitle.textAlignment = UITextAlignmentRight;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
        txtValue = [[UITextView alloc] initWithFrame:CGRectMake(160, 0, 600, 200)];
        txtValue.tag = 3;
        [txtValue setBackgroundColor:[UIColor clearColor]];
        [txtValue setTextColor:[UIColor blackColor]];
        txtValue.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        txtValue.autocorrectionType = UITextAutocorrectionTypeNo;
        txtValue.autocapitalizationType= UITextAutocapitalizationTypeNone;
        txtValue.editable = NO;
        
        [aCell.contentView addSubview:txtValue];
        [txtValue release];		
		
	}
	
	if (lblTitle != nil)	[lblTitle setText:aTitle];
	if(txtValue!= nil)   [txtValue setText:aValue];
    
	aCell.accessoryType = UITableViewCellAccessoryNone;
	return aCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *aTitle = [itemsToDisplay objectAtIndex:indexPath.row];
    NSString *value = [itemsValue objectAtIndex:indexPath.row];
    BOOL bLong = (indexPath.row == [itemsToDisplay count]-1);
    UITableViewCell *cell;
    if(bLong)
        cell = [self makeSubHighCell:tableView withTitle:aTitle value:value];        
    else
        cell = [self makeSubCell:tableView withTitle:aTitle value:value];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

@end
