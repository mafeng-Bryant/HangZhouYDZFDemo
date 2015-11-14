//
//  FSCYTableView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FSCYTableView.h"
#import "GMEPS_HZAppDelegate.h"

extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation FSCYTableView
@synthesize tableKey;
@synthesize xczfbh;
@synthesize webservice;
@synthesize currentString;
@synthesize titleAry;
@synthesize valueAry;
@synthesize titleAry2;
@synthesize valueAry2;
@synthesize zbTitleAry;
@synthesize zbValueAry;
@synthesize zbAry,aSubTable;
@synthesize gfhqk;
@synthesize bh;
@synthesize xmmc;
@synthesize bjcdwmc;
@synthesize cyfs;
@synthesize pffs;
@synthesize tqzk;
@synthesize qw;
@synthesize cyz;
@synthesize xhz;
@synthesize jyz;
@synthesize xcjc;
@synthesize grw;
@synthesize jysj;
@synthesize yzqk;
@synthesize scfh;
@synthesize gdjjrqk;
@synthesize cjsj;
@synthesize cjr;
@synthesize xgsj;
@synthesize xgr;
@synthesize bz;
@synthesize orgid;
@synthesize xh;

- (void)cancelPressed {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)initEntryWithNone {
    self.orgid = @"";
    self.bh = @"";
    self.gfhqk = @"";
    self.xmmc = @"";
    self.bjcdwmc = @"";
    self.cyfs = @"";
    self.pffs = @"";
    self.tqzk = @"";
    self.qw = @"";
    self.cyz = @"";
    self.xhz = @"";
    self.jyz = @"";
    self.xcjc = @"";
    self.grw = @"";
    self.jysj = @"";
    self.yzqk = @"";
    self.scfh = @"";
    self.gdjjrqk = @"";
    self.cjsj = @"";
    self.xgsj = @"";
    self.cjr = @"";
    self.xgr = @"";
    self.bz = @"";
    self.xh = @"";
}


- (void)dealloc
{
    [tableKey release];
    [xczfbh release];
    [webservice release];
    [currentString release];
    [aSubTable release];
    [titleAry release];
    [valueAry release];
    [titleAry2 release];
    [valueAry2 release];
    [zbTitleAry release];
    [zbValueAry release];
    [zbAry release];
    [gfhqk release];
    [bh release];
    [xmmc release];
    [bjcdwmc release];
    [cyfs release];
    [pffs release];
    [tqzk release];
    [qw release];
    [cyz release];
    [xhz release];
    [jyz release];
    [xcjc release];
    [grw release];
    [jysj release];
    [yzqk release];
    [scfh release];
    [gdjjrqk release];
    [cjsj release];
    [cjr release];
    [xgsj release];
    [xgr release];
    [bz release];
    [orgid release];
    [xh release];
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
    self.title = @"污染源废水采样";
    zbAry = [[NSMutableArray alloc] init];
    
    /*UIBarButtonItem *aItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain
															 target:self
															 action:@selector(cancelPressed)];
	self.navigationItem.rightBarButtonItem = aItem;
    */
    
    NSString *param = [WebServiceHelper createParametersWithKey:@"tableName" value:self.tableKey , @"xczfbh", self.xczfbh, nil];
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetChildsDetials" view:self.view nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
    webservice.hudTitle = @"正在获取污染废水采样表数据，请稍候...";
    [webservice run];
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
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



#pragma mark - Table view data source

- (UITableViewCell*) getCell:(NSString*) CellIdentifier forTablieView:(UITableView*) tableView
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	return cell;
}

-(void)makeTextViewCell:(UITableViewCell *)aCell andValue:(NSString*)aValue
{
	CGRect tEdtRect = CGRectMake(45, 0, 668, 300);
	UITextView* edt = [[UITextView alloc] initWithFrame:tEdtRect];
	
	[edt setBackgroundColor:[UIColor whiteColor]];    
	edt.font = [UIFont fontWithName:@"Helvetica" size:17.0];;
	edt.autocorrectionType = UITextAutocorrectionTypeNo;
	edt.autocapitalizationType= UITextAutocapitalizationTypeNone;
	edt.tag = 1;
	edt.text = aValue;
	edt.editable = NO;
	[aCell addSubview:edt];
	
	[edt release];
}

- (UITableViewCell*)makeSubCell:(UITableView *)tableView
                      withTitle:(NSString *)aTitle
                         title2:(NSString *)aTitle2
                          value:(NSString *)aValue
                         value2:(NSString *)aValue2
{
	UILabel* tLabel = nil;
    UILabel* tLabel2 = nil;
    UILabel* vLabel = nil;
    UILabel* vLabel2 = nil;
    
	UITableViewCell* aCell = [self getCell:@"Cell_DetailViewController" forTablieView:tableView];
    
	if (aCell.contentView != nil)
	{
        tLabel = (UILabel *)[aCell.contentView viewWithTag:1];
        vLabel = (UILabel *)[aCell.contentView viewWithTag:2];
        tLabel2 = (UILabel *)[aCell.contentView viewWithTag:3];
        vLabel2 = (UILabel *)[aCell.contentView viewWithTag:4];
    }
	
	if (tLabel == nil) {
		CGRect tRect1 = CGRectMake(0, 0, 100, 44);
		tLabel = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[tLabel setBackgroundColor:[UIColor clearColor]];
		[tLabel setTextColor:[UIColor darkGrayColor]];
		tLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		tLabel.textAlignment = UITextAlignmentRight;
		tLabel.tag = 1;
		[aCell.contentView addSubview:tLabel];
		[tLabel release];
		
		CGRect tRect2 = CGRectMake(100, 0, 300, 44);
		vLabel = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[vLabel setBackgroundColor:[UIColor clearColor]];
		[vLabel setTextColor:[UIColor blackColor]];
		vLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		vLabel.textAlignment = UITextAlignmentLeft;
		vLabel.tag = 2;
		[aCell.contentView addSubview:vLabel];
		[vLabel release];
        
        CGRect tRect3 = CGRectMake(400, 0, 120, 44);
		tLabel2 = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[tLabel2 setBackgroundColor:[UIColor clearColor]];
		[tLabel2 setTextColor:[UIColor darkGrayColor]];
		tLabel2.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		tLabel2.textAlignment = UITextAlignmentRight;
		tLabel2.tag = 3;
		[aCell.contentView addSubview:tLabel2];
		[tLabel2 release];
        
        CGRect tRect4 = CGRectMake(520, 0, 250, 44);
		vLabel2 = [[UILabel alloc] initWithFrame:tRect4]; //此处使用id定义任何控件对象
		[vLabel2 setBackgroundColor:[UIColor clearColor]];
		[vLabel2 setTextColor:[UIColor blackColor]];
		vLabel2.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		vLabel2.textAlignment = UITextAlignmentLeft;
		vLabel2.tag = 4;
		[aCell.contentView addSubview:vLabel2];
		[vLabel2 release];
        
    }
    
    [tLabel setText:aTitle];
    [vLabel setText:aValue];
    [tLabel2 setText:aTitle2];
    [vLabel2 setText:aValue2];
    
    aCell.accessoryType = UITableViewCellAccessoryNone;
    
	return aCell;
}

- (UITableViewCell*)makeSubCell:(UITableView *)tableView
                      withValue:(NSArray *)aValue
                        withRow:(NSUInteger)row
{
    UILabel *label0 = nil;
    UILabel *label1 = nil;
    UILabel *label2 = nil;
    UILabel *label3 = nil;
    UILabel *label4 = nil;
    UILabel *label5 = nil;
    UILabel *label6 = nil;
    UILabel *label7 = nil;
    UILabel *label8 = nil;
    UILabel *label9 = nil;
    UITableViewCell* aCell = [self getCell:@"ZB_cellIdentifier" forTablieView:tableView];
    CGRect tRect0;
    CGRect tRect1;
    CGRect tRect2;
    CGRect tRect3;
    CGRect tRect4;
    CGRect tRect5;
    CGRect tRect6;
    CGRect tRect7;
    CGRect tRect8;
    CGRect tRect9;
    
    if (aCell.contentView != nil) {
        label0 = (UILabel *)[aCell.contentView viewWithTag:1];
        label1 = (UILabel *)[aCell.contentView viewWithTag:2];
        label2 = (UILabel *)[aCell.contentView viewWithTag:3];
        label3 = (UILabel *)[aCell.contentView viewWithTag:4];
        label4 = (UILabel *)[aCell.contentView viewWithTag:5];
        label5 = (UILabel *)[aCell.contentView viewWithTag:6];
        label6 = (UILabel *)[aCell.contentView viewWithTag:7];
        label7 = (UILabel *)[aCell.contentView viewWithTag:8];
        label8 = (UILabel *)[aCell.contentView viewWithTag:9];
        label9 = (UILabel *)[aCell.contentView viewWithTag:10];
    }
    
    if (label0 == nil) {
        if (row == 0)
            tRect0 = CGRectMake(0, 0, 75, 75);
        else if (row == [zbAry count])
            tRect0 = CGRectMake(0, 1, 75, 75);
        else
            tRect0 = CGRectMake(0, 1, 75, 74);
		label0 = [[UILabel alloc] initWithFrame:tRect0]; //此处使用id定义任何控件对象
        if (row == 0)
            [label0 setBackgroundColor:[UIColor colorWithRed:(0xf1/255.0f) green:(0xe3/255.0f) blue:(0xc8/255.0f) alpha:1.0]];
        else
            [label0 setBackgroundColor:[UIColor colorWithRed:(0xfe/255.0f) green:(0xfe/255.0f) blue:(0xec/255.0f) alpha:1.0]];
		[label0 setTextColor:[UIColor blackColor]];
		label0.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        label0.numberOfLines = 3;
		label0.textAlignment = UITextAlignmentCenter;
		label0.tag = 1;
		[aCell.contentView addSubview:label0];
		[label0 release];
        
        if (row == 0)
            tRect1 = CGRectMake(76, 0, 83, 75);
        else if (row == [zbAry count])
            tRect1 = CGRectMake(76, 1, 83, 75);
        else
            tRect1 = CGRectMake(76, 1, 83, 74);
		label1 = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		if (row == 0)
            [label1 setBackgroundColor:[UIColor colorWithRed:(0xf1/255.0f) green:(0xe3/255.0f) blue:(0xc8/255.0f) alpha:1.0]];
        else
            [label1 setBackgroundColor:[UIColor colorWithRed:(0xfe/255.0f) green:(0xfe/255.0f) blue:(0xec/255.0f) alpha:1.0]];  
		[label1 setTextColor:[UIColor blackColor]];
		label1.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        label1.numberOfLines = 3;
		label1.textAlignment = UITextAlignmentCenter;
		label1.tag = 2;
		[aCell.contentView addSubview:label1];
		[label1 release];
        
        if (row == 0)
            tRect2 = CGRectMake(160, 0, 75, 75);
        else if (row == [zbAry count])
            tRect2 = CGRectMake(160, 1, 75, 75);
        else
            tRect2 = CGRectMake(160, 1, 75, 74);
		label2 = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		if (row == 0)
            [label2 setBackgroundColor:[UIColor colorWithRed:(0xf1/255.0f) green:(0xe3/255.0f) blue:(0xc8/255.0f) alpha:1.0]];
        else
            [label2 setBackgroundColor:[UIColor colorWithRed:(0xfe/255.0f) green:(0xfe/255.0f) blue:(0xec/255.0f) alpha:1.0]];
        [label2 setTextColor:[UIColor blackColor]];
		label2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        label2.numberOfLines = 3;
		label2.textAlignment = UITextAlignmentCenter;
		label2.tag = 3;
		[aCell.contentView addSubview:label2];
		[label2 release];
        
        if (row == 0)
            tRect3 = CGRectMake(236, 0, 75, 75);
        else if (row == [zbAry count])
            tRect3 = CGRectMake(236, 1, 75, 75);
        else
            tRect3 = CGRectMake(236, 1, 75, 74);
		label3 = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		if (row == 0)
            [label3 setBackgroundColor:[UIColor colorWithRed:(0xf1/255.0f) green:(0xe3/255.0f) blue:(0xc8/255.0f) alpha:1.0]];
        else
            [label3 setBackgroundColor:[UIColor colorWithRed:(0xfe/255.0f) green:(0xfe/255.0f) blue:(0xec/255.0f) alpha:1.0]];
		[label3 setTextColor:[UIColor blackColor]];
		label3.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        label3.numberOfLines = 3;
		label3.textAlignment = UITextAlignmentCenter;
		label3.tag = 4;
		[aCell.contentView addSubview:label3];
		[label3 release];
        
        if (row == 0)
            tRect4 = CGRectMake(312, 0, 75, 75);
        else if (row == [zbAry count])
            tRect4 = CGRectMake(312, 1, 75, 75);
        else
            tRect4 = CGRectMake(312, 1, 75, 74);
		label4 = [[UILabel alloc] initWithFrame:tRect4]; //此处使用id定义任何控件对象
		if (row == 0)
            [label4 setBackgroundColor:[UIColor colorWithRed:(0xf1/255.0f) green:(0xe3/255.0f) blue:(0xc8/255.0f) alpha:1.0]];
        else
            [label4 setBackgroundColor:[UIColor colorWithRed:(0xfe/255.0f) green:(0xfe/255.0f) blue:(0xec/255.0f) alpha:1.0]];
		[label4 setTextColor:[UIColor blackColor]];
		label4.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        label4.numberOfLines = 3;
		label4.textAlignment = UITextAlignmentCenter;
		label4.tag = 5;
		[aCell.contentView addSubview:label4];
		[label4 release];
        
        if (row == 0)
            tRect5 = CGRectMake(388, 0, 75, 75);
        else if (row == [zbAry count])
            tRect5 = CGRectMake(388, 1, 75, 75);
        else
            tRect5 = CGRectMake(388, 1, 75, 74);
		label5 = [[UILabel alloc] initWithFrame:tRect5]; //此处使用id定义任何控件对象
		if (row == 0)
            [label5 setBackgroundColor:[UIColor colorWithRed:(0xf1/255.0f) green:(0xe3/255.0f) blue:(0xc8/255.0f) alpha:1.0]];
        else
            [label5 setBackgroundColor:[UIColor colorWithRed:(0xfe/255.0f) green:(0xfe/255.0f) blue:(0xec/255.0f) alpha:1.0]];
		[label5 setTextColor:[UIColor blackColor]];
		label5.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        label5.numberOfLines = 3;
		label5.textAlignment = UITextAlignmentCenter;
		label5.tag = 6;
		[aCell.contentView addSubview:label5];
		[label5 release];
        
        if (row == 0)
            tRect6 = CGRectMake(464, 0, 75, 75);
        else if (row == [zbAry count])
            tRect6 = CGRectMake(464, 1, 75, 75);
        else
            tRect6 = CGRectMake(464, 1, 75, 74);
		label6 = [[UILabel alloc] initWithFrame:tRect6]; //此处使用id定义任何控件对象
		if (row == 0)
            [label6 setBackgroundColor:[UIColor colorWithRed:(0xf1/255.0f) green:(0xe3/255.0f) blue:(0xc8/255.0f) alpha:1.0]];
        else
            [label6 setBackgroundColor:[UIColor colorWithRed:(0xfe/255.0f) green:(0xfe/255.0f) blue:(0xec/255.0f) alpha:1.0]];
		[label6 setTextColor:[UIColor blackColor]];
		label6.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        label6.numberOfLines = 3;
		label6.textAlignment = UITextAlignmentCenter;
		label6.tag = 7;
		[aCell.contentView addSubview:label6];
		[label6 release];
        
        if (row == 0)
            tRect7 = CGRectMake(540, 0, 75, 75);
        else if (row == [zbAry count])
            tRect7 = CGRectMake(540, 1, 75, 75);
        else
            tRect7 = CGRectMake(540, 1, 75, 74);
		label7 = [[UILabel alloc] initWithFrame:tRect7]; //此处使用id定义任何控件对象
		if (row == 0)
            [label7 setBackgroundColor:[UIColor colorWithRed:(0xf1/255.0f) green:(0xe3/255.0f) blue:(0xc8/255.0f) alpha:1.0]];
        else
            [label7 setBackgroundColor:[UIColor colorWithRed:(0xfe/255.0f) green:(0xfe/255.0f) blue:(0xec/255.0f) alpha:1.0]];
		[label7 setTextColor:[UIColor blackColor]];
		label7.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        label7.numberOfLines = 3;
		label7.textAlignment = UITextAlignmentCenter;
		label7.tag = 8;
		[aCell.contentView addSubview:label7];
		[label7 release];
        
        if (row == 0)
            tRect8 = CGRectMake(616, 0, 75, 75);
        else if (row == [zbAry count])
            tRect8 = CGRectMake(616, 1, 75, 75);
        else
            tRect8 = CGRectMake(616, 1, 75, 74);
		label8 = [[UILabel alloc] initWithFrame:tRect8]; //此处使用id定义任何控件对象
		if (row == 0)
            [label8 setBackgroundColor:[UIColor colorWithRed:(0xf1/255.0f) green:(0xe3/255.0f) blue:(0xc8/255.0f) alpha:1.0]];
        else
            [label8 setBackgroundColor:[UIColor colorWithRed:(0xfe/255.0f) green:(0xfe/255.0f) blue:(0xec/255.0f) alpha:1.0]];;
		[label8 setTextColor:[UIColor blackColor]];
		label8.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        label8.numberOfLines = 3;
		label8.textAlignment = UITextAlignmentCenter;
		label8.tag = 9;
		[aCell.contentView addSubview:label8];
		[label8 release];
        
        if (row == 0)
            tRect9 = CGRectMake(692, 0, 75, 75);
        else if (row == [zbAry count])
            tRect9 = CGRectMake(692, 1, 75, 75);
        else
            tRect9 = CGRectMake(692, 1, 75, 74);
		label9 = [[UILabel alloc] initWithFrame:tRect9]; //此处使用id定义任何控件对象
		if (row == 0)
            [label9 setBackgroundColor:[UIColor colorWithRed:(0xf1/255.0f) green:(0xe3/255.0f) blue:(0xc8/255.0f) alpha:1.0]];
        else
            [label9 setBackgroundColor:[UIColor colorWithRed:(0xfe/255.0f) green:(0xfe/255.0f) blue:(0xec/255.0f) alpha:1.0]];
		[label9 setTextColor:[UIColor blackColor]];
		label9.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        label9.numberOfLines = 3;
		label9.textAlignment = UITextAlignmentCenter;
		label9.tag = 10;
		[aCell.contentView addSubview:label9];
		[label9 release];
    }
    [label0 setText:[aValue objectAtIndex:0]];
    [label1 setText:[aValue objectAtIndex:1]];
    [label2 setText:[aValue objectAtIndex:2]];
    [label3 setText:[aValue objectAtIndex:3]];
    [label4 setText:[aValue objectAtIndex:4]];
    [label5 setText:[aValue objectAtIndex:5]];
    [label6 setText:[aValue objectAtIndex:6]];
    [label7 setText:[aValue objectAtIndex:7]];
    [label8 setText:[aValue objectAtIndex:8]];
    [label9 setText:[aValue objectAtIndex:9]];
    
    
    aCell.accessoryType = UITableViewCellAccessoryNone;
    
	return aCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count;
    if (section == 0) {
        count = [titleAry count];
    } else if (section == 2) {
        count = 1;
    } else {
        count = [zbAry count]+1;
    }
    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *headTitle;
    if (section == 0) {
        headTitle = @"采样基本信息";
    } else if (section == 2) {
        headTitle = @"备注";
    } else {
        headTitle = [NSString stringWithFormat:@"样品信息"];
    }
    return headTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger height;
    if ([indexPath section] == 0) {
        height = 44;
    } else if ([indexPath section] == 2){
        height = 300;
    } else {
        height = 76;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
    NSUInteger section = [indexPath section];
    
    NSString *title;
    NSString *value;
    NSString *title2;
    NSString *value2;
    UITableViewCell *cell;
    
    if (section == 0) {
        title = [titleAry objectAtIndex:row];
        value = [valueAry objectAtIndex:row];
        title2 = [titleAry2 objectAtIndex:row];
        value2 = [valueAry2 objectAtIndex:row];
        cell = [self makeSubCell:tableView withTitle:title title2:title2 value:value value2:value2];
        
        NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row%2 == 0) ? @"white" : @"lightblue" ofType:@"png"];
        UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
        cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
        cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        cell.backgroundView.frame = cell.bounds;
        cell.textLabel.backgroundColor = [UIColor clearColor];
    
    } else if (section == 2){
        static NSString *cellIdentifier = @"BZ_cellIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        [self makeTextViewCell:cell andValue:self.bz];
        
    } else {
        if (row == 0) {
            cell = [self makeSubCell:tableView withValue:zbTitleAry withRow:row]; 
        } else {
            NSInteger index = row-1;
            FSCYSubItem *oneItem = [zbAry objectAtIndex:index];
            
            if (zbValueAry != nil)
                [zbValueAry removeAllObjects];
            
            [zbValueAry addObject:oneItem.ypbh];
            [zbValueAry addObject:oneItem.cydmc];
            [zbValueAry addObject:oneItem.cysj];
            [zbValueAry addObject:oneItem.jcxm1];
            [zbValueAry addObject:oneItem.sywg1];
            [zbValueAry addObject:oneItem.ls];
            [zbValueAry addObject:oneItem.kd];
            [zbValueAry addObject:oneItem.sd];
            [zbValueAry addObject:oneItem.ll];
            [zbValueAry addObject:oneItem.pfl];
            
            cell = [self makeSubCell:tableView withValue:zbValueAry withRow:row];
        }
    }
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section ==1 )
        cell.backgroundColor = [UIColor colorWithRed:0.89 green:0.77 blue:0.53 alpha:1.0];
}

#pragma mark - NSXMLParser Delegate Method

#define kGFHQK 0
#define kBH 1
#define kXMMC 2
#define kBJCDWMC 3
#define kCYFS 4
#define kPFFS 5
#define kTQZK 6
#define kQW 7
#define kCYZ 8
#define kXHZ 9
#define kJYZ 10
#define kXCJC 11
#define kGRW 12
#define kJYSJ 13
#define kYZQK 14
#define kSCFH 15
#define kGDJJRQK 16
#define kCJSJ 17
#define kCJR 18
#define kXGSJ 19
#define kXGR 20
#define kBZ 21
#define kORGID 22
#define kXH 23

#define kYPBH 24
#define kCYDMC 25
#define kCYSJ 26
#define kJCXM1 27
#define kSYWG1 28
#define kLS 29
#define kKD 30
#define kSD 31
#define kLL 32
#define kPFL 33

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
    bItem = NO;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"BH"])
		nParserStatus = kBH;
	else if ([elementName isEqualToString:@"ORGID"])
		nParserStatus = kORGID;
	else if ([elementName isEqualToString:@"GFHQK"])
		nParserStatus = kGFHQK;
	else if ([elementName isEqualToString:@"XMMC"])
		nParserStatus = kXMMC;
	else if ([elementName isEqualToString:@"BJCDWMC"])
		nParserStatus = kBJCDWMC;
    else if ([elementName isEqualToString:@"CYFS"])
		nParserStatus = kCYFS;
    else if ([elementName isEqualToString:@"PFFS"])
		nParserStatus = kPFFS;
    else if ([elementName isEqualToString:@"CJR"])
		nParserStatus = kCJR;
    else if ([elementName isEqualToString:@"XGR"])
		nParserStatus = kXGR;
    else if ([elementName isEqualToString:@"CJSJ"])
		nParserStatus = kCJSJ;
    else if ([elementName isEqualToString:@"XGSJ"])
		nParserStatus = kXGSJ;
    else if ([elementName isEqualToString:@"BZ"])
        nParserStatus = kBZ;
    else if ([elementName isEqualToString:@"TQZK"])
		nParserStatus = kTQZK;
    else if ([elementName isEqualToString:@"QW"])
		nParserStatus = kQW;
    else if ([elementName isEqualToString:@"CYZ"])
		nParserStatus = kCYZ;
    else if ([elementName isEqualToString:@"XHZ"])
		nParserStatus = kXHZ;
    else if ([elementName isEqualToString:@"JYZ"])
		nParserStatus = kJYZ;
    else if ([elementName isEqualToString:@"XCJC"])
		nParserStatus = kXCJC;
    else if ([elementName isEqualToString:@"GRW"])
		nParserStatus = kGRW;
    else if ([elementName isEqualToString:@"JYSJ"])
		nParserStatus = kJYSJ;
    else if ([elementName isEqualToString:@"YZQK"])
		nParserStatus = kYZQK;
    else if ([elementName isEqualToString:@"SCFH"])
		nParserStatus = kSCFH;
    else if ([elementName isEqualToString:@"GDJJRQK"])
		nParserStatus = kGDJJRQK;
    else if ([elementName isEqualToString:@"XH"])
		nParserStatus = kXH;
    
    else if ([elementName isEqualToString:@"YPBH"])
		nParserStatus = kYPBH;
    else if ([elementName isEqualToString:@"CYDMC"])
		nParserStatus = kCYDMC;
    else if ([elementName isEqualToString:@"CYSJ"])
		nParserStatus = kCYSJ;
    else if ([elementName isEqualToString:@"JCXM1"])
		nParserStatus = kJCXM1;
    else if ([elementName isEqualToString:@"SYWG1"])
		nParserStatus = kSYWG1;
    else if ([elementName isEqualToString:@"LS"])
		nParserStatus = kLS;
    else if ([elementName isEqualToString:@"KD"])
		nParserStatus = kKD;
    else if ([elementName isEqualToString:@"SD"])
		nParserStatus = kSD;
    else if ([elementName isEqualToString:@"LL"])
		nParserStatus = kLL;
    else if ([elementName isEqualToString:@"PFL"])
		nParserStatus = kPFL;
    
    else if ([elementName isEqualToString:@"T_YDZF_WRYFSCYZB"]) {
        aSubTable = [[FSCYSubItem alloc] initWithNone];
        bItem = YES;
    }
    
    else 
		nParserStatus = -1;
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (nParserStatus >= 0){
		if (!currentString)
			currentString = [NSMutableString string];
		[currentString appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if (nParserStatus >= 0){
		switch (nParserStatus) {
			case kBH:
			{
                self.bh = @"";
                if (currentString) {
                    self.bh = currentString;
                }
				
			}
				break;
				
			case kORGID:
			{
                self.orgid = @"";
                if (currentString) {
                    self.orgid = currentString;
                }
			}
				break;
                
			case kXH:
			{
                self.xh = @"";
                if (currentString) {
                    self.xh = currentString;
                }
			}
				break;
				
			case kGFHQK:
			{
                self.gfhqk = @"";
                if (currentString) {
                    self.gfhqk = currentString;
                }
            }
				break;
				
			case kXMMC:
			{
                self.xmmc = @"";
                if (currentString) {
                    self.xmmc = currentString;
                }
				
			}
				break;
                
            case kBJCDWMC:
			{
                self.bjcdwmc = @"";
                if (currentString) {
                    self.bjcdwmc = currentString;
                }
				
			}
				break;
                
            case kCYFS:
			{
                self.cyfs = @"";
                if (currentString) {
                    self.cyfs = currentString;                }
				
			}
				break;
                
            case kPFFS:
			{
                self.pffs = @"";
                if (currentString) {
                    self.pffs = currentString;
                }
				
			}
				break;
                
            case kCJR:
			{
                self.cjr = @"";
                if (currentString) {
                    self.cjr = currentString;
                }
			}
				break;
                
            case kCJSJ:
			{
                self.cjsj = @"";
                if (currentString) {
                    self.cjsj = [currentString substringToIndex:16];
                }
				
			}
				break;
                
            case kXGSJ:
			{
                self.xgsj = @"";
                if (currentString) {
                    self.xgsj = [currentString substringToIndex:16];
                }
				
			}
				break;
                
            case kXGR:
			{
                self.xgr = @"";
                if (currentString) {
                    self.xgr = currentString;

                }
            }
				break;
                
            case kBZ:
			{
                self.bz = @"";
                if (currentString) {
                    self.bz = currentString;
                }
			}
				break;
                
            case kTQZK:
			{
                self.tqzk = @"";
                if (currentString) {
                    self.tqzk = currentString;
                }
				
			}
				break;
                
            case kQW:
			{
                self.qw = @"";
                if (currentString) {
                    self.qw = currentString;
                }
			}
				break;
            
            case kCYZ:
			{
                self.cyz = @"";
                if (currentString) {
                    self.cyz = currentString;
                }
				
			}
				break;
                
            case kXHZ:
			{
                self.xhz = @"";
                if (currentString) {
                    self.xhz = currentString;
                }
				
			}
				break;
                
            case kJYZ:
			{
                self.jyz = @"";
                if (currentString) {
                    self.jyz = currentString;
                }
			}
				break;
                
            case kXCJC:
			{
                self.xcjc = @"";
                if (currentString) {
                    self.xcjc = currentString;
                }
				
			}
				break;
                
            case kGRW:
			{
                self.grw = @"";
                if (currentString) {
                    self.grw =currentString;
                }
			}
				break;
                
            case kJYSJ:
			{
                self.jysj = @"";
                if (currentString) {
                    self.jysj = [currentString substringToIndex:16];
                }
				
			}
				break;
                
            case kYZQK:
			{
                self.yzqk = @"";
                if (currentString) {
                    self.yzqk = currentString;
                }
			}
				break;
                
            case kSCFH:
			{
                self.scfh = @"";
                if (currentString) {
                    self.scfh = currentString;
                }
            
			}
				break;
                
            case kGDJJRQK:
			{
                self.gdjjrqk = @"";
                if (currentString) {
                    self.gdjjrqk = currentString;
                }
				
			}
				break;
                
            case kYPBH:
                aSubTable.ypbh = @"";
                if (currentString) {
                    aSubTable.ypbh = currentString;
                }
				break;
                
            case kCYDMC:
                aSubTable.cydmc = @"";
                if (currentString) {
                    aSubTable.cydmc = currentString;
                }
				break;
                
            case kCYSJ:
                aSubTable.cysj = @"";
                if (currentString) {
                    NSInteger len = [currentString length];
                    aSubTable.cysj = [currentString substringWithRange:NSMakeRange(0, len-3)];
            
                }
				break;
                
            case kJCXM1:
                aSubTable.jcxm1 = @"";
                if (currentString) {
                    aSubTable.jcxm1 = currentString;
                }
				break;
                
            case kSYWG1:
                aSubTable.sywg1 = @"";
                if (currentString) {
                    aSubTable.sywg1 = currentString;
                }
				break;
                
            case kLS:
                aSubTable.ls = @"";
                if (currentString) {
                    aSubTable.ls = currentString;
                }
				
				break;
            case kKD:
                aSubTable.kd = @"";
                if (currentString) {
                    aSubTable.kd = currentString;
                }
				break;
                
            case kSD:
                aSubTable.sd = @"";
                if (currentString) {
                    aSubTable.sd = currentString;
                }
				break;
                
            case kLL:
                aSubTable.ll = @"";
                if (currentString) {
                    aSubTable.ll = currentString;
                }
				break;
                
            case kPFL:
                aSubTable.pfl = @"";
                if (currentString) {
                    aSubTable.pfl = currentString;
                }
				break;
                
            default:
                break;
        }
		currentString = nil;
		nParserStatus = -1;
	}
    else if (bItem){
            [zbAry addObject:aSubTable];
            aSubTable = nil;
            bItem = NO;
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    titleAry = [[NSArray alloc] initWithObjects:@"行政区划：",@"项目名称：",@"被测单位：",@"天气状况：",@"监测设备：",@"生产负荷：",@"固定剂情况：", nil];
    titleAry2 = [[NSArray alloc] initWithObjects:@"规范化情况：",@"采样方式：",@"排放方式：",@"气温：",@"接样时间：",@"运转情况：",@"干扰物：",@"", nil];
    valueAry = [[NSArray alloc] initWithObjects:self.orgid,self.xmmc,self.bjcdwmc,self.tqzk,self.xcjc,self.scfh,self.gdjjrqk, nil];
    valueAry2 = [[NSArray alloc] initWithObjects:self.gfhqk,self.cyfs,self.pffs,self.qw,self.jysj,self.yzqk,self.grw,@"", nil];
    
    zbTitleAry = [[NSArray alloc] initWithObjects:@"样品编号",@"采样点名称",@"采样时间",@"监测项目",@"水样外观",@"流速(m/s)",@"宽度(m)",@"深度(m)",@"流量(m³/h)",@"排放量(t/d)", nil];
    zbValueAry = [[NSMutableArray alloc] init];
    
    [self.tableView reloadData];
}

@end
