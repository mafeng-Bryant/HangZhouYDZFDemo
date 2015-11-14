//
//  QYPFTableView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "QYPFTableView.h"
#import "GMEPS_HZAppDelegate.h"
#import "UITableViewCell+Custom.h"

extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation QYPFTableView
@synthesize tableKey;
@synthesize xczfbh;
@synthesize webservice;
@synthesize currentString;
@synthesize titleAry;
@synthesize valueAry;
@synthesize titleAry2;
@synthesize valueAry2;


@synthesize bh;
@synthesize pfnrid;
@synthesize qymc;
@synthesize qydz;
@synthesize kfs;
@synthesize khxz;
@synthesize cjr;
@synthesize xgr;
@synthesize cjsj;
@synthesize xgsj;
@synthesize bz;

- (void)cancelPressed {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)initEntryWithNone {

    self.bh = @"";
    self.pfnrid = [NSMutableString string];
    self.qymc = @"";
    self.qydz = @"";
    self.kfs = @"";
    self.khxz = [NSMutableString string];
    self.cjr = @"";
    self.xgr = @"";
    self.cjsj = @"";
    self.xgsj = @"";
    self.bz = @"";
}

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

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
    [pfnrid release];
    [qymc release];
    [qydz release];
    [kfs release];
    [khxz release];
    [cjr release];
    [xgr release];
    [cjsj release];
    [xgsj release];
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
    self.title = @"企业评分表";
    /*UIBarButtonItem *aItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain
															 target:self
															 action:@selector(cancelPressed)];
	self.navigationItem.rightBarButtonItem = aItem;
    */
   
    self.pfArr = [NSMutableArray arrayWithCapacity:0];
    NSString *param = [WebServiceHelper createParametersWithKey:@"tableName" value:self.tableKey , @"xczfbh", self.xczfbh, nil];
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetChildsDetials" nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
    webservice.hudTitle =  @"正在获取企业评分表数据，请稍候...";
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
    
    if (section == 0) 
        headTitle = @"基本信息";
    else if (section == 3) 
        headTitle = @"备注";
    else if (section == 1) 
        headTitle = @"评分内容";
    else
        headTitle = @"考核细则";
    
    return headTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger height;
    if ([indexPath section] == 0) {
        height = 56;
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
        
        if(row == 0 || row == 1)
            
            cell =  [UITableViewCell makeSubCell:tableView withTitle:title value:value height:56];
        else{
            title2 = [titleAry2 objectAtIndex:row];
            value2 = [valueAry2 objectAtIndex:row];
            
            cell = [UITableViewCell makeSubCell:tableView withTitle:title title2:title2 value:value value2:value2 height:56];
            
        }
        
       
    } else if (section == 3) {
        static NSString *cellIdentifier = @"Cell_BZViewController";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        [self makeTextViewCell:cell andValue:self.bz];
    } else if (section == 1) {
        static NSString *cellIdentifier1 = @"Cell_PFNRViewController";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1] autorelease];
        }
        [self makeTextViewCell:cell andValue:self.pfnrid];
    } else {
        static NSString *cellIdentifier2 = @"Cell_KHXZViewController";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2] autorelease];
        }
        [self makeTextViewCell:cell andValue:self.khxz];
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
#pragma mark NSXMLParser Delegate Method

#define kBH 0
#define kQYPFID 3
#define kQYMC 4
#define kQYDZ 5
#define kKFS 6
#define kKHXZ 7
#define kCJR 8
#define kXGR 9
#define kCJSJ 10
#define kXGSJ 11
#define kBZ 12

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"BH"])
		nParserStatus = kBH;
	else if ([elementName isEqualToString:@"QYPFID"])
		nParserStatus = kQYPFID;
	else if ([elementName isEqualToString:@"QYMC"])
		nParserStatus = kQYMC;
    else if ([elementName isEqualToString:@"QYDZ"])
		nParserStatus = kQYDZ;
    else if ([elementName isEqualToString:@"KFS"])
		nParserStatus = kKFS;
    else if ([elementName isEqualToString:@"CJR"])
		nParserStatus = kCJR;
    else if ([elementName isEqualToString:@"XGR"])
		nParserStatus = kXGR;
    else if ([elementName isEqualToString:@"CJSJ"])
		nParserStatus = kCJSJ;
    else if ([elementName isEqualToString:@"XGSJ"])
		nParserStatus = kXGSJ;
    else if ([elementName isEqualToString:@"BZ"])
        nParserStatus = kBZ;
    else if ([elementName isEqualToString:@"KHXZ"])
		nParserStatus = kKHXZ;
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
				
			case kQYPFID:
			{
//				[self.pfnrid appendFormat:@"%@\n",[currentString copy]];
                if (currentString) {
                    [self.pfArr addObject:currentString];
                }
                else {
                     [self.pfArr addObject:@""];
                }
                
			}
				break;
				
			case kQYMC:
			{
                self.qydz = @"";
                if (currentString) {
                    self.qymc = currentString;
                }
				
			}
				break;
                
            case kQYDZ:
			{
                self.qydz = @"";
                if (currentString) {
                    self.qydz = currentString;
                }
				
			}
				break;
                
            case kKFS:
			{
                self.kfs = @"";
                if (currentString) {
                    self.kfs = currentString;
                }
				
			}
				break;
                
            case kKHXZ:
			{
               [self.khxz appendString:@""];
                if (currentString) {
                    NSString *copyStr = [currentString copy];
                    [self.khxz appendFormat:@"%@\n",copyStr];
                    [copyStr release];
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
                    self.bz = currentString ;
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
    titleAry = [[NSArray alloc] initWithObjects:@"企业名称：",@"企业地址：",@"评分人：",@"评分时间：", nil];
    titleAry2 = [[NSArray alloc] initWithObjects:@"",@"",@"总分数：",@"", nil];
    valueAry = [[NSArray alloc] initWithObjects:self.qymc,self.qydz,self.cjr, self.cjsj,nil];
    valueAry2 = [[NSArray alloc] initWithObjects:@"",@"",self.kfs, @"",nil];
    NSSet *set = [NSSet setWithArray:self.pfArr];
    for (NSString *str in set) {
        [self.pfnrid appendFormat:@"%@\n",str];

    }
    
    [self.tableView reloadData];
}

@end
