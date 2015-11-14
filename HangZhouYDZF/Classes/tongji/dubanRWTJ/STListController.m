//
//  STListController.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "STListController.h"
#import "STDetailsController.h"
#import "GMEPS_HZAppDelegate.h"

extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;

@implementation STListController
@synthesize  currentString;
@synthesize  STInfoArr;
@synthesize  STInfoItem;
@synthesize  beginDateStr;
@synthesize  endDateStr;
@synthesize  codeStr;
@synthesize  STTypeStr;



- (void)dealloc
{
    [currentString release];
    [STInfoArr release];
    [STInfoItem release];
    [beginDateStr release];
    [endDateStr release];
    [codeStr release];
    [STTypeStr release];
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
    self.title = @"督办任务列表";
    NSString *param = [WebServiceHelper createParametersWithKey:@"supervisionType" value:STTypeStr,@"tjbh",codeStr,@"beginDate",beginDateStr,@"endDate",endDateStr,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    WebServiceHelper *webservice = [[[WebServiceHelper alloc] initWithUrl:URL method:@"GetSupervisionBasicInfo_Log_UDID" view:self.view nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self ] autorelease];
    webservice.hudTitle = @"正在获取数据，请稍候...";
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


#pragma mark -
#pragma mark NSXMLParser Delegate Method


#define kBH 0
#define kZT 1
#define kDBRDW 2
#define kJSRDW 3
#define kDBSJ 4
#define kDBRSFBJ 5

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
	bItem = NO;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"BH"])
		nParserStatus = kBH;
    else if ([elementName isEqualToString:@"ZT"])
		nParserStatus = kZT;
    else if ([elementName isEqualToString:@"DBRDW"])
		nParserStatus = kDBRDW;
    else if ([elementName isEqualToString:@"JSRDW"])
        nParserStatus = kJSRDW;
    else if ([elementName isEqualToString:@"DBSJ"])
        nParserStatus = kDBSJ;
    else if ([elementName isEqualToString:@"DBRSFBJ"])
        nParserStatus = kDBRSFBJ;
	else if ([elementName isEqualToString:@"TmpName"])
	{
		bItem = YES;
		STInfoItem = [[STStatisticsItem alloc] initWithNone];
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
				STInfoItem.bh = currentString;
				break;
                
            case kZT:
				STInfoItem.zt = currentString;
				break;
                
            case kDBSJ:
				STInfoItem.dbsj = [currentString substringToIndex:16];
				break;
                
            case kDBRDW:
				STInfoItem.dbrdw = currentString;
				break;
                
            case kJSRDW:
                STInfoItem.jsrdw = currentString;
				break;
                
            case kDBRSFBJ:
                STInfoItem.dbrsfbj = currentString;
                break;
                
			default:
				break;
		}
		currentString = nil;
		nParserStatus = -1;
	}
    if (bItem) {
        if (!STInfoArr)
            STInfoArr = [[NSMutableArray alloc] init];
        [STInfoArr addObject:STInfoItem];
        bItem = NO;
    }

}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.tableView reloadData];
}


#pragma mark -
#pragma mark TableView DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [STInfoArr count];
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
    STStatisticsItem *aSTItem = [STInfoArr objectAtIndex:row];
    
    cell.imageView.image = [UIImage imageNamed:@"阅读.png"];
	cell.textLabel.text = aSTItem.zt;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"督办单位：%@  办理单位：%@  督办时间：%@  %@",aSTItem.dbrdw,aSTItem.jsrdw,[aSTItem.dbsj substringToIndex:10],aSTItem.dbrsfbj];
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
    STDetailsController *childView = [[STDetailsController alloc] initWithNibName:@"STDetailsController" bundle:nil];
    
    STStatisticsItem *aItem = [STInfoArr objectAtIndex:row];
    [childView setXmlCode:aItem.bh];
    
	[self.navigationController pushViewController:childView animated:YES];
    [childView release];
}

@end
