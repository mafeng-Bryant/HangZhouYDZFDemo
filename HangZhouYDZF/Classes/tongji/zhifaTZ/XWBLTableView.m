//
//  XWBLTableView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "XWBLTableView.h"
#import "GMEPS_HZAppDelegate.h"
#import "DDXML.h"
extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation XWBLTableView
@synthesize tableKey;
@synthesize xczfbh;
@synthesize webservice;
@synthesize currentString;
@synthesize titleAry;
@synthesize valueAry;
@synthesize titleAry2;
@synthesize valueAry2;

@synthesize bh;
@synthesize xh;
@synthesize orgid;
@synthesize ay;
@synthesize wd;
@synthesize dcxwdd;
@synthesize xb;
@synthesize bxwrmc;
@synthesize nl; 
@synthesize zw;
@synthesize sfzhm;
@synthesize xwkssj;
@synthesize xwjssj;
@synthesize gzdw;
@synthesize jtzz;
@synthesize yb;
@synthesize cjsj;
@synthesize cjr;
@synthesize xgsj;
@synthesize xgr;
@synthesize ybagx;
@synthesize xwr;
@synthesize jlr;
@synthesize cyr;
@synthesize zfry;
@synthesize sfqr;
@synthesize zfzh;
@synthesize sqhb;
@synthesize dh;

- (void)cancelPressed {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)initEntryWithNone {
    self.bh = @"";
    self.xh = @"";
    self.orgid = @"";
    self.ay = @"";
    self.wd = @"";
    self.dcxwdd = @"";
    self.xb = @"";
    self.bxwrmc = @"";
    self.nl = @""; 
    self.zw = @"";
    self.sfzhm = @"";
    self.xwkssj = @"";
    self.xwjssj = @"";
    self.gzdw = @"";
    self.jtzz = @"";
    self.yb = @"";
    self.cjsj = @"";
    self.cjr = @"";
    self.xgsj = @"";
    self.xgr = @"";
    self.ybagx = @"";
    self.xwr = @"";
    self.jlr = @"";
    self.cyr = @"";
    self.zfry = @"";
    self.sfqr = @"";
    self.zfzh = @"";
    self.sqhb = @"";
    self.dh = @"";
}

- (void)dealloc
{
    [bh release];
    [xh release];
    [orgid release];
    [ay release];
    [wd release];
    [dcxwdd release];
    [xb release];
    [bxwrmc release];
    [nl release]; 
    [zw release];
    [sfzhm release];
    [xwkssj release];
    [xwjssj release];
    [gzdw release];
    [jtzz release];
    [yb release];
    [cjsj release];
    [cjr release];
    [xgsj release];
    [xgr release];
    [ybagx release];
    [xwr release];
    [jlr release];
    [cyr release];
    [zfry release];
    [sfqr release];
    [zfzh release];
    [sqhb release];
    [dh release];
    
    [tableKey release];
    [xczfbh release];
    [webservice release];
    [currentString release];
    [titleAry release];
    [valueAry release];
    [titleAry2 release];
    [valueAry2 release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)refreshData{
    [self.tableView reloadData];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"调查询问记录";

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
		CGRect tRect1 = CGRectMake(0, 0, 120, 44);
		tLabel = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[tLabel setBackgroundColor:[UIColor clearColor]];
		[tLabel setTextColor:[UIColor darkGrayColor]];
		tLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		tLabel.textAlignment = UITextAlignmentRight;
		tLabel.tag = 1;
		[aCell.contentView addSubview:tLabel];
		[tLabel release];
		
		CGRect tRect2 = CGRectMake(120, 0, 320, 44);
		vLabel = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[vLabel setBackgroundColor:[UIColor clearColor]];
		[vLabel setTextColor:[UIColor blackColor]];
		vLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		vLabel.textAlignment = UITextAlignmentLeft;
		vLabel.tag = 2;
		[aCell.contentView addSubview:vLabel];
		[vLabel release];
        
        CGRect tRect3 = CGRectMake(440, 0, 100, 44);
		tLabel2 = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[tLabel2 setBackgroundColor:[UIColor clearColor]];
		[tLabel2 setTextColor:[UIColor darkGrayColor]];
		tLabel2.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		tLabel2.textAlignment = UITextAlignmentRight;
		tLabel2.tag = 3;
		[aCell.contentView addSubview:tLabel2];
		[tLabel2 release];
        
        CGRect tRect4 = CGRectMake(540, 0, 250, 44);
		vLabel2 = [[UILabel alloc] initWithFrame:tRect4]; //此处使用id定义任何控件对象
		[vLabel2 setBackgroundColor:[UIColor clearColor]];
		[vLabel2 setTextColor:[UIColor blackColor]];
		vLabel2.font = [UIFont fontWithName:@"Helvetica" size:17.0];
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
	CGRect tEdtRect = CGRectMake(45, 0, 668, viewHeight);
	UIWebView* webView = [[UIWebView alloc] initWithFrame:tEdtRect];
	
	[webView setBackgroundColor:[UIColor whiteColor]];    
    [webView loadHTMLString:aValue baseURL:nil];
	[aCell addSubview:webView];
	
	[webView release];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
        headTitle = @"案由";
    } else {
        headTitle = @"询问内容";
    }
    return headTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger height;
    if ([indexPath section] == 0) {
        height = 44;
    } else if ([indexPath section] == 1) {
        height = 70;
    } else {
        float labelWidth = 300;
        CGSize constraint = CGSizeMake(labelWidth - 2 * 13, 20000.0f);
        CGSize size = [self.wd sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        height = MAX(size.height, 300.0f);
        viewHeight = height;
    }
    return height;
    
    // 计算文字高度
    
    
    ////NSLog(@"height %d", height);
    
    //[labelHeightArray addObject:[NSNumber numberWithInt:height]];
     
    
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
   
    } else if (section == 1) {
        static NSString *cellIdentifier1 = @"Cell_longTextIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1] autorelease];
        }
        cell.textLabel.numberOfLines = 4;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
        cell.textLabel.text = self.ay;
   
    } else {
        static NSString *cellIdentifier2 = @"Cell_TextViewIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2] autorelease];
        }
        
        [self makeTextViewCell:cell andValue:self.wd];
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
#define kORGID 2
#define kAY 3
#define kWD 4
#define kDCXWDD 5
#define kXB 6
#define kNL 7
#define kBXWRMC 8
#define kDH 9
#define kZW 10
#define kSFZHM 11
#define kXWKSSJ 12
#define kXWJSSJ 13
#define kGZDW 14
#define kXWR 15
#define kCJSJ 16
#define kCJR 17
#define kXGSJ 18
#define kXGR 19
#define kJTZZ 20
#define kYBAGX 21
#define kJLR 22
#define kCYR 23
#define kZFRY 24
#define kSFQR 25
#define kZFZH 26
#define kSQHB 27
#define kYB 28

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"BH"])
		nParserStatus = kBH;
	else if ([elementName isEqualToString:@"XH"])
		nParserStatus = kXH;
	else if ([elementName isEqualToString:@"ORGID"])
		nParserStatus = kORGID;
	else if ([elementName isEqualToString:@"AY"])
		nParserStatus = kAY;
	else if ([elementName isEqualToString:@"WD"])
		nParserStatus = kWD;
    else if ([elementName isEqualToString:@"DCXWDD"])
		nParserStatus = kDCXWDD;
    else if ([elementName isEqualToString:@"XB"])
		nParserStatus = kXB;
    else if ([elementName isEqualToString:@"NL"])
		nParserStatus = kNL;
    else if ([elementName isEqualToString:@"BXWRMC"])
		nParserStatus = kBXWRMC;
    else if ([elementName isEqualToString:@"DH"])
		nParserStatus = kDH;
    else if ([elementName isEqualToString:@"ZW"])
		nParserStatus = kZW;
    else if ([elementName isEqualToString:@"SFZHM"])
        nParserStatus = kSFZHM;
    else if ([elementName isEqualToString:@"XWKSSJ"])
		nParserStatus = kXWKSSJ;
    else if ([elementName isEqualToString:@"XWJSSJ"])
		nParserStatus = kXWJSSJ;
    else if ([elementName isEqualToString:@"GZDW"])
		nParserStatus = kGZDW;
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
    else if ([elementName isEqualToString:@"YB"])
		nParserStatus = kYB;
    else if ([elementName isEqualToString:@"JTZZ"])
		nParserStatus = kJTZZ;
    else if ([elementName isEqualToString:@"YBAGX"])
		nParserStatus = kYBAGX;
    else if ([elementName isEqualToString:@"JLR"])
		nParserStatus = kJLR;
    else if ([elementName isEqualToString:@"CYR"])
		nParserStatus = kCYR;
    else if ([elementName isEqualToString:@"ZFRY"])
		nParserStatus = kZFRY;
    else if ([elementName isEqualToString:@"ZFZH"])
        nParserStatus = kZFZH;
    else if ([elementName isEqualToString:@"SFQR"])
		nParserStatus = kSFQR;
    else if ([elementName isEqualToString:@"SQHB"])
		nParserStatus = kSQHB;
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
                
			case kORGID:
			{
                self.orgid = @"";
                if (currentString) {
                    self.orgid = currentString;

                }
            }
				break;
				
			case kAY:
			{
                self.ay = @"";
                if (currentString) {
                    self.ay = currentString;
                }
				
			}
				break;
				
			case kWD:
			{
                self.wd = @"";
                if (currentString) {
                    self.wd = currentString;
                }
				
			}
				break;
                
            case kDCXWDD:
			{
                self.dcxwdd = @"";
                if (currentString) {
                    self.dcxwdd = currentString;
                }
				
			}
				break;
                
            case kXB:
			{
                self.xb = @"";
                if (currentString) {
                    self.xb = currentString;

                }
            }
				break;
                
            case kNL:
			{
                self.nl = @"";
                if (currentString) {
                    self.nl = currentString;
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
                
            case kYB:
			{
                self.yb = @"";
                if (currentString) {
                    self.yb = currentString;
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
                
            case kZW:
			{
                self.zw = @"";
                if (currentString) {
                    self.zw = currentString;
                }
				
			}
				break;
                
            case kSFZHM:
			{
                self.sfzhm = @"";
                if (currentString) {
                    self.sfzhm = currentString;
                }
				
			}
				break;
                
            case kXWKSSJ:
			{
                self.xwkssj = @"";
                if (currentString) {
                    self.xwkssj = [currentString substringToIndex:16];
                }
				
			}
				break;
                
            case kXWJSSJ:
			{
                self.xwjssj = @"";
                if (currentString) {
                    self.xwjssj = [currentString substringToIndex:16];
                }
				
			}
				break;
                
                
            case kGZDW:
			{
                self.gzdw = @"";
                if (currentString) {
                    self.gzdw = currentString;
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
                
            case kJTZZ:
			{
                self.jtzz = @"";
                if (currentString) {
                    self.jtzz = currentString;
                }
				
			}
				break;
                
            case kYBAGX:
			{
                self.ybagx = @"";
                if (currentString) {
                    self.ybagx = currentString;
                }
							
            }
				break;
                
            case kJLR:
			{
                self.jlr = @"";
                if (currentString) {
                    self.jlr = currentString;
                }
				
			}
				break;
                
            case kCYR:
			{
                self.cyr = @"";
                if (currentString) {
                    self.cyr = currentString;
                }
				
			}
				break;
                
            case kZFRY:
			{
                self.zfry = @"";
                if (currentString) {
                    self.zfry = currentString;
                }
				
			}
				break;
                
            case kSFQR:
			{
                self.sfqr = @"";
                if (currentString) {
                    self.sfqr = currentString;

                }
							
            }
				break;
                
            case kZFZH:
			{
                self.zfzh = @"";
                if (currentString) {
                    self.zfzh = currentString;
                }
				
			}
				break;
                
            case kSQHB:
			{
                self.sqhb = @"";
                if (currentString) {
                    self.sqhb = currentString;
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
    titleAry = [[NSArray alloc] initWithObjects:@"区域代码：",@"询问地点：",@"性别：",@"工作单位：",@"身份证号码：",@"家庭住址：",@"与本案关系：",@"记录人：",@"执法人员：",@"身份确认：",@"开始时间：",@"创建人：",@"修改人：", nil];
    titleAry2 = [[NSArray alloc] initWithObjects:@"单位编号：",@"被询问人：",@"年龄：",@"职务：",@"联系电话：",@"邮编：",@"询问人：",@"参与人：",@"执法证号：",@"申请回避：",@"结束时间：",@"创建时间：",@"修改时间：", nil];
    
    
    valueAry = [[NSArray alloc] initWithObjects:self.orgid,self.dcxwdd,self.xb,self.gzdw,self.sfzhm,self.jtzz,self.ybagx,self.jlr,self.zfry,self.sfqr,self.xwkssj,self.cjr,self.xgr, nil];
    valueAry2 = [[NSArray alloc] initWithObjects:self.xh,self.bxwrmc,self.nl,self.zw,self.dh,self.yb,self.xwr,self.cyr,self.zfzh,self.sqhb,self.xwjssj,self.cjsj,self.xgsj, nil];
    
    [hud hide:YES];
    [self.tableView reloadData];
}

@end
