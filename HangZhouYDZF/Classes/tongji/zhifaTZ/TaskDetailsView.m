//
//  TaskDetailsView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TaskDetailsView.h"
#import "UITableViewCell+Custom.h"
#import "GMEPS_HZAppDelegate.h"
#import "QYPFTableView.h"
#import "FSCYTableView.h"
#import "JCBLTableView.h"
#import "ZFGZSTableView.h"
#import "JCYJSTableView.h"
#import "XWBLTableView.h"
#import "JSXMGZBTableView.h"
#import "GTMBase64.h"
#import "DYJLNewTableView.h"
#import "GGDMJConfig.h"
#import "HouseAndPublicArcVC.h"
#import "JanSheViewController.h"
#import "YingjiViewController.h"
#import "FieldInspectionVC.h"
#import "JianCeWaterViewController.h"
#import "JianCeSmokeViewController.h"
#import "UserInfo.h"
extern UserInfo *g_logedUserInfo;
extern GMEPS_HZAppDelegate *g_appDelegate;


@implementation TaskDetailsView
@synthesize xczfbh,wrymc;
@synthesize webservice,currentString,reponseDict;
@synthesize tableNames,aryAllDBTables,aryAllBiluNames,valueInfo;
@synthesize photoPopoverController,photoSelectViewController;
#pragma mark - Private methods


-(void)seePhoto:(id)sender{
    
    NSString* params =[WebServiceHelper createParametersWithKey:@"bh"
                                                    value:self.xczfbh,@"flag",@"ZFTZ",nil];
    
    NSString *URL = [NSString  stringWithFormat: PHOTO_URL,
                     g_appDelegate.ServerIP];
    NSString *method = @"GetEnforcementLedgerImage";
    webservice = [[WebServiceHelper alloc] initWithUrl:URL
                                                method:method
                                                  view:self.view
                                             nameSpace:KSoapNameSpace
                                            parameters:params
                                              delegate:self];
    
    webservice.hudTitle = @"正在获取勘验图，请稍候...";
    webservice.errMsg  = @"该次执法任务没有绘制勘验图";
    [webservice run];
    
    
}

-(void)localPhoto{
    
    SeePhotoViewController *seePhotoViewController = [[SeePhotoViewController alloc] initWithNibName:@"SeePhotoViewController" bundle:nil];
    seePhotoViewController.contentSizeForViewInPopover = CGSizeMake(700, 740);
    [self.navigationController pushViewController:seePhotoViewController animated:YES];
    [seePhotoViewController release];
   
}



#pragma mark - View lifecycle

- (void)dealloc
{

    [xczfbh release];
    [wrymc release];
    [webservice release];
    [currentString release];
    [tableNames release];
    [reponseDict release];
    [super dealloc];
}

- (void)putOnRecord{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定提交立案吗？" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    
    [alertView show];
    [alertView release];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //导航左边部分
    self.reponseDict = [NSMutableDictionary dictionary];
    self.aryAllBiluNames = [NSArray arrayWithObjects:@"现场监察记录", @"现场勘验记录",@"现场监察意见书",@"现场执法告知书",@"调查询问记录", @"企业评分表",@"污染源废水采样",@"建设项目跟踪",@"点源记录(历史)",@"工业项目三同时跟踪表",@"非工业项目三同时跟踪表",@"应急检查", @"在线打分(气)",@"在线打分(水)",nil];
    self.aryAllDBTables = [NSArray arrayWithObjects:@"T_YDZF_WRYXCJCJL",@"T_YDZF_KYBL",@"T_YDZF_XCJCYJSZ",@"T_YDZF_XCZFGZS",@"T_YDZF_DCXWBL",@"T_YDZF_QYPF",@"T_YDZF_WRYFSCY",@"T_YDZF_JSXMGZB",@"T_JCGL_XCZF_JBXX",@"T_YDZF_GYJSXMHJJCJL",@"T_YDZF_FDCGJJSXMHJJCJL",@"T_YDZF_QYHJYJJCB", @"T_YDZF_ZXXCDFB",@"T_YDZF_ZXXCDFB",nil];
    
    
    //导航右边部分
    UIToolbar* tools = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 190, 44)];
    [tools setTintColor:[self.navigationController.navigationBar tintColor]];
    [tools setAlpha:[self.navigationController.navigationBar alpha]];
    
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:8];
    
    UIBarButtonItem *anotherButton0 = [[UIBarButtonItem alloc] initWithTitle:@"查看勘验图" style:UIBarButtonItemStyleDone
                                                                      target:self action:@selector(seePhoto:)];
    
    UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                 target:self action:nil];
    fixedButton.width = 10.0f;
    anotherButton1 = [[UIBarButtonItem alloc] initWithTitle:@"立案" style:UIBarButtonItemStyleDone
                                                                      target:self action:@selector(putOnRecord)];
    [buttons addObject:anotherButton0];
    [buttons addObject:fixedButton];
    [buttons addObject:anotherButton1];
    
    [fixedButton release];
    [anotherButton0 release];
    [anotherButton1 release];
    
    [tools setItems:buttons animated:NO];
    
    
    UIBarButtonItem *myBtn = [[UIBarButtonItem alloc] initWithCustomView:tools];
    self.navigationItem.rightBarButtonItem = myBtn;
    [buttons release];
    [tools release];
    [myBtn release];
    
    NSString *param = [WebServiceHelper createParametersWithKey:@"xczfbh" value:self.xczfbh,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    NSString *method = @"GetDetailsByXCZFBHJson_Log_UDID";
    NSString *nameSpace = @"http://Services.MobileLaw.Powerdata.com/";
    
    webservice = [[WebServiceHelper alloc] initWithUrl:URL
                                                method:method
                                                  view:self.view
                                             nameSpace:nameSpace
                                            parameters:param
                                              delegate:self];
    
    webservice.hudTitle = @"正在请求污染源关联笔录数据，请稍候...";
    [webservice run];

    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSString *param = [WebServiceHelper createParametersWithKey:@"xczfbh" value:self.xczfbh,@"yhmc",g_logedUserInfo.YHID,@"orgid",g_logedUserInfo.userORGID, @"UDID",g_appDelegate.udid,nil];
        //    NSString *url = [g_appDelegate.ServerIP substringToIndex:18];
        NSString *serverIP = g_appDelegate.ServerIP;
        NSArray   *tmpAry = [serverIP componentsSeparatedByString:@"/"];
        serverIP = [tmpAry objectAtIndex:0];
        NSString *URL = [NSString  stringWithFormat:
                         @"http://%@/workflowManager/Workflow.asmx?",serverIP];
        webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"StartXzcfWorkflow_Log_UDID" view:self.view nameSpace:KSoapNameSpace parameters:param delegate:self];
        webservice.hudTitle = @"正在提交立案，请稍候...";
        [webservice run];
    }
}

#pragma mark - NSXMLParser Delegate Method
- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
    self.currentString = [NSMutableString string];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    currentNode = elementName;
    if([elementName isEqualToString:@"GetEnforcementLedgerImageResult"]){
        nParserStatus = 1;
    }else if([elementName isEqualToString:@"GetDetailsByXCZFBHJson_Log_UDIDResponse"])
        nParserStatus = 2;
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
    if(nParserStatus>0){
        
        [currentString appendString:string];
    }

if([currentNode isEqualToString:@"STATE"]) {
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    [reponseDict setObject:string forKey:@"status"];
}

if([currentNode isEqualToString:@"MSG"]) {
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    [reponseDict setObject:string forKey:@"msg"];
    
}

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"GetEnforcementLedgerImageResult"])
    {
        isPhoto = YES;
        NSData *data = [self.currentString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        data = [GTMBase64 decodeData:data];
        if ([data length] <=0 ) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"没有勘验图"
                                  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            return;
        }
        NSString* tmpDirectory  = [NSHomeDirectory()
                                   stringByAppendingPathComponent:@"Documents/tzPhoto.jpg"];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath: tmpDirectory])
            [manager removeItemAtPath:tmpDirectory error:NULL];
        
        NSURL *url = [NSURL fileURLWithPath:tmpDirectory];
        [data writeToURL:url atomically:NO];
        //self.currentString = nil;
        [self localPhoto];
        
    }
    else if([elementName isEqualToString:@"GetDetailsByXCZFBHJson_Log_UDIDResponse"])
	{
        self.tableNames = [NSMutableArray arrayWithCapacity:14];
        NSLog(@"%@",currentString);
         NSArray *dataInfo =  [NSJSONSerialization JSONObjectWithData:[currentString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if(dataInfo && [dataInfo count] >0){
            NSDictionary *dic = [dataInfo objectAtIndex:0];
            self.valueInfo = dic;
            if(valueInfo){
                for(int i = 1; i<=14;i++){
                    NSString *key = [NSString stringWithFormat:@"ZB%d",i];
                    if([[valueInfo objectForKey:key] length] > 0){
                        [self.tableNames addObject:[aryAllBiluNames objectAtIndex:i-1]];
                    }
                }
             
                if ([[self.valueInfo objectForKey:@"ISLA"] boolValue]) {
                    anotherButton1.enabled = NO;
                }
                else {
                    anotherButton1.enabled = YES;
                }
    
            }
        }
        
        
        [self.tableView reloadData];
        
    }
    if(nParserStatus <= 0)
        [currentString setString:@""];
    
    if ([elementName isEqualToString:@"StartXzcfWorkflow_Log_UDIDResult"]) {
        NSString *status = [reponseDict objectForKey:@"status"];
        if ([status boolValue]) {
            NSString *msg = [reponseDict objectForKey:@"msg"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"立案成功" message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
        else {
            NSString *msg = [reponseDict objectForKey:@"msg"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"立案失败" message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
       
        
    }
		
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    //NSLog(@"%@",tableNames);
    if (isPhoto == YES) {
        isPhoto = NO;
        return;
    }
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return  9;
    } else {
         return [tableNames count];
    }

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *headTitle;
    
    if (section == 0)
        headTitle = @"基本信息";
    else 
        headTitle = @"关联记录";
    
    return headTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    if(indexPath.section == 0){
        NSArray* titleArr0 = [NSArray arrayWithObjects:@"检查部门：",@"被检查单位：",@"地址：",@"所属区域：",@"管理类别：",@"所属行业：",@"法人代表：",@"联系电话：",@"环保负责人：",@"环保负责人电话：",@"检查人：",@"检查时间：", @"检查事由：",@"权利事项：",nil];
        
        NSArray* valueArr0 = [NSArray arrayWithObjects:@"JCRBM",@"DWMC",@"DWDZ",@"SSQY",@"GLLX",@"SSHY",@"DWFZR",@"DWLXDH",@"HBFZR",@"HBFZRDH",@"JCR",@"JCSJ",@"JCSY",@"QLSX",nil];
        
        

        if (indexPath.row <2 || indexPath.row >6) {
            NSString *title = [titleArr0 objectAtIndex:indexPath.row];
            NSString *value = @"";;
            if(indexPath.row ==  7){
                title = [titleArr0 objectAtIndex:12];
            }
            if (indexPath.row ==  8) {
                title = [titleArr0 objectAtIndex:13];
            }
            if(valueInfo){
                if(indexPath.row ==  7){
                    NSString *jcsyDM =  [valueInfo objectForKey:[valueArr0 objectAtIndex:12]];
                    NSArray *ary = [jcsyDM componentsSeparatedByString:@","];
                    NSMutableString *strTmp = [NSMutableString stringWithCapacity:30];
                    for(NSString *str in ary){
                        NSString *dmnr = [GGDMJConfig getDMNRByDMJBH:@"JCSY" andDM:str];
                        if([dmnr length] > 0){
                            if([strTmp length] > 0 )
                                [strTmp appendFormat:@",%@",dmnr];
                            else
                                [strTmp appendFormat:@"%@",dmnr];
                        }
                        
                    }
                    value = strTmp;
            
                }
                else if(indexPath.row ==  8){
                    
                    NSString *strDM = [valueInfo objectForKey:[valueArr0 objectAtIndex:13]];
                value = [GGDMJConfig getDMNRByDMJBH:@"XZJG" andDM:strDM];
                }
                else
                {
                   value = [valueInfo objectForKey:[valueArr0 objectAtIndex:indexPath.row]]; 
                }
            }
            
            cell =  [UITableViewCell makeSubCell:tableView withTitle:title value:value height:56];
        }
        else{
            //NSInteger index = 3+(indexPath.row-3)*2;
            NSInteger index = 2*(indexPath.row - 1);
           
    
            NSString *title1 = [titleArr0 objectAtIndex:index];
            NSString *value1 = @"";
            NSString *title2 = [titleArr0 objectAtIndex:index+1];
            NSString *value2 = @"";
            if(valueInfo){
                value1 = [valueInfo objectForKey:[valueArr0 objectAtIndex:index]];
                value2 = [valueInfo objectForKey:[valueArr0 objectAtIndex:index+1]];
                if ([title2 isEqualToString:@"检查时间："]) {
                    
                    NSInteger len = [value2 length];
                    value2 = [value2 substringWithRange:NSMakeRange(0, len-3)];
                    
                }
            }
            
            cell = [UITableViewCell makeSubCell:tableView withTitle:title1 title2:title2 value:value1 value2:value2 height:56];
        }
    }else{
        static NSString *CellIdentifier = @"Cell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.textLabel.text= [tableNames objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return;
    }
    NSString *name = [tableNames objectAtIndex:indexPath.row];
    int index = 0;
    for(NSString *str in aryAllBiluNames){
        if([str isEqualToString:name])
            break;
        index++;
    }
    if(index >=14)
        return;
    NSString *dbTable = [aryAllDBTables objectAtIndex:index];
    
    UIViewController *controller = nil;
    if ([name isEqualToString:@"企业评分表"]) {
        QYPFTableView *tmpController = [[QYPFTableView alloc] initWithNibName:@"QYPFTableView" bundle:nil];
        [tmpController setXczfbh:self.xczfbh];
        
        [tmpController setTableKey:dbTable];
        [tmpController initEntryWithNone];
        controller = tmpController;
        //[childView release];
        
    } else if ([name isEqualToString:@"污染源废水采样"]) {
        FSCYTableView *childView = [[FSCYTableView alloc] initWithNibName:@"FSCYTableView" bundle:nil] ;
        [childView setXczfbh:self.xczfbh];
        [childView setTableKey:dbTable];
        [childView initEntryWithNone];
        controller = childView;
        //[childView release];
        
    } else if ([name isEqualToString:@"现场勘验记录"]) {
        JCBLTableView *childView = [[JCBLTableView alloc] initWithNibName:@"JCBLTableView" bundle:nil] ;
        [childView setXczfbh:self.xczfbh];
        [childView setTableKey:dbTable];
        [childView initEntryWithNone];
        controller = childView;
        //[childView release];
        
    } else if ([name isEqualToString:@"现场执法告知书"]) {
        ZFGZSTableView *childView = [[ZFGZSTableView alloc] initWithNibName:@"ZFGZSTableView" bundle:nil] ;
        [childView setXczfbh:self.xczfbh];
        [childView setTableName:dbTable];
        [childView initEntryWithNone];
        controller = childView;
        
        
    } else if ([name isEqualToString:@"现场监察意见书"]) {
        JCYJSTableView *childView = [[JCYJSTableView alloc] initWithNibName:@"JCYJSTableView" bundle:nil] ;
        [childView setXczfbh:self.xczfbh];
        [childView setTableKey:dbTable];
        [childView initEntryWithNone];
        controller = childView;
    }
    else if ([name isEqualToString:@"调查询问记录"]) {
        XWBLTableView *childView = [[XWBLTableView alloc] initWithNibName:@"XWBLTableView" bundle:nil] ;
        [childView setXczfbh:self.xczfbh];
        [childView setTableKey:dbTable];
        [childView initEntryWithNone];
        controller = childView;
        
    }
//    else if ([name isEqualToString:@"建设项目跟踪"]) {
//        JSXMGZBTableView *childView = [[[JSXMGZBTableView alloc] initWithNibName:@"JSXMGZBTableView" bundle:nil] autorelease];
//        [childView setXczfbh:self.xczfbh];
//        [childView setTableKey:dbTable];
//        [childView initEntryWithNone];
//        controller = childView;
//    }
    else if([name isEqualToString:@"现场监察记录"]){
        FieldInspectionVC *childView = [[FieldInspectionVC alloc] init];
        [childView setXczfbh:self.xczfbh];
        childView.tableName = dbTable;
        childView.isHisRecord = YES;
        controller = childView;
    }
//    else if([name isEqualToString:@"点源记录(历史)"]){
//        DYJLNewTableView *childView = [[DYJLNewTableView alloc] initWithNibName:@"DYJLNewTableView" bundle:nil];
//        [childView setXczfbh:self.xczfbh];
//        controller = childView;
//    }
    else if ([name isEqualToString:@"工业项目三同时跟踪表"]) {
        JanSheViewController *childView = [[JanSheViewController alloc] initWithNibName:@"JanSheViewController" bundle:nil];
        [childView setXczfbh:self.xczfbh];
        childView.wrymc = 
        childView.tableName = dbTable;
        childView.isHisRecord = YES;
        controller = childView;
    }
    else if([name isEqualToString:@"非工业项目三同时跟踪表"]){
        HouseAndPublicArcVC *childView = [[HouseAndPublicArcVC alloc] init];
        [childView setXczfbh:self.xczfbh];
        childView.tableName = dbTable;
        childView.isHisRecord = YES;
        controller = childView;
    }
    else if([name isEqualToString:@"在线打分(水)"]) {
        JianCeWaterViewController *childView = [[JianCeWaterViewController alloc] initWithNibName:@"JianCeWaterViewController" bundle:nil];
        [childView setXczfbh:self.xczfbh];
        childView.wrymc = self.wrymc;
        childView.tableName = dbTable;
        childView.isHisRecord = YES;
        controller = childView;

    }
    else if ([name isEqualToString:@"在线打分(气)"]) {
        JianCeSmokeViewController *childView = [[JianCeSmokeViewController alloc] initWithNibName:@"JianCeSmokeViewController" bundle:nil];
        [childView setXczfbh:self.xczfbh];
        childView.wrymc = self.wrymc;
        childView.tableName = dbTable;
        childView.isHisRecord = YES;
        controller = childView;
    }
    
    else if([name isEqualToString:@"应急检查"]){
        YingjiViewController *childView = [[YingjiViewController alloc] init];
        [childView setXczfbh:self.xczfbh];
        childView.tableName = dbTable;
        childView.isHisRecord = YES;
        controller = childView;
    }
    
    if (controller) {
        controller.title = name;
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
}
@end
