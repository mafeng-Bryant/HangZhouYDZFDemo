//
//  STDetailsController.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "STDetailsController.h"
#import "STZBViewController.h"
#import "GMEPS_HZAppDelegate.h"

extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;

@implementation STDetailsController
@synthesize webservice;
@synthesize currentString;
@synthesize zbItem;
@synthesize zbArray;
@synthesize titleAry;
@synthesize valueAry;
@synthesize titleAry2;
@synthesize valueAry2;
@synthesize zbMainInfoAry;
@synthesize xmlCode;

@synthesize  dbbh;
@synthesize  rwlx;
@synthesize  dwbh;
@synthesize  dwmc;
@synthesize  szqy;
@synthesize  ssjd;
@synthesize  dbr;
@synthesize  dbrdw;
@synthesize  jsr;
@synthesize  jsrdw;
@synthesize  dbxx;
@synthesize  zt; 
@synthesize  ydbz;
@synthesize  dbsj;
@synthesize  qx;
@synthesize  sfglzf;
@synthesize  sfzb;
@synthesize  dbrsfbj;
@synthesize  dbrbjsj;
@synthesize  dbbjr;
@synthesize  jsrsfbj;
@synthesize  jsrbjsj;
@synthesize  jsbjr;
@synthesize  cjr; 
@synthesize  cjsj;
@synthesize  xgr; 
@synthesize  xgsj;


- (void)dealloc
{
    [webservice release];
    [currentString release];
    [zbArray release];
    [titleAry release];
    [valueAry release];
    [titleAry2 release];
    [valueAry2 release];
    [zbMainInfoAry release];
    [xmlCode release];
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
    self.title = @"督办任务详细信息";
    NSString *param = [WebServiceHelper createParametersWithKey:@"bh" value:self.xmlCode,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetSupervisionDetailsInfo_Log_UDID" nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
    webservice.hudTitle = @"正在获取数据，请稍候...";
    [webservice run];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


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
	CGRect tEdtRect = CGRectMake(50, 5, 668, 200);
	UITextView* edt = [[UITextView alloc] initWithFrame:tEdtRect];
	
	[edt setBackgroundColor:[UIColor clearColor]];    
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
		CGRect tRect1 = CGRectMake(0, 0, 140, 44);
		tLabel = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[tLabel setBackgroundColor:[UIColor clearColor]];
		[tLabel setTextColor:[UIColor darkGrayColor]];
		tLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		tLabel.textAlignment = UITextAlignmentRight;
		tLabel.tag = 1;
		[aCell.contentView addSubview:tLabel];
		[tLabel release];
		
		CGRect tRect2 = CGRectMake(140, 0, 200, 44);
		vLabel = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[vLabel setBackgroundColor:[UIColor clearColor]];
		[vLabel setTextColor:[UIColor blackColor]];
		vLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		vLabel.textAlignment = UITextAlignmentLeft;
        vLabel.numberOfLines = 2;
		vLabel.tag = 2;
		[aCell.contentView addSubview:vLabel];
		[vLabel release];
        
        CGRect tRect3 = CGRectMake(340, 0, 140, 44);
		tLabel2 = [[UILabel alloc] initWithFrame:tRect3]; //此处使用id定义任何控件对象
		[tLabel2 setBackgroundColor:[UIColor clearColor]];
		[tLabel2 setTextColor:[UIColor darkGrayColor]];
		tLabel2.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		tLabel2.textAlignment = UITextAlignmentRight;
		tLabel2.tag = 3;
		[aCell.contentView addSubview:tLabel2];
		[tLabel2 release];
        
        CGRect tRect4 = CGRectMake(480, 0, 200, 44);
		vLabel2 = [[UILabel alloc] initWithFrame:tRect4]; //此处使用id定义任何控件对象
		[vLabel2 setBackgroundColor:[UIColor clearColor]];
		[vLabel2 setTextColor:[UIColor blackColor]];
		vLabel2.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		vLabel2.textAlignment = UITextAlignmentLeft;
        vLabel2.numberOfLines = 2;
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


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count;
	if (section == 0) 
        count = [titleAry count];
    else if (section == 3) { 
        count = [zbMainInfoAry count];
    } else {
        count = 1;
    }
    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *headTitle;
    if (section == 0) {
        headTitle = @"任务督办主表基本信息";
    } else if (section == 1) {
        headTitle = @"督办信息";
    } else if (section == 2) {
        headTitle = @"疑点备注";
    } else {
        headTitle = @"任务督办子表信息";
    }
    return headTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger height;
    if ([indexPath section] == 0) {
        height = 44;
    } else if ([indexPath section] == 3) {
        height = 44;
    } else {
        height = 205;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:(indexPath.row%2 == 0) ? @"white" : @"lightblue" ofType:@"png"];
        UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
        cell.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
        cell.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        cell.backgroundView.frame = cell.bounds;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        
    } else if (section == 1){
        
        static NSString *cellIdentifier1 = @"DBXX_cellIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1] autorelease];
        }
        [self makeTextViewCell:cell andValue:self.dbxx];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    } else if (section == 2){
        
        static NSString *cellIdentifier2 = @"YDBZ_cellIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2] autorelease];
        }
        [self makeTextViewCell:cell andValue:self.ydbz];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    } else {
        
        static NSString *cellIdentifier3 = @"ZB_cellIdentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier3] autorelease];
        }
        cell.textLabel.text = [zbMainInfoAry objectAtIndex:row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	
	return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 3){
        UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
        NSUInteger row = [indexPath row];
        STZBInfoItem *passItem = [zbArray objectAtIndex:row];
        
        STZBViewController *childView = [[STZBViewController alloc] initWithNibName:@"STZBViewController" bundle:nil]; 
        [childView setDataItem:passItem];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childView];
        nav.modalPresentationStyle =  UIModalPresentationFormSheet;
        [self presentModalViewController:nav animated:YES];
        if (statusBarOrientation == UIInterfaceOrientationPortrait)
            nav.view.superview.frame = CGRectMake(5, 150, 758, 743);
        else 
            nav.view.superview.frame = CGRectMake(135, 20, 758, 743);
        [nav release];
        [childView release];
    }
}

#pragma mark - NSXMLParser Delegate Method

#define kRWLX 0
#define kDWMC 1
#define kSZQY 2
#define kSSJD 3
#define kDBR 4
#define kDBRDW 5
#define kJSR 6
#define kJSRDW 7
#define kZT 8
#define kDBXX 9
#define kYDBZ 10
#define kDBSJ 11
#define kQX 12
#define kSFGLZF 13
#define kSFZB 14
#define kDBRSFBJ 15
#define kDBRBJSJ 16
#define kDBBJR 17
#define kJSRSFBJ 18
#define kJSRBJSJ 19
#define kJSBJR 20
#define kCJR 21
#define kCJSJ 22
#define kXGR 23
#define kXGSJ 24

#define kHFXX 25
#define kHFSJ 26
#define kHFR 27
#define kHFRDW 28
#define kZBDWMC 29
#define kZBCJR 30
#define kZBCJSJ 31
#define kZBXGR 32
#define kZBXGSJ 33
#define kXH 34
#define kBH 35
#define kORGID 36
#define kDWBH 37

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
    bZBItem = NO;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"RWLX"])
        nParserStatus = kRWLX;
    else if ([elementName isEqualToString:@"DWMC"]) {
        if (bZBItem)
            nParserStatus = kZBDWMC;
        else
            nParserStatus = kDWMC;
    }
    else if ([elementName isEqualToString:@"SZQY"])
        nParserStatus = kSZQY;
    else if ([elementName isEqualToString:@"SSJD"])
        nParserStatus = kSSJD;
    else if ([elementName isEqualToString:@"DBR"])
        nParserStatus = kDBR;
    else if ([elementName isEqualToString:@"DBRDW"])
        nParserStatus = kDBRDW;
    else if ([elementName isEqualToString:@"JSR"])
        nParserStatus = kJSR;
    else if ([elementName isEqualToString:@"JSRDW"])
        nParserStatus = kJSRDW;
    else if ([elementName isEqualToString:@"ZT"])
        nParserStatus = kZT;
    else if ([elementName isEqualToString:@"DBXX"])
        nParserStatus = kDBXX;
    else if ([elementName isEqualToString:@"YDBZ"])
        nParserStatus = kYDBZ;
    else if ([elementName isEqualToString:@"DBSJ"])
        nParserStatus = kDBSJ;
    else if ([elementName isEqualToString:@"QX"])
        nParserStatus = kQX;
    else if ([elementName isEqualToString:@"SFGLZF"])
        nParserStatus = kSFGLZF;
    else if ([elementName isEqualToString:@"SFZB"])
        nParserStatus = kSFZB;
    else if ([elementName isEqualToString:@"DBRSFBJ"])
        nParserStatus = kDBRSFBJ;
    else if ([elementName isEqualToString:@"DBRBJSJ"])
        nParserStatus = kDBRBJSJ;
    else if ([elementName isEqualToString:@"DBBJR"])
        nParserStatus = kDBBJR;
    else if ([elementName isEqualToString:@"JSRSFBJ"])
        nParserStatus = kJSRSFBJ;
    else if ([elementName isEqualToString:@"JSRBJSJ"])
        nParserStatus = kJSRBJSJ;
    else if ([elementName isEqualToString:@"JSBJR"])
        nParserStatus = kJSBJR;
    else if ([elementName isEqualToString:@"CJR"]) {   
        if (bZBItem)
            nParserStatus = kZBCJR;
        else
            nParserStatus = kCJR;
    }
    else if ([elementName isEqualToString:@"CJSJ"]) {
        if (bZBItem)
            nParserStatus = kZBCJSJ;
        else
            nParserStatus = kCJSJ;
    }    
    else if ([elementName isEqualToString:@"XGR"]) {
        if (bZBItem)
            nParserStatus = kZBXGR;
        else
            nParserStatus = kXGR;
    }    
    else if ([elementName isEqualToString:@"XGSJ"]) {
        if (bZBItem)
            nParserStatus = kZBXGSJ;
        else
            nParserStatus = kXGSJ;
    }    
    else if ([elementName isEqualToString:@"HFXX"])
        nParserStatus = kHFXX;
    else if ([elementName isEqualToString:@"HFSJ"])
        nParserStatus = kHFSJ;
    else if ([elementName isEqualToString:@"HFR"])
        nParserStatus = kHFR;
    else if ([elementName isEqualToString:@"HFRDW"]) 
        nParserStatus = kHFRDW;
    else if ([elementName isEqualToString:@"XH"]) 
        nParserStatus = kXH;
    else if ([elementName isEqualToString:@"BH"]) 
        nParserStatus = kBH;
    else if ([elementName isEqualToString:@"ORGID"]) 
        nParserStatus = kORGID;
    else if ([elementName isEqualToString:@"DWBH"]) 
        nParserStatus = kDWBH;
    else if ([elementName isEqualToString:@"t_ydzf_db_jbxx"]) {
        self.dbbh = @"";
        self.rwlx = @"";
        self.dwbh = @"";
        self.dwmc = @"";
        self.szqy = @"";
        self.ssjd = @"";
        self.dbr = @"";
        self.dbrdw = @"";
        self.jsr = @"";
        self.jsrdw = @"";
        self.dbxx = @"";
        self.zt = @""; 
        self.ydbz = @"";
        self.dbsj = @"";
        self.qx = @"";
        self.sfglzf = @"";
        self.sfzb = @"";
        self.dbrsfbj = @"";
        self.dbrbjsj = @"";
        self.dbbjr = @"";
        self.jsrsfbj = @"";
        self.jsrbjsj = @"";
        self.jsbjr = @"";
        self.cjr = @""; 
        self.cjsj = @"";
        self.xgr = @""; 
        self.xgsj = @"";
    }
    else if ([elementName isEqualToString:@"t_ydzf_db_zb"]) {
        zbItem = [[STZBInfoItem alloc] initWithNone];
        bZBItem = YES;
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
            case kRWLX:
                self.rwlx = currentString;
                break;
            case kDWMC:
                self.dwmc = currentString;
                break;
            case kSZQY:
                self.szqy = currentString;
                break;
            case kSSJD:
                self.ssjd = currentString;
                break;
            case kDBR:
                self.dbr = currentString;
                break;
            case kDBRDW:
                self.dbrdw = currentString;
                break;
            case kJSR:
                self.jsr = currentString;
                break;
            case kJSRDW:
                self.jsrdw = currentString;
                break;
            case kZT:
                self.zt = currentString;
                break;
            case kDBXX:
                self.dbxx = currentString;
                break;
            case kYDBZ:
                self.ydbz = currentString;
                break;
            case kDBSJ:
                self.dbsj = [currentString substringToIndex:16];
                break;
            case kQX:
                self.qx = [currentString substringToIndex:16];
                break;
            case kSFGLZF:
                self.sfglzf = currentString;
                break;
            case kSFZB:
                self.sfzb = currentString;
                break;
            case kDBRSFBJ:
                self.dbrsfbj = currentString;
                break;
            case kDBRBJSJ:
                self.dbrbjsj = [currentString substringToIndex:16];
                break;
            case kJSRSFBJ:
                self.jsrsfbj = currentString;
                break;
            case kJSRBJSJ:
                self.jsrbjsj = [currentString substringToIndex:16];
                break;
            case kJSBJR:
                self.jsbjr = currentString;
                break;
            case kCJR:
                self.cjr = currentString;
                break;
            case kCJSJ:
                self.cjsj = [currentString substringToIndex:16];
                break;
            case kXGR:
                self.xgr = currentString;
                break;
            case kXGSJ:
                self.xgsj = currentString;
                break;
            case kHFXX:
                zbItem.hfxx = currentString;
                break;
            case kHFSJ:
                zbItem.hfsj = [currentString substringToIndex:16];
                break;
            case kHFR:
                zbItem.hfr = currentString;
                break;
            case kHFRDW:
                zbItem.hfrdw = currentString;
                break;
            case kZBDWMC:
                zbItem.dwmc = currentString;
                break;
            case kZBCJR:
                zbItem.cjr = currentString;
                break;
            case kZBCJSJ:
                zbItem.cjsj = [currentString substringToIndex:16];
                break;
            case kZBXGR:
                zbItem.xgr = currentString;
                break;
            case kZBXGSJ:
                zbItem.xgsj = [currentString substringToIndex:16];
                break;
            case kXH:
                zbItem.xh = currentString;
                break;
            case kBH:
                zbItem.bh = currentString;
                break;
            case kORGID:
                zbItem.orgid = currentString;
                break;
            case kDWBH:
                zbItem.dwbh = currentString;
                break;
            default:
                break;
        }
		currentString = nil;
		nParserStatus = -1;
        
    } else if (bZBItem ) {
        if (!zbArray)
            zbArray = [[NSMutableArray alloc] init];
        [zbArray addObject:zbItem];
        [zbItem release];
        bZBItem = NO;
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    titleAry = [[NSArray alloc] initWithObjects:@"督办时间：",@"期限：",@"所在区域：",@"督办人：",@"接收人：",@"是否转办：",@"督办人是否办结：",@"督办办结时间：",@"接收人办结时间：", nil];
    titleAry2 = [[NSArray alloc] initWithObjects:@"督办任务类型：",@"单位名称：",@"所在街道：",@"督办人单位：",@"接收人单位：",@"是否关联执法：",@"接收人是否办结：",@"督办办结人：",@"接收办结人：", nil];
    
    valueAry = [[NSArray alloc] initWithObjects:self.dbsj,self.qx,self.szqy,self.dbr,self.jsr,self.sfzb,self.dbrsfbj,self.dbrbjsj,self.jsrbjsj, nil];
    valueAry2 = [[NSArray alloc] initWithObjects:self.rwlx,self.dwmc,self.ssjd,self.dbrdw,self.jsrdw,self.sfglzf,self.jsrsfbj,self.dbbjr,self.jsbjr, nil];
    
    zbMainInfoAry = [[NSMutableArray alloc] init];
    STZBInfoItem *aZBItem;
    NSString *aString;
    for (int i = 0; i<[zbArray count]; i++) {
        aZBItem = (STZBInfoItem *)[zbArray objectAtIndex:i];
        aString = [NSString stringWithFormat:@"回复人：%@ 回复时间：%@",aZBItem.hfr,aZBItem.hfsj];
        [zbMainInfoAry addObject:aString];
    }
    
    [self.tableView reloadData];
}
@end
