//
//  ReplyDubanController.m
//  GMEPS_HZ
//
//  Created by chen on 11-9-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ReplyDubanController.h"
#import "LoginViewController.h"
#import "GMEPS_HZAppDelegate.h"
#import "GUIDGenerator.h"
#import <QuartzCore/QuartzCore.h>
extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;
extern sqlite3 *data_db;

@implementation ReplyDubanController
@synthesize  replyPerson,replyUnit,relpyInfo,relatedCompanies,zhuanBanPerson,zhuanBanUnit;
@synthesize currentdata,aItem;
@synthesize hfdwBH,jsdwBH,bumenNameAry,bumenBHAry;
@synthesize wordsSelectViewController,wordsPopoverController,btnReplySend;
@synthesize btnZhuanBanSend,isTaskFinished,ZBBH,companyBH;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [replyPerson release];
    [replyUnit release];
    [relpyInfo release];
    [relatedCompanies release];
    [zhuanBanUnit release];
    [zhuanBanPerson release];
    
    [aItem release];
    [hfdwBH release];
    [jsdwBH release];
    [bumenBHAry release];
    [bumenNameAry release];
    [wordsSelectViewController release];
    [btnReplySend release];
    [wordsPopoverController release];

    if (currentdata) {
        [currentdata release];
    }
    [ZBBH release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(IBAction)replyDuban:(id)sender{
    if ([replyPerson.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"请选择回复人"
                              delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    if ([replyUnit.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"请选择回复人单位"
                              delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    bReply = YES;
    [btnZhuanBanSend setEnabled:NO];
    NSString *xh = [GUIDGenerator generateBHByWryName:relatedCompanies.text];
    NSMutableString *sql = [[NSMutableString alloc] initWithCapacity:400];    
	[sql appendString:@"insert into T_YDZF_DB_ZB(XH,BH,HFXX,HFSJ,HFR,HFRDW,DWBH,DWMC,CJR,CJSJ,ORGID) values("];
    	    
	[sql appendFormat:@"'%@','%@','%@',sysdate,'%@','%@','%@','%@',",xh,aItem.BH,relpyInfo.text,replyPerson.text,replyUnit.text,companyBH,relatedCompanies.text];
    
    [sql appendFormat:@"'%@',sysdate,'%@')",g_logedUserInfo.userName,g_logedUserInfo.userORGID];
    
    
    NSString* params = [WebServiceHelper createParametersWithKey:@"commandString"
														   value:sql,nil];
	NSString *URL = [NSString stringWithFormat:KQueueServiceURL,g_appDelegate.ServerIP];
	webService = [[[WebServiceHelper alloc] initWithUrl:URL
												method:@"ProcessQueue"
											 nameSpace:KSoapNameSpace
											parameters:params 
											  delegate:self] autorelease];	
	[webService run];

    [sql release];
    
    
   
        
    
}

//获取部门数据
-(void)getBuMenDatas{
    
    NSString *sqlStr = @"select * from T_ADMIN_RMS_ZZJG  order by PXH";
    const char *utfsql = [sqlStr cStringUsingEncoding:NSUTF8StringEncoding];
    
    sqlite3_stmt *statement; 
    if (sqlite3_prepare_v2(data_db, utfsql, -1, &statement, nil)==SQLITE_OK) {
       
    }
    
    char *name;
    NSString *text;
    
    [bumenNameAry removeAllObjects];
    [bumenBHAry removeAllObjects];
    while (sqlite3_step(statement)==SQLITE_ROW) { 
        
        name=(char *)sqlite3_column_text(statement, 1); 
        if (name != NULL) {
            
            text = [NSString stringWithCString:name  encoding:NSUTF8StringEncoding];
            [bumenBHAry addObject:text];
        }		
        
        name=(char *)sqlite3_column_text(statement, 3); 
        if (name != NULL) {
            
            text = [NSString stringWithCString:name  encoding:NSUTF8StringEncoding];
            [bumenNameAry addObject:text];
        }
        
    }
    
    sqlite3_finalize(statement);
}

-(IBAction)btnSelectPressed:(id)sender{
	UIControl *ctrl = (UIControl*)sender;
    currentTag = ctrl.tag;
	
	[wordsSelectViewController.tableView reloadData];
	[self.wordsPopoverController presentPopoverFromRect:ctrl.frame
												 inView:self.view
							   permittedArrowDirections:(currentTag ==1?UIPopoverArrowDirectionUp:UIPopoverArrowDirectionDown)
											   animated:YES];
}

- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row{
	if (currentTag == 1) {
        replyUnit.text = words;
        self.hfdwBH = [bumenBHAry objectAtIndex:row];
    }
    else{
        zhuanBanUnit.text = words;
        self.jsdwBH = [bumenBHAry objectAtIndex:row];
    }
	if (wordsPopoverController != nil) {
		[wordsPopoverController dismissPopoverAnimated:YES];
	}
}

-(void)finishedTheTask{
    NSMutableString *updateSql = [[NSMutableString alloc] initWithCapacity:100];    
    [updateSql appendFormat:@"update T_YDZF_DB_JBXX set JSRSFBJ='1',JSRBJSJ=sysdate,JSBJR='%@' where  BH='%@'",replyPerson.text,aItem.BH];
    
    NSString* params2 = [WebServiceHelper createParametersWithKey:@"commandString"
                                                            value:updateSql,nil];
    NSString *URL2 = [NSString stringWithFormat:KQueueServiceURL,g_appDelegate.ServerIP];
    WebServiceHelper* webService2 = [[[WebServiceHelper alloc] initWithUrl:URL2
                                                                    method:@"ProcessQueue"
                                                                 nameSpace:KSoapNameSpace
                                                                parameters:params2 
                                                                  delegate:self] autorelease];	
    [webService2 run];
    [updateSql release];
}

-(IBAction)zhuanBanDuban:(id)sender{
    if (jsdwBH == nil || [replyUnit.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示" 
                              message:@"请选择接受人单位"  
                              delegate:nil 
                              cancelButtonTitle:@"确定" 
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
    bReply = NO;
    bAddNewZhuanBan = NO;
    [btnReplySend setEnabled:NO];
    self.ZBBH = [GUIDGenerator generateBHByWryName:relatedCompanies.text];
    NSMutableString *updateSql = [[NSMutableString alloc] initWithCapacity:100];    
    [updateSql appendFormat:@"update T_YDZF_DB_JBXX set SFZB='1',ZBBH='%@' where  BH='%@'",ZBBH,aItem.BH];
    
    NSString* params = [WebServiceHelper createParametersWithKey:@"commandString"
                                                           value:updateSql,nil];
    NSString *URL = [NSString stringWithFormat:KQueueServiceURL,g_appDelegate.ServerIP];
    webService = [[[WebServiceHelper alloc] initWithUrl:URL
                                                 method:@"ProcessQueue"
                                              nameSpace:KSoapNameSpace
                                             parameters:params
                                               delegate:self] autorelease];	
    [webService run];
    [updateSql release];

}

-(void)addNewZhuanBan{
    
    bAddNewZhuanBan = YES;
	NSMutableString *sql = [[NSMutableString alloc] initWithCapacity:400];    
	[sql appendString:@"insert into T_YDZF_DB_JBXX(BH,DBBH,RWLX,SZQY,SSJD,DBR,DBRDW,DBRDWBH,JSR,JSRDW,JSRDWBH,"
	 "ZT,DBXX,DBSJ,QX,SFGLZF,SFZB,ZBBH,DBRSFBJ,DBRBJSJ,DBBJR,JSRSFBJ,JSRBJSJ,JSBJR,CJR,CJSJ,XGR,ORGID,XGSJ) values("];
    
	[sql appendFormat:@"'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@',",ZBBH,@"杭环督办",aItem.RWLX,aItem.SZQY,aItem.SSJD,aItem.DBR,aItem.DBRDW,aItem.DBRDWBH,
     replyPerson.text,replyUnit.text,jsdwBH];
	
	[sql appendFormat:@"'%@','%@',sysdate,to_date('%@' , 'yyyy-mm-dd'),'%@','%@',",aItem.ZT,aItem.DBXX,
	 aItem.QX,@"0", @"0"];
    
    //转办编号 
    [sql appendFormat:@"'%@','%@','%@','%@','%@','%@','%@',",@"",@"0",
	 @"",@"", @"0",@"",@""];
    
    [sql appendFormat:@"'%@',sysdate,'%@','%@',sysdate)",g_logedUserInfo.userName,g_logedUserInfo.userName,g_logedUserInfo.userORGID];
    
    
    NSString* params = [WebServiceHelper createParametersWithKey:@"commandString"
														   value:sql,nil];
	NSString *URL = [NSString stringWithFormat:KQueueServiceURL,g_appDelegate.ServerIP];
	webService = [[WebServiceHelper alloc] initWithUrl:URL
												method:@"ProcessQueue"
											 nameSpace:KSoapNameSpace
											parameters:params 
											  delegate:self];	
	[webService run];
    //NSLog(@"%@",sql);
    [sql release];
    
   
}

-(void)returnSites:(NSDictionary*)values source:(NSInteger)type{
	if (values != nil) {
		
		self.companyBH  = [values objectForKey:@"WRYBH"];
		self.relatedCompanies.text = [values objectForKey:@"WRYMC"];
	}
}

-(IBAction)selectCompany:(id)sender{
	
	UISearchSitesController *formViewController = [[UISearchSitesController alloc] initWithNibName:@"UISearchSitesController" bundle:nil];
	[formViewController setDelegate:self];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:formViewController];
	nav.modalPresentationStyle =  UIModalPresentationFormSheet;
	[self presentModalViewController:nav animated:YES];
	nav.view.superview.frame = CGRectMake(30, 100, 700, 700);
	// nav.view.superview.center = self.view.center;
	
	[formViewController release];
	[nav release];
	
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bumenBHAry = [NSMutableArray arrayWithCapacity:60];
    self.bumenNameAry = [NSMutableArray arrayWithCapacity:60];
    [self getBuMenDatas];
	CommenWordsViewController *tmpController = [[CommenWordsViewController alloc] initWithNibName:@"CommenWordsViewController" bundle:nil ];
	tmpController.contentSizeForViewInPopover = CGSizeMake(320, 400);
	tmpController.delegate = self;
	tmpController.wordsAry = bumenNameAry;
    
    UIPopoverController *tmppopover = [[UIPopoverController alloc] initWithContentViewController:tmpController];
	self.wordsSelectViewController = tmpController;
    self.wordsPopoverController = tmppopover;
	
	[tmpController release];
    [tmppopover release];
    
    relpyInfo.layer.borderColor = UIColor.grayColor.CGColor;  //textview边框颜色
    relpyInfo.layer.borderWidth = 2;
    replyPerson.text = g_logedUserInfo.userName;
    replyUnit.text = g_logedUserInfo.userDanwei;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{	
	if( [elementName isEqualToString:@"ProcessQueueResult"])
	{
		self.currentdata = [NSMutableString string];
	} 
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (currentdata) 
		[currentdata appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	
	if(currentdata && [elementName isEqualToString:@"ProcessQueueResult"])
	{
		
		if([currentdata isEqualToString:@"true"])
		{
            if(bReply){
                
                if(isTaskFinished.on == YES){
                    isTaskFinished.on = NO;
                    [self finishedTheTask];
                    
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] 
                                          initWithTitle:@"提示" 
                                          message:@"数据已成功提交至服务器"  
                                          delegate:self 
                                          cancelButtonTitle:@"确定" 
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                    [btnReplySend setEnabled:NO];
                }
                
            }
            else{
                if(!bAddNewZhuanBan)
                    [self addNewZhuanBan];
                else{
                    UIAlertView *alert = [[UIAlertView alloc] 
                                          initWithTitle:@"提示" 
                                          message:@"数据已成功提交至服务器"  
                                          delegate:self 
                                          cancelButtonTitle:@"确定" 
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                    [btnZhuanBanSend setEnabled:NO];
                }
                    
                
            }
			
		}
		else {
			
			UIAlertView *alert = [[UIAlertView alloc] 
								  initWithTitle:@"错误" 
								  message:@"提交数据到服务器失败！"  delegate:self
								  cancelButtonTitle:@"确定" 
								  otherButtonTitles:nil];
            [[[alert subviews] objectAtIndex:2] setBackgroundColor:[UIColor colorWithRed:0.5 green:0.0f blue:0.0f alpha:1.0f]];
			[alert show];
			[alert release];
		}
		
	}
}

@end
