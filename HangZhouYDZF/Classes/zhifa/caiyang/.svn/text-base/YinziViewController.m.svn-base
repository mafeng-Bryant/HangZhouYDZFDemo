//
//  YinziViewController.m
//  GMEPS_HZ
//
//  Created by sz apple on 11-10-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "YinziViewController.h"



@implementation YinziViewController
@synthesize arySectionValues,delegate,yzTableView,arySelectedIndex,arySectionNoValues;


-(void) okItemPressed:(id)sender{
    
    NSMutableString *yinziString = [[NSMutableString alloc] init];
    NSMutableString *yinziStringNo = [[NSMutableString alloc] init];
    
    for (NSIndexPath *indexPath in arySelectedIndex) {
        
        NSString *name = [[arySectionValues objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        NSString *no = [[arySectionValues objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        if ([yinziString length] == 0)
            [yinziString appendFormat:@"%@",name];
        else
            [yinziString appendFormat:@",%@",name];
        
        if ([yinziStringNo length] == 0)
            [yinziStringNo appendFormat:@"%@",no];
        else
            [yinziStringNo appendFormat:@",%@",no];
        
    }
    
    
    [delegate returnSelectedYinzi:yinziString andNo:yinziStringNo];
    [yinziStringNo release];
    [yinziString release];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

- (void)dealloc
{
    [arySectionValues release];
    [arySelectedIndex release];
    [yzTableView release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentSizeForViewInPopover = CGSizeMake(300, 500);
    
    UIBarButtonItem *aButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone  
                                                               target:self action:@selector(okItemPressed:)];
    self.navigationItem.rightBarButtonItem = aButton;	
    [aButton release];
    

    NSArray *section1 = [NSMutableArray arrayWithObjects:@"COD",@"pH",@"NH3-N",@"TN",@"TP",@"SS",@"色度", nil];
    NSArray *section2 = [NSMutableArray arrayWithObjects:@"总铬",@"六价铬",@"总镍",@"总镉",@"总铜",@"总锌",@"总锰", nil];
    NSArray *section3 = [NSMutableArray arrayWithObjects:@"动植物油",@"石油类",@"甲醛",@"氟化物",@"硫化物",@"总氰化合物",@"粪大肠菌群",@"总余氯",@"肠道致病菌",@"结核杆菌",@"挥发酚",@"总砷",@"总汞",@"总铅",@"总银", nil];
    
    self.arySectionValues = [NSArray arrayWithObjects:section1,section2,section3,nil];
    
    NSArray *sectionNo1 = [NSMutableArray arrayWithObjects:@"5501",@"5502",@"5503",@"5504",@"5505",@"5506",@"5507", nil];
    NSArray *sectionNo2 = [NSMutableArray arrayWithObjects:@"6601",@"6602",@"6603",@"6604",@"6605",@"6606",@"6607", nil];
    NSArray *sectionNo3 = [NSMutableArray arrayWithObjects:@"7701",@"7702",@"7703",@"7704",@"7705",@"7706",@"7707",@"7708",@"7709",@"7710",@"7711",@"7712",@"7713",@"7714",@"7715", nil];
    
    self.arySectionNoValues = [NSArray arrayWithObjects:sectionNo1,sectionNo2,sectionNo3,nil];
    
    self.arySelectedIndex = [NSMutableArray arrayWithCapacity:30];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source


#define HEADER_HEIGHT 35

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return HEADER_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
	if (section == 0) 
       return @"常用";
    else if (section == 1) 
        return @"重金属";
    else 
        return @"其它";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[arySectionValues objectAtIndex:section] count];
    
}







- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    

    NSString *name = [[arySectionValues objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;

    for (NSIndexPath *index in arySelectedIndex) {
        if (index.section == indexPath.section && index.row == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        }
    }
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    cell.textLabel.textColor = [UIColor blueColor];
    cell.textLabel.text = name;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isFinded = NO;
    for (NSIndexPath *index in arySelectedIndex) {
        if (index.section == indexPath.section && index.row == indexPath.row) {
            [arySelectedIndex removeObject:index];
            isFinded = YES;
            break;
        }
    }
    if (!isFinded) {
        [arySelectedIndex addObject:indexPath];
    }
    [self.yzTableView reloadData];
    
}

@end
