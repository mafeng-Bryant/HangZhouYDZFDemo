//
//  RecentLawEnforcementViewController.m
//  GMEPS_HZ
//
//  Created by TianZhuLi on 14-3-24.
//
//

#import "RecentLawEnforcementViewController.h"

@interface RecentLawEnforcementViewController ()

@end

@implementation RecentLawEnforcementViewController
@synthesize currentPageIndex;
@synthesize dicDate;
@synthesize nParserStatus;
@synthesize currentString;
@synthesize allAry;
@synthesize webService;
@synthesize childView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithWRYBH:(NSString *)wrybh
{
    self = [super init];
    if (self) {
        [self setWRYBH:wrybh];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self setRequestForWRYMC:YES];
    allAry = [[NSMutableArray alloc] init];
    NSString* params = [WebServiceHelper createParametersWithKey:@"wrybh"
														   value:_WRYBH,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
	if (webService != nil) {
		[webService release];
	}
    
    NSString *URL = [NSString  stringWithFormat: kLedger_URL,g_appDelegate.ServerIP];
	webService = [[WebServiceHelper alloc] initWithUrl:URL
												method:@"GetQyxxZfjlList_Log_UDID"
                                                  view:self.view
											 nameSpace:KSoapNameSpace
											parameters:params
											  delegate:self];
	[webService run];

    
}
///**
// *  根据污染源的名称查找该污染源的相关执法记录
// *
// *  @param wrymc 污染源名称
// */
//-(void)getwebservice:(NSString*)wrymc
//{
//    
//    NSString *string = [NSString stringWithFormat:@"%d",currentPageIndex];
//    if (string==nil) string = @"";
//    NSString *params = [WebServiceHelper createParametersWithKey:@"bmbh" value:g_logedUserInfo.BMBH,@"number",string,@"dwmc",_WRYMC,@"ssqy",@"",@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
//    NSString *URL = [NSString  stringWithFormat:kLedger_URL ,g_appDelegate.ServerIP];
//    if (webService != nil) {
//		[webService release];
//	}
//    webService = [[[WebServiceHelper alloc] initWithUrl:URL method:@"GetQYXXListIPDs_Log_UDID" view:self.view nameSpace:@"http://tempuri.org/" parameters:params delegate:self ] autorelease];
//    webService.hudTitle = @"正在获取历史执法数据，请稍候...";
//    webService.errMsg = @"获取历史执法数据失败，请检查网络后重试";
//    [webService run];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 
#pragma mark NSXMLParserDelegate Methods

#define kXCZFBH 0
#define kDWBH   1
#define kDWMC   2
#define kDWDZ   3
#define kDCSJ   4
#define kDCJSSJ 5
#define kSFHG   6
#define kSFZG   7
#define kSFDB   8
#define kSFTJ   9
#define kSZJD   10
#define kSZXZQ  11
#define kJCR    12
#define kDQYM    13
#define kZYM    14

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.currentString = [NSMutableString string];
	nParserStatus = -1;
	
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if( [elementName isEqualToString:@"GetQyxxZfjlList_Log_UDIDResult"]) {
        nParserStatus = 15;//查
    }else if ([elementName isEqualToString:@"现场执法编号"])
		nParserStatus = kXCZFBH;
    else if ([elementName isEqualToString:@"企业名称"])
		nParserStatus = kDWMC;
    else if ([elementName isEqualToString:@"检查时间"])
		nParserStatus = kDCSJ;
    else if ([elementName isEqualToString:@"企业编号"])
        nParserStatus = kDWBH;
    else if ([elementName isEqualToString:@"企业地址"])
        nParserStatus = kDWDZ;
    else if ([elementName isEqualToString:@"检查结束时间"])
        nParserStatus = kDCJSSJ;
    else if ([elementName isEqualToString:@"是否合格"])
        nParserStatus = kSFHG;
    else if ([elementName isEqualToString:@"是否在管"])
        nParserStatus = kSFZG;
    else if ([elementName isEqualToString:@"是否督办"])
        nParserStatus = kSFDB;
    else if ([elementName isEqualToString:@"是否上传"])
        nParserStatus = kSFTJ;
    else if ([elementName isEqualToString:@"所在街道"])
        nParserStatus = kSZJD;
    else if ([elementName isEqualToString:@"所在区域"])
        nParserStatus = kSZXZQ;
    else if ([elementName isEqualToString:@"检查人"])
        nParserStatus = kJCR;
    else if ([elementName isEqualToString:@"当前页码"])
        nParserStatus = kDQYM;
    else if ([elementName isEqualToString:@"总页码"])
        nParserStatus = kZYM;
	else if ([elementName isEqualToString:@"TmpName"])
        dicDate = [[NSMutableDictionary alloc] initWithCapacity:10];
	else
		nParserStatus = -1;
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (nParserStatus >= 0)
		[currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if( [elementName isEqualToString:@"GetQyxxZfjlList_Log_UDIDResult"]) {
        _jsonString = [currentString copy];
    }
    switch (nParserStatus) {
		case kXCZFBH: {
            NSString *copyStr = [currentString copy];
            [dicDate setObject:copyStr forKey:@"XCZFBH"];
            [copyStr release];
        }
			break;
		case kDWMC: {
            NSString *copyStr = [currentString copy];
            [dicDate setObject:copyStr forKey:@"DWMC"];
            [copyStr release];
        }
			break;
        case kSZXZQ: {
            NSString *copyStr = [currentString copy];
            [dicDate setObject:copyStr forKey:@"SZXZQ"];
            [copyStr release];
        }
			break;
        case kDCSJ: {
            NSString *copyStr = [[currentString substringToIndex:16] copy];
            [dicDate setObject:copyStr forKey:@"DCSJ"];
            [copyStr release];
        }
			break;
        case kJCR: {
            NSString *copyStr = [currentString copy];
            [dicDate setObject:copyStr forKey:@"JCR"];
            [copyStr release];
        }
			break;
        case kDQYM: {
            NSString *copyStr = [currentString copy];
            currentPageIndex = [copyStr intValue];
            [copyStr release];
        }
			break;
        case kZYM: {
            NSString *copyStr = [currentString copy];
            //pageCount = [copyStr intValue];
            [copyStr release];
        }
			break;
    }
    if ([elementName isEqualToString:@"TmpName"]) {
        NSString *xczfbh = [dicDate objectForKey:@"XCZFBH"];
        if (xczfbh==nil||[xczfbh isEqualToString:@""]) {
            xczfbh = @"";
        }
        NSString *copyStr = [xczfbh copy];
        [dicDate setObject:copyStr forKey:@"XCZFBH"];
        [copyStr release];
        
        NSString *dwmc = [dicDate objectForKey:@"DWMC"];
        if (dwmc==nil||[dwmc isEqualToString:@""]) {
            dwmc = @"";
        }
        copyStr = [dwmc copy];
        [dicDate setObject:copyStr forKey:@"DWMC"];
        [copyStr release];
        
        NSString *ssqy = [dicDate objectForKey:@"SZXZQ"];
        if (ssqy==nil||[ssqy isEqualToString:@""]) {
            ssqy = @"";
        }
        copyStr = [ssqy copy];
        [dicDate setObject:copyStr forKey:@"SZXZQ"];
        [copyStr release];
        
        NSString *dcsj = [dicDate objectForKey:@"DCSJ"];
        if (dcsj==nil||[dcsj isEqualToString:@""]) {
            dcsj = @"";
        }
        dcsj = [dcsj stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
        [dicDate setObject:dcsj forKey:@"DCSJ"];
        
        NSString *jcr = [dicDate objectForKey:@"JCR"];
        if (jcr==nil||[jcr isEqualToString:@""]) {
            jcr = @"";
        }
        
        copyStr = [jcr copy];
        [dicDate setObject:copyStr forKey:@"JCR"];
        [copyStr release];
        
        [allAry addObject:dicDate];
        dicDate = nil;
        [dicDate release];
    }
    nParserStatus = -1;
    [currentString setString:@""];
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if ([allAry count] > 0) {
        [self.tableView reloadData];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"没有相关数据记录。"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
}
/**
 *  从json字符串中获取污染源的名称
 *
 *  @param JSONString json字符串
 *
 *  @return 污染源名称
 */
-(NSString *)getWRYMCFromJSON:(NSString *)JSONString
{
    NSArray *arr = [JSONString objectFromJSONString];
    NSDictionary *Dic = [arr lastObject];
    NSString *str = [[Dic objectForKey:@"WRYMC"] copy];
    return str;
}


#pragma mark -
#pragma mark UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allAry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
	NSUInteger row = [indexPath row];
    if (row <[allAry count]) {
        NSDictionary *tmp = [allAry objectAtIndex:row];
        
        NSString *jcrStr = [tmp objectForKey:@"JCR"];
        if (jcrStr==nil||[jcrStr isEqualToString:@"(null)"]) jcrStr=@"";
        NSString *jcr = [NSString stringWithFormat:@"检查人：%@",jcrStr];
        NSString *dcsj = [NSString stringWithFormat:@"检查时间：%@",[tmp objectForKey:@"DCSJ"]];
        NSString *ssqy = [NSString stringWithFormat:@"所属区域：%@",[tmp objectForKey:@"SZXZQ"]];
        NSString *dwmc = [NSString stringWithFormat:@"%d %@",row+1,[tmp objectForKey:@"DWMC"]];
        cell = [UITableViewCell makeSubCell:tableView withTitle:dwmc SubValue1:jcr SubValue2:dcsj SubValue3:ssqy];
        cell.imageView.image = [UIImage imageNamed:@"阅读.png"];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
	return cell;

}

#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0&&indexPath.row!=[allAry count])
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    if (row<[allAry count]) {
        childView = [[TaskDetailsView alloc] initWithStyle:UITableViewStylePlain];
        
        childView.xczfbh = [[allAry objectAtIndex:row]objectForKey:@"XCZFBH"];
        childView.wrymc  = [[allAry objectAtIndex:row] objectForKey:@"DWMC"];
        
        [self.navigationController pushViewController:childView animated:YES];
    }
}

- (void)dealloc
{
    [allAry removeAllObjects];
    [allAry release];
    [_WRYBH release];
    [_WRYMC release];
    [super dealloc];
}
@end
