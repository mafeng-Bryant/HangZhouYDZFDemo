//
//  JCYJSTableView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "JCYJSTableView.h"
#import "GMEPS_HZAppDelegate.h"

extern GMEPS_HZAppDelegate *g_appDelegate;


@implementation JCYJSTableView
@synthesize tableKey;
@synthesize xczfbh;
@synthesize webservice;
@synthesize currentString;
@synthesize titleAry;
@synthesize valueAry;
@synthesize titleAry2;
@synthesize valueAry2;
@synthesize bh;
@synthesize hhjch;
@synthesize qymc;
@synthesize sbsj;
@synthesize wgsj;
@synthesize sbdz;
@synthesize xcjcry;
@synthesize qydsr;
@synthesize lxdh;
@synthesize qylxdh;
@synthesize orgid;
@synthesize jcsj;
@synthesize jcyj;
@synthesize cjsj;
@synthesize cjr;
@synthesize xgsj;
@synthesize xgr;
@synthesize bz;


- (void)cancelPressed {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)initEntryWithNone {
    self.orgid = @"";
    self.bh = @"";
    self.hhjch = @"";
    self.qymc = @"";
    self.qylxdh = @"";
    self.sbsj= @"";
    self.wgsj = @"";
    self.jcyj = @"";
    self.qydsr = @"";
    self.lxdh = @"";
    self.jcsj = @"";
    self.xcjcry = @"";
    self.cjr = @"";
    self.xgr = @"";
    self.cjsj = @"";
    self.xgsj = @"";
    self.bz = @"";
    self.sbdz = @"";
}

- (void)dealloc
{
    [tableKey release];
    [xczfbh release];
    [webservice release];
    [currentString release];
    [titleAry release];
    [valueAry release];
    [titleAry2 release];
    [valueAry2 release];
    [bh release];
    [hhjch release];
    [qymc release];
    [sbsj release];
    [wgsj release];
    [sbdz release];
    [xcjcry release];
    [qydsr release];
    [lxdh release];
    [qylxdh release];
    [orgid release];
    [jcsj release];
    [jcyj release];
    [cjsj release];
    [cjr release];
    [xgsj release];
    [xgr release];
    [bz release];
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
    self.title = @"现场监察意见书";
    /*UIBarButtonItem *aItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain
															 target:self
															 action:@selector(cancelPressed)];
	self.navigationItem.rightBarButtonItem = aItem;
    */
    if (hud)
        [hud release];
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.delegate = nil;
    hud.labelText = @"正在读取数据，请稍候...";
    [hud show:YES];
    
    NSString *param = [WebServiceHelper createParametersWithKey:@"tableName" value:self.tableKey , @"xczfbh", self.xczfbh, nil];
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetChildsDetials" nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
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


#pragma mark - Table view data source


- (UITableViewCell*) getCell:(NSString*) CellIdentifier forTablieView:(UITableView*) tableView
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	return cell;
}

- (UITableViewCell*)makeSubCell:(UITableView *)tableView
                      withTitle:(NSString *)aTitle
                         title2:(NSString *)aTitle2
                          value:(NSString *)aValue
                         value2:(NSString *)aValue2
{
	UILabel* tLabel = nil;
    UILabel* tLabel2 = nil;
    UILabel* vLabel = nil;
    UILabel* vLabel2 = nil;
    
	UITableViewCell* aCell = [self getCell:@"Cell_DetailViewController" forTablieView:tableView];
    
	if (aCell.contentView != nil)
	{
        tLabel = (UILabel *)[aCell.contentView viewWithTag:1];
        vLabel = (UILabel *)[aCell.contentView viewWithTag:2];
        tLabel2 = (UILabel *)[aCell.contentView viewWithTag:3];
        vLabel2 = (UILabel *)[aCell.contentView viewWithTag:4];
    }
	
	if (tLabel == nil) {
		CGRect tRect1 = CGRectMake(0, 0, 100, 44);
		tLabel = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[tLabel setBackgroundColor:[UIColor clearColor]];
		[tLabel setTextColor:[UIColor darkGrayColor]];
		tLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		tLabel.textAlignment = UITextAlignmentRight;
		tLabel.tag = 1;
		[aCell.contentView addSubview:tLabel];
		[tLabel release];
		
		CGRect tRect2 = CGRectMake(100, 0, 250, 44);
		vLabel = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[vLabel setBackgroundColor:[UIColor clearColor]];
		[vLabel setTextColor:[UIColor blackColor]];
		vLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		vLabel.textAlignment = UITextAlignmentLeft;
		vLabel.tag = 2;
		[aCell.contentView addSubview:vLabel];
		[vLabel release];
        
        CGRect tRect3 = CGRectMake(350, 0, 100, 44);
		tLabel2 = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[tLabel2 setBackgroundColor:[UIColor clearColor]];
		[tLabel2 setTextColor:[UIColor darkGrayColor]];
		tLabel2.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		tLabel2.textAlignment = UITextAlignmentRight;
		tLabel2.tag = 3;
		[aCell.contentView addSubview:tLabel2];
		[tLabel2 release];
        
        CGRect tRect4 = CGRectMake(450, 0, 250, 44);
		vLabel2 = [[UILabel alloc] initWithFrame:tRect4]; //此处使用id定义任何控件对象
		[vLabel2 setBackgroundColor:[UIColor clearColor]];
		[vLabel2 setTextColor:[UIColor blackColor]];
		vLabel2.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		vLabel2.textAlignment = UITextAlignmentLeft;
		vLabel2.tag = 4;
		[aCell.contentView addSubview:vLabel2];
		[vLabel2 release];
        
    }
    
    [tLabel setText:aTitle];
    [vLabel setText:aValue];
    [tLabel2 setText:aTitle2];
    [vLabel2 setText:aValue2];
    
    aCell.accessoryType = UITableViewCellAccessoryNone;
    
	return aCell;
}


-(void)makeTextViewCell:(UITableViewCell *)aCell andValue:(NSString*)aValue
{
	CGRect tEdtRect = CGRectMake(45, 0, 668, 300);
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count;
    if (section == 0) {
        count = [titleAry count];
    } else {
        count = 1;
    }
    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *headTitle;
    if (section == 0) {
        headTitle = @"基本信息";
    } else if (section == 1) {
        headTitle = @"违规事件";
    } else if (section == 2) {
        headTitle = @"监察意见";
    } else {
        headTitle = @"备注";
    }
    return headTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger height;
    if ([indexPath section] == 0) {
        height = 44;
    } else if ([indexPath section] == 1) {
        height = 100;
    } else {
        height = 300;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
    NSUInteger section = [indexPath section];
    
    NSString *title;
    NSString *value;
    NSString *title2;
    NSString *value2;
    UITableViewCell *cell;
    
    if (section == 0) {
        title = [titleAry objectAtIndex:row];
        value = [valueAry objectAtIndex:row];
        title2 = [titleAry2 objectAtIndex:row];
        value2 = [valueAry2 objectAtIndex:row];
        cell = [self makeSubCell:tableView withTitle:title title2:title2 value:value value2:value2];
    } else {
        static NSString *cellIdentifier = @"Cell_longTextIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        
        if (section == 1) {
            cell.textLabel.numberOfLines = 4;
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
            cell.textLabel.text = self.wgsj;
        }
        else if (section == 2)
            [self makeTextViewCell:cell andValue:self.jcyj];
        else
            [self makeTextViewCell:cell andValue:self.bz];
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


#pragma mark - Table view delegate



#pragma mark - NSXMLParser Delegate Method

#define kBH 0
#define kORGID 1
#define kHHJCH 2
#define kQYMC 3
#define kJCSJ 4
#define kJCYJ 5
#define kSBSJ 6
#define kWGSJ 7
#define kSBDZ 8
#define kXCJCRY 9
#define kQYDSR 10
#define kLXDH 11
#define kQYLXDH 12
#define kCJR 13
#define kXGR 14
#define kCJSJ 15
#define kXGSJ 16
#define kBZ 17


- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"BH"])
		nParserStatus = kBH;
	else if ([elementName isEqualToString:@"ORGID"])
		nParserStatus = kORGID;
	else if ([elementName isEqualToString:@"HHJCH"])
		nParserStatus = kHHJCH;
	else if ([elementName isEqualToString:@"QYMC"])
		nParserStatus = kQYMC;
	else if ([elementName isEqualToString:@"JCSJ"])
		nParserStatus = kJCSJ;
    else if ([elementName isEqualToString:@"JCYJ"])
		nParserStatus = kJCYJ;
    else if ([elementName isEqualToString:@"SBSJ"])
		nParserStatus = kSBSJ;
    else if ([elementName isEqualToString:@"WGSJ"])
		nParserStatus = kWGSJ;
    else if ([elementName isEqualToString:@"SBDZ"])
		nParserStatus = kSBDZ;
    else if ([elementName isEqualToString:@"XCJCRY"])
		nParserStatus = kXCJCRY;
    else if ([elementName isEqualToString:@"QYDSR"])
		nParserStatus = kQYDSR;
    else if ([elementName isEqualToString:@"LXDH"])
        nParserStatus = kLXDH;
    else if ([elementName isEqualToString:@"QYLXDH"])
		nParserStatus = kQYLXDH;
    else if ([elementName isEqualToString:@"CJR"])
		nParserStatus = kCJR;
    else if ([elementName isEqualToString:@"XGR"])
		nParserStatus = kXGR;
    else if ([elementName isEqualToString:@"CJSJ"])
		nParserStatus = kCJSJ;
    else if ([elementName isEqualToString:@"CJR"])
		nParserStatus = kCJR;
    else if ([elementName isEqualToString:@"XGSJ"])
		nParserStatus = kXGSJ;
    else if ([elementName isEqualToString:@"XGR"])
		nParserStatus = kXGR;
    else if ([elementName isEqualToString:@"BZ"])
		nParserStatus = kBZ;
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
			{
                self.bh = @"";
                if (currentString) {
                    self.bh = currentString;
                }
				
			}
				break;
				
			case kORGID:
			{
                self.orgid = @"";
                if (currentString) {
                    self.orgid = currentString;
                }
				
			}
				break;
                
			case kHHJCH:
			{
                self.hhjch = @"";
                if (currentString) {
                    self.hhjch = currentString;
                }
				
			}
				break;
				
			case kQYMC:
			{
                self.qymc = @"";
                if (currentString) {
                    self.qymc = currentString;

                }
							
            }
				break;
				
			case kJCSJ:
			{
                self.jcsj = @"";
                if (currentString) {
                    self.jcsj = [currentString substringToIndex:16];
                }
				
			}
				break;
                
            case kJCYJ:
			{
                self.jcyj = @"";
                if (currentString) {
                    self.jcyj = currentString;
                }
				
			}
				break;
                
            case kSBSJ:
			{
                self.sbsj = @"";
                if (currentString) {
                    self.sbsj = [currentString substringToIndex:16];
                }
				
			}
				break;
                
            case kSBDZ:
			{
                self.sbdz = @"";
                if (currentString) {
                    self.sbdz = currentString;
                }
				
			}
				break;
                
            case kCJR:
			{
                self.cjr = @"";
                if (currentString) {
                    self.cjr = currentString;
                }
				
			}
				break;
                
            case kCJSJ:
			{
                self.cjsj = @"";
                if (currentString) {
                    self.cjsj = [currentString substringToIndex:16];
                }
				
			}
				break;
                
            case kXGSJ:
			{
                self.xgsj = @"";
                if (currentString) {
                    self.xgsj = [currentString substringToIndex:16];
                }
				
			}
				break;
                
            case kXGR:
			{
                self.xgr = @"";
                if (currentString) {
                    self.xgr = currentString;
                }
				
			}
				break;
                
            case kBZ:
			{
                self.bz = @"";
                if (currentString) {
                    self.bz = currentString;
                }
				
			}
				break;
                
            case kWGSJ:
			{
                self.wgsj = @"";
                if (currentString) {
                    self.wgsj = currentString;
                }
				
			}
				break;
                
            case kXCJCRY:
			{
                self.xcjcry = @"";
                if (currentString) {
                    self.xcjcry = currentString;
                }
				
			}
				break;
                
            case kQYDSR:
			{
                self.qydsr = @"";
                if (currentString) {
                    self.qydsr = currentString;
                }
				
			}
				break;
                
            case kLXDH:
			{
                self.lxdh = @"";
                if (currentString) {
                    self.lxdh= currentString;
                }
				
			}
				break;
                
            case kQYLXDH:
			{
                self.qylxdh = @"";
                if (currentString) {
                    self.qylxdh = currentString;
                }
				
			}
				break;
                
            default:
                break;
        }
		currentString = nil;
		nParserStatus = -1;
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    titleAry = [[NSArray alloc] initWithObjects:@"审批文号：",@"企业电话：",@"上报时间：",@"企业当事人：",@"创建人：",@"修改人：",@"现场监察人：", nil];
    titleAry2 = [[NSArray alloc] initWithObjects:@"企业名称：",@"检查时间：",@"上报单位：",@"当事人电话：",@"创建时间：",@"修改时间：",@"区域代码：", nil];
    valueAry = [[NSArray alloc] initWithObjects:self.hhjch,self.qylxdh,self.sbsj,self.qydsr,self.cjr,self.xgr,self.xcjcry, nil];
    valueAry2 = [[NSArray alloc] initWithObjects:self.qymc,self.jcsj,self.sbdz,self.lxdh,self.cjsj,self.xgsj,self.orgid, nil];
    
    [hud hide:YES];
    [self.tableView reloadData];
}

@end
