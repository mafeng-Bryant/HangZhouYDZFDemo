//
//  UISendDubanController.m
//  GMEPS_HZ
//
//  Created by chen on 11-9-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UISendDubanController.h"
#import "GMEPS_HZAppDelegate.h"
#import "LoginViewController.h"
#import "GMEPS_HZAppDelegate.h"
#import "GUIDGenerator.h"
#import "SharedInformations.h"
#import <QuartzCore/QuartzCore.h>


extern GMEPS_HZAppDelegate *g_appDelegate;

extern sqlite3 *data_db;
extern UserInfo *g_logedUserInfo;

@implementation UISendDubanController
@synthesize  duBanRenField,dubanDWFiled;   
@synthesize jieShouRenField,jieShouDWField,jieShourenSJField;
@synthesize areaPickerView,streetPickerView,subjectField,typeSegment,contentText;  
@synthesize deadlineField;//,biluSegment,danweiField,yidianField,QYBH;
@synthesize webService,currentdata,btnSend,xzqhdmAry,areaNameAry,streetAry;
@synthesize dbdwBH,jsdwBH,bumenNameAry,bumenBHAry;
@synthesize wordsPopoverController,wordsSelectViewController;
@synthesize popController,streetBHAry;
@synthesize sffsdxSegment;
@synthesize PopPeopleController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    //[self update];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"uisendduban" object:nil];
}


- (void)dealloc
{
    if (currentdata) {
        [currentdata release];
    }
    if(webService)
        [webService release];

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark -
#pragma mark selectLinkManDelegate
- (void)returnContacts:(NSString *)users Numbers:(NSArray *)numbers{
    
    
    NSMutableString *numberStr = [NSMutableString string];
    
    for(int i =0;i <[numbers count];i++) {
        NSString *number  = [numbers objectAtIndex:i];
        if (i==0) {
            [numberStr appendString:number];
        }
        else {
            [numberStr appendFormat:@",%@",number];
        }
    }
    
    jieShouRenField.text = users;
    jieShourenSJField.text = numberStr;
    if (PopPeopleController) {
        [PopPeopleController dismissPopoverAnimated:YES];
    }
}

#pragma mark - View lifecycle

-(IBAction)choosePerson:(id)sender
{
    UIControl *control = (UIControl*)sender;
    currentTag = control.tag;
    
   
    
    if (PopPeopleController==nil) {
        ContactListViewController *contactViewController = [[ContactListViewController alloc] initWithStyle:UITableViewStylePlain];
        contactViewController.contactDelegate = self;
        contactViewController.contentSizeForViewInPopover = CGSizeMake(320, 480);
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:contactViewController];
        
        UIPopoverController *tmpPopover = [[UIPopoverController alloc] initWithContentViewController:controller];
        self.PopPeopleController = tmpPopover;
        
        [contactViewController release];
        [tmpPopover release];
        [controller release];
        
    }
    
    [self.PopPeopleController presentPopoverFromRect:control.frame
                                              inView:self.view
                            permittedArrowDirections:UIPopoverArrowDirectionLeft
                                            animated:YES];
    
}




//获取部门数据
-(void)getBuMenDatas{
    
    NSString *sqlStr = @"select * from T_ADMIN_RMS_ZZJG order by PXH";
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
							   permittedArrowDirections:UIPopoverArrowDirectionUp
											   animated:YES];
}

- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row{
	if (currentTag == 1) {
        dubanDWFiled.text = words;
        self.dbdwBH = [bumenBHAry objectAtIndex:row];
    }
    else{
        jieShouDWField.text = words;
        self.jsdwBH = [bumenBHAry objectAtIndex:row];
    }
	if (wordsPopoverController != nil) {
		[wordsPopoverController dismissPopoverAnimated:YES];
	}
}

-(void)saveBilu:(id)sender
{
    recordStatus = Record_SaveLocal;
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"提示" 
                          message:@"把数据暂存在本地吗？"  
                          delegate:self
                          cancelButtonTitle:@"确定" 
                          otherButtonTitles:@"取消",nil];
    [alert show];
    [alert release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (recordStatus == Record_SaveLocal) {
        if (buttonIndex == 0) {
            SharedInformations *info = [SharedInformations sharedSharedInformations];
            //[info.dicStoreTempData removeAllObjects];
            [info.dicStoreTempData setValue:self forKey:@"UISendDubanController"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if(buttonIndex == 1){
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self sendTask:nil];
        }
    }
    else if(recordStatus == Record_Commited_Success)
    {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }

    }
    
    
}

-(void)backItemPressed{
    if(recordStatus == Record_Commited_Success)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }

    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:@"督办任务暂未发送，确认返回主界面"
                          delegate:self
                          cancelButtonTitle:@"确认"
                          otherButtonTitles:@"取消",nil];
    alert.alpha = 1.0f;
    [alert show];
    [alert release];
    return;
    
}

-(void)sqlDate:(NSString*)sender
{
    NSMutableString *sqlStr = [NSMutableString stringWithFormat:@"select * from T_COMN_XZQHDM where FDM='%@'",sender];
    
    const char *utfsql = [sqlStr cStringUsingEncoding:NSUTF8StringEncoding];
    
    sqlite3_stmt *statement; 
    if (sqlite3_prepare_v2(data_db, utfsql, -1, &statement, nil)==SQLITE_OK) { 
        
    }
    
    
    char *name;
    NSString *text;
    [streetAry removeAllObjects];
    //[streetAry addObject:@"不限"];
    [streetBHAry  removeAllObjects];
    //[streetBHAry addObject:@""];
    
    while (sqlite3_step(statement)==SQLITE_ROW) { 
        
        name=(char *)sqlite3_column_text(statement, 1); 
        if (name != NULL) {
            
            text = [NSString stringWithCString:name  encoding:NSUTF8StringEncoding];
            [streetAry addObject:text];
        }		
        
        name=(char *)sqlite3_column_text(statement, 0); 
        if (name != NULL) {
            
            text = [NSString stringWithCString:name  encoding:NSUTF8StringEncoding];
            [streetBHAry addObject:text];
        }	
        
        
    }
    
    sqlite3_finalize(statement);

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    recordStatus = Record_None;
    dicSsjd = [[NSMutableDictionary alloc] initWithCapacity:10];
    //bCommited = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backItemPressed)];
    
    NSArray *ary = [[NSArray alloc] initWithObjects:@"上城区",
                           @"下城区", @"江干区",@"拱墅区",@"西湖区",@"下沙区",@"滨江区",@"萧山区",@"余杭区",@"桐庐县",@"淳安县",@"建德市",@"富阳市",@"临安市",@"西湖名胜风景区",nil];
	self.areaNameAry = ary;
	[ary release];
	
	self.xzqhdmAry =[NSArray arrayWithObjects:@"330102000",@"330103000",@"330104000",@"330105000",@"330106000",@"330107000",@"330108000", @"330109000", @"330110000", @"330122000", @"330127000",@"330182000",@"330183000",@"330185000",@"330111000",
                     nil];
    
    self.streetAry   = [NSMutableArray arrayWithCapacity:30];
    self.streetBHAry = [NSMutableArray arrayWithCapacity:30];
    
    //[streetAry addObject:@"不限"];
    self.bumenBHAry = [NSMutableArray arrayWithCapacity:60];
    self.bumenNameAry = [NSMutableArray arrayWithCapacity:60];
  
    self.dbdwBH =  g_logedUserInfo.BMBH;
    duBanRenField.text = g_logedUserInfo.userName;
    dubanDWFiled.text  = g_logedUserInfo.userDanwei;
    
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
    
    PopupDateViewController *dateController = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDateAndTime];
	dateController.delegate = self;
	
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
	
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	[popover release];
	[nav release];
    

    [self sqlDate:[self.xzqhdmAry objectAtIndex:0]];//开始显示第一个区的值
    contentText.layer.borderColor = UIColor.grayColor.CGColor;  //textview边框颜色
    contentText.layer.borderWidth = 2;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"uisendduban" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(update) name:@"uisendduban" object:nil];
}

- (void)update
{
    SharedInformations *info = [SharedInformations sharedSharedInformations];
    //[info.dicStoreTempData removeAllObjects];
    [info.dicStoreTempData setValue:self forKey:@"UISendDubanController"];
}


-(IBAction)sendTask:(id)sender{
    if([dubanDWFiled.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"错误"
                              message:@"请填写督办单位"  delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }

    if([jieShouDWField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"错误"
                              message:@"请选择接收单位"  delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
    if([jieShourenSJField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"错误"
                              message:@"请输入接收人手机号码"  delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }

    
    if([deadlineField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"错误" 
                              message:@"请填写期限"  delegate:self
                              cancelButtonTitle:@"确定" 
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }

        NSRange range=[jieShourenSJField.text rangeOfString:@","];
    NSArray *ary = [jieShourenSJField.text componentsSeparatedByString:@","];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[1]+[3,5,8]+[0-9]*$"];  
    BOOL isMatch            = [predicate evaluateWithObject:jieShourenSJField.text]; 
    if (!range.location!=NSNotFound) {
        if (jieShourenSJField.text.length!=11) {
            UIAlertView *alert = [[UIAlertView alloc] 
                                  initWithTitle:@"错误" 
                                  message:@"输入的手机号码要为11位数字"  delegate:nil
                                  cancelButtonTitle:@"确定" 
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            return;

        
        }
        
        if (isMatch==NO) {
            UIAlertView *alert = [[UIAlertView alloc] 
                                  initWithTitle:@"错误" 
                                  message:@"输入的手机号码都要为数字和前3位格式要正确"  delegate:nil
                                  cancelButtonTitle:@"确定" 
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            return;
            
            
        }

    }
    //NSLog(@"shuzu:%@",ary);
    for (int i = 0; i < [ary count]; i++) {
        NSString *str = [ary objectAtIndex:i];
        if (str.length !=11 ) {
            UIAlertView *alert = [[UIAlertView alloc] 
                                  initWithTitle:@"错误" 
                                  message:@"多个号码的位数都要为11位数字"  delegate:nil
                                  cancelButtonTitle:@"确定" 
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            return;
        }
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[1]+[3,5,8]+[0-9]*$"];  
        BOOL isMatch            = [predicate evaluateWithObject:str]; 
        if (isMatch == NO) {
            UIAlertView *alert = [[UIAlertView alloc] 
                                  initWithTitle:@"错误" 
                                  message:@"输入的接收人手机号码格式要正确"  delegate:nil
                                  cancelButtonTitle:@"确定" 
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            return;
        }

    }

    for (int i = 0; i<[areaNameAry count]; i++) {
        [dicSsjd setObject:[xzqhdmAry objectAtIndex:i] forKey:[areaNameAry objectAtIndex:i]];
    }
    
    
    NSString *BH = [GUIDGenerator generateBHByWryName:dubanDWFiled.text];
	NSMutableString *sql = [[NSMutableString alloc] initWithCapacity:400];    
	[sql appendString:@"insert into T_YDZF_DB_JBXX(BH,DBBH,RWLX,SZQY,SSJD,DBR,DBRDW,DBRDWBH,JSR,JSRSJ,SFFSDX,SFYFS,JSRDW,JSRDWBH,"
	 "ZT,DBXX,DBSJ,QX,SFGLZF,SFZB,ZBBH,DBRSFBJ,DBRBJSJ,DBBJR,JSRSFBJ,JSRBJSJ,JSBJR,CJR,CJSJ,XGR,ORGID,XGSJ) values("];
    int areaRow = [areaPickerView selectedRowInComponent:0];
	NSString *areaBH =[dicSsjd valueForKey:[areaNameAry objectAtIndex:areaRow]] ;//存储代码值
    int streetRow = [streetPickerView selectedRowInComponent:0];
    NSString *streetBH = @"";
    if([streetBHAry count] != 0)
        streetBH = [streetBHAry objectAtIndex:streetRow];
    NSString *strType = [typeSegment titleForSegmentAtIndex:typeSegment.selectedSegmentIndex];
    
	[sql appendFormat:@"'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%d','0','%@','%@',",BH,@"杭环督办",strType,areaBH,streetBH,duBanRenField.text,dubanDWFiled.text,dbdwBH, jieShouRenField.text,jieShourenSJField.text,sffsdxSegment.selectedSegmentIndex,jieShouDWField.text,jsdwBH];
	
	[sql appendFormat:@"'%@','%@',sysdate,to_date('%@' , 'yyyy-mm-dd hh24:mi'),'%@','%@',",subjectField.text,contentText.text,
	 deadlineField.text,@"0", @"0"];
    
    //转办编号 
    [sql appendFormat:@"'%@','%@','%@','%@','%@','%@','%@',",@"",@"0",
	 @"",@"", @"0",@"",@""];
    
    [sql appendFormat:@"'%@',sysdate,'%@','%@',sysdate)",g_logedUserInfo.userName,g_logedUserInfo.userName,g_logedUserInfo.userORGID];
    
    ////NSLog(@"ddd:%@",sql);
    NSString* params = [WebServiceHelper createParametersWithKey:@"commandString"
														   value:sql,@"userName",g_logedUserInfo.userName,nil];
	NSString *URL = [NSString stringWithFormat:KQueueServiceURL,g_appDelegate.ServerIP];
	webService = [[WebServiceHelper alloc] initWithUrl:URL
												method:@"ProcessQueue_Log"
                                                  view:self.view
											 nameSpace:KSoapNameSpace
											parameters:params 
											  delegate:self];
    webService.hudTitle = @"正在发送督办信息，请稍候...";
	[webService run];
    [sql release];
     
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{	
	if( [elementName isEqualToString:@"ProcessQueue_LogResult"])
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
	
	if(currentdata && [elementName isEqualToString:@"ProcessQueue_LogResult"])
	{
		
		if([currentdata isEqualToString:@"true"])
		{
            recordStatus = Record_Commited_Success;
			UIAlertView *alert = [[UIAlertView alloc] 
								  initWithTitle:@"提示" 
								  message:@"督办任务发送成功,是否返回主界面"  
								  delegate:self
								  cancelButtonTitle:@"确定"
								  otherButtonTitles:@"取消",nil];
			[alert show];
			[alert release];
            
			[btnSend setEnabled:NO];
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

//UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        return [areaNameAry  count];
    }
    else
        return [streetAry count];
}

//delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        
        NSString *str = [xzqhdmAry objectAtIndex:row];
        [self sqlDate:str];//从数据库里获取数据
        [streetPickerView reloadAllComponents];
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        return [areaNameAry  objectAtIndex:row];
    }
    else{
        return [streetAry objectAtIndex:row];
    }
}

//时间
-(IBAction)touchFromDate:(id)sender{
	UIButton *btn =(UIButton*)sender;
	[popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	currentTag = btn.tag;
}

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date{ 
	[popController dismissPopoverAnimated:YES];
	if (bSaved) {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
		NSString *dateString = [dateFormatter stringFromDate:date];
		[dateFormatter release];  
        deadlineField.text = dateString;
	}
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	return NO;
}

@end
