//
//  UISearchSitesController.m
//  GMEPS_HZ
//
//  Created by chen on 11-10-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UISearchSitesController.h"
#import "SharedInformations.h"
#import "DBHelper.h"
#import "GMEPS_HZAppDelegate.h"
#import "UserInfo.h"
#import "JSONKit.h"
#import "ZrsUtils.h"


#define DATA_UPDATE  1
#define DATA_REFRESH 2

extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;

@implementation UISearchSitesController
@synthesize dataResultArray,searchDataBar,delegate,bLastSelected,isEnable,lastCompanyName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [lastCompanyName release];
    [dataResultArray release];
    [searchDataBar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(IBAction)cancelSelect:(id)sender{
	[self dismissModalViewControllerAnimated:YES];
	[delegate returnSites:nil source:currentIndex];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [searchDataBar becomeFirstResponder];
}

-(void)refreshView:(UIRefreshControl *)refresh {
    if (refresh.refreshing) {
        
        refresh.attributedTitle = [[[NSAttributedString alloc] initWithString:@"更新数据中..."] autorelease];
        if (currentIndex == 0) {
            [self performSelector:@selector(updateWryList) withObject:nil afterDelay:2];
        }
        
        else {
            [self performSelector:@selector(updateSourceOfData) withObject:nil afterDelay:2];
        }
    
    }
}

- (void)filterSourceOfData:(NSString *)searchTxt{
    NSString *url = [NSString stringWithFormat:KExamine_URL,g_appDelegate.ServerIP];
    NSString *param = [WebServiceHelper createParametersWithKey:@"xmmc" value:searchTxt,@"strCount",@"",@"strPage",@"",@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    NSString *method = @"GetXMSPBasicInfo";
    
    webService = [[WebServiceHelper alloc] initWithUrl:url
                                                method:method
                                                  view:self.view
                                             nameSpace:KSoapNameSpace parameters:param
                                              delegate:self];
    webService.hudTitle = @"正在查询项目审批数据，请稍候...";
    [webService run];

}

- (void)updateSourceOfData{
    data_status = DATA_UPDATE;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *date = [userDefaults objectForKey:@"LastSyncTime"];
    if ([date isEqualToString:@""] || date == nil) {
        date = @"2013/01/01 12:00:00";
    }
    NSString *lastUpdated = [NSString stringWithFormat:@"上次更新： %@", date];
    self.refreshControl.attributedTitle = [[[NSAttributedString alloc] initWithString:lastUpdated] autorelease];
    
    NSString *url = [NSString stringWithFormat:KExamine_URL,g_appDelegate.ServerIP];
    NSString *param = [WebServiceHelper createParametersWithKey:@"xmmc" value:@"",@"strCount",@"",@"strPage",[NSString stringWithFormat:@"%d",currentPage],@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    NSString *method = @"GetXMSPBasicInfo";
    
    webService = [[WebServiceHelper alloc] initWithUrl:url
                                                method:method
                                             nameSpace:KSoapNameSpace parameters:param
                                              delegate:self];
    
    [webService run];
    
    currentPage++;

}

- (void)updateWryList{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *date = [userDefaults objectForKey:@"LastSyncTime"];
    if ([date isEqualToString:@""] || date == nil) {
        date = @"2013/01/01 12:00:00";
    }
    NSString *lastUpdated = [NSString stringWithFormat:@"上次更新： %@", date];
    self.refreshControl.attributedTitle = [[[NSAttributedString alloc] initWithString:lastUpdated] autorelease];
    DataSyncManager *syncManager = [[DataSyncManager alloc] init];
    syncManager.syncDelegate = self;
    [syncManager syncWryList];
   
    [self.tableView reloadData];
}

- (void)refreshSourceOfData:(NSString *)jsonStr {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *lastSyncTime = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    [userDefaults  setObject:lastSyncTime forKey:@"LastSyncTime"];

    if ([jsonStr isEqualToString:@"无数据"]) {
        isEmpty = YES;
        self.dataResultArray = nil;
        [self.tableView reloadData];
        return;
    }
    
    NSArray *aryTmp = [jsonStr objectFromJSONString];
    NSMutableArray *xmmcAry = [[NSMutableArray alloc] initWithCapacity:1];
    
    if(aryTmp){
        for(NSDictionary *dicItem in aryTmp){
           
            [xmmcAry addObject:dicItem];
        if (data_status == DATA_UPDATE) {
                [dataResultArray addObject:dicItem];
            }
        }
        
        if (data_status == DATA_REFRESH) {
             self.dataResultArray = xmmcAry;
        }
        
        [self.tableView reloadData];
       
    }
    [xmmcAry release];
    
   
     [self.refreshControl endRefreshing];
}


- (void)syncDataFinished {
    NSArray *resultAry = [[DBHelper sharedInstance] queryWryListByRule:g_logedUserInfo.userORGID];
    self.dataResultArray = [NSMutableArray arrayWithArray:resultAry];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

-(IBAction)otherComp:(id)sender{
    //[searchBar becomeFirstResponder];
    if ([searchDataBar.text isEqualToString:@""]||searchDataBar.text == nil) {
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"提示" 
                              message:@"企业名称不能为空"  
                              delegate:self 
                              cancelButtonTitle:@"确定" 
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;

    }
    NSMutableDictionary * dic = [[NSMutableDictionary alloc ]initWithCapacity:10];
    [dic setValue:searchDataBar.text forKey:@"WRYMC"];
    SharedInformations *info = [SharedInformations sharedSharedInformations];
    info.lastSelectedComany = dic;
    
    [delegate returnSites:dic source:currentIndex];
    [self dismissModalViewControllerAnimated:YES];
    [dic release];
}


- (void)switchDataSource:(UISegmentedControl *)sender {
    NSInteger index =  sender.selectedSegmentIndex;
   
    currentIndex = index;
    currentPage = 1;
    NSString *title = [sender titleForSegmentAtIndex:index];
    if ([title isEqualToString:@"项目审批"]) {
        data_status = DATA_REFRESH;
        NSString *url = [NSString stringWithFormat:KExamine_URL,g_appDelegate.ServerIP];
        NSString *param = [WebServiceHelper createParametersWithKey:@"xmmc" value:@"",@"strCount",@"",@"strPage",[NSString stringWithFormat:@"%d",currentPage],@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
        NSString *method = @"GetXMSPBasicInfo";

        webService = [[WebServiceHelper alloc] initWithUrl:url
                                                    method:method
                                                      view:self.view
                                                 nameSpace:KSoapNameSpace parameters:param
                                                       delegate:self];
        
        webService.hudTitle = @"正在获取项目审批数据，请稍候...";
        [webService run];
        currentPage ++;
    }
    else if([title isEqualToString:@"一源一档"]) {
        NSArray *resultAry = [[DBHelper sharedInstance] queryWryListByRule:g_logedUserInfo.userORGID];
        self.dataResultArray = [NSMutableArray arrayWithArray:resultAry];
        
        SharedInformations *info = [SharedInformations sharedSharedInformations];
        if (info.lastSelectedComany != nil) {
            bLastSelected = YES;
            self.lastCompanyName = [info.lastSelectedComany valueForKey:@"WRYMC"];
        }
        else
            bLastSelected = NO;
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    
//    self.navigationItem.titleView = searchBar;
    // Create a bar button item using the search bar as its view.
    currentIndex = 0;
    UISegmentedControl *selectSouce = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"一源一档",@"项目审批",nil]];
    [selectSouce setFrame:CGRectMake(0.0, 7, 200, 30)];
    selectSouce.segmentedControlStyle = UISegmentedControlStyleBar;
    selectSouce.selectedSegmentIndex = currentIndex;
    [selectSouce addTarget:self action:@selector(switchDataSource:) forControlEvents:UIControlEventValueChanged];
    selectSouce.hidden = !isEnable;
    
    
    self.navigationItem.titleView = selectSouce;
    
     //self.tableView.tableHeaderView = searchBar;
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithTitle:@"其它企业"
                                                                   style:UIBarButtonItemStyleDone  
                                                                  target:self action:@selector(otherComp:)];
    
    self.navigationItem.rightBarButtonItem =searchItem;
    [searchItem release];
    
    UIBarButtonItem *myBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered  
                                                             target:self action:@selector(cancelSelect:)];
	self.navigationItem.leftBarButtonItem = myBtn;
	[myBtn release];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.tintColor = [UIColor lightGrayColor];
    refresh.attributedTitle = [[[NSAttributedString alloc] initWithString:@"下拉更新数据"] autorelease];
    
    [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    [refresh release];
    
//    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
//    refresh.tintColor = [UIColor lightGrayColor];
//    refresh.attributedTitle = [[[NSAttributedString alloc] initWithString:@"Pull to Refresh"] autorelease];
//    [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
//    self.refreshControl = refresh;
//    [refresh release];

    
    NSArray *resultAry = [[DBHelper sharedInstance] queryWryListByRule:g_logedUserInfo.userORGID];
	self.dataResultArray = [NSMutableArray arrayWithArray:resultAry];

    SharedInformations *info = [SharedInformations sharedSharedInformations];
    if (info.lastSelectedComany != nil) {
        bLastSelected = YES;
        self.lastCompanyName = [info.lastSelectedComany valueForKey:@"WRYMC"];
    }
    else
        bLastSelected = NO;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if(bLastSelected && currentIndex == 0)
        return 2;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *content;
    if (bLastSelected) {
        if (indexPath.section == 0) {
            content = lastCompanyName;
        }
        else if([dataResultArray count] >= 1){
            NSDictionary *dic = [dataResultArray objectAtIndex:indexPath.row];
            content =  [dic objectForKey:@"WRYMC"];
        }
        else {
            return 44.0;
        }
    }
    
    else {
    NSDictionary *dic = [dataResultArray objectAtIndex:indexPath.row];
    
    if (currentIndex == 0) {
        content =  [dic objectForKey:@"WRYMC"];
    }
    else {
        content =  [dic objectForKey:@"XMMC"];
    }

    
   
    }
    CGFloat  cellHeight = [ZrsUtils calculateTextHeight:content byFontSize:14 andWidth:600];
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //if(indexPath.row%2 == 0)
    //    cell.backgroundColor = LIGHT_BLUE_UICOLOR;
     
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(bLastSelected){
        if(section == 0 && currentIndex == 0)
            return @"最近一次选择的污染源";
        else if(isEmpty)
            return @"没有查询到相关结果";
        else
            return @"搜索结果";
    }
    if(isEmpty)
        return @"没有查询到相关结果";
    else
        return @"搜索结果";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(bLastSelected && currentIndex ==0){
        if (section == 0) {
            return 1;
        }
        else
            return [dataResultArray count];
    }
    else 
        return [dataResultArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.numberOfLines = 0;
    
    if (bLastSelected && indexPath.section == 0 && currentIndex ==0) {
        cell.textLabel.text = lastCompanyName;
        
    }
    else{
        NSDictionary *dic = [dataResultArray objectAtIndex:indexPath.row];

        if (currentIndex == 0) {
           cell.textLabel.text =  [dic objectForKey:@"WRYMC"];
        }
        else {
            cell.textLabel.text =  [dic objectForKey:@"XMMC"];
        }
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSDictionary *dicWRY = nil;
  
    if(bLastSelected && indexPath.section == 0 && currentIndex ==0){
        SharedInformations *info = [SharedInformations sharedSharedInformations];
        dicWRY = info.lastSelectedComany;
    }
    else if(currentIndex == 0 ){
            dicWRY = [dataResultArray objectAtIndex:indexPath.row];
            SharedInformations *info = [SharedInformations sharedSharedInformations];
            info.lastSelectedComany = dicWRY;
    }
    else {
         dicWRY = [dataResultArray objectAtIndex:indexPath.row];
    }
    
     [delegate returnSites:dicWRY source:currentIndex];
    [self dismissModalViewControllerAnimated:YES];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (currentIndex == 0) {
        NSArray *resultAry = [[DBHelper sharedInstance] queryWryListByRule:g_logedUserInfo.userORGID Name:searchText];
        self.dataResultArray = [NSMutableArray arrayWithArray:resultAry];
        if ([resultAry count] >= 1) {
            isEmpty = NO;
        }
        else {
            isEmpty = YES;

        }
        [self.tableView reloadData];
    } 
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (currentIndex == 1) {
        [self filterSourceOfData:searchBar.text];
    }
}

#define PARSER_TABLE 1

#pragma mark -
#pragma mark NSXMLParser Delegate

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"GetXMSPBasicInfoResult"]){
        nParserStatus = PARSER_TABLE;
    }
	else
		nParserStatus = -1;
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (nParserStatus){
        if(curData == nil)
            curData = [[NSMutableString stringWithCapacity:100] retain];
		[curData appendString:string];
    }
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if (nParserStatus >= 0) {
        switch (nParserStatus) {
            case PARSER_TABLE:
                [self refreshSourceOfData:curData];
                break;
                
            default:
                break;
        }
    }
	
	[curData setString:@""];
    nParserStatus = -1;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [curData release];
    curData = nil;
}

@end
