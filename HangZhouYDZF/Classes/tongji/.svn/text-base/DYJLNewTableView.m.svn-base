//
//  DYJLNewTableView.m
//  GMEPS_HZ
//
//  Created by ihumor on 13-4-8.
//
//

#import "DYJLNewTableView.h"
#import "GMEPS_HZAppDelegate.h"
#import "UITableViewCell+Custom.h"
#import "GGDMJConfig.h"

extern GMEPS_HZAppDelegate *g_appDelegate;

@interface DYJLNewTableView ()

@end

@implementation DYJLNewTableView

@synthesize taskInfoItem;
@synthesize titleArr,valueArr,titleRight,valueRight;
@synthesize xczfbh,webservice,currentString;

#pragma mark - View lifecycle

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    NSString *param = [WebServiceHelper createParametersWithKey:@"xczfbh" value:self.xczfbh ,@"tableName",@"T_JCGL_XCZF_JBXX",nil];
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    webservice = [[[WebServiceHelper alloc] initWithUrl:URL method:@"GetChildsDetials" view:self.view nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self] autorelease];
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
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 8;
    }
    else if (section == 1) {
        return 7;
    }
    else{
        return 4;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"企业档案";
    }
    else if (section == 1) {
        return @"三废排放";
    }
    else{
        return @"监测与应急";
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 2 && indexPath.row == 3)
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
    UITableViewCell *cell;
    if(indexPath.section == 0){
        title = [titleArr objectAtIndex:row];
        value = [valueArr objectAtIndex:row];
        title2 = [titleRight objectAtIndex:row];
        value2 = [valueRight objectAtIndex:row];
        cell = [UITableViewCell makeSubCell:tableView withTitle:title title2:title2 value:value value2:value2 height:56];
    }
    else if(indexPath.section == 1){
        row += 8;
        title = [titleArr objectAtIndex:row];
        value = [valueArr objectAtIndex:row];
        title2 = [titleRight objectAtIndex:row];
        value2 = [valueRight objectAtIndex:row];
        cell = [UITableViewCell makeSubCell:tableView withTitle:title title2:title2 value:value value2:value2 height:56];
    }
    else{
        row+=15;
        if (row == [titleArr count])
            cell = [UITableViewCell makeSubCell:tableView withTitle:@"监察小结：" andText:taskInfoItem.jcxj height:200];
        else {
            title = [titleArr objectAtIndex:row];
            value = [valueArr objectAtIndex:row];
            title2 = [titleRight objectAtIndex:row];
            value2 = [valueRight objectAtIndex:row];
            cell = [UITableViewCell makeSubCell:tableView withTitle:title title2:title2 value:value value2:value2 height:56];
        }
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
    
}

#pragma mark - NSXMLParser Delegate Method

#define kXCZFBH 0
#define kDWMC 1
#define kDWDZ 2
#define kDWFZR 3
#define kDWLXDH 4
#define kHBFZR 5
#define kHBFZRDH 6
#define kSFHG 7
#define kSFZG 8
#define kSFDB 9
#define kZFXZ 10
#define kDCSJ 11
#define kDCJSSJ 12
#define kJCRBM 13
#define kJCR 14
#define kZJH 15
#define kLRR 16
#define kSFTJ 17
#define kCJR 18
#define kCJSJ 19
#define kXGR 20
#define kXGSJ 21
#define kGPSSWE 22
#define kGPSDWN 23
#define kSSHY 24
#define kNGQK 25
#define kSCQK 26
#define kCRCM 27
#define kYWFL 28
#define kCJHJ 29
#define kFSZYLY 30
#define kYPSL 31
#define kTZWRW 32
#define kCLFS 33
#define kXCPSQK 34
#define kFSSSYX 35
#define kGFPK 36
#define kWNCZFS 37
#define kFSTZJL 38
#define kFQZYLY 39
#define kCWSBSL 40
#define kXCQK 41
#define kZLFS 42
#define kFQLX 43
#define kYJTJ 44
#define kFQSSYX 45
#define kPFQK 46
#define kGFLX 47
#define kSFCS 48
#define kGFTZJL 49
#define kWFLX 50
#define kCSSL 51
#define kCCQK 52
#define kBQBS 53
#define kTZDJ 54
#define kZYLD 55
#define kTZSB 56
#define kSBLX 57
#define kYXQK 58
#define kSJ 59
#define kFZSS 60
#define kSJXQ 61
#define kYWJL 62
#define kYJSS 63
#define kYJYA 64
#define kYJWZ 65
#define kYLQK 66
#define kJCXJ 67
#define kSSQY 68
#define kXZJG 69
//#define KQLSX 70
#define KQYXZ 71
- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
    self.currentString = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"XCZFBH"])
		nParserStatus = kXCZFBH;
    if ([elementName isEqualToString:@"DWMC"])
		nParserStatus = kDWMC;
    if ([elementName isEqualToString:@"DWDZ"])
		nParserStatus = kDWDZ;
    if ([elementName isEqualToString:@"DWFZR"])
		nParserStatus = kDWFZR;
    if ([elementName isEqualToString:@"DWLXDH"])
		nParserStatus = kDWLXDH;
    if ([elementName isEqualToString:@"HBFZR"])
		nParserStatus = kHBFZR;
    if ([elementName isEqualToString:@"HBFZRDH"])
        nParserStatus = kHBFZRDH;
    if ([elementName isEqualToString:@"SFHG1"])
		nParserStatus = kSFHG;
    if ([elementName isEqualToString:@"SFZG1"])
		nParserStatus = kSFZG;
    if ([elementName isEqualToString:@"SFDB1"])
		nParserStatus = kSFDB;
    if ([elementName isEqualToString:@"ZFXZ"])
		nParserStatus = kZFXZ;
    if ([elementName isEqualToString:@"DCSJ"])
		nParserStatus = kDCSJ;
    if ([elementName isEqualToString:@"DCJSSJ"])
		nParserStatus = kDCJSSJ;
    if ([elementName isEqualToString:@"JCRBM"])
		nParserStatus = kJCRBM;
    if ([elementName isEqualToString:@"JCR"])
		nParserStatus = kJCR;
    if ([elementName isEqualToString:@"ZJH"])
		nParserStatus = kZJH;
    if ([elementName isEqualToString:@"LRR"])
		nParserStatus = kLRR;
    if ([elementName isEqualToString:@"ISSUBMIT1"])
		nParserStatus = kSFTJ;
    if ([elementName isEqualToString:@"CJR"])
		nParserStatus = kCJR;
    if ([elementName isEqualToString:@"CJSJ"])
		nParserStatus = kCJSJ;
    if ([elementName isEqualToString:@"XGR"])
		nParserStatus = kXGR;
    if ([elementName isEqualToString:@"XGSJ"])
		nParserStatus = kXGSJ;
    if ([elementName isEqualToString:@"GPSDWN"])
		nParserStatus = kGPSDWN;
    if ([elementName isEqualToString:@"GPSSWE"])
		nParserStatus = kGPSSWE;
    if ([elementName isEqualToString:@"SSHY"])
		nParserStatus = kSSHY;
    if ([elementName isEqualToString:@"NGQK"])
		nParserStatus = kNGQK;
    if ([elementName isEqualToString:@"SCQK"])
		nParserStatus = kSCQK;
    if ([elementName isEqualToString:@"CRCM"])
		nParserStatus = kCRCM;
    if ([elementName isEqualToString:@"YWFL"])
		nParserStatus = kYWFL;
    if ([elementName isEqualToString:@"CJHJ"])
		nParserStatus = kCJHJ;
    if ([elementName isEqualToString:@"FSZYLY"])
		nParserStatus = kFSZYLY;
    if ([elementName isEqualToString:@"YPSL"])
		nParserStatus = kYPSL;
    if ([elementName isEqualToString:@"TZWRW"])
		nParserStatus = kTZWRW;
    if ([elementName isEqualToString:@"CLFS"])
		nParserStatus = kCLFS;
    if ([elementName isEqualToString:@"XCPSQK"])
		nParserStatus = kXCPSQK;
    if ([elementName isEqualToString:@"FSSSYX"])
		nParserStatus = kFSSSYX;
    if ([elementName isEqualToString:@"GFPK"])
		nParserStatus = kGFPK;
    if ([elementName isEqualToString:@"WNCZFS"])
		nParserStatus = kWNCZFS;
    if ([elementName isEqualToString:@"FSTZJL"])
		nParserStatus = kFSTZJL;
    if ([elementName isEqualToString:@"FQZYLY"])
		nParserStatus = kFQZYLY;
    if ([elementName isEqualToString:@"CWSBSL"])
		nParserStatus = kCWSBSL;
    if ([elementName isEqualToString:@"XCQK"])
		nParserStatus = kXCQK;
    if ([elementName isEqualToString:@"ZLFS"])
		nParserStatus = kZLFS;
    if ([elementName isEqualToString:@"FQLX"])
		nParserStatus = kFQLX;
    if ([elementName isEqualToString:@"YJTJ"])
		nParserStatus = kYJTJ;
    if ([elementName isEqualToString:@"FQSSYX"])
		nParserStatus = kFQSSYX;
    if ([elementName isEqualToString:@"PFQK"])
		nParserStatus = kPFQK;
    if ([elementName isEqualToString:@"GFLX"])
		nParserStatus = kGFLX;
    if ([elementName isEqualToString:@"SFCS"])
		nParserStatus = kSFCS;
    if ([elementName isEqualToString:@"GFTZJL"])
		nParserStatus = kGFTZJL;
    if ([elementName isEqualToString:@"WFLX"])
		nParserStatus = kWFLX;
    if ([elementName isEqualToString:@"CSSL"])
		nParserStatus = kCSSL;
    if ([elementName isEqualToString:@"CCQK"])
		nParserStatus = kCCQK;
    if ([elementName isEqualToString:@"BQBS"])
		nParserStatus = kBQBS;
    if ([elementName isEqualToString:@"TZDJ"])
		nParserStatus = kTZDJ;
    if ([elementName isEqualToString:@"SBLX"])
		nParserStatus = kSBLX;
    if ([elementName isEqualToString:@"YXQK"])
		nParserStatus = kYXQK;
    if ([elementName isEqualToString:@"SJ"])
		nParserStatus = kSJ;
    if ([elementName isEqualToString:@"FZSS"])
		nParserStatus = kFZSS;
    if ([elementName isEqualToString:@"SJXQ"])
		nParserStatus = kSJXQ;
    if ([elementName isEqualToString:@"YWJL"])
		nParserStatus = kYWJL;
    if ([elementName isEqualToString:@"YJSS"])
		nParserStatus = kYJSS;
    if ([elementName isEqualToString:@"YJYA"])
		nParserStatus = kYJYA;
    if ([elementName isEqualToString:@"YJWZ"])
		nParserStatus = kYJWZ;
    if ([elementName isEqualToString:@"YLQK"])
		nParserStatus = kYLQK;
    if ([elementName isEqualToString:@"JCXJ"])
		nParserStatus = kJCXJ;
    if ([elementName isEqualToString:@"SSQY"])
		nParserStatus = kSSQY;
    if ([elementName isEqualToString:@"XZJG"])
		nParserStatus = kXZJG;
    if ([elementName isEqualToString:@"QYXZ"])
		nParserStatus = KQYXZ;
    
	if ([elementName isEqualToString:@"TmpName"])
	{
		taskInfoItem = [[TaskStatisticsItem alloc] initWithNone];
	}
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (nParserStatus >= 0){
        if ([string isEqualToString:@"(null)"]||string==nil)
            string = @"";
		[currentString appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if (nParserStatus >= 0){
		switch (nParserStatus) {
            case kXCZFBH:
                taskInfoItem.xczfbh = currentString;
                break;
                
            case kDWMC:
                taskInfoItem.dwmc = currentString;
                break;
                
            case kDWDZ:
                taskInfoItem.dwdz = currentString;
                break;
                
            case kDWFZR:
                taskInfoItem.dwfzr = currentString;
                break;
                
            case kDWLXDH:
                taskInfoItem.dwlxdh = currentString;
                break;
                
            case kHBFZR:
                taskInfoItem.hbfzr = currentString;
                break;
                
            case kHBFZRDH:
                taskInfoItem.hbfzrdh = currentString;
                break;
                
            case kSFHG:
                taskInfoItem.sfhg = currentString;
                break;
                
			case kSFZG:
                taskInfoItem.sfzg = currentString;
                break;
                
            case kSFDB:
                taskInfoItem.sfdb = currentString;
                break;
                
            case kZFXZ:{
                NSString *copyString = [currentString copy];
                taskInfoItem.zfxz = [GGDMJConfig getDMNRByDMJBH:@"JCSY" andDM:copyString];
                [copyString release];
            }
                break;
                
            case kDCSJ:
                taskInfoItem.dcsj = [currentString substringToIndex:16];
                break;
                
            case kDCJSSJ:
                taskInfoItem.dcjssj = [currentString substringToIndex:16];
                break;
                
            case kJCRBM:
                taskInfoItem.jcrbm = currentString;
                break;
                
            case kJCR:
                taskInfoItem.jcr = currentString;
                break;
                
            case kZJH:
                taskInfoItem.zjh = currentString;
                break;
                
            case kLRR:
                taskInfoItem.lrr = currentString;
                break;
                
            case kSFTJ:
                taskInfoItem.issubmit = currentString;
                break;
                
            case kCJR:
                taskInfoItem.cjr = currentString;
                break;
                
            case kCJSJ:
                taskInfoItem.cjsj = [currentString substringToIndex:16];
                break;
                
            case kXGR:
                taskInfoItem.xgr = currentString;
                break;
                
            case kXGSJ:
                taskInfoItem.xgsj = [currentString substringToIndex:16];
                break;
                
            case kGPSDWN:
                taskInfoItem.gpsdwn = currentString;
                break;
                
            case kGPSSWE:
                taskInfoItem.gpsswe = currentString;
                break;
                
            case kSSHY: {
                NSString *copyString = [currentString copy];
                taskInfoItem.sshy = [GGDMJConfig getDMNRByDMJBH:@"SSHY" andDM:copyString];
                [copyString release];
            }
                break;
                
            case kNGQK:
                taskInfoItem.ngqk = currentString;
                break;
                
            case kSCQK:
                taskInfoItem.scqk = currentString;
                break;
                
            case kCRCM:
                taskInfoItem.crcm = currentString;
                break;
                
            case kYWFL:
                taskInfoItem.ywfl = currentString;
                break;
                
            case kCJHJ:
                taskInfoItem.cjhj = currentString;
                break;
                
            case kFSZYLY:
                taskInfoItem.fszyly = currentString;
                break;
                
            case kYPSL:
                taskInfoItem.ypsl = currentString;
                break;
                
            case kTZWRW:
                taskInfoItem.tzwrw = currentString;
                break;
                
            case kCLFS:
                taskInfoItem.clfs = currentString;
                break;
                
            case kXCPSQK:
                taskInfoItem.xcpsqk = currentString;
                break;
                
            case kFSSSYX:
                taskInfoItem.fsssyx = currentString;
                break;
                
            case kGFPK:
                taskInfoItem.gfpk = currentString;
                break;
                
            case kWNCZFS:
                taskInfoItem.wnczfs = currentString;
                break;
                
            case kFSTZJL:
                taskInfoItem.fstzjl = currentString;
                break;
                
            case kFQZYLY:
                taskInfoItem.fqzyly = currentString;
                break;
                
            case kCWSBSL:
                taskInfoItem.cwsbsl = currentString;
                break;
                
            case kXCQK:
                taskInfoItem.xcqk = currentString;
                break;
                
            case kZLFS:
                taskInfoItem.zlfs = currentString;
                break;
                
            case kFQLX:
                taskInfoItem.fqlx = currentString;
                break;
                
            case kYJTJ:
                taskInfoItem.yjtj = currentString;
                break;
                
            case kFQSSYX:
                taskInfoItem.fqssyx = currentString;
                break;
                
            case kPFQK:
                taskInfoItem.pfqk = currentString;
                break;
                
            case kGFLX:
                taskInfoItem.gflx = currentString;
                break;
                
            case kSFCS:
                taskInfoItem.sfcs = currentString;
                break;
                
            case kGFTZJL:
                taskInfoItem.gftzjl = currentString;
                break;
                
            case kWFLX:
                taskInfoItem.wflx = currentString;
                break;
                
            case kCSSL:
                taskInfoItem.cssl = currentString;
                break;
                
            case kCCQK:
                taskInfoItem.ccqk = currentString;
                break;
                
            case kBQBS:
                taskInfoItem.bqbs = currentString;
                break;
                
            case kTZDJ:
                taskInfoItem.tzdj = currentString;
                break;
                
            case kTZSB:
                taskInfoItem.tzsb = currentString;
                break;
                
            case kSBLX:
                taskInfoItem.sblx = currentString;
                break;
                
            case kYXQK:
                taskInfoItem.yxqk = currentString;
                break;
                
            case kSJ:
                taskInfoItem.sj = currentString;
                break;
                
            case kFZSS:
                taskInfoItem.fzss = currentString;
                break;
                
            case kSJXQ:
                taskInfoItem.sjxq = [currentString substringToIndex:10];
                break;
                
            case kYWJL:
                taskInfoItem.ywjl = currentString;
                break;
                
            case kYJSS:
                taskInfoItem.yjss = currentString;
                break;
                
            case kYJYA:
                taskInfoItem.yjya = currentString;
                break;
                
            case kYJWZ:
                taskInfoItem.yjwz = currentString;
                break;
                
            case kYLQK:
                taskInfoItem.ylqk = currentString;
                break;
                
            case kJCXJ:
                taskInfoItem.jcxj = currentString;
                break;
                
            case kSSQY: {
                
                taskInfoItem.ssqy = [GGDMJConfig getDMNRByDMJBH:@"SSQY" andDM:currentString];
            }
                break;
                
            case kXZJG:
                taskInfoItem.xzjg = [GGDMJConfig getDMNRByDMJBH:@"XZJG" andDM:currentString];
                break;
                
            case KQYXZ:
                taskInfoItem.qyxz = [GGDMJConfig getDMNRByDMJBH:@"QYXZ" andDM:currentString];
                break;
                
			default:
				break;
		}
		[self.currentString setString:@""];
		nParserStatus = -1;
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    self.titleArr = [NSArray arrayWithObjects:@"权力事项：",@"企业名称：",@"法人：",@"环保管理人：",@"检查时间：",@"检查人：",@"记录人：",@"GPS点位N：",@"所属行业：",@"生产情况：",@"排水情况：",@"废水设施运行：",@"药剂添加：",@"三防措施：",@"标志标识：",@"设备类型：",@"运行情况：",@"设施物资：", nil];
    
    self.titleRight = [NSArray arrayWithObjects:@"企业现状：",@"地址：",@"区域：",@"联系电话：",@"检查结束时间：",@"检查事由：",@"纳管情况：",@"GPS点位E：",@"雨污分流：",@"排口规范：",@"废气类型：",@"废气设施运行：",@"存贮环境：",@"台账单据：",@"",@"建设安装：",@"应急预案：",@"应急演练：", nil];
    taskInfoItem.dcsj = [taskInfoItem.dcsj stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    taskInfoItem.dcjssj = [taskInfoItem.dcjssj stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    self.valueArr = [NSArray arrayWithObjects:taskInfoItem.xzjg,taskInfoItem.dwmc,taskInfoItem.dwfzr,taskInfoItem.hbfzr,taskInfoItem.dcsj,taskInfoItem.jcr,taskInfoItem.lrr,taskInfoItem.gpsdwn,taskInfoItem.sshy,taskInfoItem.scqk,taskInfoItem.xcpsqk,taskInfoItem.fsssyx,taskInfoItem.yjtj,taskInfoItem.sfcs,taskInfoItem.bqbs,taskInfoItem.sblx,taskInfoItem.yxqk,taskInfoItem.yjwz, nil];
    
    self.valueRight = [NSArray arrayWithObjects:taskInfoItem.qyxz,taskInfoItem.dwdz,taskInfoItem.ssqy,taskInfoItem.hbfzrdh,taskInfoItem.dcjssj,taskInfoItem.zfxz,taskInfoItem.ngqk,taskInfoItem.gpsswe,taskInfoItem.ywfl,taskInfoItem.gfpk,taskInfoItem.fqlx,taskInfoItem.fqssyx,taskInfoItem.ccqk,taskInfoItem.tzdj,@"",taskInfoItem.sj,taskInfoItem.yjya,taskInfoItem.ylqk, nil];
    
    [self.tableView reloadData];
}

@end
