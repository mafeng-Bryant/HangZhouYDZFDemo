    //
//  WryXmspDetails.m
//  WryXmsp
//
//  Created by hejunhua on 11-9-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WryXmspDetails.h"
#import "GMEPS_HZAppDelegate.h"

extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;
@implementation WryXmspDetails
@synthesize webservice;
@synthesize currentString;
@synthesize selectedItem;
@synthesize detailsArr;
@synthesize detailsTable;
@synthesize totalOpinion,opinionController;

- (void)initSelectedItem:(id)aItem {
	self.selectedItem = aItem;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	
	detailsTable.hidden = YES;
	bHasPFYJ = NO;
    _isDownloadAccessory = NO;
    detailsArr = [[NSMutableArray alloc] init];
    _accessoryArray  = [[NSMutableArray alloc] init];
	totalOpinion = [[TotalOpinionView alloc] init];
    opinionController = [[UIPopoverController alloc] initWithContentViewController:totalOpinion];
	if (_isXMSPInfo) {
        _methodName = @"GetWryXmspInfo_Log_UDID";
    }else{
        _methodName = @"GetWryXmysList_Log_UDID";
    }
    NSString* params = [WebServiceHelper createParametersWithKey:@"wrybh" value:selectedItem.wrybh,@"xmbh",selectedItem.xmbh,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    
    NSString *URL = [NSString  stringWithFormat: KYYYD_URL,g_appDelegate.ServerIP];
    webservice = [[WebServiceHelper alloc] initWithUrl:URL
                                                method:_methodName
                                                  view:self.view
                                             nameSpace:KSoapNameSpace
                                            parameters:params
                                              delegate:self];
	[webservice run];
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



#pragma mark -
#pragma mark NSXMLParserDelegate Methods

#define kXMBH 0
#define kXMMC 1
#define kWRYBH 2
#define kSFTGSP 3
#define kSPRQ 4
#define kTZDW 5
#define kPFYJ 6 //批复意见
#define JSON_VALUE 7;//服务器返回的json数值

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"GetWryXmspInfo_Log_UDIDResult"]){
        nParserStatus = JSON_VALUE;
    }else if ([elementName isEqualToString:@"GetWryXmspFjDetails_Log_UDIDResult"]){
        nParserStatus = JSON_VALUE;
        _isDownloadAccessory = YES;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (nParserStatus >=0) {
		if (!currentString)
			currentString = [NSMutableString string];
		[currentString appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"GetWryXmspInfo_Log_UDIDResult"]){
        NSLog(currentString);
        _jsonString = [currentString copy];
    }else if ([elementName isEqualToString:@"GetWryXmspFjDetails_Log_UDIDResult"]){
        NSLog(currentString);
        _jsonString = [currentString copy];
    }
    currentString = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (_isDownloadAccessory) {
        [self getAccessoryInfoFromJSON:_jsonString];
        _isDownloadAccessory = NO;
        [self goAccessoryListViewController];
        
    }else{
        [self getDictionaryFromJSON:_jsonString];
        if (detailsArr) {
            detailsTable.hidden = NO;
            [detailsTable reloadData];
        }
    }
}
/**
 *  @Description   从服务器返回的字JSON符串中获取相应的值
 *
 *  @param  JSONString  JSON格式字符串
 *
 *  @return 
 */
-(void)getDictionaryFromJSON:(NSString *)JSONString
{
    NSArray *arr = [JSONString objectFromJSONString];
    NSDictionary *dic = [arr lastObject];
    [detailsArr addObject:[NSString stringWithFormat:@"项目名称：%@",[dic objectForKey:@"XMMC"]]];
    [detailsArr addObject:[NSString stringWithFormat:@"项目年度：%@",[dic objectForKey:@"XMND"]]];
    [detailsArr addObject:[NSString stringWithFormat:@"投资单位：%@",[dic objectForKey:@"TZDW"]]];
    [detailsArr addObject:[NSString stringWithFormat:@"投资单位地址：%@",[dic objectForKey:@"TZDWDZ"]]];
    [detailsArr addObject:[NSString stringWithFormat:@"审批文号：%@",[dic objectForKey:@"SPWH"]]];
    
    if([[[dic objectForKey:@"SPRQ"] substringToIndex:4] isEqualToString:@"1755"])
        [detailsArr addObject:@"审批日期："];
    else{
        [detailsArr addObject:[NSString stringWithFormat:@"审批日期：%@",[[dic objectForKey:@"SPRQ"] substringToIndex:10]]];
    }

    [detailsArr addObject:[NSString stringWithFormat:@"审批单位：%@",[dic objectForKey:@"SPDW"]]];
    if (![[dic objectForKey:@"PFYJ"] isEqual:@""]) {
        bHasPFYJ = YES;
    }
    strPFYJ = [[NSString stringWithFormat:@"审批意见：\n%@", [[dic objectForKey:@"PFYJ"] stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n    "] ] retain];
    [self setNoOfAccessory:[dic objectForKey:@"XH"]];
     
}
//从JSON字符串里获取附件的信息
-(void)getAccessoryInfoFromJSON:(NSString *)JSONString
{
    [_accessoryArray removeAllObjects];
    NSArray *arr = [JSONString objectFromJSONString];
    //NSString *tmpPath=NSTemporaryDirectory();
    for (NSDictionary *Dic in arr) {
        AccessoryItem *item = [[AccessoryItem alloc] initWithTID:[Dic objectForKey:@"TID"]
                                                     downloadURL:[Dic objectForKey:@"LJDZ"]
                                                        filePath:nil
                                                        fileName:[NSString stringWithFormat:@"%@.%@",[Dic objectForKey:@"MC"],[Dic objectForKey:@"GS"]]];
        [_accessoryArray addObject:item];
        [item release];
    }
    
}

-(void)goAccessoryListViewController
{
    AccessoryLsitViewController *newController = [[AccessoryLsitViewController alloc] initWithAccessoryArray:_accessoryArray];
    [self.navigationController pushViewController:newController animated:YES];
    [newController release];
}

#pragma mark -
#pragma mark UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (bHasPFYJ) {
        if (section != 0) {
            return 1;
        }
    }
	return [detailsArr count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (bHasPFYJ) {
        return 3;
    }
    return 1;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {	
    
    if (bHasPFYJ) {
        if (indexPath.section == 1) {
            int line = [strPFYJ length]/36+1;
            return line *35;
        }
    }
	return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *WryXmspDetailsCellIdentifier = @"WryXmspDetailsCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WryXmspDetailsCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:WryXmspDetailsCellIdentifier] autorelease];
	}
	NSUInteger row = [indexPath row];
	
    if (indexPath.section == 0) {
        cell.textLabel.text = [detailsArr objectAtIndex:row];
    }else if (indexPath.section == 1){
        int line = [strPFYJ length]/36+1;
        int height = line *35;
        cell.textLabel.frame = CGRectMake(5, 5, 750, height);
        cell.textLabel.numberOfLines = 0;//不限制
        cell.textLabel.text = strPFYJ;
    }else if (indexPath.section == 2){
        cell = _clikedCell;
    }
    
    NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row%2 == 0) ? @"lightblue" : @"white" ofType:@"png"];
	UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
	cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
	cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	cell.backgroundView.frame = cell.bounds;
	cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   	return cell;
}

-(IBAction)clikedButton:(id)sender
{
    [self getURLOfAccessory];
}
//获取附件信息
-(BOOL)getURLOfAccessory
{
    NSString *str = nil;
    if (_isXMSPAccessory) {
        str = @"1";             //审批
    }else{
        str = @"2";             //验收
    }
    NSString* params = [WebServiceHelper createParametersWithKey:@"wrybh" value:selectedItem.wrybh,@"xh",self.noOfAccessory,@"lb",str,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    
    NSString *URL = [NSString  stringWithFormat: KYYYD_URL,g_appDelegate.ServerIP];
	webservice = [[WebServiceHelper alloc] initWithUrl:URL
												method:@"GetWryXmspFjDetails_Log_UDID"
                                                  view:self.view
											 nameSpace:KSoapNameSpace
											parameters:params
											  delegate:self];
	[webservice run];
}

#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[totalOpinion release];
	[opinionController release];
	[webservice release];
	[currentString release];
	[selectedItem release];
	[detailsArr release];
	[detailsTable release];
    [_jsonString release];
    [_methodName release];
    [_urlStringOfAccessory release];
    [_accessoryArray removeAllObjects];
    [_accessoryArray release];
    [super dealloc];
}

@end
