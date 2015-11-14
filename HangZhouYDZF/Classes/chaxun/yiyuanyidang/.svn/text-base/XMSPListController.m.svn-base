    //
//  XMSPListController.m
//  GMEPS_HZ
//
//  Created by chen on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XMSPListController.h"
#import "WryXmspDetails.h"
#import "GMEPS_HZAppDelegate.h"

extern GMEPS_HZAppDelegate *g_appDelegate ;
extern UserInfo *g_logedUserInfo;
@implementation XMSPListController
@synthesize  wryInfoArr,wryInfoItem;
@synthesize curData,webService,wrybh,myTableView,parentController;
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	nParserStatus = -1;
    wryInfoArr = [[NSMutableArray alloc] init];
	self.curData = [NSMutableString stringWithCapacity:50];
    NSString* params = [WebServiceHelper createParametersWithKey:@"wrybh" value:wrybh,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
	
	if (webService != nil) {
		[webService release];
	}
    
    NSString *URL = [NSString  stringWithFormat: KYYYD_URL,g_appDelegate.ServerIP];
	webService = [[WebServiceHelper alloc] initWithUrl:URL
												method:@"GetWryXmspList_Log_UDID"
                                                  view:self.view
											 nameSpace:KSoapNameSpace
											parameters:params 
											  delegate:self];
	[webService run];
	
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


#define kXMBH 0     //项目编号
#define kXMMC 1     //项目名称
#define kWRYBH 2    //污染源编号
#define kSFTGSP 3   //审查通过情况标致
#define kSPRQ 4     //审批日期



-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (curData) 
		[curData appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	
    if ([elementName isEqualToString:@"GetWryXmspList_Log_UDIDResult"]){
        _jsonString = [curData copy];
    }
    
	[curData setString:@""];
	
	
}


- (void)parserDidEndDocument:(NSXMLParser *)parser{
    //解析数据
    [self getValueFromJSON:_jsonString];
	[self.myTableView reloadData];

	if (wryInfoArr == nil || [wryInfoArr count] == 0) {
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"提示" 
							  message:@"没有相关记录。"  
							  delegate:self 
							  cancelButtonTitle:@"确定" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;			
	}
}

-(void)getValueFromJSON:(NSString *)JSONString
{
    for (NSDictionary *Dic in [JSONString objectFromJSONString]) {
        wryInfoItem =  [[PollutionInfoItem alloc] init];
        [wryInfoItem setWrybh:[Dic objectForKey:@"WRYBH"]];
        [wryInfoItem setXmbh:[Dic objectForKey:@"XMBH"]];
        [wryInfoItem setXmmc:[Dic objectForKey:@"XMMC"]];
        [wryInfoItem setYssqbh:[Dic objectForKey:@"YSSQBH"]];
        if ([[Dic objectForKey:@"SFTGSP"] isEqual:@"1"]) {
            [wryInfoItem setSftgsp:@"已通过"];
        }else{
            wryInfoItem.sftgsp = @"未通过";
        }
        
        if([[[Dic objectForKey:@"SPRQ"] substringToIndex:4] isEqualToString:@"1755"])
                    wryInfoItem.sprq = @"";
                else
                    wryInfoItem.sprq = [[Dic objectForKey:@"SPRQ"] substringToIndex:10];
        [wryInfoArr addObject:wryInfoItem];
        [wryInfoItem release];
        wryInfoItem = nil;
    }
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return [wryInfoArr count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{	

	return @"";
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {	

	return 65;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *WryXmspListCellIdentifier = @"WryXmspListCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WryXmspListCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:WryXmspListCellIdentifier] autorelease];
	}
	NSUInteger row = [indexPath row];
	PollutionInfoItem *aItem = [wryInfoArr objectAtIndex:row];
	cell.textLabel.text = aItem.xmmc;

    cell.detailTextLabel.text = [NSString stringWithFormat:@"项目编号：%@\n污染源编号：%@\n审批日期：%@\n%@",aItem.xmbh,aItem.wrybh,aItem.sprq,aItem.sftgsp];

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
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	WryXmspDetails *childView = [[WryXmspDetails alloc] initWithNibName:@"WryXmspDetails" bundle:nil];
	childView.isXMSPInfo = YES;
    childView.isXMSPAccessory = YES;
	[childView initSelectedItem:[wryInfoArr objectAtIndex:row]];
	
	[self.parentController.navigationController pushViewController:childView
														  animated:YES];	
	[childView release];

}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
