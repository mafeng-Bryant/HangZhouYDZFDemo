//
//  choosePersonControllerView.m
//  GMEPS_HZ
//
//  Created by Apple on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "choosePersonControllerView.h"
#import "UserInfo.h"

@implementation SectionItem1
@synthesize sectionName;
@synthesize bOpened;
@end
extern UserInfo *g_logedUserInfo;
@implementation choosePersonControllerView
@synthesize aryDanwei,dicPersonAll;
@synthesize arySectionItems,arySectionPerson;
@synthesize delegate;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
/*
-(void)initializeSectionDatas{
    //NSArray *keys = [dicPersonInfomation allKeys];
    self.arySectionItems = [[NSMutableArray alloc] initWithCapacity:10];
    //self.arySectionPerson = [[NSMutableArray alloc] initWithCapacity:10];
    int count = [aryDanwei count];
    for (int i = 0; i < count;i++ ) {
        SectionItem1 *aItem = [[SectionItem1 alloc] init];
        aItem.sectionName = [aryDanwei objectAtIndex:i];
        aItem.bOpened = YES;
        [arySectionItems addObject:aItem];
        [aItem release];
    }
    [self.tableView reloadData];
}
*/
-(void)personSure
{
    [delegate returnChoosePersons:arySectionPerson isSure:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *aButton1 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone  
                                                                target:self action:@selector(personSure)];
    
    self.navigationItem.rightBarButtonItem = aButton1;	
    [aButton1 release];
    //[self initializeSectionDatas];
    //self.aryDanwei = [[NSMutableArray alloc] initWithCapacity:100];
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

-(void)dealloc
{
    [aryDanwei release];
    [dicPersonAll release];
    [arySectionPerson release];
    [super dealloc];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.aryDanwei count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    /*SectionItem1 *aItem = [arySectionItems objectAtIndex:indexPath.row];
    NSArray *ary = [dicPersonAll objectForKey:aItem.sectionName];
    NSDictionary *dic = [ary objectAtIndex:indexPath.row];
    NSString *name = [dic objectForKey:@"YHMC"];
    */
    NSString * name = [aryDanwei objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    for (UserInfo *aInfo in arySectionPerson) {
        if ([name isEqualToString:aInfo.userName]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    cell.textLabel.text = name;

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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        for (UserInfo *aInfo in arySectionPerson) {
            if ([cell.textLabel.text isEqualToString:aInfo.userName]) {
                [arySectionPerson removeObject:aInfo];
                break;
            }
        }
    }
    else{
        
        UserInfo *aInfo = [[UserInfo alloc] init];
        
        NSArray *ary = [dicPersonAll objectForKey:[aryDanwei objectAtIndex:indexPath.row]];
        NSDictionary *dic = [ary objectAtIndex:0];
        aInfo.userName = [dic objectForKey:@"YHMC"];
        if(aInfo.userName == nil)aInfo.userName =@"";
        aInfo.YHID = [dic objectForKey:@"YHID"];
        if(aInfo.YHID == nil)aInfo.YHID =@"";
        aInfo.userDanwei = [dic objectForKey:@"BMMC"];
        if(aInfo.userDanwei == nil)aInfo.userDanwei =@"";
        aInfo.BMBH = [dic objectForKey:@"BMBH"];
        if(aInfo.BMBH == nil)aInfo.BMBH =@"";
        aInfo.ZFZJBH = [dic objectForKey:@"ZFZJBH"];
        if(aInfo.ZFZJBH == nil)aInfo.ZFZJBH =@"";
        aInfo.FSHBJ = [dic objectForKey:@"FSHBJ"];
        if(aInfo.FSHBJ == nil)aInfo.FSHBJ =@"";
        aInfo.userPhone = [dic objectForKey:@"PHONE"];
        if(aInfo.userPhone == nil)aInfo.userPhone =@"";
        [arySectionPerson addObject:aInfo];
        
        [aInfo release];
        
    }
    [delegate returnChoosePersons:arySectionPerson isSure:NO];
    [self.tableView reloadData];

    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
