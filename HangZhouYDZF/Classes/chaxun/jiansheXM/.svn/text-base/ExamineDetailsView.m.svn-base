    //
//  ExamineDetailsView.m
//  RetrieveExamine
//
//  Created by hejunhua on 11-9-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ExamineDetailsView.h"
#import "GMEPS_HZAppDelegate.h"

extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation ExamineDetailsView
@synthesize webservice,infoItem,currentString;
@synthesize detail,xhCode,titlesAry,valueAry;

- (void)viewDidLoad {
    self.title = @"建设项目审批详细信息";
	detail.hidden = YES;
    
    infoItem = [[SPDetailsInfoItem alloc] initWithNone];
    
	NSString *param = [WebServiceHelper createParametersWithKey:@"XH" value:xhCode,nil];
	NSString *url = [NSString stringWithFormat: KExamine_URL,g_appDelegate.ServerIP];
    
	webservice = [[WebServiceHelper alloc] initWithUrl:url
												method:@"RetrieveExamineDetails"
                  view:self.view
											 nameSpace:@"http://tempuri.org/"
											parameters:param 
											  delegate:self];
    webservice.hudTitle = @"正在获取项目审批详细信息，请稍候...";
	[webservice run];
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[webservice release];
    [infoItem release];
    [currentString release];
    [detail release];
    [xhCode release];
    [titlesAry release];
    [valueAry release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSXMLParser Delegate Method

#define kXMMC 0 
#define kSPRQ 1
#define kHYLX 2
#define kTZDW 3
#define kTZDWDZ 4
#define kXMZTZ 5
#define kHBZTZ 6
#define kXZQH 7
#define kSFTGSP 8
#define kHBLXR 9
#define kLXRDH 10
#define kSPWH 11
#define kPFYJ 12

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"XMMC"])
		nParserStatus = kXMMC;
	else if ([elementName isEqualToString:@"SPRQ"])
		nParserStatus = kSPRQ;
	else if ([elementName isEqualToString:@"HYLX"])
		nParserStatus = kHYLX;
	else if ([elementName isEqualToString:@"TZDW"])
		nParserStatus = kTZDW;
	else if ([elementName isEqualToString:@"TZDWDZ"])
		nParserStatus = kTZDWDZ;
	else if ([elementName isEqualToString:@"XMZTZ"])
		nParserStatus = kXMZTZ;
	else if ([elementName isEqualToString:@"HBZTZ"])
		nParserStatus = kHBZTZ;
	else if ([elementName isEqualToString:@"XZQH"])
		nParserStatus = kXZQH;
	else if ([elementName isEqualToString:@"SFTGSP"])
		nParserStatus = kSFTGSP;
    else if ([elementName isEqualToString:@"HBLXR"])
        nParserStatus = kHBLXR;
    else if ([elementName isEqualToString:@"LXRDH"])
        nParserStatus = kLXRDH;
    else if ([elementName isEqualToString:@"SPWH"])
        nParserStatus = kSPWH;
    else if ([elementName isEqualToString:@"PFYJ"])
        nParserStatus = kPFYJ;
	else 
		nParserStatus = -1;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (nParserStatus >= 0){
		if (!currentString)
			self.currentString = [NSMutableString string];
		[currentString appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if (nParserStatus >= 0){
		switch (nParserStatus) {
            case kXMMC:
                infoItem.xmmc = currentString;
                break;
                
            case kSPRQ:
                infoItem.sprq = [currentString substringToIndex:10];
                break;
                
            case kHYLX:
                infoItem.hylx = currentString;
                break;
                
            case kTZDW:
                infoItem.tzdw = currentString;
                break;
                
            case kTZDWDZ:
                infoItem.tzdwdz = currentString;
                break;
                
            case kXMZTZ:
                infoItem.xmztz = currentString;
                break;
                
            case kHBZTZ:
                infoItem.hbztz = currentString;
                break;
                
            case kXZQH:
                infoItem.xzqh = currentString;
                break;
                
            case kSFTGSP:
            {
                if ([currentString isEqualToString:@"1"])
                    infoItem.sftgsp = @"已通过";
                else
                    infoItem.sftgsp = @"未通过";
            }
                break;
                
            case kHBLXR:
                infoItem.hblxr = currentString ;
                break;
                
            case kLXRDH:
                infoItem.lxrdh = currentString ;
                break;
                
            case kSPWH:
                infoItem.spwh = currentString ;
                break;
                
            case kPFYJ:
                infoItem.pfyj = currentString;
                break;
                
            default:
                break;
        }
        
        
		nParserStatus = -1;
        currentString = nil;
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	titlesAry = [[NSArray alloc] initWithObjects:@"项目名称：",@"审批日期：",@"行业类型：",@"投资单位：",@"投资单位地址：",@"环保联系人：",@"联系人电话：",@"项目总投资（万元）：",@"环保总投资（万元）：",@"审批文号：",@"行政区划：",@"是否通过审批：", nil];
    valueAry = [[NSArray alloc] initWithObjects:infoItem.xmmc,infoItem.sprq,infoItem.hylx,infoItem.tzdw,infoItem.tzdwdz,infoItem.hblxr,infoItem.lxrdh,infoItem.xmztz,infoItem.hbztz,infoItem.spwh,infoItem.xzqh,infoItem.sftgsp, nil];
    
    [self.detail reloadData];
    detail.hidden = NO;
}	




#pragma mark -
#pragma mark TableView DataSource Methods


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
		CGRect tRect2 = CGRectMake(5, 0, 160, 44);
		lblTitle = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor grayColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblTitle.textAlignment = UITextAlignmentRight;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		CGRect tRect3 = CGRectMake(180, 0, 520, 44);
		lblValue = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[lblValue setBackgroundColor:[UIColor clearColor]];
		[lblValue setTextColor:[UIColor blackColor]];
		lblValue.font = [UIFont fontWithName:@"Helvetica" size:15.0];
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


-(void)makeTextViewCell:(UITableViewCell *)aCell andValue:(NSString*)aValue
{
	CGRect tEdtRect = CGRectMake(50, 0, 668, viewHeight);
	UITextView* edt = [[UITextView alloc] initWithFrame:tEdtRect];
	
	[edt setBackgroundColor:[UIColor whiteColor]];    
	edt.font = [UIFont fontWithName:@"Helvetica" size:15.0];;	
	edt.autocorrectionType = UITextAutocorrectionTypeNo;
	edt.autocapitalizationType= UITextAutocapitalizationTypeNone;
	edt.tag = 1;
	edt.text = aValue;
	edt.editable = NO;
	[aCell addSubview:edt];
	
	[edt release];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count;
    if (section == 0) {
        count = [titlesAry count];
    } else {
        count = 1;
    }
    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *headTitle;
    if (section == 0) {
        headTitle = @"基本信息";
    } else {
        headTitle = @"批复意见";
    }
    return headTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger height;
    if ([indexPath section] == 0) {
        height = 44;
    } else {
        float labelWidth = 300;
        CGSize constraint = CGSizeMake(labelWidth - 2 * 13, 20000.0f);
        CGSize size = [infoItem.pfyj sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        height = MAX(size.height, 300.0f);
        viewHeight = height;

    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
    NSUInteger section = [indexPath section];
    
    NSString *title;
    NSString *value;
    UITableViewCell *cell;
    
    if (section == 0) {
        title = [titlesAry objectAtIndex:row];
        value = [valueAry objectAtIndex:row];
        cell = [self makeSubCell:tableView withTitle:title value:value];
    } else {
        static NSString *cellIdentifier = @"Cell_PFYJIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        [self makeTextViewCell:cell andValue:infoItem.pfyj];
    }
    
    NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row%2 == 0) ? @"white" : @"lightblue" ofType:@"png"];
	UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
	cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
	cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	cell.backgroundView.frame = cell.bounds;
	cell.textLabel.backgroundColor = [UIColor clearColor];
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

#pragma mark -
#pragma mark TableView Delegate Methods


@end
