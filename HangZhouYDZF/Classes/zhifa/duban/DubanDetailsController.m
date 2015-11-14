//
//  DubanDetailsController.m
//  GMEPS_HZ
//
//  Created by chen on 11-10-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "DubanDetailsController.h"
#import "WebServiceHelper.h"
#import "GMEPS_HZAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"

extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;

extern sqlite3 *data_db;

@implementation DuBanDetailItem

@synthesize XH;
@synthesize BH;    
@synthesize HFXX;  
@synthesize HFSJ;  
@synthesize HFR;   
@synthesize HFRDW; 
@synthesize DWBH; 
@synthesize DWMC;

@end


@implementation DubanDetailsController
@synthesize aItem,myTableView,aryDetailItems,aDetailItem,curData,dicBumenName;
@synthesize currentIndex;


- (void)dealloc
{
    [aItem release];
    [myTableView release];
    [aryDetailItems release];
    [curData release];
    [dicBumenName release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(IBAction)btnFinishTask:(id)sender{
    bWebServiceForFinish = YES;
    NSMutableString *updateSql = [[NSMutableString alloc] initWithCapacity:100];    
    [updateSql appendFormat:@"update T_YDZF_DB_JBXX set DBRSFBJ='1',DBRBJSJ=sysdate,DBBJR='%@' where  BH='%@'",g_logedUserInfo.userName,aItem.BH];

    NSString* params2 = [WebServiceHelper createParametersWithKey:@"commandString"
                                                            value:updateSql,nil];
    NSString *URL2 = [NSString stringWithFormat:KQueueServiceURL,g_appDelegate.ServerIP];
    WebServiceHelper* webService2 = [[[WebServiceHelper alloc] initWithUrl:URL2
                                                                    method:@"ProcessQueue"
                                                                 nameSpace:KSoapNameSpace
                                                                parameters:params2 
                                                                  delegate:self] autorelease];
	webService2.hudTitle = @"正在发送结束督办任务请求，请稍候...";
    [webService2 run];
    [updateSql release];
}

/*
-(void)getBuMenDatas{
    
    self.dicBumenName = [NSMutableDictionary dictionaryWithCapacity:40];
    NSString *sqlStr = @"select * from T_ADMIN_RMS_ZZJG";
    const char *utfsql = [sqlStr cStringUsingEncoding:NSUTF8StringEncoding];
    
    sqlite3_stmt *statement; 
    if (sqlite3_prepare_v2(baseinfo_db, utfsql, -1, &statement, nil)==SQLITE_OK) { 

    }
    
    char *name;
    NSString *bmName = nil;
    NSString *bmbh= nil;
    while (sqlite3_step(statement)==SQLITE_ROW) { 
        
        name=(char *)sqlite3_column_text(statement, 1); 
        if (name != NULL) {
            
            bmName = [NSString stringWithCString:name  encoding:NSUTF8StringEncoding];
        }		
        
        name=(char *)sqlite3_column_text(statement, 3); 
        if (name != NULL) {            
            bmbh = [NSString stringWithCString:name  encoding:NSUTF8StringEncoding];
            
        }
        
        if(bmbh && bmName){
            [dicBumenName setObject:bmName forKey:bmbh];
            bmbh = nil;
            bmName = nil;
        }
        
        
    }
    
    sqlite3_finalize(statement);
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self getBuMenDatas];
    self.curData = [NSMutableString stringWithCapacity:100];
    self.aryDetailItems = [NSMutableArray arrayWithCapacity:10];
    bWebServiceForFinish = NO;
    NSString* params = [WebServiceHelper createParametersWithKey:@"bh"
														   value:aItem.BH,nil];

	NSString *URL = [NSString  stringWithFormat: KDBRW_URL,g_appDelegate.ServerIP];
    
	WebServiceHelper *webService = [[[WebServiceHelper alloc] initWithUrl:URL
												 method:@"GetDBRWDetail"
                                     view:self.view
											  nameSpace:KSoapNameSpace
											 parameters:params 
											   delegate:self] autorelease];
    webService.hudTitle = @"正在获取督办任务回复信息，请稍候...";
	[webService run];

    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [aryDetailItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 240;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    return 100;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return @"针对该任务的回复";

}

- (UITableViewCell*) getCell:(NSString*) CellIdentifier forTablieView:(UITableView*) tableView
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	return cell;
}

-(UILabel*)createCustomLabelWithRect:(CGRect)rect andValue:(NSString*)value
                              andTag:(int)tag{
    UILabel *titleLabel = [[[UILabel alloc] initWithFrame:rect] autorelease];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor blackColor]];
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.text = value;
    titleLabel.tag = tag;
    return titleLabel;
}


-(UITableViewCell*)makeSubCell:(UITableView *)tableView
					 withIndexPath:(NSIndexPath *)indexPath						
{
	UILabel* replyDate   = nil;
    UILabel* replyPerson = nil;
    UILabel* replyUnit= nil;
	UITextView* replyInfo = nil;
    UILabel* relatedCompany = nil;
    
	UITableViewCell* aCell = [self getCell:@"Cell_DubanDetail" forTablieView:tableView];
	
	if (aCell.contentView != nil)
	{
        replyDate = (UILabel *)[aCell.contentView viewWithTag:1];
        relatedCompany = (UILabel *)[aCell.contentView viewWithTag:2]; 
        replyPerson = (UILabel *)[aCell.contentView viewWithTag:3];
        replyUnit = (UILabel *)[aCell.contentView viewWithTag:4];
        replyInfo = (UITextView *)[aCell.contentView viewWithTag:5];
               
	}
	
	if (replyDate == nil) {
        CGRect rect1_1 = CGRectMake(5, 0, 80, 40);
        CGRect rect1_2 = CGRectMake(90, 0, 200, 40);
        CGRect rect2_1 = CGRectMake(5, 40, 80, 40);
        CGRect rect2_2 = CGRectMake(90, 40, 600, 40);
        CGRect rect3_1 = CGRectMake(5, 80, 80, 40);
        CGRect rect3_2 = CGRectMake(90, 80, 150, 40);
        CGRect rect3_3 = CGRectMake(250, 80, 150, 40);
        CGRect rect3_4 = CGRectMake(410, 80, 350, 40);
        CGRect rect4_1 = CGRectMake(5, 120, 80, 40);
        CGRect rect4_2 = CGRectMake(120, 125, 640, 115);
        
		UILabel *titleLabel = [self createCustomLabelWithRect:rect1_1
                                                     andValue:@"回复日期：" 
                                                       andTag:0];
		[aCell.contentView addSubview:titleLabel];
        
        UILabel *titleLabel2 = [self createCustomLabelWithRect:rect2_1
                                                      andValue:@"关联企业：" 
                                                        andTag:0];
        [aCell.contentView addSubview:titleLabel2];
        
        UILabel *titleLabel3 = [self createCustomLabelWithRect:rect3_1
                                                      andValue:@"回复人："
                                                        andTag:0];
        [aCell.contentView addSubview:titleLabel3];
        
        UILabel *titleLabel4 = [self createCustomLabelWithRect:rect3_3
                                                      andValue:@"回复人所属单位："
                                                        andTag:0];
        [aCell.contentView addSubview:titleLabel4];
        
        UILabel *titleLabel5 = [self createCustomLabelWithRect:rect4_1
                                                      andValue:@"回复信息：" 
                                                        andTag:0];
 
        [aCell.contentView addSubview:titleLabel5];
        
		
        replyDate = [self createCustomLabelWithRect:rect1_2
                                           andValue:@"" 
                                             andTag:1];
        [aCell.contentView addSubview:replyDate];
        
        relatedCompany = [self createCustomLabelWithRect:rect2_2
                                             andValue:@"" 
                                               andTag:2];
        [aCell.contentView addSubview:relatedCompany];
        
        replyPerson =[self createCustomLabelWithRect:rect3_2
                                            andValue:@"" 
                                              andTag:3];
        [aCell.contentView addSubview:replyPerson];
        
        
        replyUnit = [self createCustomLabelWithRect:rect3_4
                                           andValue:@"" 
                                             andTag:4];
        [aCell.contentView addSubview:replyUnit];
                        
        //[titleLabel release];
        //[titleLabel2 release];
        //[titleLabel3 release];
        //[titleLabel4 release];
        //[titleLabel5 release];
        //[replyDate release];
        //[replyPerson release];
        //[replyUnit release];
        //[relatedCompany release];
        
        replyInfo = [[UITextView alloc] initWithFrame:rect4_2];        
        [replyInfo setBackgroundColor:[UIColor clearColor]];    
        replyInfo.font = [UIFont fontWithName:@"Helvetica" size:15.0];;	
        replyInfo.autocorrectionType = UITextAutocorrectionTypeNo;
        replyInfo.autocapitalizationType= UITextAutocapitalizationTypeNone;
        replyInfo.tag = 5;
        replyInfo.editable = NO;
        [aCell addSubview:replyInfo];        
        [replyInfo release];	
	}
    
    DuBanDetailItem *aTmpItem = [aryDetailItems objectAtIndex:indexPath.row];
	if (replyDate != nil)	[replyDate setText:aTmpItem.HFSJ];
	if (relatedCompany != nil)	[relatedCompany setText:aTmpItem.DWMC];
	if (replyPerson != nil)	[replyPerson setText:aTmpItem.HFR];
	if (replyUnit != nil)	[replyUnit setText:aTmpItem.HFRDW];
	if (replyInfo != nil)	[replyInfo setText:aTmpItem.HFXX];
    
	aCell.accessoryType = UITableViewCellAccessoryNone;
	return aCell;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self makeSubCell:tableView withIndexPath:indexPath];    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

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

#pragma mark - UIAlertView Delegate 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

#define TAG_XH    0 
#define TAG_BH    1 //督办编号
#define TAG_HFXX  2 //回复信息
#define TAG_HFSJ  3 //回复时间
#define TAG_HFR   4 //回复人
#define TAG_HFRDW 5 //回复人单位编号
#define TAG_DWBH  6 //企业单位编号
#define TAG_DWMC  7  //单位名称



-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	if(bWebServiceForFinish)
        return;
	if ([elementName isEqualToString:@"XH"])
		nParserStatus = TAG_XH;	
	else if ([elementName isEqualToString:@"BH"])
		nParserStatus = TAG_BH;
	else if ([elementName isEqualToString:@"HFXX"])
		nParserStatus = TAG_HFXX;
	else if ([elementName isEqualToString:@"HFSJ"])
		nParserStatus = TAG_HFSJ;
	else if ([elementName isEqualToString:@"HFR"])
		nParserStatus = TAG_HFR;
	else if ([elementName isEqualToString:@"HFRDW"])
		nParserStatus = TAG_HFRDW;
    else if ([elementName isEqualToString:@"DWBH"])//
		nParserStatus = TAG_DWBH;
	else if ([elementName isEqualToString:@"DWMC"])
		nParserStatus = TAG_DWMC;

    
	else if ([elementName isEqualToString:@"TmpName"]) {
		aDetailItem = [[DuBanDetailItem alloc] init];
	}
	else {
		nParserStatus = -1;
	}
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (curData) 
		[curData appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if(bWebServiceForFinish){
        if([elementName isEqualToString:@"ProcessQueueResult"])
        {
            
            if([curData isEqualToString:@"true"])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FinishDuBanTask" object:nil];
                
                
                UIAlertView *alert = [[UIAlertView alloc] 
                                      initWithTitle:@"提示" 
                                      message:@"发送督办任务结束请求成功"  
                                      delegate:self 
                                      cancelButtonTitle:@"确定" 
                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
                
            }
            else {
                
                UIAlertView *alert = [[UIAlertView alloc] 
                                      initWithTitle:@"错误" 
                                      message:@"发送督办任务结束请求失败！"  delegate:self
                                      cancelButtonTitle:@"确定" 
                                      otherButtonTitles:nil];
                [[[alert subviews] objectAtIndex:2] setBackgroundColor:[UIColor colorWithRed:0.5 green:0.0f blue:0.0f alpha:1.0f]];
                [alert show];
                [alert release];
            }
            
        }
        return;
    }
    
	if (nParserStatus >=0 && aDetailItem) {
		switch (nParserStatus) {
                
			case TAG_XH:
				aDetailItem.XH = curData;
				break;
			case TAG_BH:
				aDetailItem.BH = curData;
				break;
			case TAG_HFXX:
				aDetailItem.HFXX =curData;
				break;
                
            case TAG_HFSJ:
				aDetailItem.HFSJ =curData;
				break;
			case TAG_HFR:
				aDetailItem.HFR = curData;
				break;
			case TAG_HFRDW:
				aDetailItem.HFRDW = curData;			
				break;
			case TAG_DWBH:
				aDetailItem.DWBH = curData;
				break;	       
            case TAG_DWMC:
				aDetailItem.DWMC = curData;
				break;

			default:
				break;
		
        }
		nParserStatus = -1;
	} else {
		if (aDetailItem && [elementName isEqualToString:@"TmpName"]){

            [aryDetailItems addObject:aDetailItem];
            [aDetailItem release];
		}
	}
	[curData setString:@""];
    
}


- (void)parserDidEndDocument:(NSXMLParser *)parser{

    if(!bWebServiceForFinish){
        if ([aryDetailItems count] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] 
                                  initWithTitle:@"提示" 
                                  message:@"没有该任务的回复信息！"  
                                  delegate:nil
                                  cancelButtonTitle:@"确定" 
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            [self.myTableView setHidden:YES];
        }
        else{
            [self.myTableView reloadData];
            [self.myTableView setHidden:NO];
        }
        
    }
    
}


@end
