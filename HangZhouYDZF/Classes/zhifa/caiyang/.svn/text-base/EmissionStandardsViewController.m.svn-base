//
//  EmissionStandardsViewController.m
//  GMEPS_HZ
//
//  Created by sz apple on 11-10-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "EmissionStandardsViewController.h"

@implementation EmissionStandardsViewController
@synthesize standardSelected;
@synthesize filteredAry;
@synthesize standardAry;
@synthesize delegate;

-(void) okItemPressed:(id)sender{
    [delegate returnSelectedStandards:standardSelected];
}

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

- (void)dealloc {
    [standardSelected release];
    [filteredAry release];
    [standardAry release];
    [super dealloc];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.contentSizeForViewInPopover = CGSizeMake(600, 500);
    
    
    UIBarButtonItem *aButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone  
                                                               target:self action:@selector(okItemPressed:)];
    self.navigationItem.rightBarButtonItem = aButton;	
    [aButton release];
    
    self.standardAry = [NSArray arrayWithObjects:@"地表水环境质量标准(GB3838-2002)",
                        @"纺织染整工业水污染物排放标准(GB4287-2012)",
                        @"制浆造纸工业水污染物排放标准(GB3544-2008)",
                        @"电镀污染物排放标准(GB21900-2008)",
                        @"合成革与人造革工业污染物排放标准(GB21902-2008)",
                        @"医疗机构水污染物排放标准(GB18466-2005)",
                        @"啤酒工业污染物排放标准(GB19821-2005)",
                        @"城镇污水处理厂污染物排放标准(GB18918-2002)",
                        @"污水综合排放标准(GB8978-1996)",
                        @"污水排入城市下水道水质标准(CJ343-2010)",
                        @"环境空气质量标准(GB3095-2012)",
                        @"火电厂大气污染物排放标准(GB13223-2011)",
                        @"水泥工业大气污染物排放标准(GB4915-2004)",
                        @"饮食业油烟排放标准(试行)(GB18483-2001)",
                        @"锅炉大气污染物排放标准(GB13271-2001)",
                        @"大气污染物综合排放标准(GB16297-1996)",
                        @"声环境质量标准(GB3096-2008)",
                        @"建筑施工场界环境噪声排放标准(GB12523-2011)",
                        @"工业企业厂界环境噪声排放标准(GB12348-2008)",
                        @"危险废物焚烧污染控制标准(GB18484-2001)",
                        @"危险废物贮存污染控制标准(GB18597-2001)",
                        @"一般工业固体废物贮存、处置场污染控制标准(GB18599-2001)",
                        @"生活垃圾填埋污染控制标准(GB16889-2008)",
                         nil];
    self.filteredAry = [NSMutableArray arrayWithArray:standardAry];
    
    self.standardSelected = [NSMutableArray arrayWithCapacity:10];
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
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [filteredAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSString *standard = [filteredAry objectAtIndex:indexPath.row];
    NSString *standardStr;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    for (standardStr in standardSelected) {
        if ([standard isEqualToString:standardStr])
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    [standardStr release];
    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    cell.textLabel.textColor = [UIColor blueColor];
    cell.textLabel.text = standard;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *standardStr;
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        
        for (standardStr in standardSelected) {
            if ([cell.textLabel.text isEqualToString:standardStr]) {
                [standardSelected removeObject:standardStr];
                break;
            }
        }
    }
    else {
        standardStr = cell.textLabel.text;
        [standardSelected addObject:standardStr];
    }
    
   // [standardStr release];
    [self.tableView reloadData];
}

@end
