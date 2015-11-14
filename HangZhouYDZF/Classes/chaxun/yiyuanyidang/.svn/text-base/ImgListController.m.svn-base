//
//  ImgListController.m
//  GMEPS_HZ
//
//  Created by sz apple on 11-12-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ImgListController.h"
#import "ImgDetailController.h"
#import "GMEPS_HZAppDelegate.h"
extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation ImgListItem
@synthesize mc,gs,ljdz,sl;
- (ImgListItem *)init {
    self = [super init];
    if (self) {
        self.mc = @"";
        self.gs = @"";
        self.ljdz = @"";
        self.sl = @"";
    }
    return self;
}
@end

@implementation ImgListController
@synthesize wrybh,dm,bItem,nParserStatus;
@synthesize webservice,currentString,resultAry,myListItem;

#pragma mark - View lifecycle
- (void)dealloc {
    [wrybh release];
    [dm release];
    [webservice release];
    [currentString release];
    [resultAry release];
    [myListItem release];
    [super dealloc];
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


- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *param = [WebServiceHelper createParametersWithKey:@"wrybh" value:self.wrybh,  nil];
    NSString *URL = [NSString stringWithFormat:KYYYD_URL,g_appDelegate.ServerIP];
    webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetWryQydaFjDetails" view:self.view nameSpace:KSoapNameSpace parameters:param delegate:self];
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
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [resultAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    ImgListItem *aItem = [resultAry objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@.%@",aItem.mc,aItem.gs];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",aItem.sl];
    if([aItem.sl integerValue] > 0)
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImgListItem *aItem = [resultAry objectAtIndex:indexPath.row];
    
    ImgDetailController *childView = [[ImgDetailController alloc] initWithNibName:@"ImgDetailController" bundle:nil];
    NSString *strUrl = [NSString stringWithFormat:@"http://%@/UploadFile/%@", g_appDelegate.yyydIP,aItem.ljdz];
    
    childView.imgURL = strUrl;//aItem.ljdz;
    childView.title = [NSString stringWithFormat:@"%@.%@",aItem.mc,aItem.gs];
    [self.navigationController pushViewController:childView animated:YES];
    [childView release];
}

#pragma mark - NSXMLParserDelegate

#define TAG_MC   0
#define TAG_LJDZ 1
#define TAG_GS   2
#define TAG_SL   3

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
    bItem = NO;
    resultAry = [[NSMutableArray alloc] init];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName attributes: (NSDictionary *)attributeDict
{
	
	if ([elementName isEqualToString:@"MC"])
		nParserStatus = TAG_MC;	
	else if ([elementName isEqualToString:@"LJDZ"])
		nParserStatus = TAG_LJDZ;
	else if ([elementName isEqualToString:@"GS"])
		nParserStatus = TAG_GS;
    else if ([elementName isEqualToString:@"SL"])
		nParserStatus = TAG_SL;
	else if ([elementName isEqualToString:@"TmpName"]) {
        bItem = YES;
		myListItem = [[ImgListItem alloc] init];;
	}
	else {
		nParserStatus = -1;
	}
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (nParserStatus >= 0) {
		if (!currentString)
            self.currentString = [NSMutableString string];
        [currentString appendString:string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	if (nParserStatus >=0) {
		switch (nParserStatus) {
			case TAG_MC:
				myListItem.mc = currentString;
				break;
			case TAG_LJDZ:
				myListItem.ljdz = currentString;
				break;
			case TAG_GS:
				myListItem.gs = currentString;
				break;
            case TAG_SL:
				myListItem.sl = currentString;
				break;
			default:
				break;
		}
		nParserStatus = -1;
        [currentString setString:@""];
        
	} else if (bItem) {	
		[resultAry addObject:myListItem];
        [myListItem release];
        bItem = NO;
	}
}


- (void)parserDidEndDocument:(NSXMLParser *)parser{
	
	[self.tableView reloadData];
	
}

@end
