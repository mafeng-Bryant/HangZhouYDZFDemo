//
//  ScoreViewController.m
//  EPad
//
//  Created by chen on 11-4-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScoreViewController.h"
#import "UISearchSitesController.h"
#import "GMEPS_HZAppDelegate.h"
#import "GUIDGenerator.h"
extern GMEPS_HZAppDelegate *g_appDelegate;
#import "SharedInformations.h"
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "DBHelper.h"
#import "OMGToast.h"
#define T_XCZF_PFB @"T_YDZF_PFB"
extern UserInfo *g_logedUserInfo;
@implementation XizeDetailItems
@synthesize reasons;
@synthesize aryDetailsIndex;
@end


#import "GTMBase64.h"
#import "JSONKit.h"

#define kWebService_Commit 2 //提交记录
@implementation ScoreViewController

@synthesize popController,itemsController,curScoreLabel;
@synthesize dicDetailReasons,itemsDic,myTableView,tableName;
@synthesize wrybh,wrymc,wrydz,xczfbh,QYMC,finishBarItem,aryBZTextView;
@synthesize arySectionTitles,arySectionSubItems;
@synthesize popRecordController,recordController,recordStatus;

#pragma mark -
#pragma mark View lifecycle
- (void)returnReasons:(NSString *)words
        andItemsIndex:(NSArray*)aryIndexes withIndex:(NSUInteger)keyIndex
{
	[popController dismissPopoverAnimated:YES];
    
	XizeDetailItems *aItem = [[XizeDetailItems alloc] init];
    if (words == nil)
        aItem.reasons = @"";
    else
        aItem.reasons = words;
    aItem.aryDetailsIndex = aryIndexes;
    
	NSString *strKey = [NSString stringWithFormat:@"%d",keyIndex];
	[dicDetailReasons setObject:aItem forKey:strKey];
    
	[aItem release];
	
	[self.myTableView reloadData];
}

-(void)selectSegment:(id)sender{
	UISegmentedControl *ctrl = (UISegmentedControl*)sender;
	NSInteger index = ctrl.tag;
	
	if (ctrl.selectedSegmentIndex == 1 && bItems[index]== NO) {
		
		bItems[index] = !bItems[index];
		
		int section = [self calculateSectionByIndex:index];
		//70+70 header footer
		CGRect frame = CGRectMake(500,index*70+section*(70+70), 600, 300);
		
		//frame.origin.x += 200;
		//frame.size.height += 300;
		id key = [NSString stringWithFormat:@"%d",index];
		if ([[itemsDic allKeys] containsObject:key]) {
			itemsController.itemsAry = [itemsDic objectForKey:key];
            itemsController.itemsIndex = index;
            [itemsController clearContents];
            itemsController.contentSizeForViewInPopover = CGSizeMake(320, 460);
            [itemsController.myTableView reloadData];
            
            [self.popController presentPopoverFromRect:frame
                                                inView:self.myTableView
                              permittedArrowDirections:UIPopoverArrowDirectionAny
                                              animated:YES];
		}
        //存储没有扣分原因或者不写扣分原因
        XizeDetailItems *aItem = [[XizeDetailItems alloc] init];
        aItem.reasons = @"";
        aItem.aryDetailsIndex = [NSArray arrayWithObject:@""];
        [dicDetailReasons setObject:aItem forKey:[NSString stringWithFormat:@"%d",index]];
        [aItem release];
        
	}
	else if (ctrl.selectedSegmentIndex == 0 && bItems[index]== YES){
		bItems[index] = FALSE;
		[self.myTableView reloadData];
        NSString *strKey = [NSString stringWithFormat:@"%d",index];
        [dicDetailReasons removeObjectForKey:strKey];
	}
	[self calculateScore];
}


-(void)returnSites:(NSDictionary*)values source:(NSInteger)type{
	if (values == nil) {
		[self.navigationController popViewControllerAnimated:YES];
	}
	else {
        if ([values count] == 1) {
            [btnTitleView setTitle:[values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.title = QYMC.text = [values objectForKey:@"WRYMC"];
            self.wrybh = @"";
            self.wrydz = @"";
        }
        else
        {
            self.wrybh  = [values objectForKey:@"WRYBH"];
            self.wrymc = self.title =QYMC.text = [values objectForKey:@"WRYMC"];;
            self.wrydz = [values objectForKey:@"DWDZ"];
            [btnTitleView setTitle: [values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
        }
        [self generateXCZFBH];
	}
}

-(void)selectPolutionSrc:(id)sender{
    isclear = YES;
    [myTableView reloadData];
	UISearchSitesController *formViewController = [[UISearchSitesController alloc] initWithNibName:@"UISearchSitesController" bundle:nil];
	[formViewController setDelegate:self];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:formViewController];
	nav.modalPresentationStyle =  UIModalPresentationFormSheet;
	[self presentModalViewController:nav animated:YES];
	nav.view.superview.frame = CGRectMake(30, 100, 700, 700);
	
	[formViewController release];
	[nav release];
	
}

-(void)sureCommitBilu
{
    //    NSString *BH = [[DBHelper sharedInstance] getXCZFBHByMc:QYMC.text];
    //    [[DBHelper sharedInstance] saveXCZFBH:BH Wrymc:QYMC.text TableName:@"T_YDZF_QYPF"];
    
    NSMutableArray *aryBiluSqls = [[[NSMutableArray alloc] initWithCapacity:50] autorelease];
	NSMutableString *sql = [[[NSMutableString alloc] initWithCapacity:400] autorelease];
	[sql appendString:@"insert into T_YDZF_QYPF(ORGID,BH,QYID,PFNRID,QYMC,QYDZ,KFS,KHXZ,BZ,CJSJ,CJR) values("];
    
    NSString *reason=nil;
    NSString *bz=nil;
	int totalScore = [self calculateScore];
    
	for (int i = 0; i < ITEMS_SUM; i++) {
        if (bItems[i]) {
            NSString *strKey = [NSString stringWithFormat:@"%d",i];
            int section = [self calculateSectionByIndex:i];
            bz = [[aryBZTextView objectAtIndex:section] text];
            XizeDetailItems *aItem = [dicDetailReasons objectForKey:strKey];
            if ([aItem.aryDetailsIndex count] > 0) {
                for (int j=0; j<[aItem.aryDetailsIndex count]; j++) {
                    reason = [aItem.aryDetailsIndex objectAtIndex:j];
                    [sql appendFormat:@"'%@','%@','%@','%d','%@','%@','%d','%@','%@',sysdate,'%@')",g_logedUserInfo.userORGID,self.xczfbh,wrybh,
                     i+1,QYMC.text,wrydz,totalScore,reason,bz,g_logedUserInfo.userName];
                    [aryBiluSqls addObject:[sql copy]];
                    
                    [sql setString:@"insert into T_YDZF_QYPF(ORGID,BH,QYID,PFNRID,QYMC,QYDZ,KFS,KHXZ,BZ,CJSJ,CJR) values("];
                    
                }
            }
            else{
                [sql appendFormat:@"'%@','%@','%@','%d','%@','%@','%d','%@','%@',sysdate,'%@')",g_logedUserInfo.userORGID,self.xczfbh,wrybh,
                 i+1,QYMC.text,wrydz,totalScore,@"",bz,g_logedUserInfo.userName];
                [aryBiluSqls addObject:[sql copy]];
                
                [sql setString:@"insert into T_YDZF_QYPF(ORGID,BH,QYID,PFNRID,QYMC,QYDZ,KFS,KHXZ,BZ,CJSJ,CJR) values("];
            }
        }
    }
    
    sumToCommit = [aryBiluSqls count];
    NSMutableString *sqlCommit = [NSMutableString stringWithCapacity:1];
    for (int i=0; i< [aryBiluSqls count]; i++) {
        NSString *sqlStr  =  [aryBiluSqls objectAtIndex:i];
        if (i == 0) {
            [sqlCommit appendString:sqlStr];
        }
        else {
            [sqlCommit appendFormat:@"^%@",sqlStr];
        }
        
        ////NSLog(@"%@",sqlStr);
    }
    
    NSString* params = [WebServiceHelper createParametersWithKey:@"cmdTexts"
                                                           value:sqlCommit,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    iWebServiceType = kWebService_Commit;
    NSString *URL = [NSString  stringWithFormat: KQueueServiceURL,g_appDelegate.ServerIP];
    WebServiceHelper *webService = [[[WebServiceHelper alloc] initWithUrl:URL
                                                    method:@"ProcessQueues_Ipad_Log_UDID"
                                                                     view:self.view
                                                                nameSpace:KSoapNameSpace
                                                               parameters:params
                                                                 delegate:self] autorelease];
    [webService run];

    
	//finishBarItem.enabled = NO;
    SharedInformations *info = [SharedInformations sharedSharedInformations];
	[info.dicStoreTempData removeAllObjects];
    
}

-(void)generateXCZFBH{
    if([[DBHelper sharedInstance] hasCommitBL:self.wrymc andTableName:self.tableName]){
        alertType = kAlert_GenXCZFBH;
        NSString *msg = @"该企业已经今天已做记录，需要做另外一份吗？";
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:msg
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:@"取消",nil];
        [alert show];
        [alert release];
        
        return;
    }
    else{
        self.xczfbh = [[DBHelper sharedInstance] getXCZFBHByMc:self.wrymc];
    }
}

- (NSDictionary *)getValueData {
    NSMutableDictionary *dicValues = [NSMutableDictionary dictionaryWithCapacity:5];
    
    [dicValues setValue:self.wrybh forKey:@"QYID"];
    [dicValues setValue:self.wrymc forKey:@"QYMC"];
    [dicValues setValue:self.wrydz forKey:@"QYDZ"];
    [dicValues setValue:curScoreLabel.text forKey:@"SCORE"];
    
    NSMutableDictionary *detailDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *ItemDict = [NSMutableDictionary dictionary];
    
    //存储备注数据
    UITextView *tmpView;
    NSMutableString *remarkStr = [[NSMutableString alloc] initWithCapacity:10];
    
    for (int i = 0; i < [aryBZTextView count]; i++) {
        tmpView = [aryBZTextView objectAtIndex:i];
        if (i == 0) {
            [remarkStr appendString:tmpView.text];
        }
        else {
            [remarkStr appendFormat:@",%@",tmpView.text];
        }
    }
    [dicValues setValue:remarkStr forKey:@"BZ"];
    [remarkStr release];
    
    
    //存储评分细则扣分数据
    for (int i = 0; i < [dicDetailReasons count]; i++) {
        XizeDetailItems *aItem = [[dicDetailReasons allValues] objectAtIndex:i];
        [detailDict setObject:aItem.aryDetailsIndex forKey:@"YYDMJ"];
        [detailDict setObject:aItem.reasons forKey:@"KFYY"];
        NSString *copyDetailDict = [detailDict copy];
        [ItemDict setObject:copyDetailDict forKey:[[dicDetailReasons allKeys] objectAtIndex:i]];
        [copyDetailDict release];
    }
    
    [dicValues setObject:ItemDict forKey:@"KFXZ"];
    
    
    return dicValues;
}

-(void)saveBilu:(id)sender
{
    NSDictionary *dicData = [self getValueData];
    NSMutableDictionary *dicValue = [NSMutableDictionary dictionaryWithDictionary:dicData];
    [dicValue setValue:self.xczfbh forKey:@"XCZFBH"];
    [self saveLocalRecord:dicValue];
    
}

-(void)saveLocalRecord:(id)valueDatas{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:valueDatas options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    DBHelper *helper = [DBHelper sharedInstance];
    BOOL res = [helper saveRecord:jsonStr XCZFBH:xczfbh WRYMC:wrymc TableName:tableName JCR:g_logedUserInfo.userName];
    [jsonStr release];
    if(res){
        recordStatus= Record_SaveLocal;
        [OMGToast showWithText:@"记录已暂存在本地！" duration:1.0];
    }
}



-(void)commitBilu:(id)sender{
    [self Signame];
}

-(void)Signame{
    BOOL isBegin = NO;
    for (int i = 0; i < ITEMS_SUM; i++) {
        if (bItems[i]) {
            isBegin = YES;
        }
    }
    
    //开始进来不做任何操作就提交的情况
    if (isBegin != YES) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"请对该企业进行检查"
                              delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }

    SignNameController *controller = [[[SignNameController alloc] initWithNibName:@"SignNameController" bundle:nil] autorelease];
    
    controller.delegate = self;
    controller.wrybh = self.wrybh;
    controller.wrymc = QYMC.text;
    controller.xczfbh = self.xczfbh;
    controller.tableName = @"signNameTable";
    controller.lxBH = 3;
    controller.firstName = g_logedUserInfo.userName;
    controller.secondName = @"陪同执法人员";
    controller.modalPresentationStyle =  UIModalPresentationFormSheet;
    
    [self presentModalViewController:controller animated:YES];
    controller.view.superview.frame = CGRectMake(0, 1024-630, 768, 630);
    
}

-(void)signFinished{
    [self sureCommitBilu];
}

- (void)textViewDidBeginEditing:(UITextField *)textField {
    NSTimeInterval animationDuration=0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	float width=self.view.frame.size.width;
	float height=self.view.frame.size.height;
	CGRect rect=CGRectMake(0.0f,-300,width,height);//上移，按实际情况设置
	self.view.frame=rect;
	[UIView commitAnimations];
	return ;
}

- (void)textViewDidEndEditing:(UITextField *)textField{
	NSTimeInterval animationDuration=0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	float width=self.view.frame.size.width;
	float height=self.view.frame.size.height;
	CGRect rect=CGRectMake(0.0f,0.0f,width,height);
	self.view.frame=rect;
	[UIView commitAnimations];
    
}

-(void)initSectionFooterView{
    
    self.aryBZTextView = [NSMutableArray arrayWithCapacity:Section_SUM];
    CGRect rect2 = CGRectMake(50.0, 10.0, 668, 60);
    
    for (int i = 0; i < Section_SUM; i++) {
        UITextView *sectionTextView =
        [[UITextView alloc] initWithFrame:rect2];
        sectionTextView.scrollEnabled = NO;
        sectionTextView.layer.borderColor = UIColor.grayColor.CGColor;  //textview边框颜色
        sectionTextView.layer.cornerRadius = 3.5f;
        sectionTextView.layer.borderWidth = 1;
        sectionTextView.font = [UIFont fontWithName:@"Helvetica" size:14.0];
        if (i == Section_SUM-1) {//最后一项设置代理
            sectionTextView.delegate = self;
        }
        [aryBZTextView addObject:sectionTextView];
        [sectionTextView release];
    }
    
}

-(void)initScoreDatas{
    self.arySectionTitles = [NSArray arrayWithObjects: @"否决性指标(有一项符合直接判为不合格)",
                             @"加分项",@"废水污染物治理设施",@"废气污染物治理设施",
                             @"污染物治理设施达标排放",@"在线监测设施运行",
                             @"在线监测数据传输与运维记录",@"在线监测数据异常及处理",
                             @"一般固废处置情况",@"危险固体废物处置情况",
                             @"环评和“三同时”执行情况",@"环境应急设施",@"环境应急管理",
                             nil];
    
    NSArray *section1Datas = [NSArray arrayWithObjects:@"立案处罚企业",
                              @"发生环境污染事故的企业",@"导致群体性上访的企业",nil];
    
	NSArray *section2Datas = [NSArray arrayWithObjects:@"企业环保资料一厂一档规范、齐全（5分）", nil];
    
    NSArray *section3Datas = [NSArray arrayWithObjects:@"车间废水收集安全，无跑冒滴漏 (2分) ",@"雨水、冷却水、污水分流彻底(2分)",@"加药设施运行正常 (2分)",
                              @"处理设施运行正常(2分) ",@"标准化排放口设置规范(2分)",nil];
    
    NSArray *section4Datas = [NSArray arrayWithObjects:
                              @"车间废气收集完全(2分)",
                              @"收集管道无破损 (2分)",
                              @"废气污染物治理设施运行符合要求(2分)",
                              @"风机开启符合环评要求(2分)",
                              @"排放高度符合环保要求(2分)",nil ];
    
    NSArray *section5Datas = [NSArray arrayWithObjects:
                              @"废水达标排放 (5分)",
                              @"废气达标排放 (5分)",
                              nil];
	
	
	NSArray *section6Datas = [[NSArray alloc] initWithObjects:@"在线设备取样口设置规范(4分) ",
                              @" 视频监控设置规范 (1分)",
                              @"在线设备接线（接地、防雷等）设置规范(1分)",
                              @" 在线监测房配套设施（载气、爬梯和分瓶器等）运行正常(1分)",nil ];
    
    NSArray *section7Datas = [NSArray arrayWithObjects:
                              @"监测因子传输一致性符合2%的要求(2分)",
                              @" 运维记录是否规范(3分)",nil ];
    
    NSArray *section8Datas = [NSArray arrayWithObjects:
                              @"分析仪量程、时段、参数和公式等设置规范 (4分)",
                              @"数据呈恒值、零值、满量程值和超标值等，未在72小时内修复(4分)",
                              nil];
	
	NSArray *section9Datas = [NSArray arrayWithObjects:@"建立固体废物台账(2分)",
                              @"申报登记(2分)",
                              @"防扬散、防流失、防渗漏措施完善 (3分)",
                              @"安全分类存放，或采取无害化处置措施(3分)",nil ];
    
    NSArray *section10Datas = [NSArray arrayWithObjects:
                               @"建立危险废物台账(4分) ",
                               @"制定危险废物管理计划，并报所在地环保部门备案(4分)",
                               @"有转移联单(4分)",
                               @"容器和包装物以及设施、场所设置危险废物识别标志(4分)",
                               @" 贮存危险废物采取符合国家环境保护标准的防护措施(4分)",
                               nil];
	
	NSArray *section11Datas = [NSArray arrayWithObjects:@"已编制环评(5分)",
                               @"已取得环评批文(5分) ",@"已通过环保部门试生产（试运行）审核(5分) ",
                               @" 已通过环保部门“三同时”验收(5分)",
                               nil];
	
	
	NSArray *section12Datas = [NSArray arrayWithObjects:@"有规范的应急池(3分)",
                               @"应急物资储备齐全(2分) ",nil];
    
    NSArray *section13Datas = [NSArray arrayWithObjects:
                               @"有应急预案(3分) ",@" 定期组织应急演练(2分)",	nil];
    
    self.arySectionSubItems = [NSArray arrayWithObjects:section1Datas,
                               section2Datas,section3Datas,section4Datas,
                               section5Datas,section6Datas,section7Datas,
                               section8Datas,section9Datas,section10Datas,
                               section11Datas,section12Datas,section13Datas,nil];
    
	scoreItems[0] = scoreItems[1] = scoreItems[2] = 0;
    scoreItems[3] = 5;
    for(int i =4;i<=13;i++)
		scoreItems[i] = 2;
	scoreItems[14] = scoreItems[15] = 5;
    scoreItems[16] = 4;
	scoreItems[17] = scoreItems[18] = scoreItems[19] = 1;
	scoreItems[20] = 2;
	scoreItems[21] = 3;
	scoreItems[22] =  scoreItems[23]  =4;
    scoreItems[24] = scoreItems[25] = 2;
	scoreItems[26] = scoreItems[27] = 3;
	scoreItems[28] = scoreItems[29] = scoreItems[30] = 4;
	scoreItems[31] = scoreItems[32] = 4;
    scoreItems[33] = scoreItems[34] = scoreItems[35] = scoreItems[36] = 5;
    scoreItems[37] = scoreItems[39] = 3;
	scoreItems[38] = scoreItems[40] = 2;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertType == kAlert_Choose) {
        if (buttonIndex == 0) {
            [self saveBilu:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if(buttonIndex == 1){
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if(alertType == kAlert_GenXCZFBH){
        if (buttonIndex == 0) {
            self.xczfbh = [GUIDGenerator generateBHByWryName:self.wrymc];
            
        }else{
            [self selectPolutionSrc];
        }
    }
    
    if (recordStatus == Record_Commited_Success) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    //    if (iAlertViewType == COMMIT_BILU) {
    //        if (buttonIndex == 0) {
    //            [self sureCommitBilu:nil];
    //        }
    //        iAlertViewType = -1;
    //    }
    //
    //    if (iAlertViewType == COMMIT_BILU_ALERT) {
    //        if (buttonIndex == 0) {
    //            [self saveBilu:nil];
    //            [self.navigationController popViewControllerAnimated:YES];
    //        }
    //        else if(buttonIndex == 1){
    //            [self.navigationController popViewControllerAnimated:YES];
    //        }
    //    }
    //
    //    if ([alertView.message isEqualToString:@"数据已成功提交至服务器"]) {
    //        [TemporarySave deletePlistFileContent:T_XCZF_PFB qymc:QYMC.text];
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }
    //iAlertViewType = 1;
    
}

-(void)selectPolutionSrc{
	for (int i = 100; i<=104; i++) {
        UITextField *field = nil;
        field = (UITextField*)[self.view viewWithTag:i];
        field.text = @"";
    }
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

-(void)backItemPressed{
    /*if (bCommited) {
     [self.navigationController popViewControllerAnimated:YES];
     return;
     }
     */
    if(recordStatus == Record_SaveLocal)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    alertType = kAlert_Choose;
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:@"您输入的数据还未提交到服务器，请选择操作"
                          delegate:self
                          cancelButtonTitle:@"暂存数据"
                          otherButtonTitles:@"丢弃数据",nil];
    alert.alpha = 1.0f;
    [alert show];
    [alert release];
    
    return;
}

- (void)displayRecordDatas:(NSDictionary *)values {
    
}

-(void)qyBilu:(id)sender{
    if (popRecordController == nil) {
        ChooseRecordViewController *tmpController =
        [[ChooseRecordViewController alloc] initWithStyle:UITableViewStylePlain];
        tmpController.blName = tableName;
        tmpController.wrymc = wrymc;
        tmpController.isGetHistory = NO;
        tmpController.contentSizeForViewInPopover = CGSizeMake(600, 400);
        tmpController.delegate = self;
        
        
        UINavigationController *tmpNav = [[UINavigationController alloc] initWithRootViewController:tmpController];
        UIPopoverController *tmpPopover = [[UIPopoverController alloc] initWithContentViewController:tmpNav];
        self.popRecordController = tmpPopover;
        [tmpController.tableView reloadData];
        [tmpPopover release];
        [tmpNav release];
        [tmpController release];
    }
    UINavigationController *navVC = (UINavigationController *)popRecordController.contentViewController;
    NSArray *contrArr = navVC.childViewControllers;
    if (contrArr.count>0) {
        ChooseRecordViewController *tmpController = [contrArr objectAtIndex:0];
        tmpController.isGetHistory = NO;
    }
    
    [popRecordController dismissPopoverAnimated:NO];
    
	[self.popRecordController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}


- (void)viewDidLoad {
    
    
      
    
    
    
    
    
    [super viewDidLoad];
    //bCommited = NO;
    self.tableName = @"T_YDZF_QYPF";
    //导航左边部分
    UIToolbar *tool1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 110, 44)];
    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backItemPressed)];
    NSMutableArray* buttons1 = [[NSMutableArray alloc] initWithCapacity:8];
    [buttons1 addObject:leftButton];
    //   [buttons1 addObject:dyButton];
    
    //   [dyButton release];
    [leftButton release];
    [tool1 setItems:buttons1 animated:NO];
    [buttons1 release];
    UIBarButtonItem *myBItem1 = [[UIBarButtonItem alloc] initWithCustomView:tool1];
    self.navigationItem.leftBarButtonItem = myBItem1;
    [myBItem1 release];
    [tool1 release];
    
    btnTitleView = [[UIButton buttonWithType:UIButtonTypeRoundedRect ] retain];
    btnTitleView.tintColor = [UIColor lightGrayColor];
    btnTitleView.frame = CGRectMake(0, 0, 400, 35);
    [btnTitleView addTarget:self action:@selector(selectPolutionSrc:) forControlEvents:UIControlEventTouchUpInside];
    [btnTitleView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.navigationItem.titleView  = btnTitleView;
    
    
	NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:@"white" ofType:@"png"];
	UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
	myTableView.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
    
	self.dicDetailReasons =[NSMutableDictionary dictionaryWithCapacity:50];
    [self initSectionFooterView];
    [self initScoreDatas];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	
    //UIToolbar *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 110, 44)];
    //tool.barStyle = UIBarStyleBlackTranslucent;
    //[tool setTintColor:[UIColor clearColor]];
    //[tool setTintColor:[self.navigationController.navigationBar tintColor]];
    //[tool setAlpha:[self.navigationController.navigationBar alpha]];
    UIToolbar *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 210, 44)];
    
    UIBarButtonItem *qyButton = [[UIBarButtonItem alloc] initWithTitle:@"获取暂存记录" style:UIBarButtonItemStyleDone
                                                                target:self action:@selector(qyBilu:)];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"暂存" style:UIBarButtonItemStyleDone target:self action:@selector(saveBilu:)];
    UIBarButtonItem *commitButton = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(commitBilu:)];
    
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
    [buttons addObject:qyButton];
    [buttons addObject:saveButton];
    [buttons addObject:commitButton];
    [qyButton release];
    [saveButton release];
    [commitButton release];
    
    [tool setItems:buttons animated:NO];
    [buttons release];
    UIBarButtonItem *myBItem = [[UIBarButtonItem alloc] initWithCustomView:tool];
    self.navigationItem.rightBarButtonItem = myBItem;
    [myBItem release];
    [tool release];
    
	
	for (int i=0; i< 41; i++) {
		bItems[i] = FALSE;
	}
	
    DetailsItemViewController *controller = [[DetailsItemViewController alloc] initWithNibName:@"DetailsItemViewController"
																						bundle:nil];
	self.itemsController = controller;
	itemsController.delegate = self;
	[controller release];
	
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:itemsController];
	
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	//popController.delegate = self;
	[popover release];
	[nav release];
    
	NSString *path = [[NSBundle mainBundle] pathForResource:@"kaohexize" ofType:@"plist"];
	itemsDic = [[NSDictionary alloc]  initWithContentsOfFile:path];
	
	curScoreLabel.text = @"100";
	
	[self selectPolutionSrc:nil];
    isclear = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"scoreview" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(update) name:@"scoreview" object:nil];
    
}

- (void)update
{
    [self saveBilu:nil];
    /*
     SharedInformations *info = [SharedInformations sharedSharedInformations];
     //[info.dicStoreTempData removeAllObjects];
     [info.dicStoreTempData setValue:self forKey:@"ScoreViewController"];
     */
}

#pragma mark -
#pragma mark delegate
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	
	if( [elementName isEqualToString:@"ProcessQueues_Ipad_Log_UDIDResult"])
	{
		currentdata = [NSMutableString string];
	}
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (currentdata)
		[currentdata appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	
	if(currentdata && [elementName isEqualToString:@"ProcessQueues_Ipad_Log_UDIDResult"])
	{
		
		if([currentdata isEqualToString:@"true"])
		{
			UIAlertView *alert = [[UIAlertView alloc]
								  initWithTitle:@"提示"
								  message:@"数据已成功提交至服务器"
								  delegate:self
								  cancelButtonTitle:@"确定"
								  otherButtonTitles:nil];
			[alert show];
			[alert release];
            recordStatus= Record_Commited_Success;
            [[DBHelper sharedInstance] saveXCZFBH:self.xczfbh Wrymc:self.wrymc TableName:self.tableName];
            
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark -
#pragma mark Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [arySectionTitles count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
	return [[arySectionSubItems objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
	return [arySectionTitles objectAtIndex:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGRect rect = CGRectMake(0.0, 0.0, 768, 60);
    UIView *footerView = [[UIView alloc] initWithFrame:rect];
    CGRect rect1 = CGRectMake(0.0, 0.0, 50, 60);
    UILabel *label = [[UILabel alloc] initWithFrame:rect1];
    label.text = @"备注";
    
    UITextView *sectionTextView = [aryBZTextView objectAtIndex:section];
    if (sectionTextView == nil) {
        //NSLog(@"error");
    }
    [footerView addSubview:sectionTextView];
    [footerView addSubview:label];
    [label release];
    
    return [footerView autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 70;
}

//计算索引 dicDetailReasons的key
-(NSInteger)calculateIndex:(NSIndexPath *)indexPath {
    int res = 0;
    for (int i = 0; i < indexPath.section; i++) {
        res += [[arySectionSubItems objectAtIndex:i] count];
    }
    res += indexPath.row;
    return res;
	
}

//计算索引 dicDetailReasons的key
-(NSInteger)calculateSectionByIndex:(NSInteger) index {
    int sub=0,i=0;
    
    for ( i = 0; i < Section_SUM; i++) {
        sub += [[arySectionSubItems objectAtIndex:i] count];
        if(index < sub)
            return i;
    }
    return i;
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    NSInteger index = [self calculateIndex:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		
	}
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
	NSArray *ary = nil;
    if (indexPath.section == 0) {
        ary = [NSArray arrayWithObjects:@"否",@"是",nil];
    }
    else if(indexPath.section == 1){
        ary = [NSArray arrayWithObjects:@"不加分",@"加分",nil];
    }
    else{
        ary = [NSArray arrayWithObjects:@"是",@"否",nil];
    }
    
	cell.textLabel.text = [[arySectionSubItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
	if(ary == nil)return nil;
	UISegmentedControl *ctrl = [[UISegmentedControl alloc] initWithItems:ary];
	ctrl.frame = CGRectMake(608, 10, 110, 36);
    if (isclear == YES) {
        for (int i = 0; i<41; i++) {
            bItems[i]=NO;
            ctrl.selectedSegmentIndex = 1;
            curScoreLabel.text = @"100";
            int section = [self calculateSectionByIndex:i];
            UITextView *view = [aryBZTextView objectAtIndex:section];
            view.text = @"";
        }
        isclear = NO;
    }
	[ctrl addTarget:self action:@selector(selectSegment:) forControlEvents:UIControlEventValueChanged];
	//UIBarButtonItem *aButtonItem = [[UIBarButtonItem alloc] initWithCustomView:ctrl];
	ctrl.tag = index;
	
	if (bItems[index]) {
		//cell.accessoryType = UITableViewCellAccessoryCheckmark;
		
		NSString *strKey = [NSString stringWithFormat:@"%d",index];
        XizeDetailItems *aItem = [dicDetailReasons objectForKey:strKey];
        if (aItem.reasons != nil)
        {
            NSString *reason = [NSString stringWithFormat:@"%@",
                                aItem.reasons];
            
            cell.detailTextLabel.text = reason;
            cell.detailTextLabel.textColor = [UIColor redColor];
        }
        
		ctrl.selectedSegmentIndex = 1;
		
	} else {
		//cell.accessoryType = UITableViewCellAccessoryNone;
		ctrl.selectedSegmentIndex = 0;
		cell.detailTextLabel.text = @"";
	}
	
	//[cell addSubview:ctrl];
	cell.accessoryView = ctrl;
	[ctrl release];
    
	
    return cell;
}

-(int)calculateScore{
	int sum = 0;
	int i;
	for ( i = 4; i<41; i++) {
		if (!bItems[i]) {
			sum += scoreItems[i];
		}
	}
    if (bItems[3]) {
        sum += 5;
    }
	for (i=0; i<3; i++) {
		if (bItems[i]) {
			sum -= 50;
		}
	}
	
	sum -= 10;//总分有115，但还是按100算
	if (sum < 0) {
		sum = 0;
	}
	if (sum<80) {
		curScoreLabel.textColor = [UIColor redColor];
	}
	else {
		curScoreLabel.textColor = [UIColor greenColor];
	}
    
	curScoreLabel.text =  [NSString stringWithFormat:@"%d",sum];
	return sum;
}

//计算得分
-(void)sumScores:(id)sender{
    
	int sum = [self calculateScore];
    
	NSString *msg = [NSString stringWithFormat:@"获得分数：%d",sum];
	
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:@"提示"
						  message:msg
						  delegate:self
						  cancelButtonTitle:@"确定"
						  otherButtonTitles:nil];
	[alert show];
	[alert release];
	return;
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*NSInteger index = [self calculateIndex:indexPath];
     bItems[index] = !bItems[index];
     [tableView reloadData];*/
    
}

#pragma mark -
#pragma mark ChooseRecordDelegate delegate


-(void)returnInfo:(NSDictionary*)valueDatas{
    UITextView *xzbzView;
    if (valueDatas!=nil) {
        curScoreLabel.text = [valueDatas objectForKey:@"SCORE"];
        for (int i = 0; i < [aryBZTextView count]; i++) {
            xzbzView = [aryBZTextView objectAtIndex:i];
            NSString *remarkStr = [valueDatas objectForKey:@"BZ"];
            NSArray *remarkAry  = [remarkStr componentsSeparatedByString:@","];
            xzbzView.text = [remarkAry objectAtIndex:i];
        }
        
        NSDictionary *reasonDict = [valueDatas objectForKey:@"KFXZ"];
        if (reasonDict) {
            [dicDetailReasons removeAllObjects];
            for (int i = 0; i < [[reasonDict allKeys] count]; i++) {
                NSDictionary *reasonItem = [[reasonDict allValues] objectAtIndex:i];
                XizeDetailItems *aItem = [[XizeDetailItems alloc] init];
                
                aItem.reasons = [reasonItem objectForKey:@"KFYY"];
                aItem.aryDetailsIndex = [reasonItem objectForKey:@"YYDMJ"];
                [dicDetailReasons setObject:aItem forKey:[[reasonDict allKeys] objectAtIndex:i]];
                bItems[[[[reasonDict allKeys] objectAtIndex:i] intValue]] = YES;
                //NSLog(@"4:%@",[[dicPfgx allKeys] objectAtIndex:i]);
                
                [aItem release];
            }
        }
        
        //NSLog(@"5:%@",dicDetailReasons);
        [self.myTableView reloadData];
    }
    
    [popRecordController dismissPopoverAnimated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
    //[self update];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"scoreview" object:nil];
}

- (void)dealloc {
	[arySectionSubItems release];
    [arySectionTitles release];
	[popController release];
	[itemsController release];
	[dicDetailReasons release];
    [wrymc release];
    [wrybh release];
    [wrydz release];
    [popRecordController release];
    [recordController release];
    [QYMC release];
    [xczfbh release];
    [tableName release];
    [super dealloc];
}


@end

