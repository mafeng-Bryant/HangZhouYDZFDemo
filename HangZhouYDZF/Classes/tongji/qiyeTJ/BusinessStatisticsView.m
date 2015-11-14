//
//  BusinessStatisticsView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BusinessStatisticsView.h"
#import "ChartItem.h"
#import "TaskListView.h"
#import "GMEPS_HZAppDelegate.h"
#import "UserInfo.h"

extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;
@implementation BusinessStatisticsView
@synthesize webservice;
@synthesize currentString;
@synthesize staTypeArr;
@synthesize staCountArr;
@synthesize staCodeArr;

@synthesize beginDateValue;
@synthesize endDateValue;
@synthesize popView;
@synthesize resultTable;
@synthesize chartView;


- (void)popingInputView {
    popView = [[PopInputView alloc] initWithNibName:@"PopInputView" bundle:nil];
	popView.businessParentView = self;
    popView.parentTag = 3;
    
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:popView];
	nav.modalPresentationStyle =  UIModalPresentationFormSheet;
	[self presentModalViewController:nav animated:YES];
	nav.view.superview.frame = CGRectMake(200, 100, 380, 250);
	// nav.view.superview.center = self.view.center;
	[nav release];
}

- (void)initWithBeginDate:(NSString *)bdValue endDate:(NSString *)edValue {
    if (staTypeArr)
        [staTypeArr removeAllObjects];
    if (staCountArr)
        [staCountArr removeAllObjects];
    
    NSString *param = [WebServiceHelper createParametersWithKey:@"beginDate" value:bdValue,@"endDate",edValue,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    
     NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetTaskBasicsByBusinessType_Log_UDID" view:self.view  nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
    [webservice run];
}



- (void)addChart {
    [chartView clearItems];
    NSMutableArray *itemArray = [[[NSMutableArray alloc] init] autorelease];
    
    ChartItem *aItem;
    NSMutableArray *colorAry = [[[NSMutableArray alloc] initWithCapacity:20] autorelease];
    [ChartItem makeColorArray:colorAry];
    UIColor *aColor;
    for (int i = 0; i < [staCountArr count]; i++) {
        aColor = [colorAry objectAtIndex:i];
        aItem = [ChartItem itemWithValue:[[staCountArr objectAtIndex:i] intValue]*1.0f Name:[staTypeArr objectAtIndex:i] Color:aColor.CGColor];
        [itemArray addObject:aItem];
    }
   
    
    [chartView addGroupArray:itemArray withGroupName:@""];
    [chartView setHidden:NO];
    [chartView setNeedsDisplay];
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
     [super viewDidLoad];
    self.title = @"企业统计图表结果";
    resultTable.hidden = YES;
    
    NSDate *today = [NSDate date];
    NSCalendar *chinese = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:-3];
    NSDate *fromday = [chinese dateByAddingComponents:offsetComponents toDate:today options:0];
    beginDateValue = [[NSString alloc] initWithFormat:@"%@",[[fromday description] substringToIndex:10]];
    endDateValue = [[NSString alloc] initWithFormat:@"%@",[[today description] substringToIndex:10]];
    
    [offsetComponents release];
    [chinese release];
    
    NSString *param = [WebServiceHelper createParametersWithKey:@"beginDate" value:beginDateValue,@"endDate",endDateValue,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    
     NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetTaskBasicsByBusinessType_Log_UDID" view:self.view  nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
    [webservice run];
    
    UIBarButtonItem *aItem = [[UIBarButtonItem alloc] initWithTitle:@"输入起止时间" style:UIBarButtonItemStylePlain
															 target:self
															 action:@selector(popingInputView)];
	self.navigationItem.rightBarButtonItem = aItem;
    
    NTChartView *chart = [[NTChartView alloc] initWithFrame:CGRectMake(15, 15, 738, 530)];
    [self.view addSubview:chart];
    self.chartView = chart;
    [chart release];
    
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [webservice release];
    [currentString release];
    [staTypeArr release];
    [staCountArr release];
    [staCodeArr release];
    [beginDateValue release];
    [endDateValue release];
    [resultTable release];
    [chartView release];
    [popView release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSXMLParser Delegate Method


- (void)parserDidStartDocument:(NSXMLParser *)parser {
	bStaType = NO;
	bStaCount = NO;
    bStaCode = NO;
    self.currentString = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"TJ"])
		bStaType = YES;
	if ([elementName isEqualToString:@"COUNT"])
		bStaCount = YES;
    if ([elementName isEqualToString:@"TJBH"])
        bStaCode = YES;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (bStaType || bStaCount || bStaCode){
		[currentString appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if (bStaType) {
        if (!staTypeArr)
            staTypeArr = [[NSMutableArray alloc] init];
        NSString *copyStr = [currentString copy];
        [staTypeArr addObject:copyStr];
        bStaType = NO;
        [copyStr release];
    }
    
    if (bStaCount) {
        if (!staCountArr)
            staCountArr = [[NSMutableArray alloc] init];
        NSString *copyStr = [currentString copy];
        [staCountArr addObject:copyStr];
        bStaCount = NO;
        [copyStr release];
    }
    
    if (bStaCode) {
        if (!staCodeArr)
            staCodeArr = [[NSMutableArray alloc] init];
        NSString *copyStr = [currentString copy];
        [staCodeArr addObject:copyStr];
        bStaCode = NO;
        [copyStr release];
    }
    
    [self.currentString setString:@""];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if ([staTypeArr count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"查询时间段内没有任务！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else {
        [self addChart];
        
        resultTable.hidden = NO;
        [resultTable reloadData];
    }
}


#pragma mark -
#pragma mark Table View DataSource Methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"      企业类型          任务总数";
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
	UITableViewCell* aCell = [self getCell:@"Cell_resultTable" forTablieView:tableView];
	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lblValue = (UILabel *)[aCell.contentView viewWithTag:2];
	}
	
	if (lblTitle == nil) {
		CGRect tRect2 = CGRectMake(0, 0, 150, 38);
		lblTitle = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor blackColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblTitle.textAlignment = UITextAlignmentCenter;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		CGRect tRect3 = CGRectMake(150, 0, 100, 38);
		lblValue = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lblValue setBackgroundColor:[UIColor clearColor]];
		[lblValue setTextColor:[UIColor blackColor]];
		lblValue.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblValue.textAlignment = UITextAlignmentCenter;
		lblValue.tag = 2;	
		[aCell.contentView addSubview:lblValue];
		[lblValue release];
	}
	
	if (lblTitle != nil)	[lblTitle setText:aTitle];
	if (lblValue != nil)	[lblValue setText:aValue];
	
    if ([aValue isEqualToString:@"0"]) {
        aCell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	return aCell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [staTypeArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 38;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
    NSString *aTitle = [staTypeArr objectAtIndex:row];
    NSString *value = [staCountArr objectAtIndex:row];
    
	UITableViewCell *cell = [self makeSubCell:tableView withTitle:aTitle value:value];
	
    NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row%2 == 0) ? @"lightblue" : @"white" ofType:@"png"];
	UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
	cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
	cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	cell.backgroundView.frame = cell.bounds;
	cell.textLabel.backgroundColor = [UIColor clearColor];
    
	return cell;
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
	TaskListView *childView = [[TaskListView alloc] initWithNibName:@"TaskListView" bundle:nil];
    
    if (![[staCountArr objectAtIndex:row] isEqualToString:@"0"]) {
        [childView setBeginDateStr:beginDateValue];
        [childView setEndDateStr:endDateValue];
        [childView setBusinessStr:[staTypeArr objectAtIndex:row]];
        [childView setConditionStr:[staCodeArr objectAtIndex:row]];
        [childView setStatisticsTag:3];
        [self.navigationController pushViewController:childView animated:YES];
        
    }
    [childView release];
}

@end
