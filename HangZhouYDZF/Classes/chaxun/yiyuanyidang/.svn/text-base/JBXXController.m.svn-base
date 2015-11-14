//
//  JBXXController.m
//  GMEPS_HZ
//
//  Created by chen on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JBXXController.h"
#import "GMEPS_HZAppDelegate.h"
#import "HtmlTableGenerator.h"
extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;
#define GetWryJbxx  @"GetWryJbxx"
@implementation JBXXController
@synthesize jbxxWebView,jbxxTitleItems,jbxxItemKeys,dicJBXX,wrybh;
@synthesize curData,webService;
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
	jbxxTitleItems = [[NSArray alloc] initWithObjects:@"污染源编号",@"企业状态",
						   @"污染源名称", @"污染源简称",@"原公司名称（多个公司名称以分号间隔）",@"单位地址",@"行政区划",
						   @"单位类型", @"所属街道",@"所属环保局",
						   @"经度", @"纬度",@"所属流域", @"是否饮用水源保护区",@"法人代表",@"法人联系电话",@"环保联系人",@"环保联系人电话",
						   @"传真号码",@"邮政编码",@"电子信箱",@"网址", @"所在工业区",@"厂区面积",@"企业规模",@"是否上市公司",@"是否有子公司",@"子公司名称（多家子公司以分号间隔）",@"环保监管级别（废水）",@"环保监管级别（废气）",@"环保监管级别（重金属）",@"环保监管级别（污水处理厂）",@"行业类型",@"登记注册类型",@"重点污染源类型",@"锅炉数、总蒸吨数",@"燃料类型",@"上年末固定资产原值（万元）",@"环保设施原值（万元）",@"是否纳入环境信用评定",@"近三年环境信用评定等级（倒序）",@"营业执照代码",@"组织机构代码",@"开户银行",@"银行账号",@"是否有排污申请",@"是否有排污收费",@"排污许可证编号",@"有效期",@"废水执行排放标准",@"废气执行排放标准",@"危险废物",@"危废委托处理单位",@"污水年排放量",@"排放去向",@"是否有监督监测",@"是否有清洁生产",@"是否有在线监测",@"是否有排污口规范化",@"是否环境污染重点监管单位",@"是否通过环境监督员制度验收",@"是否有放射源",@"放射源种类",@"污染源介绍",@"备注",
						   nil];
	
	jbxxItemKeys = [[NSArray alloc] initWithObjects:@"WRYBH",@"QYZT",@"WRYMC",@"WRYJC",@"YGSMC",@"DWDZ",@"XZQH",@"DWLX",@"SSJD",@"SSHBJ",@"JD",@"WD",@"LY",@"SFYYSYBHQ",@"FRDB",@"LXDH",@"HBLXR",@"HBLXRDH",@"CZHM"@"YZBM",@"DZXX",@"WZ",@"SZGYYQ",@"CQMJ",@"QYGM",@"SFSSGS",@"SFYZGS",@"ZGSMC",@"FSJGJB",@"FQJGJB",@"ZJSJGJB",@"WSCLCJGJB",@"HYLX",@"DJZCLX",@"ZDWRYLX",@"GLXHSL",@"RLLX",@"SNMGDZCYZ",@"HBSSYZ",@"SFNRHJXYPD",@"JSNHJXYPDDJ",@"YYZZDM",@"ZZJGDM",@"KHYY",@"YYZH",@"SFYPWSQ",@"SFYPWSF",@"PWXKZBH",@"YXQ",@"FSPFBZ",@"FQPFBZ",@"WXFW",@"WFCLDW",@"WSNPFL",@"PFQX",@"SFJDJC",@"SFQJSC",@"SFZXJC",@"SFPWGFH",@"SFHJWRZDJGDW",@"SFTGHJJDYZDYS",@"SFFSY",@"FSYZL",@"WRYJS",@"BZ",nil];
	
	dicJBXX = [[NSMutableDictionary alloc] initWithCapacity:100];
	curData = [[NSMutableString alloc] initWithCapacity:200];
	
	NSString* params = [WebServiceHelper createParametersWithKey:@"wrybh"
														   value:wrybh,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
	if (webService != nil) {
		[webService release];
	}
    
    NSString *URL = [NSString  stringWithFormat: KYYYD_URL,g_appDelegate.ServerIP];
	webService = [[WebServiceHelper alloc] initWithUrl:URL
												method:@"GetWryJbxx_Log_UDID"
                                                  view:self.view
											 nameSpace:KSoapNameSpace
											parameters:params
											  delegate:self];
	[webService run];
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


#define kXMBH 0
#define kXMMC 1
#define kWRYBH 2
#define kSFTGSP 3
#define kSPRQ 4

#define TAG_JCRQ  0
#define TAG_JCDMC 1
#define TAG_PFL   2
#define TAG_WRWND 3
#define TAG_DMNR  4
#define TAG_BZ    5


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (curData)
		[curData appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if( [elementName isEqualToString:@"GetWryJbxx_Log_UDIDResult"]) {
        _jsonString = [curData copy];
    }
    [curData setString:@""];
}

-(NSDictionary *)getNSDictionaryFromJSON:(NSString *)JSONString
{

    NSMutableString *str = [JSONString substringFromIndex:1];
    str = [str substringToIndex:str.length-1];
    NSLog(str);
    NSDictionary *Dic = [str objectFromJSONString];
    return Dic;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    dicJBXX = [self getNSDictionaryFromJSON:_jsonString];
    [curData release];
	NSString *htmlStr = [HtmlTableGenerator genContentWithTitle:@"企业基本信息" andParaMeters:dicJBXX andType:GetWryJbxx];
    jbxxWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    [self.jbxxWebView loadHTMLString:htmlStr baseURL:[[NSBundle mainBundle] bundleURL]];
}



- (void)dealloc {
    [dicJBXX release];
    [curData release];
    [_jsonString release];
    [super dealloc];
}


@end
