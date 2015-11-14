//
//  PFBZViewController.m
//  GMEPS_HZ
//
//  Created by  on 11-10-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PFBZViewController.h"

@implementation PFBZViewController
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

-(void)dealloc{
    
    [super dealloc];
}

#pragma mark - View lifecycle
-(void) okItemPressed:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:100];
    for (int i = 0; i < 5; i++) {
        if(iSelIndex[i] != -1)
        {
            [str appendFormat:@"%@:%@;",[aryTitles objectAtIndex:i],
             [[aryItems objectAtIndex:i] objectAtIndex:iSelIndex[i]]];
        }
    }
    [delegate returnSelectedBiaoZhun:str];
    [str release];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    aryItems = [[NSArray alloc] initWithObjects:
                [NSArray arrayWithObjects:@"一级",@"二级",@"三级", nil],
                [NSArray arrayWithObjects:@"一级",@"二级",@"三级", nil],
                [NSArray arrayWithObjects:@"表1",@"表2",@"表3",@"纳管", nil],
                [NSArray arrayWithObjects:@"表1",@"表2",@"表3",@"纳管", nil],
                [NSArray arrayWithObjects:@"一级A",@"一级B",@"二级",@"三级", nil],nil];
    
    aryTitles = [[NSArray alloc] initWithObjects:
                 @"《污水综合排放标准》", @"《纺织染整工业水污染物排放标准》",
                 @"《电镀污染物排放标准》",@"《制浆造纸工业水污染物排放标准》",
                 @"《城镇污水处理厂污染物排放标准》",nil];
    
    UIBarButtonItem *aButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone  
                                                               target:self action:@selector(okItemPressed:)];
    self.navigationItem.rightBarButtonItem = aButton;	
    [aButton release];
    
    for (int i = 0; i < 5; i++) {
        iSelIndex[i] = -1;
    }
    

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
    return [aryTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [[aryItems objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [aryTitles objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [[aryItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    // Configure the cell...
    if (indexPath.row == iSelIndex[indexPath.section]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    if(iSelIndex[indexPath.section] == indexPath.row)
        iSelIndex[indexPath.section] = -1;//取消选择
    else
        iSelIndex[indexPath.section] = indexPath.row;
    [tableView reloadData];
    
}

@end
