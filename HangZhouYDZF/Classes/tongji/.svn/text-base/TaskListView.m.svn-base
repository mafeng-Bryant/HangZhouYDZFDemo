//
//  TaskListView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TaskListView.h"
#import "GMEPS_HZAppDelegate.h"
#import "UserInfo.h"

extern UserInfo *g_logedUserInfo;
extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation TaskListView
@synthesize webservice;
@synthesize currentString;
@synthesize taskItemDic;
@synthesize taskInfoArr;
@synthesize listTable;
@synthesize beginDateStr;
@synthesize endDateStr;
@synthesize districtStr;
@synthesize childView;
@synthesize businessStr;
@synthesize industryStr;
@synthesize branchStr;
@synthesize statisticsTag,tableName;
@synthesize conditionStr;


- (void)dealloc
{

    [currentString release];
    [taskItemDic release];
    [taskInfoArr release];
    [listTable release];
    [beginDateStr release];
    [endDateStr release];
    [districtStr release];
    [childView release];
    [branchStr release];
    [conditionStr release];
    [super dealloc];
    //[super dealloc];
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
    self.title = @"任务列表";
    
    switch (statisticsTag) {
        case 0:
        {
            self.title = @"区域统计任务列表";
            NSString *param = [WebServiceHelper createParametersWithKey:@"area" value:self.conditionStr,@"beginDate",self.beginDateStr,@"endDate",self.endDateStr,@"tableName",tableName,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
            
            NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
            webservice = [[[WebServiceHelper alloc] initWithUrl:URL method:@"GetTaskDetailsByArea_Log_UDID" view:self.view nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self ] autorelease];
            webservice.hudTitle = @"正在获取数据，请稍候...";
            [webservice run];
        }
            break;
            
        case 1:
        {
            self.title = [NSString stringWithFormat:@"%@-任务列表",self.industryStr];
            NSString *param = [WebServiceHelper createParametersWithKey:@"industryType" value:self.conditionStr,@"beginDate",self.beginDateStr,@"endDate",self.endDateStr,@"orgid",g_logedUserInfo.userORGID,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
            
            NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
            webservice = [[[WebServiceHelper alloc] initWithUrl:URL method:@"GetTaskDetailsByIndustryType_Log_UDID"
                                                           view:self.view nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self] autorelease];
            webservice.hudTitle = @"正在获取数据，请稍候...";
            [webservice run];
        }
        break;
            
        case 2:
        {
            self.title = @"部门统计任务列表";
            NSString *param = [WebServiceHelper createParametersWithKey:@"userDepart" value:self.conditionStr,@"beginDate",self.beginDateStr,@"endDate",self.endDateStr,@"tableName",tableName,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
            
            NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
            webservice = [[[WebServiceHelper alloc] initWithUrl:URL method:@"GetTaskDetailsByUserDepart_Log_UDID" view:self.view nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self] autorelease];
            webservice.hudTitle = @"正在获取数据，请稍候...";
            [webservice run];
        }
            break;
            
        case 3:
        {
            self.title = [NSString stringWithFormat:@"%@-任务列表",businessStr];
            NSString *param = [WebServiceHelper createParametersWithKey:@"businessType" value:self.conditionStr,@"beginDate",self.beginDateStr,@"endDate",self.endDateStr,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
            
            NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
            webservice = [[[WebServiceHelper alloc] initWithUrl:URL method:@"GetTaskDetailsByBusinessType_Log_UDID" view:self.view nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self] autorelease];
            webservice.hudTitle = @"正在获取数据，请稍候...";
            [webservice run];
        }
            break;
        
        default:
            break;
    }
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark NSXMLParser Delegate Method


#define kXCZFBH 0
#define kDWMC 1
#define kDCSJ 2
#define kJCR 3
#define kSFHG 4

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
	bItem = NO;
    self.currentString = [NSMutableString string];
    self.taskItemDic = [[[NSMutableDictionary alloc] initWithCapacity:5] autorelease];
    self.taskInfoArr = [[[NSMutableArray alloc] init] autorelease];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"XCZFBH"])
		nParserStatus = kXCZFBH;
    else if ([elementName isEqualToString:@"DWMC"])
		nParserStatus = kDWMC;
    else if ([elementName isEqualToString:@"JCSJ"])
		nParserStatus = kDCSJ;
    else if ([elementName isEqualToString:@"JCR"])
        nParserStatus = kJCR;
    else if ([elementName isEqualToString:@"SFHG"])
        nParserStatus = kSFHG;
	else if ([elementName isEqualToString:@"TmpName"])
	{
		bItem = YES;
		[self.taskItemDic removeAllObjects];
	}
	else 
		nParserStatus = -1;
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (nParserStatus >= 0){
		[currentString appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if (nParserStatus >= 0){
		switch (nParserStatus) {
            case kXCZFBH:
			{
                NSString *copyString = [currentString copy];
				[self.taskItemDic setObject:copyString forKey:@"XCZFBH"];
                [copyString release];
			}
				break;
                
            case kDWMC:
			{
                NSString *copyString = [currentString copy];
				[self.taskItemDic setObject:copyString forKey:@"DWMC"];
                [copyString release];
			}
				break;
                
            case kDCSJ:
			{
                NSString *copyString = [[currentString substringToIndex:16] copy];
                [self.taskItemDic setObject:copyString forKey:@"JCSJ"];
                [copyString release];
			}
				break;
            
            case kJCR:
			{
                 NSString *copyString = [currentString copy];
				[self.taskItemDic setObject:copyString forKey:@"JCR"];
                [copyString release];
			}
				break;
            
            case kSFHG:
			{
                if ([currentString isEqualToString:@"是"])
                    [self.taskItemDic setObject:@"合格" forKey:@"SFHG"];
                else if ([currentString isEqualToString:@"否"])
                    [self.taskItemDic setObject:@"不合格" forKey:@"SFHG"];
                else
                    [self.taskItemDic setObject:@"待定" forKey:@"SFHG"];
			}
				break;
                
			default:
				break;
		}
		[self.currentString setString:@""];
		nParserStatus = -1;
	} else {
		if (bItem && [elementName isEqualToString:@"TmpName"]) {
            NSDictionary *copyTaskItem = [taskItemDic copy];
			[self.taskInfoArr addObject:copyTaskItem];
            [copyTaskItem release];
			bItem = NO;
		}
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [listTable reloadData];
}


#pragma mark -
#pragma mark TableView DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [taskInfoArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *TaskListCellIdentifier = @"TaskListCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TaskListCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TaskListCellIdentifier] autorelease];
	}
	NSUInteger row = [indexPath row];
    
    NSDictionary * aItem = [taskInfoArr objectAtIndex:row];
    
    cell.imageView.image = [UIImage imageNamed:@"阅读.png"];
	cell.textLabel.text = [aItem objectForKey:@"DWMC"];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"检查人：%@      调查时间：%@",([aItem objectForKey:@"JCR"]!=nil)?[aItem objectForKey:@"JCR"]:@"",[aItem objectForKey:@"JCSJ"]];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row%2 == 0) ? @"lightblue" : @"white" ofType:@"png"];
	UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
	cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
	cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	cell.backgroundView.frame = cell.bounds;
	cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
	return cell;
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSUInteger row = [indexPath row];
    
    childView = [[TaskDetailsView alloc] initWithStyle:UITableViewStylePlain];
    
    NSDictionary * aItem = [taskInfoArr objectAtIndex:row];
    [childView setXczfbh:[aItem objectForKey:@"XCZFBH"]];

	[self.navigationController pushViewController:childView animated:YES];   
}


@end
