//
//  MutiConditionViewController.m
//  GMEPS_HZ
//
//  Created by sz apple on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MutiConditionViewController.h"
#import "GMEPS_HZAppDelegate.h"
#import "TaskListView.h"
#import "UserInfo.h"
extern UserInfo *g_logedUserInfo;
extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation MutiConditionViewController
@synthesize areaSeg,industrySeg,departSeg,businessSeg;
@synthesize areaAry,industryAry,departAry,businessAry;
@synthesize webservice,currentString,resultDic,oneItem;
@synthesize resultTable,dateButton,popView,startDate,endDate;

#pragma mark - Self Init Method

- (void)initWithBeginDate:(NSString *)bdValue endDate:(NSString *)edValue {
    self.startDate = bdValue;
    self.endDate = edValue;
    resultTable.hidden = YES;
    [resultDic removeAllObjects];
    [areaAry removeAllObjects];
    [industryAry removeAllObjects];
    [departAry removeAllObjects];
    [businessAry removeAllObjects];
    
    NSString *param = [WebServiceHelper createParametersWithKey:@"beginDate" value:startDate,@"endDate",endDate,@"orgid",g_logedUserInfo.userORGID,@"bmbh",g_logedUserInfo.BMBH,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetMutiConditionData_Log_UDID" view:self.view nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
    webservice.hudTitle = @"正在获取数据，请稍候...";
    [webservice run];

}

- (IBAction)dateButtonPressed:(id)sender {
    popView = [[PopInputView alloc] initWithNibName:@"PopInputView" bundle:nil];
	popView.mutiConditionParentView = self;
    popView.parentTag = 5;
    
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:popView];
	nav.modalPresentationStyle =  UIModalPresentationFormSheet;
	[self presentModalViewController:nav animated:YES];
	nav.view.superview.frame = CGRectMake((768-380)/2, 240, 380, 250);
	// nav.view.superview.center = self.view.center;
	[nav release];
}

- (IBAction)SegValueChanged:(id)sender {
    [resultDic removeAllObjects];
    
    if ([areaSeg selectedSegmentIndex] == 0){
        NSArray *copyAry = [areaAry copy];
        [resultDic setObject:copyAry forKey:@"行政区划"];
        [copyAry release];
    }
    
    if ([industrySeg selectedSegmentIndex] == 0) {
        NSArray *copyAry = [industryAry copy];
        [resultDic setObject:copyAry forKey:@"行业类型"];
        [copyAry release];
    }
    
    if ([departSeg selectedSegmentIndex] == 0) {
         NSArray *copyAry = [departAry copy];
        [resultDic setObject:copyAry forKey:@"部门名称"];
        [copyAry release];
    }
    
    if ([businessSeg selectedSegmentIndex] == 0) {
        NSArray *copyAry = [businessAry copy];
        [resultDic setObject:copyAry forKey:@"企业类型"];
        [copyAry release];
    }
    
    [self.resultTable reloadData];
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
        aCell.accessoryType = UITableViewCellAccessoryNone;
    }
	return aCell;
}

#pragma mark - Memory Manager

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

- (void)dealloc {
    [super dealloc];
    [areaSeg release];
    [industrySeg release];
    [departSeg release];
    [businessSeg release];
    [areaAry release];
    [industryAry release];
    [departAry release];
    [businessAry release];
    [webservice release];
    [currentString release];
    [resultDic release];
    [oneItem release];
    [resultTable release];
    [dateButton release];
    [popView release];
    [startDate release];
    [endDate release];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"多条件统计表";
    
    areaAry = [[NSMutableArray alloc] init];
    industryAry = [[NSMutableArray alloc] init];
    departAry = [[NSMutableArray alloc] init];
    businessAry = [[NSMutableArray alloc] init];
    resultDic = [[NSMutableDictionary alloc] init];
    
    NSDate *today = [NSDate date];
    NSCalendar *chinese = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:-3];
    NSDate *fromday = [chinese dateByAddingComponents:offsetComponents toDate:today options:0];
    

    
    self.startDate = [[[NSString alloc] initWithFormat:@"%@",[[fromday description] substringToIndex:10]] autorelease];
    self.endDate = [[[NSString alloc] initWithFormat:@"%@",[[today description] substringToIndex:10]] autorelease];
    
    
    [offsetComponents release];
    [chinese release];
    
    NSString *param = [WebServiceHelper createParametersWithKey:@"beginDate" value:startDate,@"endDate",endDate,@"orgid",g_logedUserInfo.userORGID,@"bmbh",g_logedUserInfo.BMBH,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetMutiConditionData_Log_UDID" view:self.view nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
    webservice.hudTitle = @"正在获取多任务统计数据，请稍候...";
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
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSString*)returnSection:(NSInteger)_section{
    NSString *title = @"";
    if (_section == 0) 
        title = @"行政区划";
    else if(_section == 1)
        title = @"行业类型";
    else if(_section == 2)
        title = @"部门名称";
    else if(_section == 3)
        title = @"企业类型";
    return title;
}

#pragma mark - Table view dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *headerTitle = [NSString stringWithFormat:@"      %@          任务总数",[self returnSection:section]];
        
    return headerTitle;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSString *key = [[resultDic allKeys] objectAtIndex:section];
    NSArray *array = [resultDic objectForKey:[self returnSection:section]];
    if ([array count]==0) {
        return 1;
    }
    else
        return [array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 38;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
	NSUInteger row = [indexPath row];
    NSUInteger section = [indexPath section];
   
    NSArray *array = [resultDic objectForKey:[self returnSection:section]];
    if ([array count]==0) 
        cell = [self makeSubCell:tableView withTitle:@"没有查询" value:@""];
    else{
        oneItem = [array objectAtIndex:row];
        NSString *aTitle = oneItem.condition;
        NSString *aValue = oneItem.count;
        
        cell = [self makeSubCell:tableView withTitle:aTitle value:aValue];
    }
	return cell;
}

#pragma mark - Table view Delegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSUInteger row = [indexPath row];
//    NSUInteger section = [indexPath section];
//    
//    //NSString *key = [[resultDic allKeys] objectAtIndex:section];
//    NSString *key = [self returnSection:section];
//    NSArray *array = [resultDic objectForKey:key];
//    if ([array count]==0) {
//        return;
//    }
//    oneItem = [array objectAtIndex:row];
//    TaskListView *childView = [[TaskListView alloc] initWithNibName:@"TaskListView" bundle:nil];
//  
//    if (![oneItem.count isEqualToString:@"0"]&&![oneItem.count isEqualToString:@""]) {
//        [childView setBeginDateStr:startDate];
//        [childView setEndDateStr:endDate];
//        
//        if ([key isEqualToString:@"行政区划"]) {
//            [childView setDistrictStr:oneItem.condition];
//            [childView setConditionStr:oneItem.conditionCode];
//            [childView setStatisticsTag:0];
//        }
//        else if ([key isEqualToString:@"行业类型"]) {
//            [childView setIndustryStr:oneItem.condition];
//            [childView setConditionStr:oneItem.conditionCode];
//            [childView setStatisticsTag:1];
//        }
//        else if ([key isEqualToString:@"部门名称"]) {
//            [childView setBranchStr:oneItem.condition];
//            [childView setConditionStr:oneItem.conditionCode];
//            [childView setStatisticsTag:2];
//        }
//        else if ([key isEqualToString:@"企业类型"]) {
//            [childView setBusinessStr:oneItem.condition];
//            [childView setConditionStr:oneItem.conditionCode];
//            [childView setStatisticsTag:3];
//        }
//            }
//    [self.navigationController pushViewController:childView animated:YES];
//    [childView release];

}


#pragma mark - NSXMLParser delegate
#define kTJBH   0
#define kTJ     1
#define kCOUNT  2

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
    bItem = NO;
    bArea = NO;
    bIndustry = NO;
    bDepart = NO;
    bBusiness = NO;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"TJ"])
		nParserStatus = kTJ;
	if ([elementName isEqualToString:@"COUNT"])
		nParserStatus = kCOUNT;
    if ([elementName isEqualToString:@"TJBH"])
        nParserStatus = kTJBH;
    if ([elementName isEqualToString:@"TmpName"]) {
        oneItem = [[ConditionItem alloc] initWithNone];
        bItem = YES;
    }
    if ([elementName isEqualToString:@"GroupArea"]) {
        bArea = YES;
        bIndustry = NO;
        bDepart = NO;
        bBusiness = NO;
    }
    if ([elementName isEqualToString:@"IndustryType"]) {
        bIndustry = YES;
        bArea = NO;
        bDepart = NO;
        bBusiness = NO;
    }
    if ([elementName isEqualToString:@"UserDepart"]) {
        bDepart = YES;
        bArea = NO;
        bIndustry = NO;
        bBusiness = NO;
    }
    if ([elementName isEqualToString:@"BusinessType"]) {
        bBusiness = YES;
        bArea = NO;
        bIndustry = NO;
        bDepart = NO;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (nParserStatus >= 0){
		if (!currentString)
			currentString = [NSMutableString string];
		[currentString appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if (nParserStatus >=0) {
        switch (nParserStatus) {
            case kTJBH:
                oneItem.conditionCode = currentString;
                break;
            case kTJ:
                oneItem.condition = currentString;
            case kCOUNT:
                oneItem.count = currentString;
            default:
                break;
        }
        nParserStatus = -1;
        currentString = nil;
    }
    
    if (bItem) {
        if (bArea)
            [areaAry addObject:oneItem];
        else if (bIndustry)
            [industryAry addObject:oneItem];
        else if (bDepart)
            [departAry addObject:oneItem];
        else if (bBusiness)
            [businessAry addObject:oneItem];
        
        [oneItem release];
        bItem = NO;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if ([areaSeg selectedSegmentIndex] == 0) {
        NSArray *copyArea = [areaAry copy];
        [resultDic setObject:copyArea forKey:@"行政区划"];
        [copyArea release];
    }
    
    if ([industrySeg selectedSegmentIndex] == 0) {
        NSArray *copyIndustry = [industryAry copy];
        [resultDic setObject:copyIndustry forKey:@"行业类型"];
        [copyIndustry release];
    }
    
    if ([departSeg selectedSegmentIndex] == 0) {
        NSArray *copyDepart = [departAry copy];
        [resultDic setObject:copyDepart forKey:@"部门名称"];
        [copyDepart release];
    }
    
    if ([businessSeg selectedSegmentIndex] == 0) {
        NSArray *copyBusiness = [businessAry copy];
        [resultDic setObject:copyBusiness forKey:@"企业类型"];
        [copyBusiness release];
    }
  
    resultTable.hidden = NO;
    [self.resultTable reloadData];
}


@end
