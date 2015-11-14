//
//  JSXMGZBTableView.m
//  GMEPS_HZ
//
//  Created by power humor on 12-5-24.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import "JSXMGZBTableView.h"
#import "GMEPS_HZAppDelegate.h"
#import "UITableViewCell+Custom.h"
extern GMEPS_HZAppDelegate *g_appDelegate;
@implementation JSXMGZBTableView

@synthesize titleAry,valueAry,titleAry2,valueAry2;
@synthesize xczfbh,webservice,currentString;
@synthesize tableKey;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initEntryWithNone {
    bh = @"";
    xmmc = @"";
    jsdd = @"";
    xzqhdm = @"";
    jsdw = @"";
    yqjgrq = @"";
    xmfzr = @"";
    lxdh = @"";
    lxr = @""; 
    lxrdh = @"";
    spbm = @"";
    spwh = @"";
    hylx = @"";
    ybhy = @"";
    xmlx = @"";
    mgcd = @"";
    ssqk = @"";
    gzjb = @"";
    ztgc = @"";
    sclss = @"";
    fqclss = @"";
    zsclss = @"";
    gfclss = @"";
    qksm = @"";
    xfqk = @"";
    qtspnrlsqk = @"";
    jcyj = @"";
    jcrq = @"";
    cjr = @"";
    cjsj = @"";
    xgr = @"";
    xgsj = @"";
    gzbh = @"";
    hbsstzq = @"";
    hbsstzs = @"";
    hbsstzzs = @"";
    hbsstzz = @"";
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
    
    
    if (HUD)
        [HUD release];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.delegate = nil;
    HUD.labelText = @"正在读取数据，请稍候...";
    [HUD show:YES];
    ////NSLog(@"bianhao:%@",self.xczfbh);
    NSString *param = [WebServiceHelper createParametersWithKey:@"tableName" value:self.tableKey , @"xczfbh", self.xczfbh, nil];
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetChildsDetials" nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
    [webservice run];    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [titleAry count]+3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"建设项目跟踪";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0 && indexPath.row >= [titleAry count])
        return 200;
    else
        return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	
    NSString *title;
    NSString *value;
    NSString *title2;
    NSString *value2;
    UITableViewCell *cell = nil;
    int lenght = [titleAry count];
    if (row >= [titleAry count])
    {
        if (row==[titleAry count]) 
            cell = [UITableViewCell makeSubCell:tableView withTitle:@"情况说明：" andText:qksm height:200];
        else if(row == lenght+1)
            cell = [UITableViewCell makeSubCell:tableView withTitle:@"其他审批内容：" andText:qtspnrlsqk height:200];
        else if(row == lenght+2)
            cell = [UITableViewCell makeSubCell:tableView withTitle:@"监察意见：" andText:jcyj height:200];
    }
    else {
        title = [titleAry objectAtIndex:row];
        value = [valueAry objectAtIndex:row];
        title2 = [titleAry2 objectAtIndex:row];
        value2 = [valueAry2 objectAtIndex:row];
        cell = [UITableViewCell makeSubCell:tableView withTitle:title title2:title2 value:value value2:value2 height:56];
    }
    
    
	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

#pragma mark - NSXMLParser Delegate Method

#define kBH     0
#define kXMMC   1
#define kJSDD   2
#define kXZQHDM 3
#define kJSDW   4
#define kYQJGRQ 5
#define kXMFZR  6
#define kLXDH   7
#define kLXR    8
#define kLXRDH  9
#define kSPWH   10
#define kSPBM   11
#define kHYLX   12
#define kYBHY   13
#define kMGCD   14
#define kSSQK   15
#define kGZJB   16
#define kZTGC   17
#define kSCLSS  18
#define kFQCLSS 19
#define kZSCLSS 20
#define kGFCLSS 21
#define kQKSM   22
#define kXFQK   23
#define kQTSPNRLSQK 24
#define kJCYJ   25
#define kJCRQ   26
#define kCJR    27
#define kCJSJ   28
#define kXGR    29
#define kXGSJ   30
#define kGZBH   31
#define kXMLX   32
#define kHBSSTZS 33
#define kHBSSTZQ 34
#define kHBSSTZZS 35
#define kHBSSTZZ 36

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"BH"])
		nParserStatus = kBH;
	else if ([elementName isEqualToString:@"XMMC"])
		nParserStatus = kXMMC;
	else if ([elementName isEqualToString:@"JSDD"])
		nParserStatus = kJSDD;
	else if ([elementName isEqualToString:@"XZQHDM"])
		nParserStatus = kXZQHDM;
	else if ([elementName isEqualToString:@"JSDW"])
		nParserStatus = kJSDW;
    else if ([elementName isEqualToString:@"YQJGRQ"])
		nParserStatus = kYQJGRQ;
    else if ([elementName isEqualToString:@"XMFZR"])
		nParserStatus = kXMFZR;
    else if ([elementName isEqualToString:@"LXDH"])
		nParserStatus = kLXDH;
    else if ([elementName isEqualToString:@"LXR"])
		nParserStatus = kLXR;
    else if ([elementName isEqualToString:@"LXRDH"])
		nParserStatus = kLXRDH;
    else if ([elementName isEqualToString:@"SPBM"])
		nParserStatus = kSPBM;
    else if ([elementName isEqualToString:@"SPWH"])
        nParserStatus = kSPWH;
    else if ([elementName isEqualToString:@"HYLX"])
		nParserStatus = kHYLX;
    else if ([elementName isEqualToString:@"YBHY"])
		nParserStatus = kYBHY;
    else if ([elementName isEqualToString:@"XMLX"])
		nParserStatus = kXMLX;
    else if ([elementName isEqualToString:@"MGCD"])
		nParserStatus = kMGCD;
    else if ([elementName isEqualToString:@"SSQK"])
		nParserStatus = kSSQK;
    else if ([elementName isEqualToString:@"GZJB"])
		nParserStatus = kGZJB;
    else if ([elementName isEqualToString:@"ZTGC"])
		nParserStatus = kZTGC;
    else if ([elementName isEqualToString:@"SCLSS"])
		nParserStatus = kSCLSS;
    else if ([elementName isEqualToString:@"FQCLSS"])
		nParserStatus = kFQCLSS;
    else if ([elementName isEqualToString:@"ZSCLSS"])
		nParserStatus = kZSCLSS;
    else if ([elementName isEqualToString:@"GFCLSS"])
		nParserStatus = kGFCLSS;
    else if ([elementName isEqualToString:@"QKSM"])
		nParserStatus = kQKSM;
    else if ([elementName isEqualToString:@"XFQK"])
		nParserStatus = kXFQK;
    else if ([elementName isEqualToString:@"QTSPNRLSQK"])
		nParserStatus = kQTSPNRLSQK;
    else if ([elementName isEqualToString:@"JCYJ"])
        nParserStatus = kJCYJ;
    else if ([elementName isEqualToString:@"JCRQ"])
		nParserStatus = kJCRQ;
    else if ([elementName isEqualToString:@"CJR"])
		nParserStatus = kCJR;
    else if ([elementName isEqualToString:@"CJSJ"])
		nParserStatus = kCJSJ;
    else if ([elementName isEqualToString:@"XGR"])
		nParserStatus = kXGR;
    else if ([elementName isEqualToString:@"XGSJ"])
		nParserStatus = kXGSJ;
    else if ([elementName isEqualToString:@"GZBH"])
		nParserStatus = kGZBH;
    else if ([elementName isEqualToString:@"XMLX"])
		nParserStatus = kXMLX;
    else if ([elementName isEqualToString:@"HBSSTZS"])
		nParserStatus = kHBSSTZS;
    else if ([elementName isEqualToString:@"HBSSTZQ"])
		nParserStatus = kHBSSTZQ;
    else if ([elementName isEqualToString:@"HBSSTZZS"])
		nParserStatus = kHBSSTZZS;
    else if ([elementName isEqualToString:@"HBSSTZZ"])
		nParserStatus = kHBSSTZZ;
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
                bh = @"";
                if (currentString) {
                    bh = [currentString copy];
                }
				
			}
				break;
				
			case kXMMC:
			{
                xmmc = @"";
                if (currentString) {
                    xmmc = [currentString copy];
                }
				
			}
				break;
                
			case kJSDD:
			{
                jsdd = @"";
                if (currentString) {
                    jsdd = [currentString copy];
                }
				
			}
				break;
				
			case kXZQHDM:
			{
                xzqhdm = @"";
                if (currentString) {
                    xzqhdm = [currentString copy];
                }
				
			}
				break;
				
			case kJSDW:
			{
                jsdw = @"";
                if (currentString) {
                    jsdw = [currentString copy];
                }
				
			}
				break;
                
            case kYQJGRQ:
			{
                yqjgrq = @"";
                if (currentString) {
                    yqjgrq = [[currentString substringToIndex:16] copy];
                }
				
			}
				break;
                
            case kXMFZR:
			{
                xmfzr = @"";
                if (currentString) {
                    xmfzr = [currentString copy];
                }
				
			}
				break;
                
            case kLXDH:
			{
                lxdh = @"";
                if (currentString) {
                    lxdh = [currentString copy];
                }
				
			}
				break;
                
            case kLXR:
			{
                lxr = @"";
                if (currentString) {
                    lxr = [currentString copy];
                }
				
			}
				break;
                
            case kLXRDH:
			{
                lxrdh = @"";
                if (currentString) {
                    lxrdh = [currentString copy];
                }
				
			}
				break;
                
            case kSPBM:
			{
                spbm = @"";
                if (currentString) {
                    spbm = [currentString copy];
                }
				
			}
				break;
                
            case kHYLX:
			{
                hylx = @"";
                if (currentString) {
                    hylx = [currentString copy];
                }
				
			}
				break;
                
            case kYBHY:
			{
                ybhy = @"";
                if (currentString) {
                    ybhy = [currentString copy];
                }
				
			}
				break;
                
            case kXMLX:
			{
                xmlx = @"";
                if (currentString) {
                    xmlx = [currentString copy];
                }
				
			}
				break;
                
            case kMGCD:
			{
                mgcd = @"";
                if (currentString) {
                    mgcd = [currentString copy];
                }
				
			}
				break;
                
            case kSSQK:
			{
                ssqk = @"";
                if (currentString) {
                    ssqk = [currentString copy];
                }
				
			}
				break;
                
            case kGZJB:
			{
                gzjb = @"";
                if (currentString) {
                    gzjb = [currentString copy];
                }
				
			}
				break;
                
            case kZTGC:
			{
                ztgc = @"";
                if (currentString) {
                    ztgc = [currentString copy];
                }
				
			}
				break;
                
            case kSCLSS:
			{
                sclss = @"";
                if (currentString) {
                    sclss = [currentString copy];
                }
				
			}
				break;
                
            case kFQCLSS:
			{
                fqclss =@"";
                if (currentString) {
                    fqclss = [currentString copy];
                }
				
			}
				break;
                
            case kZSCLSS:
			{
                zsclss = @"";
                if (currentString) {
                    zsclss = [currentString copy];
                }
				
			}
				break;
                
            case kGFCLSS:
			{
                gfclss = @"";
                if (currentString) {
                    gfclss = [currentString copy];
                }
				
			}
				break;
                
            case kQKSM:
			{
                qksm = @"";
                if (currentString) {
                    qksm = [currentString copy];
                }
				
			}
				break;
                
            case kXFQK:
			{
                xfqk = @"";
                if (currentString) {
                    xfqk = [currentString copy];
                }
				
			}
				break;
                
            case kQTSPNRLSQK:
			{
                qtspnrlsqk = @"";
                if (currentString) {
                    qtspnrlsqk = [currentString copy];
                }
				
			}
				break;
                
            case kJCYJ:
			{
                jcyj = @"";
                if (currentString) {
                    jcyj = [currentString copy];
                }
				
			}
				break;
                
            case kJCRQ:
			{
                jcrq = @"";
                if (currentString) {
                    jcrq = [[currentString substringToIndex:16] copy];
                }
				
			}
				break;
                
            case kCJR:
			{
                cjr = @"";
                if (currentString) {
                    cjr = [currentString copy];
                }
				
			}
				break;
                
            case kCJSJ:
			{
                cjsj = @"";
                if (currentString) {
                    cjsj = [[currentString substringToIndex:16] copy];
                }
				
			}
				break;
                
            case kXGR:
			{
                xgr = @"";
                if (currentString) {
                    xgr = [currentString copy];
                }
				
			}
				break;
                
            case kXGSJ:
			{
                xgsj = @"";
                if (xgsj) {
                    xgsj = [currentString copy];
                }
				
			}
				break;
                
            case kGZBH:
			{
                gzbh = @"";
                if (currentString) {
                    gzbh = [currentString copy];
                }
				
			}
				break;
                
            case kHBSSTZS:
			{
                hbsstzs = @"";
                if (currentString) {
                    hbsstzs = [currentString copy];
                }
				
			}
				break;
                
            case kHBSSTZQ:
			{
                hbsstzq = @"";
                if (currentString) {
                    hbsstzq = [currentString copy];
                }
				
			}
				break;
                
            case kHBSSTZZS:
			{
                hbsstzzs = @"";
                if (currentString) {
                    hbsstzzs = [currentString copy];
                }
				
			}
				break;
                
            case kHBSSTZZ:
			{
                hbsstzz = @"";
                if (currentString) {
                    hbsstzz = [currentString copy];
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
    jcrq = [jcrq stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    cjsj = [cjsj stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    yqjgrq = [yqjgrq stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    titleAry = [[NSArray alloc] initWithObjects:@"建设项目名称：",@"地址：",@"建设单位：",@"项目负责人：",@"联系人：",@"审批部门：",@"行业类型：",@"项目类型：",@"实施情况：",@"环保投资水：",@"环保投资声：",@"主体工程：",@"废气处理设施：",@"固体处理设施：",@"创建人：",@"监察日期：", nil];
    titleAry2 = [[NSArray alloc] initWithObjects:@"跟踪编号：",@"区域：",@"预期竣工日期：",@"联系电话：",@"联系电话：",@"批准文号：",@"一般行业：",@"敏感程度：",@"跟踪级别：",@"环保投资气：",@"环保投资渣：",@"水处理设施：",@"噪声处理设施：",@"信访情况：",@"创建时间：",@"", nil];
    valueAry = [[NSArray alloc] initWithObjects:xmmc,jsdd,jsdw,xmfzr,lxr,spbm,hylx,xmlx,ssqk,hbsstzs,hbsstzzs,ztgc,fqclss,gfclss,cjr,jcrq,nil];
    valueAry2 = [[NSArray alloc] initWithObjects:gzbh,xzqhdm,yqjgrq,lxdh,lxrdh,spwh,ybhy,mgcd,gzjb,hbsstzq,hbsstzz,sclss,zsclss,xfqk,cjsj,@"",nil];
    
    [HUD hide:YES];
    [self.tableView reloadData];
}


@end
