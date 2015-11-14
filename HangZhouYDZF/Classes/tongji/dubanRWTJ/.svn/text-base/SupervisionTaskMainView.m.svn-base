//
//  SupervisionTaskMainView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SupervisionTaskMainView.h"
#import "ChartItem.h"
#import "STListController.h"
#import "GMEPS_HZAppDelegate.h"
#import "UserInfo.h"

extern UserInfo *g_logedUserInfo;
extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation SupervisionTaskMainView
@synthesize webservice;
@synthesize currentString;
@synthesize tjItem;
@synthesize aryForTable;
@synthesize beginDateValue;
@synthesize endDateValue,supervisionType;
@synthesize resultTable;
@synthesize chartView;
@synthesize popView;


- (void)popingInputView {
    popView = [[PopInputView alloc] initWithNibName:@"PopInputView" bundle:nil];
	popView.supervisionParentView = self;
    popView.parentTag = 4;
    
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:popView];
	nav.modalPresentationStyle =  UIModalPresentationFormSheet;
	[self presentModalViewController:nav animated:YES];
	nav.view.superview.frame = CGRectMake((768-380)/2, 240, 380, 250);
	// nav.view.superview.center = self.view.center;
	[nav release];
}

- (void)initWithBeginDate:(NSString *)bdValue endDate:(NSString *)edValue {
    if (aryForTable)
        [aryForTable removeAllObjects];
    resultTable.hidden = YES;
    self.beginDateValue = bdValue;
    self.endDateValue = edValue;
    
    NSString *param = [WebServiceHelper createParametersWithKey:@"supervisionType" value:self.supervisionType,@"beginDate",bdValue,@"endDate",edValue,@"orgid",g_logedUserInfo.userORGID,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetSupervisionTask_Log_UDID" nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
    webservice.hudTitle =  @"正在查询统计数据，请稍候...";
    [webservice run];
}

- (void)addChart {
    [chartView clearItems];
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    ChartItem *aItem;
    ConditionItem *aConditionItem;
    NSMutableArray *colorAry = [[[NSMutableArray alloc] initWithCapacity:20] autorelease];
    [ChartItem makeColorArray:colorAry];
    UIColor *aColor;
    for (int i = 0; i < [aryForTable count]; i++) {
        aColor = [colorAry objectAtIndex:i];
        aConditionItem = [aryForTable objectAtIndex:i];
        aItem = [ChartItem itemWithValue:[aConditionItem.count intValue]*1.0f Name:aConditionItem.condition Color:aColor.CGColor];
        [itemArray addObject:aItem];
    }
   
    
    [chartView addGroupArray:itemArray withGroupName:@""];
    [itemArray release];
    [chartView setNeedsDisplay];
    
}


- (IBAction)buttonPressed:(id)sender {	
    // Regisete for HUD callbacks so we can remove it from the window at the right time
    UISegmentedControl *segCtrl = (UISegmentedControl *)sender;
    currentTag = segCtrl.selectedSegmentIndex;
    NSLog(@"currentTag:%d",currentTag);
    if (aryForTable)
        [aryForTable removeAllObjects];
    if (webservice) {
        [webservice release];
    }
    
    switch (currentTag) {
        case 0:
        {
            resultTable.hidden = YES;
            self.supervisionType = @"AREA";
            
            NSString *param = [WebServiceHelper createParametersWithKey:@"supervisionType" value:self.supervisionType,@"beginDate",self.beginDateValue,@"endDate",self.endDateValue,@"orgid",g_logedUserInfo.userORGID,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
            NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
            webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetSupervisionTask_Log_UDID" view:self.view nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
            webservice.hudTitle = @"正在获取督办任务统计数据，请稍候...";
            [webservice run];
        }
            break;
            
        case 1:
        {
            resultTable.hidden = YES;
            self.supervisionType = @"DBBM";
            
            NSString *param = [WebServiceHelper createParametersWithKey:@"supervisionType" value:self.supervisionType,@"beginDate",self.beginDateValue,@"endDate",self.endDateValue,@"orgid",g_logedUserInfo.userORGID,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
            NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
            webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetSupervisionTask_Log_UDID" view:self.view nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
            webservice.hudTitle = @"正在获取督办部门统计数据，请稍候...";
            [webservice run];
        }
            break;
            
        case 2:
        {
            self.supervisionType = @"BLBM";
            resultTable.hidden = YES;
            
            NSString *param = [WebServiceHelper createParametersWithKey:@"supervisionType" value:self.supervisionType,@"beginDate",self.beginDateValue,@"endDate",self.endDateValue,@"orgid",g_logedUserInfo.userORGID,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
            NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
            webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetSupervisionTask_Log_UDID" view:self.view nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
            webservice.hudTitle = @"正在获取办理部门统计数据，请稍候...";
            [webservice run];
        }
            break;
            
        case 3:
        {
            self.supervisionType = @"ISEND";
            resultTable.hidden = YES;
            
            NSString *param = [WebServiceHelper createParametersWithKey:@"supervisionType" value:self.supervisionType,@"beginDate",self.beginDateValue,@"endDate",self.endDateValue,@"orgid",g_logedUserInfo.userORGID,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
            NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
            webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetSupervisionTask_Log_UDID" view:self.view nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
            webservice.hudTitle = @"正在获取是否办结统计数据，请稍候...";
            [webservice run];
        }
            break;
            
            
        default:
            break;
    }
}


- (void)dealloc
{
    [webservice release];
    [currentString release];
    [aryForTable release];
    [beginDateValue release];
    [endDateValue release];
    [supervisionType release];
    [resultTable release];
    [chartView release];
    [popView release];
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
    self.title = @"督办任务统计图表结果";
    resultTable.hidden = YES;
    NSDate *today = [NSDate date];
    /*NSCalendar *chinese = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:-3];
    NSDate *fromday = [chinese dateByAddingComponents:offsetComponents toDate:today options:0];
    beginDateValue = [[NSString alloc] initWithFormat:@"%@",[[fromday description] substringToIndex:10]];
     */
    self.beginDateValue = @"1990-01-01";
    self.endDateValue = [[[NSString alloc] initWithFormat:@"%@",[[today description] substringToIndex:10]] autorelease];
    self.supervisionType = @"AREA";
    currentTag = 0;
   
    // Regisete for HUD callbacks so we can remove it from the window at the right time
    

    
    UIBarButtonItem *aItem = [[UIBarButtonItem alloc] initWithTitle:@"输入起止时间" style:UIBarButtonItemStylePlain
															 target:self
															 action:@selector(popingInputView)];
	self.navigationItem.rightBarButtonItem = aItem;
    
    NTChartView *chart = [[NTChartView alloc] initWithFrame:CGRectMake(15, 80, 738, 560)];
    [self.view addSubview:chart];
    self.chartView = chart;
    [chart release];
    
    NSString *param = [WebServiceHelper createParametersWithKey:@"supervisionType" value:self.supervisionType,@"beginDate",self.beginDateValue,@"endDate",self.endDateValue,@"orgid",g_logedUserInfo.userORGID,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetSupervisionTask_Log_UDID" view:self.view nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
    webservice.hudTitle = @"正在获取督办任务统计数据，请稍候...";
    [webservice run];
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


#pragma mark - NSXMLParser Delegate Method
#define kTJBH   0
#define kTJ     1
#define kCOUNT  2

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
    bItem = NO;
    self.currentString = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"TJ"])
		nParserStatus = kTJ;
	if ([elementName isEqualToString:@"COUNT"])
		nParserStatus = kCOUNT;
    if ([elementName isEqualToString:@"TJBH"])
        nParserStatus = kTJBH;
    if ([elementName isEqualToString:@"TmpName"]) {
        tjItem = [[ConditionItem alloc] initWithNone];
        bItem = YES;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (nParserStatus >= 0){
		[currentString appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if (nParserStatus >=0) {
        switch (nParserStatus) {
            case kTJBH:
                tjItem.conditionCode = currentString;
                break;
            case kTJ:
                tjItem.condition = currentString;
            case kCOUNT:
                tjItem.count = currentString;
            default:
                break;
        }
        nParserStatus = -1;
        [self.currentString setString:@""];
    }
    
    if (bItem) {
        if (!aryForTable)
            aryForTable = [[NSMutableArray alloc] init];
        
        [aryForTable addObject:tjItem];
        [tjItem release];
        bItem = NO;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if ([aryForTable count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"查询时间段内没有任务！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
    } else {
        
        [self addChart];
        resultTable.hidden = NO;
        //[self.resultTable reloadData];
    }
    [self.resultTable reloadData];
}


#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *headerTitle = @"";
    switch (currentTag) {
        case 0:
            headerTitle = @"      所属区域          任务总数";
            break;
        case 1:
            headerTitle = @"      督办部门          任务总数";
            break;
        case 2:
            headerTitle = @"      办理部门          任务总数";
            break;
        case 3:
            headerTitle = @"      是否办结          任务总数";
            break;
        default:
            break;
    }
    
    return headerTitle;
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
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblTitle.textAlignment = UITextAlignmentCenter;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		CGRect tRect3 = CGRectMake(150, 0, 100, 38);
		lblValue = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lblValue setBackgroundColor:[UIColor clearColor]];
		[lblValue setTextColor:[UIColor blackColor]];
		lblValue.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblValue.textAlignment = UITextAlignmentCenter;
		lblValue.tag = 2;	
		[aCell.contentView addSubview:lblValue];
		[lblValue release];
	}
	
	if (lblTitle != nil)	[lblTitle setText:aTitle];
	if (lblValue != nil)	[lblValue setText:aValue];
    
    if ([aValue isEqualToString:@"0"]||[aValue isEqualToString:@""]) {
        aCell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	return aCell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [aryForTable count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 38;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
    ConditionItem *aCItem = [aryForTable objectAtIndex:row];
    
    NSString *aTitle = aCItem.condition;
    NSString *aValue = aCItem.count;
    
	UITableViewCell *cell = [self makeSubCell:tableView withTitle:aTitle value:aValue];
    
	NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row%2 == 0) ? @"lightblue" : @"white" ofType:@"png"];
	UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
	cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
	cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	cell.backgroundView.frame = cell.bounds;
	cell.textLabel.backgroundColor = [UIColor clearColor];
    
	return cell;
}

#pragma mark - Table view Delegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    ConditionItem *aCItem = [aryForTable objectAtIndex:row];
    if (![aCItem.count isEqualToString:@"0"]&&![aCItem.count isEqualToString:@""]) {
        STListController *childView = [[STListController alloc] initWithNibName:@"STListController" bundle:nil];
        [childView setBeginDateStr:self.beginDateValue];
        [childView setEndDateStr:self.endDateValue];
        [childView setSTTypeStr:self.supervisionType];
        [childView setCodeStr:aCItem.conditionCode];
        [self.navigationController pushViewController:childView animated:YES];
        [childView release];
    }
}


@end
