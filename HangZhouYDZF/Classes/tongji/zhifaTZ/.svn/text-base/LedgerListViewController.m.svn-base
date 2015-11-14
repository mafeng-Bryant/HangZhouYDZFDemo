//
//  LedgerListViewController.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LedgerListViewController.h"
#import "GMEPS_HZAppDelegate.h"
#import "UserInfo.h"
#import "UITableViewCell+Custom.h"
extern UserInfo *g_logedUserInfo;
extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation LedgerListViewController
@synthesize currentString;

@synthesize listTable;
@synthesize childView;
@synthesize _searchBar;
@synthesize pageCount,nodataWebView;

- (void)dealloc
{
    [nodataWebView release];
    [currentString release];
    [listTable release];
    [childView release];
    [_searchBar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)getwebservice:(NSString*)wrymc
{

    NSString *string = [NSString stringWithFormat:@"%d",currentPageIndex];
    if (string==nil) string = @"";
    NSString *param = [WebServiceHelper createParametersWithKey:@"bmbh" value:g_logedUserInfo.BMBH,@"number",string,@"dwmc",wrymc,@"ssqy",@"",@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    NSString *URL = [NSString  stringWithFormat:kLedger_URL ,g_appDelegate.ServerIP];
    WebServiceHelper *webservice = [[[WebServiceHelper alloc] initWithUrl:URL method:@"GetQYXXListIPDs_Log_UDID" view:self.view nameSpace:@"http://tempuri.org/" parameters:param delegate:self ] autorelease];
    webservice.hudTitle = @"正在获取执法任务数据，请稍候...";
    webservice.errMsg = @"获取执法任务数据失败，请检查网络后重试";
    [webservice run];
}

-(void)mcSearchBar{
    [allAry removeAllObjects];
    currentPageIndex = 1;
    [self getwebservice:_searchBar.text];
    [_searchBar resignFirstResponder];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    listTable.hidden = YES;
    self.title = @"执法任务列表";
    
    currentPageIndex = 1;
    allAry = [[NSMutableArray alloc] initWithCapacity:50];
    updateAllAry = [[NSMutableArray alloc] initWithCapacity:50];
    
    UIToolbar *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
    UIBarButtonItem *mcButton = [[UIBarButtonItem alloc] initWithTitle:@"查询" style:UIBarButtonItemStyleDone
                                                                target:self action:@selector(mcSearchBar)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 230.0, 0.0)];
    searchBar.placeholder = @"根据单位名称查询";
    searchBar.delegate = self;
    self._searchBar = searchBar;
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBar];
    [searchBar release];

    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:8];
    [buttons addObject:searchItem];
    [buttons addObject:mcButton];
    [mcButton release];
    [searchItem release];
    [tool setItems:buttons animated:NO];
    [buttons release];
    UIBarButtonItem *myBItem = [[UIBarButtonItem alloc] initWithCustomView:tool];
    self.navigationItem.rightBarButtonItem = myBItem;
    [myBItem release];
    [tool release];

    
    [self getwebservice:@""];
    

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - NSXMLParserDelegate

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
	if ([elementName isEqualToString:@"现场执法编号"])
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
        dicDate = [[NSMutableDictionary alloc]initWithCapacity:10];
	else 
		nParserStatus = -1;
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (nParserStatus >= 0)
		[currentString setString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    //NSString* test;
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
            pageCount = [copyStr intValue];
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
        [updateAllAry addObject:dicDate];
        dicDate = nil;
        [dicDate release];
    }
    
    nParserStatus = -1;
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [allAry removeLastObject];
    isLoading = NO;
    [listTable reloadData];
    
    
    if([allAry count] == 0){
        if(nodataWebView == nil){
            self.nodataWebView = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)] autorelease];
            [nodataWebView loadHTMLString:@"<CENTER>未查询到相关数据！</CENTER>" baseURL:nil];
            [self.view addSubview:nodataWebView];
        }
        nodataWebView.hidden = NO;
        
        listTable.hidden = YES;
    }else{
        listTable.hidden = NO;
         nodataWebView.hidden = YES;
    }
        
}



#pragma mark -
#pragma mark TableView DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [allAry count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//static NSString *TaskListCellIdentifier = @"TaskListCellIdentifier";
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
#pragma mark TableView Delegate Methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0&&indexPath.row!=[allAry count])
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    if (row<[allAry count]) {
        childView = [[TaskDetailsView alloc] initWithStyle:UITableViewStylePlain];
        
        childView.xczfbh = [[allAry objectAtIndex:row]objectForKey:@"XCZFBH"];
        childView.wrymc  = [[allAry objectAtIndex:row] objectForKey:@"DWMC"];
        
        [self.navigationController pushViewController:childView animated:YES];  
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	
	if (isLoading) return;
    if (currentPageIndex == pageCount)
        return;
    if (scrollView.contentSize.height - scrollView.contentOffset.y <= 850 ) {
        // Released above the header
		isLoading = YES;
        currentPageIndex++;
		[self getwebservice:self._searchBar.text];
    }
}


#pragma mark - UISearchBarDelegate

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
 /*   [allAry removeAllObjects];
    currentPageIndex = 1;
    [self getwebservice:searchBar.text];
  */
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

}


@end
