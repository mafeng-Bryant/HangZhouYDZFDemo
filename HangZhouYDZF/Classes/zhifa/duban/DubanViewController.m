    //
//  DubanViewController.m
//  EPad
//
//  Created by chen on 11-9-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DubanViewController.h"
#import "LoginViewController.h"
#import "ReplyDubanController.h"
#import "DubanDetailsController.h"
#import "DubanFullInfoController.h"

extern UserInfo *g_logedUserInfo;
#import "GMEPS_HZAppDelegate.h"

extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation DubanViewController
@synthesize myTableView,curData,aInfoItem,aryTodoItems;
@synthesize arySendItems;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)finishDuBanTask:(NSNotification *)notification {
    NSIndexPath *currentIndex = [myTableView indexPathForSelectedRow];
    [arySendItems removeObjectAtIndex:currentIndex.row];
    [myTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishDuBanTask:) name:@"FinishDuBanTask" object:nil];
    
    
    self.curData = [NSMutableString stringWithCapacity:100];
    self.aryTodoItems = [NSMutableArray arrayWithCapacity:30];
    self.arySendItems = [NSMutableArray arrayWithCapacity:30];
    
    bToDoWebService = YES;
    NSString* params = [WebServiceHelper createParametersWithKey:@"bmbh"
														   value:g_logedUserInfo.BMBH,nil];
	NSString *URL = [NSString  stringWithFormat: KDBRW_URL,g_appDelegate.ServerIP];
                    
	WebServiceHelper *webService = [[[WebServiceHelper alloc] initWithUrl:URL
												 method:@"GetToDoDBRW"
                                                view:self.view 
											  nameSpace:KSoapNameSpace
											 parameters:params 
											   delegate:self] autorelease];
    webService.hudTitle = @"正在获取督办任务列表，请稍候...";
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



#define TAG_BH    1
#define TAG_DBBH  2 //督办编号
#define TAG_RWLX  3//任务类型
#define TAG_DWBH  4 //关联记录单位编号
#define TAG_DWMC  5 //关联记录单位名称
#define TAG_SZQY  6 //所在区域
#define TAG_SSJD  7 //所在街道
#define TAG_DBR   8  //督办人
#define TAG_DBRDWBH 9 //督办人单位编号
#define TAG_DBRDW   10 //督办人单位
#define TAG_JSR     11  //接收人
#define TAG_JSRDWBH 12
#define TAG_JSRDW   13
#define TAG_ZT      14
#define TAG_DBXX    15
#define TAG_DBSJ    16
#define TAG_QX      17
#define TAG_SFGLZF  18
#define TAG_DBRBJSJ 19 //督办人办结时间
#define TAG_JSRSFBJ 20
#define TAG_JSBJR   21
#define TAG_JSRBJSJ     22
#define TAG_DBRSFBJ 23
#define TAG_SFZB    24
#define TAG_DBBJR   25
#define TAG_YDBZ    26

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	
	if ([elementName isEqualToString:@"BH"])
		nParserStatus = TAG_BH;	
	else if ([elementName isEqualToString:@"DBBH"])
		nParserStatus = TAG_DBBH;
	else if ([elementName isEqualToString:@"RWLX"])
		nParserStatus = TAG_RWLX;
	else if ([elementName isEqualToString:@"SZQY"])
		nParserStatus = TAG_SZQY;
	else if ([elementName isEqualToString:@"SSJD"])
		nParserStatus = TAG_SSJD;
	else if ([elementName isEqualToString:@"DBR"])
		nParserStatus = TAG_DBR;
    else if ([elementName isEqualToString:@"DBRDWBH"])//
		nParserStatus = TAG_DBRDWBH;
	else if ([elementName isEqualToString:@"DBRDW"])
		nParserStatus = TAG_DBRDW;
	else if ([elementName isEqualToString:@"JSR"])
		nParserStatus = TAG_JSR;
	else if ([elementName isEqualToString:@"JSRDWBH"])
		nParserStatus = TAG_JSRDWBH;
	else if ([elementName isEqualToString:@"JSRDW"])
		nParserStatus = TAG_JSRDW;
    else if ([elementName isEqualToString:@"ZT"])//
		nParserStatus = TAG_ZT;
	else if ([elementName isEqualToString:@"DBXX"])
		nParserStatus = TAG_DBXX;
	else if ([elementName isEqualToString:@"DBSJ"])
		nParserStatus = TAG_DBSJ;
	else if ([elementName isEqualToString:@"QX"])
		nParserStatus = TAG_QX;
	else if ([elementName isEqualToString:@"SFGLZF"])
		nParserStatus = TAG_SFGLZF;
    else if ([elementName isEqualToString:@"DBRBJSJ"])//
		nParserStatus = TAG_DBRBJSJ;
	else if ([elementName isEqualToString:@"JSRSFBJ"])
		nParserStatus = TAG_JSRSFBJ;
	else if ([elementName isEqualToString:@"JSRBJSJ"])
		nParserStatus = TAG_JSRBJSJ;
	else if ([elementName isEqualToString:@"JSBJR"])
		nParserStatus = TAG_JSBJR;
    else if ([elementName isEqualToString:@"DBRSFBJ"])
		nParserStatus = TAG_DBRSFBJ;
    else if ([elementName isEqualToString:@"SFZB"])
		nParserStatus = TAG_SFZB;
    else if ([elementName isEqualToString:@"DBBJR"])
		nParserStatus = TAG_DBBJR;
    else if ([elementName isEqualToString:@"YDBZ"])
		nParserStatus = TAG_YDBZ;
        
	else if ([elementName isEqualToString:@"TmpName"]) {
		aInfoItem = [[DBRWInfoItem alloc] init];
        [aInfoItem resetValue];
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
	if (nParserStatus >=0 && aInfoItem) {
		switch (nParserStatus) {
                
			case TAG_BH:
				aInfoItem.BH = curData;
				break;
			case TAG_DBBH:
				aInfoItem.DBBH = curData;
				break;
			case TAG_RWLX:
				aInfoItem.RWLX =curData;
				break;
			case TAG_DWBH:
				aInfoItem.DWBH = curData;
				break;
			case TAG_DWMC:
				aInfoItem.DWMC = curData;			
				break;
			case TAG_SZQY:
				aInfoItem.SZQY = curData;
				break;	       
            case TAG_SSJD:
				aInfoItem.SSJD = curData;
				break;
			case TAG_DBR:
				aInfoItem.DBR = curData;
				break;
            case TAG_DBRDWBH:
				aInfoItem.DBRDWBH =curData;
				break;
			case TAG_DBRDW:
				aInfoItem.DBRDW = curData;
				break;
			case TAG_JSR:
				aInfoItem.JSR = curData;
				break;
			case TAG_JSRDWBH:
				aInfoItem.JSRDWBH = curData;			
				break;
			case TAG_JSRDW:
				aInfoItem.JSRDW = curData;
				break;
                
            case TAG_ZT:
				aInfoItem.ZT = curData;
				break;
			case TAG_DBXX:
				aInfoItem.DBXX = curData;			
				break;
			case TAG_DBSJ:
				aInfoItem.DBSJ = curData;
				break;    
              
            case TAG_QX:
                if([curData length] > 10)
                    aInfoItem.QX = [curData substringToIndex:10];
                else
                    aInfoItem.QX = curData;
				break;
			case TAG_SFGLZF:
				aInfoItem.SFGLZF = [curData isEqualToString:@"1"];			
				break;
			case TAG_DBRBJSJ:
				aInfoItem.DBRBJSJ = curData;
				break;
            case TAG_JSRSFBJ:
				aInfoItem.JSRSFBJ = [curData isEqualToString:@"1"];
				break;
			case TAG_JSBJR:
				aInfoItem.JSBJR = curData;			
				break;
			case TAG_JSRBJSJ:
				aInfoItem.JSRBJSJ = curData;
				break;
            case TAG_DBRSFBJ:
				aInfoItem.DBRSFBJ = [curData isEqualToString:@"1"];
				break;
            case TAG_SFZB:
				aInfoItem.SFZB = [curData isEqualToString:@"1"];
				break;
            case TAG_DBBJR:
				aInfoItem.DBBJR = curData;
				break;
            case TAG_YDBZ:
				aInfoItem.YDBZ = curData;
				break;  
			default:
				break;
		}
		nParserStatus = -1;
	} else {
		if (aInfoItem && [elementName isEqualToString:@"TmpName"]){
            if(bToDoWebService)
                [aryTodoItems addObject:aInfoItem];
            else
                [arySendItems addObject:aInfoItem];
            [aInfoItem release];
		}
	}
	[curData setString:@""];
		
}


- (void)parserDidEndDocument:(NSXMLParser *)parser{
    if(bToDoWebService)
    {
        bToDoWebService = NO;
        NSString* params = [WebServiceHelper createParametersWithKey:@"bmbh"
                                                               value:g_logedUserInfo.BMBH,nil];
        NSString *URL = [NSString  stringWithFormat: KDBRW_URL,g_appDelegate.ServerIP];
        
        WebServiceHelper *webService = [[[WebServiceHelper alloc] initWithUrl:URL
                                                     method:@"GetTSendedDBRW"
                                                     view:self.view
                                                  nameSpace:KSoapNameSpace
                                                 parameters:params 
                                                   delegate:self] autorelease];
        [webService run];
    }
    else
       [self.myTableView reloadData];
	
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section == 0)
        if ([aryTodoItems count]==0) {
            return 1;
        }
        else
            return [aryTodoItems count];
    else
        if ([arySendItems count]==0) {
            return 1;
        }
        else
            return [arySendItems count];
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0)
        return @"待办的督办任务";
    else
        return @"下发的督办任务";
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row%2 == 0)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    DBRWInfoItem *aItem ;
    if(indexPath.section == 0){
        if ([aryTodoItems count]==0||aryTodoItems == nil) {
            cell.textLabel.text = @"没有相关的任务";
            cell.detailTextLabel.text = @"";
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else{
            aItem = [aryTodoItems objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString  stringWithFormat:@"督办人：%@   督办单位：%@", aItem.DBR,aItem.DBRDW];
            cell.detailTextLabel.numberOfLines = 0;
            cell.detailTextLabel.text = aItem.DBXX;
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        }
    }
    else{
        if ([arySendItems count]==0||arySendItems == nil) {
            cell.textLabel.text = @"没有相关的任务";
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else{
            aItem = [arySendItems objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString  stringWithFormat:@"接收人：%@   接收单位：%@", aItem.JSR,aItem.JSRDW];
            
            cell.detailTextLabel.text = aItem.DBXX;
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    DBRWInfoItem *aItem ;
    if(indexPath.section == 0){
        aItem = [aryTodoItems objectAtIndex:indexPath.row];
    }
    else{
        aItem = [arySendItems objectAtIndex:indexPath.row];
    }
    
    DubanFullInfoController *controller = [[DubanFullInfoController alloc]
                                        initWithNibName:@"DubanFullInfoController" bundle:nil];
    controller.aItem =  aItem;
    
    [self.navigationController pushViewController:controller animated:YES];
    
    [controller release];
    
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    if(indexPath.section == 0){
        if ([aryTodoItems count] <= 0) {
            return;
        }
        ReplyDubanController *controller = [[ReplyDubanController alloc]
                                            initWithNibName:@"ReplyDubanController" bundle:nil];
        controller.aItem =  [aryTodoItems objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];
        
        [controller release];
    }
    else{
        if ([arySendItems count] <= 0) {
            return;
        }
        DubanDetailsController *controller = [[DubanDetailsController alloc]
                                            initWithNibName:@"DubanDetailsController" bundle:nil];
        controller.aItem =  [arySendItems objectAtIndex:indexPath.row];
        controller.currentIndex = indexPath.row;
        [self.navigationController pushViewController:controller animated:YES];
        
        [controller release];
    }
	
	
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [aryTodoItems removeAllObjects];
    [aryTodoItems release];
    [arySendItems release];
    [super dealloc];
}


@end
