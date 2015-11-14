    //
//  HJJCController.m
//  GMEPS_HZ
//
//  Created by chen on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HJJCController.h"
#import "GMEPS_HZAppDelegate.h"

extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation HJJCController
@synthesize myTableView,curData;
@synthesize dicJianCeInfo,jcInfoItem,jcKeysAry;
@synthesize wrybh;
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
	self.curData = [NSMutableString stringWithCapacity:50];
	NSString* params = [WebServiceHelper createParametersWithKey:@"wrybh"
														   value:wrybh,nil];
	if (webService != nil) {
		[webService release];
	}
    NSString *URL = [NSString  stringWithFormat: KYYYD_URL,g_appDelegate.ServerIP];
    
	webService = [[WebServiceHelper alloc] initWithUrl:URL
												method:@"GetWryFsJdjc"
                                                  view:self.view
											 nameSpace:KSoapNameSpace
											parameters:params 
											  delegate:self];	
	[webService run];
	
	self.dicJianCeInfo = [NSMutableDictionary dictionaryWithCapacity:10];
	self.jcKeysAry = [NSMutableArray arrayWithCapacity:10];

	
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


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#define TAG_JCRQ  0
#define TAG_JCDMC 1
#define TAG_PFL   2
#define TAG_WRWND 3
#define TAG_DMNR  4
#define TAG_BZ    5


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	
	if ([elementName isEqualToString:@"JCRQ"])
		nParserStatus = TAG_JCRQ;
	
	else if ([elementName isEqualToString:@"JCDMC"])
		nParserStatus = TAG_JCDMC;
	else if ([elementName isEqualToString:@"PFL"])
		nParserStatus = TAG_PFL;
	else if ([elementName isEqualToString:@"WRWND"])
		nParserStatus = TAG_WRWND;
	else if ([elementName isEqualToString:@"DMNR"])
		nParserStatus = TAG_DMNR;
	else if ([elementName isEqualToString:@"BZ"]) {
		nParserStatus = TAG_BZ;
	}
	else if ([elementName isEqualToString:@"TmpName"]) {
		jcInfoItem = [[HJJCInfoItem alloc] init];
	}
	else {
		nParserStatus = -1;
	}
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (curData) 
		[curData appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	if (nParserStatus >=0 && jcInfoItem) {
		switch (nParserStatus) {
			case TAG_JCRQ:
				jcInfoItem.JCRQ = curData;
				break;
			case TAG_JCDMC:
				jcInfoItem.JCDMC = curData;
				break;
			case TAG_PFL:
				jcInfoItem.PFL =curData;
				break;
			case TAG_WRWND:
				jcInfoItem.WRWND = curData;
				break;
			case TAG_DMNR:
				jcInfoItem.DMNR = curData;			
				break;
			case TAG_BZ:
				jcInfoItem.BZ = curData;
				break;	
			default:
				break;
		}
		nParserStatus = -1;
	} else {
		if ([elementName isEqualToString:@"TmpName"]){
			NSMutableArray *itemsAry = [dicJianCeInfo objectForKey:jcInfoItem.JCRQ];
			if (itemsAry) {
				[itemsAry addObject:jcInfoItem];
			}
			else {
				itemsAry = [[NSMutableArray alloc] initWithObjects:jcInfoItem,nil];					
				[dicJianCeInfo setObject:itemsAry forKey:jcInfoItem.JCRQ];
				[itemsAry release];
				[jcKeysAry addObject:jcInfoItem.JCRQ];
				[jcInfoItem release];
			}
		}
	}
	[curData setString:@""];
	
	
}


- (void)parserDidEndDocument:(NSXMLParser *)parser{

	if ([dicJianCeInfo count] == 0) {
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
	
	[self.myTableView reloadData];
	
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	return [jcKeysAry count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	NSArray *ary = [dicJianCeInfo objectForKey:[jcKeysAry objectAtIndex:section]];
	return [ary count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{	
	NSString *str =  [jcKeysAry objectAtIndex:section];
	return [str substringToIndex:10];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 55;
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
	UITableViewCell* aCell = [self getCell:@"Cell_DetailViewController1" forTablieView:tableView];
	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lblValue = (UILabel *)[aCell.contentView viewWithTag:2];
	}
	
	if (lblTitle == nil) {
		CGRect tRect2 = CGRectMake(5, 0, 140, 44);
		lblTitle = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor grayColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblTitle.textAlignment = UITextAlignmentRight;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		CGRect tRect3 = CGRectMake(160, 0, 600, 44);
		lblValue = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lblValue setBackgroundColor:[UIColor clearColor]];
		[lblValue setTextColor:[UIColor blackColor]];
		lblValue.font = [UIFont fontWithName:@"Helvetica" size:14.0];
		lblValue.textAlignment = UITextAlignmentLeft;
		lblValue.tag = 2;	
		[aCell.contentView addSubview:lblValue];
		[lblValue release];
	}
	
	if (lblTitle != nil)	[lblTitle setText:aTitle];
	if (lblValue != nil)	[lblValue setText:aValue];
	
	aCell.accessoryType = UITableViewCellAccessoryNone;
	return aCell;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    	
		NSArray *itemAry = [dicJianCeInfo objectForKey:[jcKeysAry objectAtIndex:indexPath.section]];
		HJJCInfoItem *aItem = [itemAry objectAtIndex:indexPath.row];
		
		NSString *aTitle = aItem.JCDMC;
		NSString *value = [NSString stringWithFormat:@" 排放量(t/d)：%@        %@浓度：%@(%@)",
						   aItem.PFL,aItem.DMNR, aItem.WRWND,aItem.BZ];
		UITableViewCell *cell = [self makeSubCell:tableView withTitle:aTitle value:value];
		
		return cell;

    
}


- (void)dealloc {
	[webService release];
	[curData release];
    [super dealloc];
}


@end
