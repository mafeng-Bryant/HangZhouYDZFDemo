//
//  JCBLTableView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "JCBLTableView.h"
#import "GMEPS_HZAppDelegate.h"
#import "GTMBase64.h"
extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation JCBLTableView
@synthesize tableKey;
@synthesize xczfbh;
@synthesize webservice;
@synthesize currentString;
@synthesize titleAry;
@synthesize valueAry;
@synthesize titleAry2;
@synthesize valueAry2;
@synthesize bh;
@synthesize xcfzr;
@synthesize nl;
@synthesize xb;
@synthesize sfzhm;
@synthesize gzdw;
@synthesize zw;
@synthesize ybagx;
@synthesize jtzz;
@synthesize dh;
@synthesize qtjzr;
@synthesize zfzh;
@synthesize qrsf;
@synthesize sqhb;
@synthesize xcqk;
@synthesize yb;
@synthesize cjsj;
@synthesize cjr;
@synthesize xgsj;
@synthesize xgr;
@synthesize bz;
@synthesize zt;


- (void)cancelPressed {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)initEntryWithNone {
    self.xcfzr = @"";
    self.bh = @"";
    self.nl = @"";
    self.xb = @"";
    self.sfzhm = @"";
    self.gzdw = @"";
    self.zw = @"";
    self.ybagx = @"";
    self.jtzz = @"";
    self.dh = @"";
    self.qtjzr = @"";
    self.zfzh = @"";
    self.qrsf = @"";
    self.sqhb = @"";
    self.xcqk = @"";
    self.yb = @"";
    self.cjr = @"";
    self.xgr = @"";
    self.cjsj = @"";
    self.xgsj = @"";
    self.bz = @"";
    self.zt = @"";
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
    [xcfzr release];
    [nl release];
    [xb release];
    [sfzhm release];
    [gzdw release];
    [zw release];
    [ybagx release];
    [jtzz release];
    [dh release];
    [qtjzr release];
    [zfzh release];
    [qrsf release];
    [sqhb release];
    [xcqk release];
    [yb release];
    [cjsj release];
    [cjr release];
    [xgsj release];
    [xgr release];
    [bz release];
    [zt release];
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
    self.title = @"现场勘验记录";
    

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
		CGRect tRect1 = CGRectMake(0, 0, 130, 44);
		tLabel = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[tLabel setBackgroundColor:[UIColor clearColor]];
		[tLabel setTextColor:[UIColor darkGrayColor]];
		tLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		tLabel.textAlignment = UITextAlignmentRight;
		tLabel.tag = 1;
		[aCell.contentView addSubview:tLabel];
		[tLabel release];
		
		CGRect tRect2 = CGRectMake(130, 0, 280, 44);
		vLabel = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[vLabel setBackgroundColor:[UIColor clearColor]];
		[vLabel setTextColor:[UIColor blackColor]];
		vLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		vLabel.textAlignment = UITextAlignmentLeft;
		vLabel.tag = 2;
		[aCell.contentView addSubview:vLabel];
		[vLabel release];
        
        CGRect tRect3 = CGRectMake(400, 0, 130, 44);
		tLabel2 = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[tLabel2 setBackgroundColor:[UIColor clearColor]];
		[tLabel2 setTextColor:[UIColor darkGrayColor]];
		tLabel2.font = [UIFont fontWithName:@"Helvetica" size:17.0];
		tLabel2.textAlignment = UITextAlignmentRight;
		tLabel2.tag = 3;
		[aCell.contentView addSubview:tLabel2];
		[tLabel2 release];
        
        CGRect tRect4 = CGRectMake(530, 0, 250, 44);
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
        headTitle = @"现场情况";
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
        height = 300;
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
            [self makeTextViewCell:cell andValue:self.xcqk];
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


#pragma mark -
#pragma mark NSXMLParser Delegate Method

#define kBH 0
#define kXCFZR 1
#define kNL 2
#define kXB 3
#define kSFZHM 4
#define kGZDW 5
#define kZW 6
#define kYBAGX 7
#define kJTZZ 8
#define kDH 9
#define kQTJZR 10
#define kZFZH 11
#define kQRSF 12
#define kSQHB 13
#define kXCQK 14
#define kYB 15
#define kCJSJ 16
#define kCJR 17
#define kXGSJ 18
#define kXGR 19
#define kBZ 20
#define kZT 21

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"BH"])
		nParserStatus = kBH;
	else if ([elementName isEqualToString:@"XCFZR"])
		nParserStatus = kXCFZR;
	else if ([elementName isEqualToString:@"NL"])
		nParserStatus = kNL;
	else if ([elementName isEqualToString:@"XB"])
		nParserStatus = kXB;
	else if ([elementName isEqualToString:@"SFZHM"])
		nParserStatus = kSFZHM;
    else if ([elementName isEqualToString:@"GZDW"])
		nParserStatus = kGZDW;
    else if ([elementName isEqualToString:@"ZW"])
		nParserStatus = kZW;
    else if ([elementName isEqualToString:@"YBAGX"])
		nParserStatus = kYBAGX;
    else if ([elementName isEqualToString:@"JTZZ"])
		nParserStatus = kJTZZ;
    else if ([elementName isEqualToString:@"DH"])
		nParserStatus = kDH;
    else if ([elementName isEqualToString:@"QTJZR"])
		nParserStatus = kQTJZR;
    else if ([elementName isEqualToString:@"ZFZH"])
        nParserStatus = kZFZH;
    else if ([elementName isEqualToString:@"QRSF"])
		nParserStatus = kQRSF;
    else if ([elementName isEqualToString:@"SQHB"])
		nParserStatus = kSQHB;
    else if ([elementName isEqualToString:@"XCQK"])
		nParserStatus = kXCQK;
    else if ([elementName isEqualToString:@"YB"])
		nParserStatus = kYB;
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
    else if ([elementName isEqualToString:@"ZT"])
		nParserStatus = kZT;
    else 
		nParserStatus = -1;
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
		if (!currentString)
			currentString = [NSMutableString string];
		[currentString appendString:string];
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //NSLog(@"sss:%@",elementName);
    
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
				
			case kXCFZR:
			{
                self.xcfzr = @"";
                if (currentString) {
                    self.xcfzr = currentString;
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
				
			case kXB:
			{
                self.xb = @"";
                if (currentString) {
                    self.xb = currentString;
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
                
            case kGZDW:
			{
                self.gzdw = @"";
                if (currentString) {
                    self.gzdw = currentString;
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
                
            case kYBAGX:
			{
                self.ybagx = @"";
                if (currentString) {
                    self.ybagx = currentString;
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
                
            case kJTZZ:
			{
                self.jtzz = @"";
                if (currentString) {
                    self.jtzz = currentString;
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
                
            case kQTJZR:
			{
                self.qtjzr = @"";
                if (currentString) {
                    self.qtjzr = currentString;
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
                
            case kQRSF:
			{
                self.qrsf = @"";
                if (currentString) {
                    self.qrsf = currentString;
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
                
            case kXCQK:
			{
                self.xcqk = @"";
                if (currentString) {
                    self.xcqk = currentString;
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
                
            case kZT:
			{
                self.zt = @"";
                if (currentString) {
                    self.zt = currentString;
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
    titleAry = [[NSArray alloc] initWithObjects:@"现场负责人：",@"年龄：",@"工作单位：",@"与本案关系：",@"电话：",@"执法证号：",@"其他见证人：",@"创建人：",@"修改人：", nil];
    titleAry2 = [[NSArray alloc] initWithObjects:@"身份证号码：",@"性别：",@"职务：",@"家庭住址：",@"邮编：",@"身份确认：",@"申请回避：",@"创建时间：",@"修改时间：",@"", nil];
    valueAry = [[NSArray alloc] initWithObjects:self.xcfzr,self.nl,self.gzdw,self.ybagx,self.dh,self.zfzh,self.qtjzr,self.cjr,self.xgr,nil];
    valueAry2 = [[NSArray alloc] initWithObjects:self.sfzhm,self.xb,self.zw,self.jtzz,self.yb,self.qrsf,self.sqhb,self.cjsj,self.xgsj,@"", nil];
    
    [hud hide:YES];
    [self.tableView reloadData];
}


@end
