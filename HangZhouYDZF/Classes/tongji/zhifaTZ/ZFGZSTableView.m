//
//  ZFGZSTableView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ZFGZSTableView.h"
#import "GMEPS_HZAppDelegate.h"

extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation ZFGZSTableView
@synthesize tableName;
@synthesize xczfbh;
@synthesize webservice;
@synthesize currentString;
@synthesize titleAry;
@synthesize valueAry;
@synthesize titleAry2;
@synthesize valueAry2;
@synthesize bh;
@synthesize xh;
@synthesize hhjgh;
@synthesize wrymc;
@synthesize tzsj;
@synthesize qlclsj;
@synthesize bjcdb;
@synthesize bxwrmc;
@synthesize dh;
@synthesize jcsj;
@synthesize fxdw;
@synthesize wf;
@synthesize tzqlsj;
@synthesize js;
@synthesize qt;
@synthesize xwr;
@synthesize cjsj;
@synthesize cjr;
@synthesize xgsj;
@synthesize xgr;
@synthesize bz;
@synthesize zfrdh;

- (void)cancelPressed {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)initEntryWithNone {
    titleAry = [[NSArray alloc] initWithObjects:@"审批文号：",@"通知时间：",@"前来时间：",@"单位当事人：",@"现场检查人：",@"被检查代表：",@"创建人：",@"修改人：", nil];
    titleAry2 = [[NSArray alloc] initWithObjects:@"污染源名称：",@"通知前来时间：",@"检查时间：",@"当事人电话：",@"检查人电话：",@"处理科室：",@"创建时间：",@"修改时间：", nil];
    
    self.xh = @"";
    self.bh = @"";
    self.hhjgh = @"";
    self.wrymc = @"";
    self.wf = @"";
    self.tzsj= @"";
    self.qlclsj = @"";
    self.bjcdb = @"";
    self.bxwrmc = @"";
    self.dh = @"";
    self.jcsj = @"";
    self.fxdw = @"";
    self.tzqlsj = @"";
    self.js = @"";
    self.qt = @"";
    self.xwr = @"";
    self.cjr = @"";
    self.xgr = @"";
    self.cjsj = @"";
    self.xgsj = @"";
    self.bz = @"";
    self.zfrdh = @"";
    
}

- (void)dealloc
{
    [tableName release];
    [xczfbh release];
    [webservice release];
    [currentString release];
    [titleAry release];
    [valueAry release];
    [titleAry2 release];
    [valueAry2 release];
    [bh release];
    [xh release];
    [hhjgh release];
    [wrymc release];
    [tzsj release];
    [qlclsj release];
    [bjcdb release];
    [bxwrmc release];
    [dh release];
    [jcsj release];
    [fxdw release];
    [wf release];
    [tzqlsj release];
    [js release];
    [qt release];
    [xwr release];
    [cjsj release];
    [cjr release];
    [xgsj release];
    [xgr release];
    [bz release];
    [zfrdh release];
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
    self.title = @"现场执法告知书";
    
    NSString *param = [WebServiceHelper createParametersWithKey:@"tableName" value:self.tableName , @"xczfbh", self.xczfbh, nil];
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    NSString *method = @"GetChildsDetials";
    NSString *nameSpace = @"http://Services.MobileLaw.Powerdata.com/";
    webservice = [[WebServiceHelper alloc] initWithUrl:URL
                                                method:method
                                                  view:self.view
                                             nameSpace:nameSpace
                                            parameters:param
                                              delegate:self];
    webservice.hudTitle = @"正在获取执法告知书数据，请稍候...";
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
        
        CGRect tRect3 = CGRectMake(280, 0, 120, 44);
		tLabel2 = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[tLabel2 setBackgroundColor:[UIColor clearColor]];
		[tLabel2 setTextColor:[UIColor darkGrayColor]];
		tLabel2.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		tLabel2.textAlignment = UITextAlignmentRight;
		tLabel2.tag = 3;
		[aCell.contentView addSubview:tLabel2];
		[tLabel2 release];
        
        CGRect tRect4 = CGRectMake(400, 0, 250, 44);
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
    return 5;
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
        headTitle = @"发现该单位";
    } else if (section == 2) {
        headTitle = @"已违反";
    } else if (section == 3) {
        headTitle = @"其他随带物";
    } else {
        headTitle = @"备注";
    }
    return headTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger height;
    if ([indexPath section] == 0) {
        height = 44;
    } else if ([indexPath section] == 4) {
        height = 300;
    } else {
        height = 100;
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
            cell.textLabel.text = self.fxdw;
        }
        else if (section == 2) {
            cell.textLabel.numberOfLines = 4;
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
            cell.textLabel.text = self.wf;
        }
        else if (section == 3) {
            cell.textLabel.numberOfLines = 4;
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
            cell.textLabel.text = self.qt;
        }
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
#define kXH 1
#define kHHJGH 2
#define kWRYMC 3
#define kWF 4
#define kTZSJ 5
#define kQLCLSJ 6
#define kBJCDB 7
#define kBXWRMC 8
#define kDH 9
#define kJCSJ 10
#define kFXDW 11
#define kTZQLSJ 12
#define kJS 13
#define kQT 14
#define kXWR 15
#define kCJSJ 16
#define kCJR 17
#define kXGSJ 18
#define kXGR 19
#define kBZ 20
#define kZFRDH 21
#define kXDNR  22


- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
	if ([elementName isEqualToString:@"BH"])
		nParserStatus = kBH;
	else if ([elementName isEqualToString:@"XH"])
		nParserStatus = kXH;
	else if ([elementName isEqualToString:@"HHJGH"])
		nParserStatus = kHHJGH;
	else if ([elementName isEqualToString:@"WRYMC"])
		nParserStatus = kWRYMC;
	else if ([elementName isEqualToString:@"WF"])
		nParserStatus = kWF;
    else if ([elementName isEqualToString:@"TZSJ"])
		nParserStatus = kTZSJ;
    else if ([elementName isEqualToString:@"QLCLSJ"])
		nParserStatus = kQLCLSJ;
    else if ([elementName isEqualToString:@"BJCDB"])
		nParserStatus = kBJCDB;
    else if ([elementName isEqualToString:@"BXWRMC"])
		nParserStatus = kBXWRMC;
    else if ([elementName isEqualToString:@"DH"])
		nParserStatus = kDH;
    else if ([elementName isEqualToString:@"JCSJ"])
		nParserStatus = kJCSJ;
    else if ([elementName isEqualToString:@"FXDW"])
        nParserStatus = kFXDW;
    else if ([elementName isEqualToString:@"TZQLSJ"])
		nParserStatus = kTZQLSJ;
    else if ([elementName isEqualToString:@"JS"])
		nParserStatus = kJS;
    else if ([elementName isEqualToString:@"XDNR"])
        nParserStatus = kXDNR;
    else if ([elementName isEqualToString:@"QT"])
		nParserStatus = kQT;
    else if ([elementName isEqualToString:@"XWR"])
		nParserStatus = kXWR;
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
    else if ([elementName isEqualToString:@"ZFRDH"])
		nParserStatus = kZFRDH;
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
				
			case kXH:
			{
                self.xh = @"";
                if (currentString) {
                    self.xh = currentString;
                }
				
			}
				break;
                
			case kHHJGH:
			{
                self.hhjgh = @"";
                if (currentString) {
                    self.hhjgh = currentString;
                }
				
			}
				break;
				
			case kWRYMC:
			{
                self.wrymc = @"";
                if (currentString) {
                    self.wrymc = currentString;
                }
				
			}
				break;
				
			case kWF:
			{
                self.wf = @"";
                if (currentString) {
                    self.wf = currentString;
                }
				
			}
				break;
                
            case kTZSJ:
			{
                self.tzsj = @"";
                if (currentString) {
                    NSInteger len = [currentString length];
                    self.tzsj = [currentString substringWithRange:NSMakeRange(0, len-3)];
                }
				
			}
				break;
                
            case kQLCLSJ:
			{
                self.qlclsj = @"";
                if (currentString) {
                    NSInteger len = [currentString length];
                    self.qlclsj = [currentString substringWithRange:NSMakeRange(0, len-3)];
                }
				
			}
				break;
                
            case kBJCDB:
			{
                self.bjcdb = @"";
                if (currentString) {
                    self.bjcdb = currentString;
                    
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
                    NSInteger len = [currentString length];
                    self.cjsj = [currentString substringWithRange:NSMakeRange(0, len-3)];
                }
				
			}
				break;
                
            case kXGSJ:
			{
                self.xgsj = @"";
                if (currentString) {
                    NSInteger len = [currentString length];
                    self.xgsj = [currentString substringWithRange:NSMakeRange(0, len-3)];
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
                
            case kBXWRMC:
			{
                self.bxwrmc = @"";
                if (currentString) {
                    self.bxwrmc = currentString;
                }
				
			}
				break;
                
            case kDH:
			{
                self.dh = @"";
                if (currentString) {
                    self.dh = currentString;
                }
				
			}
				break;
                
            case kJCSJ:
			{
                self.jcsj = @"";
                if (currentString) {
                    NSInteger len = [currentString length];
                    self.jcsj = [currentString substringWithRange:NSMakeRange(0, len-3)];
                }
				
			}
				break;
                
            case kFXDW:
			{
                self.fxdw = @"";
                if (currentString) {
                    self.fxdw = currentString;
                }
				
			}
				break;
                
            case kTZQLSJ:
			{
                self.tzqlsj = @"";
                if (currentString) {
                    NSInteger len = [currentString length];
                    self.tzqlsj = [currentString substringWithRange:NSMakeRange(0, len-3)];
                }
				
			}
				break;
                
            case kJS:
			{
                self.js = @"";
                if (currentString) {
                    self.js = currentString;
                }
				
			}
				break;
                
            case kQT:
			{
                self.qt = @"";
                if (currentString) {
                    self.qt = currentString;
                }
				
			}
				break;
                
            case kXDNR: {
                if (currentString) {
                    self.qt = [NSString stringWithFormat:@"%@|%@",currentString,qt];
                }
            }
                break;
                
            case kXWR:
			{
                self.xwr = @"";
                if (currentString) {
                    self.xwr = currentString;
                }
				
			}
				break;
                
            case kZFRDH:
			{
                self.zfrdh = @"";
                if (currentString) {
                    self.zfrdh = currentString;
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
    valueAry = [[NSArray alloc] initWithObjects:self.hhjgh,self.tzsj,self.qlclsj,self.bxwrmc,self.xwr,self.bjcdb,self.cjr,self.xgr, nil];
    valueAry2 = [[NSArray alloc] initWithObjects:self.wrymc,self.tzqlsj,self.jcsj,self.dh,self.zfrdh,self.js,self.cjsj,self.xgsj, nil];
    
    [self.tableView reloadData];
    
}


@end
