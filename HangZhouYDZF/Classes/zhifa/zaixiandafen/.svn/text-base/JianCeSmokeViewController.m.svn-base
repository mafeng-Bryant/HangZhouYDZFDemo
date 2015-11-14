//
//  JianCeSmokeViewController.m
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-4-18.
//
//

#import "JianCeSmokeViewController.h"
#import "LKDrawLabBgImage.h"
#import "DBHelper.h"
#import "UserInfo.h"
#import "OMGToast.h"
#import "GMEPS_HZAppDelegate.h"
#import "WebServiceHelper.h"



extern UserInfo *g_logedUserInfo;
extern GMEPS_HZAppDelegate *g_appDelegate;

#define kAlert_None       0
#define kAlert_Choose     1 //选择提交、暂存、丢弃
#define kAlert_SureCommit 2 //确定提交
#define kAlert_Commit_Success 3 //提交成功

@interface JianCeSmokeViewController ()
@property (nonatomic, assign) NSInteger alertType;
@property (nonatomic, retain)   NSMutableString *currentData;
@property (nonatomic, retain) UIPopoverController *popRecordController;

@end

@implementation JianCeSmokeViewController

@synthesize currentData,alertType,popRecordController;
@synthesize tableName,dwbh,wrymc,tableBH,xczfbh,menuTagID,recordStatus,dicWryInfo;
@synthesize isHisRecord,isSaveRecord;

- (void)dealloc {
    [currentData release];
    [checkDict release];
    [baseInfo release];
    [_currentIndex release];
    [dicWryInfo release];
    [super dealloc];
}


- (void)loadLocalSaveRecord{
    NSArray *chooseAry = [[DBHelper sharedInstance] queryRecordByWrymc:wrymc andTableName:tableName TYPE:@"smoke"];
    NSDictionary *dic = [chooseAry objectAtIndex:0];
    NSString *valueJson = [dic objectForKey:@"JSON"];
    NSDictionary *dataInfo =  [NSJSONSerialization JSONObjectWithData:[valueJson dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    [self displayRecordDatas:dataInfo];
}

-(void)requestServerHisRecord{
    NSString* params = [WebServiceHelper createParametersWithKey:@"tableName"														   value:tableName,@"xczfbh",xczfbh,@"lx",@"1",@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    
    NSString *url = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    WebServiceHelper *webService = [[[WebServiceHelper alloc] initWithUrl:url
                                                                   method:@"GetChildsDetialsjson_Log_UDID"
                                                                     view:self.view
                                                                nameSpace:@"http://Services.MobileLaw.Powerdata.com/"
                                                               parameters:params
                                                                 delegate:self] autorelease];
    webService.hudTitle = @"正在获取提交的笔录数据，请稍候...";
    [webService run];
}

- (void)refreshScore:(NSString *)currentScore {
    total = 0;
    NSInteger section = [_currentIndex section];
    NSInteger row = [_currentIndex row];
    NSArray *projectArray = [checkDict objectForKey:@"projectArray"];
    
    NSMutableDictionary *cellContent =  [[projectArray objectAtIndex:section] objectAtIndex:row] ;
    
    NSMutableString  *projectScore = [NSMutableString stringWithString:currentScore];
    
    
    //NSMutableString *newTitle = [NSMutableString stringWithFormat:@"评分项目(满分6分)                                         得分:%@分",currentScore];
    
    [cellContent setObject:projectScore forKey:@"score"];
    [masterTableView reloadData];
    
    for (NSArray *sectionArr in projectArray) {
        for (NSDictionary *cellContent in sectionArr) {
            NSString *score = [cellContent objectForKey:@"score"];
            total  = total + [score intValue];
        }
    }
    
    [checkDict setObject:[NSString stringWithFormat:@"%d",total] forKey:@"total"];
    masterBarItem.title = [NSString stringWithFormat:@"当前得分:%d分",total];
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
    
}


-(void)backItemPressed{
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

- (IBAction)segmentValueChanged:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;
    NSInteger selectIndex = [control selectedSegmentIndex];
    NSString *selectTitle = [control titleForSegmentAtIndex:selectIndex];
    if ([selectTitle isEqualToString:@"有超标"]) {
        ZBLabel.hidden = NO;
        CBZB.hidden = NO;
    }
    else {
        ZBLabel.hidden = YES;
        CBZB.hidden = YES;
        CBZB.text = @"";
    }
}

- (NSDictionary *)getValueData{
    NSMutableArray *aryValues = [NSMutableArray arrayWithCapacity:16];
    NSArray *projectArray = [checkDict objectForKey:@"projectArray"];
    int totalScore = [[checkDict objectForKey:@"total"] intValue];
    for (NSArray *sectionAry in projectArray) {
        for (NSDictionary *projectDict in sectionAry) {
            NSMutableArray *projectValues = nil;
            NSString *shortName = [projectDict objectForKey:@"short"];
            NSDictionary *contentDict = [projectDict objectForKey:@"content"];
            NSString *flag = [[[contentDict objectForKey:@"section"] objectAtIndex:1] objectForKey:@"flag"];
            NSArray *cellArray = [contentDict objectForKey:@"cellArray"];
            if ([flag isEqualToString:@"select"]) {
                int projectScore = 0;
                projectValues = [[NSMutableArray alloc ]initWithCapacity:7];
                NSMutableDictionary *dicValues = [[NSMutableDictionary alloc] initWithCapacity:3];
                NSString *contentKey = [NSString stringWithFormat:@"%@PFNR1",shortName];
                NSString *scoreKey = [NSString stringWithFormat:@"%@DF1",shortName];
                NSString *reasonKey = [NSString stringWithFormat:@"%@KFYY1",shortName];
                NSArray *contentArray = [cellArray objectAtIndex:1];
                NSString *reasonText = [[[cellArray objectAtIndex:2] objectAtIndex:0] objectForKey:@"text"];
                NSMutableString *selectContent = [NSMutableString stringWithCapacity:7];
                for (int i=0; i<[contentArray count]; i++   ) {
                    NSDictionary *detailDict = [contentArray objectAtIndex:i];
                    int score = [[detailDict objectForKey:@"score"] intValue];
                    
                    BOOL isSelect = [[detailDict objectForKey:@"switch"] boolValue];
                    if (isSelect) {
                        [selectContent appendFormat:@"%d,",i];
                    }
                    else {
                        score = 0;
                    }
                    projectScore = projectScore + score;
                    
                }
                NSUInteger length = [selectContent length];
                if (length > 0)  {
                    NSRange range = NSMakeRange(length -1, 1);
                    [selectContent deleteCharactersInRange:range];
                }
                [dicValues setObject:selectContent forKey:contentKey];
                [dicValues setObject:[NSString stringWithFormat:@"%d",projectScore] forKey:scoreKey];
                [dicValues setObject:reasonText forKey:reasonKey];
                [projectValues addObject:dicValues];
                [dicValues release];
            }
            else {
                projectValues = [[NSMutableArray alloc ]initWithCapacity:7];
                NSArray *contentArray = [cellArray objectAtIndex:1];
                for (int j=0; j<[contentArray count]; j++ ) {
                    NSMutableDictionary *dicValues =  [[NSMutableDictionary alloc] initWithCapacity:3];
                    NSDictionary *detailDict = [contentArray objectAtIndex:j];
                    NSString *contentKey = [NSString stringWithFormat:@"%@PFNR%d",shortName,j+1];
                    NSString *scoreKey = [NSString stringWithFormat:@"%@DF%d",shortName,j+1];
                    NSString *reasonKey = [NSString stringWithFormat:@"%@KFYY%d",shortName,j+1];
                    NSString *detailScore = [detailDict objectForKey:@"score"];
                    NSString *reasonText = [detailDict objectForKey:@"text"];
                    NSDictionary *target = [detailDict objectForKey:@"target"];
                    if (reasonText == nil && target != nil) {
                        reasonText = @"";
                        NSString *type1 = [[target objectForKey:@"type1"] objectForKey:@"name"];
                        NSString *type2 = [[target objectForKey:@"type2"] objectForKey:@"name"];
                        NSString *type3 = [[target objectForKey:@"type3"] objectForKey:@"name"];
                        if ([type1 isEqual:@"因子"]) {
                            type1 = @"YZ";
                        }
                        
                        if ([type2 isEqual:@"标气"]) {
                            type2 = @"BQ";
                        }
                        
                        if ([shortName isEqual:@"FQXZXT"] && [type3 isEqual:@"实测"]) {
                            type3 = @"SC";
                        }
                        
                        if ([shortName isEqual:@"FQSJYZX"] && [type2 isEqual:@"实测"]) {
                            type2 = @"SZ";
                        }
                        
                        if ([shortName isEqual:@"FQSJYZX"] && [type3 isEqual:@"数采"]) {
                            type3 = @"SC";
                        }
                        
                        NSString *type1Key = [NSString stringWithFormat:@"%@%@",shortName,type1];
                        NSString *type2Key = [NSString stringWithFormat:@"%@%@",shortName,type2];
                        NSString *type3Key = [NSString stringWithFormat:@"%@%@",shortName,type3];
                        
                        
                        
                        NSArray *elementAry =  [[target objectForKey:@"type1"] objectForKey:@"data"];
                        NSMutableString *typeContent1 = [NSMutableString string];
                        for (int i=0; i< [elementAry count]; i++) {
                            NSString *elementName = [elementAry objectAtIndex:i];
                            if (i == 0) {
                                [typeContent1 appendFormat:@"%@",elementName];
                            }
                            else {
                                [typeContent1 appendFormat:@"|%@",elementName];
                                
                            }
                        }
                        
                        NSArray *standardAry = [[target objectForKey:@"type2"] objectForKey:@"data"];
                        NSMutableString *typeContent2 = [NSMutableString string];
                        for (int i=0; i< [standardAry count]; i++) {
                            NSString *standardData = [standardAry objectAtIndex:i];
                            if (i == 0) {
                                [typeContent2 appendFormat:@"%@",standardData];
                            }
                            else {
                                [typeContent2 appendFormat:@"|%@",standardData];
                                
                            }
                        }
                        
                        NSArray *actuallyAry = [[target objectForKey:@"type3"] objectForKey:@"data"];
                        NSMutableString *typeContent3 = [NSMutableString string];
                        for (int i=0; i< [actuallyAry count]; i++) {
                            NSString *actuallyData = [actuallyAry objectAtIndex:i];
                            if (i == 0) {
                                [typeContent3 appendFormat:@"%@",actuallyData];
                            }
                            else {
                                [typeContent3 appendFormat:@"|%@",actuallyData];
                                
                            }
                        }
                        
                        [dicValues setObject:typeContent1 forKey:type1Key];
                        [dicValues setObject:typeContent2 forKey:type2Key];
                        [dicValues setObject:typeContent3 forKey:type3Key];
                    }
                    
                    [dicValues setObject:@"0" forKey:contentKey];
                    [dicValues setObject:detailScore forKey:scoreKey];
                    [dicValues setObject:reasonText forKey:reasonKey];
                    [projectValues addObject:dicValues];
                    [dicValues release];
                    
                }
                
            }
            [aryValues addObject:projectValues];
            [projectValues release];
        }
    }
    
    NSDictionary *dataValue = [NSDictionary dictionaryWithObjectsAndKeys:aryValues,@"content",[NSString stringWithFormat:@"%d",totalScore],@"total",xczfbh,@"BH",nil];
    
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documnetsDirectory = [paths objectAtIndex:0];
    //    NSString *mypath = [documnetsDirectory stringByAppendingPathComponent:@"record.plist"];
    //    [dataValue writeToFile:mypath atomically:YES];
    
    return dataValue;
    
}

#pragma mark -
#pragma mark ChooseRecordDelegate delegate


-(void)returnInfo:(NSDictionary*)valuesData{
    
    [self displayRecordDatas:valuesData];
    [popRecordController dismissPopoverAnimated:YES];
}



//暂存本地
-(void)saveBilu:(id)sender
{
    [detailViewController saveLastDetailViewData];
    NSDictionary *dicValues = [self getValueData];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithDictionary:dicValues];
    
    [dicData setObject:JCDW.text forKey:@"ZFJCDW"];
    [dicData setObject:QYMC.text forKey:@"DWMC"];
    [dicData setObject:QYDZ.text forKey:@"DWDZ"];
    [dicData setObject:[ZDSX titleForSegmentAtIndex:ZDSX.selectedSegmentIndex] forKey:@"ZDSX"];
    [dicData setObject:YWGS.text forKey:@"YWGS"];
    [dicData setObject:[CBQK titleForSegmentAtIndex:ZDSX.selectedSegmentIndex] forKey:@"ZDJCSJSFYCBQK"];
    [dicData setObject:CBZB.text forKey:@"CBZB"];
    
    [self saveLocalRecord:dicData];
}

-(void)loadData:(NSDictionary*)values{
    JCDW.text = [values objectForKey:@"ZFJCDW"];
    QYMC.text = [values objectForKey:@"DWMC"];
    QYDZ.text = [values objectForKey:@"DWDZ"];
    YWGS.text = [values objectForKey:@"YWGS"];
    CBZB.text = [values objectForKey:@"CBZB"];
    
    NSString *selectTitle = [values objectForKey:@"ZDSX"];
    if ([selectTitle length] > 0) {
        for (int n=0; n < ZDSX.numberOfSegments; n++) {
            NSString *title = [ZDSX titleForSegmentAtIndex:n];
            if ([title isEqualToString:selectTitle]) {
                ZDSX.selectedSegmentIndex = n;
            }
        }
    }
    
    selectTitle = [values objectForKey:@"ZDJCSJSFYCBQK"];
    if ([selectTitle length] > 0) {
        for (int n=0; n < CBQK.numberOfSegments; n++) {
            NSString *title = [CBQK titleForSegmentAtIndex:n];
            if ([title isEqualToString:selectTitle]) {
                CBQK.selectedSegmentIndex = n;
            }
        }
        if ([selectTitle isEqualToString:@"有超标"]) {
            ZBLabel.hidden = NO;
            CBZB.hidden = NO;
        }
        
    }
    
    NSArray *aryValues = [values objectForKey:@"content"];
    NSString *totalScore = [values objectForKey:@"total"];
     NSArray *projectArray = [checkDict objectForKey:@"projectArray"];
    [checkDict setObject:totalScore forKey:@"total"];
    NSMutableArray *projectAry = [NSMutableArray arrayWithCapacity:17];
    
    for (NSArray *sectionArray in projectArray) {
        [projectAry addObjectsFromArray:sectionArray];
    }
    
    for (int i = 0; i < [aryValues count]; i++) {
        NSArray *aryDatas = [aryValues objectAtIndex:i];
        NSMutableDictionary *contentDict = [projectAry objectAtIndex:i];
        NSString *flag = [[[[contentDict objectForKey:@"content"] objectForKey:@"section"] objectAtIndex:1] objectForKey:@"flag"];
        
        NSString *shortName = [contentDict  objectForKey:@"short"];
        if ([flag isEqualToString:@"select"]) {
            NSDictionary *dataDict = [aryDatas objectAtIndex:0];
            NSString *contentKey = [NSString stringWithFormat:@"%@PFNR1",shortName];
            NSString *scoreKey = [NSString stringWithFormat:@"%@DF1",shortName];
            NSString *reasonKey = [NSString stringWithFormat:@"%@KFYY1",shortName];
            NSString *selectContent = [dataDict objectForKey:contentKey];
            NSString *score = [dataDict objectForKey:scoreKey];
            NSString *reasonText = [dataDict objectForKey:reasonKey];
            NSArray *selectArray = [selectContent componentsSeparatedByString:@","];
            NSArray *selectItems = [[[contentDict objectForKey:@"content"]objectForKey:@"cellArray"] objectAtIndex:1] ;
            for (int row=0 ;row< [selectItems count]; row++) {
                BOOL isContain =  [selectArray containsObject:[NSString stringWithFormat:@"%d",row]];
                if (isContain) {
                    NSMutableDictionary *itemDict = [[[[contentDict objectForKey:@"content"] objectForKey:@"cellArray"] objectAtIndex:1] objectAtIndex:row];
                    [itemDict setObject:@"1" forKey:@"switch"];
                }
                else {
                    NSMutableDictionary *itemDict = [[[[contentDict objectForKey:@"content"]objectForKey:@"cellArray"] objectAtIndex:1] objectAtIndex:row];
                    [itemDict setObject:@"0" forKey:@"switch"];
                }
            }
            [contentDict setObject:score forKey:@"score"];
            NSMutableDictionary *reasonDict = [[[[contentDict objectForKey:@"content"]objectForKey:@"cellArray"] objectAtIndex:2] objectAtIndex:0];
            [reasonDict setObject:reasonText forKey:@"text"];
        }
        
        else {
            int projectScore =0;
            for (int j=0; j < [aryDatas count]; j++) {
                NSDictionary *dataDict  = [aryDatas objectAtIndex:j];
                //NSString *contentKey = [NSString stringWithFormat:@"%@PFNR%d",shortName,j+1];
                NSString *scoreKey = [NSString stringWithFormat:@"%@DF%d",shortName,j+1];
                NSString *reasonKey = [NSString stringWithFormat:@"%@KFYY%d",shortName,j+1];
                
                NSString *score = [dataDict objectForKey:scoreKey];
                projectScore = projectScore + [score intValue];
                NSString *reasonText = [dataDict objectForKey:reasonKey];
                NSMutableDictionary *itemDict = [[[[contentDict objectForKey:@"content"]objectForKey:@"cellArray"] objectAtIndex:1] objectAtIndex:j];
                NSMutableDictionary *target = [itemDict objectForKey:@"target"];
                
                if ([flag isEqualToString:@"segment"]) {
                    [itemDict setObject:score forKey:@"score"];
                    [itemDict setObject:reasonText forKey:@"text"];
                    
                }
                
                else  if (target == nil) {
                    if ([score intValue] > 0) {
                        [itemDict setObject:@"1" forKey:@"switch"];
                    }
                    else {
                        [itemDict setObject:@"0" forKey:@"switch"];
                    }
                    [itemDict setObject:score forKey:@"score"];
                    [itemDict setObject:reasonText forKey:@"text"];
                }
                
                else {
                    [itemDict setObject:score forKey:@"score"];
                    NSString *type1 = [[target objectForKey:@"type1"] objectForKey:@"name"];
                    NSString *type2 = [[target objectForKey:@"type2"] objectForKey:@"name"];
                    NSString *type3 = [[target objectForKey:@"type3"] objectForKey:@"name"];
                    
                    if ([type1 isEqualToString:@"因子"]) {
                        type1 = @"YZ";
                    }
                    if ([type2 isEqual:@"标气"]) {
                        type2 = @"BQ";
                    }
                    
                    if ([shortName isEqual:@"FQXZXT"] && [type3 isEqual:@"实测"]) {
                        type3 = @"SC";
                    }
                    
                    if ([shortName isEqual:@"FQSJYZX"] && [type2 isEqual:@"实测"]) {
                        type2 = @"SZ";
                    }
                    
                    if ([shortName isEqual:@"FQSJYZX"] && [type3 isEqual:@"数采"]) {
                        type3 = @"SC";
                    }
                    
                    NSString *type1Key = [NSString stringWithFormat:@"%@%@",shortName,type1];
                    NSString *type2Key = [NSString stringWithFormat:@"%@%@",shortName,type2];
                    NSString *type3Key = [NSString stringWithFormat:@"%@%@",shortName,type3];
                    
                    NSString *typeContent1 = [dataDict objectForKey:type1Key];
                    NSString *typeContent2 = [dataDict objectForKey:type2Key];
                    NSString *typeContent3 = [dataDict objectForKey:type3Key];
                    
                    NSArray *factorAry = [typeContent1 componentsSeparatedByString:@"|"];
                    NSArray *testAry = [typeContent2 componentsSeparatedByString:@"|"];
                    
                    NSArray *measureAry = [typeContent3 componentsSeparatedByString:@"|"];
                    
                    NSMutableDictionary *typeDict1 = [target objectForKey:@"type1"];
                    NSMutableDictionary *typeDict2 = [target objectForKey:@"type2"];
                    NSMutableDictionary *typeDict3 = [target objectForKey:@"type3"];
                    
                    [typeDict1 setObject:factorAry forKey:@"data"];
                    [typeDict2 setObject:testAry forKey:@"data"];
                    [typeDict3 setObject:measureAry forKey:@"data"];
                    //[itemDict setObject:target forKey:@"target"];
                    
                }
            }
            [contentDict setObject:[NSString stringWithFormat:@"%d",projectScore] forKey:@"score"];
            
            
        }
    }
    
}

//根据值来显示值
-(void)displayRecordDatas:(id)values{
    NSDictionary *valueDic = (NSDictionary*)values;
    [self loadData:valueDic];
    NSArray *projectArray = [checkDict objectForKey:@"projectArray"];
    
    NSDictionary  *tableData = [[[projectArray objectAtIndex:0] objectAtIndex:0] objectForKey:@"content"];
    NSString *projectScore =  [[[projectArray objectAtIndex:0] objectAtIndex:0] objectForKey:@"score"];
    NSString *totalScore = [checkDict objectForKey:@"total"];
    masterBarItem.title = [NSString stringWithFormat:@"当前得分:%@分",totalScore];
    detailViewController.tableDict =  tableData;
    detailViewController.scoreTotal = [projectScore intValue];
    [detailViewController reloadTableView];
    NSIndexPath *one =  [NSIndexPath indexPathForRow:0 inSection:0];
    [masterTableView selectRowAtIndexPath:one animated:NO scrollPosition:UITableViewRowAnimationTop];
    [masterTableView reloadData];
}

-(void)saveLocalRecord:(NSDictionary *)valueDatas{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:valueDatas options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    DBHelper *helper = [DBHelper sharedInstance];
    
    
    BOOL res = [helper saveRecord:jsonStr XCZFBH:xczfbh WRYMC:wrymc TableName:tableName JCR:g_logedUserInfo.userName TYPE:@"smoke"];
    [jsonStr release];
    
    
    NSString *totalScore = [valueDatas objectForKey:@"total"];
    NSMutableDictionary *mainTable = [NSMutableDictionary dictionary];
    
    [mainTable setObject:tableBH forKey:@"BH"];
    [mainTable setObject:@"1" forKey:@"LX"];
    [mainTable setObject:totalScore forKey:@"ZF"];
    [mainTable setObject:xczfbh forKey:@"XCZFBH"];
    [mainTable setObject:JCDW.text forKey:@"ZFJCDW"];
    [mainTable setObject:QYMC.text forKey:@"DWMC"];
    [mainTable setObject:QYDZ.text forKey:@"DWDZ"];
    [mainTable setObject:[ZDSX titleForSegmentAtIndex:ZDSX.selectedSegmentIndex] forKey:@"ZDSX"];
    [mainTable setObject:YWGS.text forKey:@"YWGS"];
    [mainTable setObject:[CBQK titleForSegmentAtIndex:ZDSX.selectedSegmentIndex] forKey:@"ZDJCSJSFYCBQK"];
    [mainTable setObject:CBZB.text forKey:@"CBZB"];
    
    
    
    jsonData = [NSJSONSerialization dataWithJSONObject:mainTable options:NSJSONWritingPrettyPrinted error:&error];
    jsonStr = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    BOOL main = [helper saveRecord:jsonStr XCZFBH:xczfbh WRYMC:wrymc TableName:@"T_YDZF_ZXXCDFB" JCR:g_logedUserInfo.userName TYPE:@"smoke"];
    [jsonStr release];
    
    if(res && main){
        recordStatus= Record_SaveLocal;
        [OMGToast showWithText:@"记录已暂存在本地！" duration:1.0];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RecordStatus" object:[NSNumber numberWithInt:menuTagID]];
    }
    
    
    
    
    
    
//    
//    
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:valueDatas options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *jsonStr = [[[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding] autorelease];
//
//    DBHelper *helper = [DBHelper sharedInstance];
//    
//    BOOL res = [helper saveRecord:jsonStr XCZFBH:xczfbh WRYMC:wrymc TableName:tableName JCR:g_logedUserInfo.userName TYPE:@"smoke"];
//    
//    NSString *totalScore = [valueDatas objectForKey:@"total"];
//    NSMutableDictionary *mainTable = [NSMutableDictionary dictionary];
//    
//    [mainTable setObject:tableBH forKey:@"BH"];
//    [mainTable setObject:@"1" forKey:@"LX"];
//    [mainTable setObject:totalScore forKey:@"ZF"];
//    [mainTable setObject:xczfbh forKey:@"XCZFBH"];
//    [mainTable setObject:JCDW.text forKey:@"ZFJCDW"];
//    [mainTable setObject:QYMC.text forKey:@"DWMC"];
//    [mainTable setObject:QYDZ.text forKey:@"DWDZ"];
//    [mainTable setObject:[ZDSX titleForSegmentAtIndex:ZDSX.selectedSegmentIndex] forKey:@"ZDSX"];
//    [mainTable setObject:YWGS.text forKey:@"YWGS"];
//    [mainTable setObject:[CBQK titleForSegmentAtIndex:ZDSX.selectedSegmentIndex] forKey:@"ZDJCSJSFYCBQK"];
//    [mainTable setObject:CBZB.text forKey:@"CBZB"];
//    
//    BOOL main = [helper saveRecord:jsonStr XCZFBH:xczfbh WRYMC:wrymc TableName:@"T_YDZF_ZXXCDFB" JCR:g_logedUserInfo.userName TYPE:@"smoke"];
//    
//    
//    if(res && main){
//        recordStatus= Record_SaveLocal;
//        [OMGToast showWithText:@"记录已暂存在本地！" duration:1.0];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"RecordStatus" object:[NSNumber numberWithInt:menuTagID]];
//    }
}

//获取暂存记录
-(void)qyBilu:(id)sender{
    if (popRecordController == nil) {
        ChooseRecordViewController *tmpController =
        [[ChooseRecordViewController alloc] initWithStyle:UITableViewStylePlain];
        tmpController.blName = tableName;
        tmpController.wrymc = wrymc;
        tmpController.type = @"smoke";
        tmpController.contentSizeForViewInPopover = CGSizeMake(800, 400);
        tmpController.delegate = self;
        
        
        UINavigationController *tmpNav = [[UINavigationController alloc] initWithRootViewController:tmpController];
        UIPopoverController *tmpPopover = [[UIPopoverController alloc] initWithContentViewController:tmpNav];
        self.popRecordController = tmpPopover;
        [tmpController.tableView reloadData];
        [tmpPopover release];
        [tmpNav release];
        [tmpController release];
    }
    
	[self.popRecordController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        total = 0;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"smokecheck" ofType:@"plist"];
        NSMutableDictionary *fileDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        checkDict = [fileDict mutableCopy];
        dataArray = [[NSMutableArray alloc] initWithCapacity:6];
        [fileDict release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"固定污染源烟气连续监测系统现场核查表";
    detailViewController.refreshDelegate = self;
    masterBarItem.title = @"当前得分:100分";
    
    scrollView.contentSize = CGSizeMake(768, 1400);
    JCDW.text = g_logedUserInfo.userDanwei;
    QYMC.text = [dicWryInfo objectForKey:@"DWMC"];
    QYDZ.text = [dicWryInfo objectForKey:@"DWDZ"];
    
    NSArray *projectArray = [checkDict objectForKey:@"projectArray"];
    NSDictionary  *tableData = [[[projectArray objectAtIndex:0] objectAtIndex:0] objectForKey:@"content"];
    NSString *score =  [[[projectArray objectAtIndex:0] objectAtIndex:0] objectForKey:@"score"];
    NSString *shortName = [[[projectArray objectAtIndex:0] objectAtIndex:0] objectForKey:@"short"];
    detailViewController.tableDict =  tableData;
    detailViewController.shortName = shortName;
    detailViewController.scoreTotal = [score intValue];
    [detailViewController reloadTableView];
    
    masterTableView.contentSize = CGSizeMake(280, 1280);
    
    NSIndexPath *one =  [NSIndexPath indexPathForRow:0 inSection:0];
    lastSelected = one;
    [masterTableView selectRowAtIndexPath:one animated:NO scrollPosition:UITableViewRowAnimationTop];
    
    if(isHisRecord){
        [self requestServerHisRecord];
        recordStatus= Record_SaveLocal;

    }
    else{
        //导航左边部分
        UIToolbar *tool1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 110, 44)];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backItemPressed)];
        NSMutableArray* buttons1 = [[NSMutableArray alloc] initWithCapacity:8];
        [buttons1 addObject:leftButton];
        [leftButton release];
        [tool1 setItems:buttons1 animated:NO];
        [buttons1 release];
        
        UIBarButtonItem *myBItem1 = [[UIBarButtonItem alloc] initWithCustomView:tool1];
        self.navigationItem.leftBarButtonItem = myBItem1;
        [myBItem1 release];
        [tool1 release];
        
        
        //导航右边部分
        UIToolbar* tools = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
        [tools setTintColor:[self.navigationController.navigationBar tintColor]];
        [tools setAlpha:[self.navigationController.navigationBar alpha]];
        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:4];
        UIBarButtonItem *anotherButton0 = [[UIBarButtonItem alloc] initWithTitle:@"获取暂存记录" style:UIBarButtonItemStyleDone
                                                                          target:self action:@selector(qyBilu:)];
        
        UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                     target:self action:nil];
        fixedButton.width = 10.0f;
        UIBarButtonItem *anotherButton1 = [[UIBarButtonItem alloc] initWithTitle:@"暂存" style:UIBarButtonItemStyleDone
                                                                          target:self action:@selector(saveBilu:)];
        [buttons addObject:anotherButton0];
        [anotherButton0 release];
        [buttons addObject:fixedButton];
        [fixedButton release];
        
        [buttons addObject:anotherButton1];
        [anotherButton1 release];
        
        [tools setItems:buttons animated:NO];
        [buttons release];
        UIBarButtonItem *myBtn = [[UIBarButtonItem alloc] initWithCustomView:tools];
        self.navigationItem.rightBarButtonItem = myBtn;
        
        [myBtn release];
        [tools release];
        
    }
    if (isSaveRecord) {
        [self loadLocalSaveRecord];
    }
    
    
    //detailViewController.refreshDelegate = self;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.isHisRecord) {
        NSArray *subViews = [scrollView subviews];
        for (UIView *childView in subViews) {
            if( [childView isKindOfClass:[UITextField class]] || [childView isKindOfClass:[UISegmentedControl class]]) {
                childView.userInteractionEnabled = NO;
            }
        }
        detailViewController.view.userInteractionEnabled = NO;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"GetChildsDetialsjson_Log_UDIDResult"]) {
        currentNote = @"GetChildsDetialsjson_Log_UDIDResult";
        self.currentData = [NSMutableString string];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (currentData) {
        [currentData appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (currentData &&[ currentNote isEqualToString:@"GetChildsDetialsjson_Log_UDIDResult"]) {
        NSDictionary *dataInfo = [NSJSONSerialization JSONObjectWithData:[currentData dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        NSArray *dataZB = [dataInfo objectForKey:@"T_YDZF_ZXXCDFBZB"];
        NSDictionary *dataFB = [[dataInfo objectForKey:@"T_YDZF_ZXXCDFB"] objectAtIndex:0];
        
        NSString *totalScore = [dataFB objectForKey:@"ZF"];
        NSString *jcdwStr = [dataFB objectForKey:@"ZFJCDW"];
        NSString *dwmcStr = [dataFB objectForKey:@"DWMC"];
        NSString *dwdzStr = [dataFB objectForKey:@"DWDZ"];
        NSString *ywgsStr = [dataFB objectForKey:@"YWGS"];
        NSString *zdsxStr = [dataFB objectForKey:@"ZDSX"];
        NSString *cbqkStr = [dataFB objectForKey:@"ZDJCSJSFYCBQK"];
        NSString *cbzbStr = [dataFB objectForKey:@"CBZB"];
        
        NSInteger num = [dataZB count];
        NSMutableArray *zbAry = [NSMutableArray arrayWithCapacity:num];
        for (int i= 0; i < num; i++) {
            [zbAry addObject:[NSNull null]];
        }


        for (int index = 0; index < [dataZB count]; index++) {
            NSDictionary *item =[dataZB objectAtIndex:index];
            
            NSString *contentMC = [item objectForKey:@"PFXMPFNR"];
            if ([contentMC isEqualToString:@"JCYFPFNR1"]) {
                [zbAry replaceObjectAtIndex:0 withObject:item];
            }
            else if([contentMC isEqualToString:@"AZWZPFNR1"]) {
                [zbAry replaceObjectAtIndex:1 withObject:item];
            }
            else if([contentMC isEqualToString:@"AZWZPFNR2"]) {
                [zbAry replaceObjectAtIndex:2 withObject:item];
            }
            else if([contentMC isEqualToString:@"AZWZPFNR3"]) {
                [zbAry replaceObjectAtIndex:3 withObject:item];
            }
            else if([contentMC isEqualToString:@"TTHGXPFNR1"]) {
                [zbAry replaceObjectAtIndex:4 withObject:item];
            }
            else if([contentMC isEqualToString:@"RGJCTJPFNR1"]) {
                [zbAry replaceObjectAtIndex:5 withObject:item];
            }
            else if([contentMC isEqualToString:@"RGJCTJPFNR2"]) {
                [zbAry replaceObjectAtIndex:6 withObject:item];
            }
            else if([contentMC isEqualToString:@"RGJCTJPFNR3"]) {
                [zbAry replaceObjectAtIndex:7 withObject:item];
            }
            else if([contentMC isEqualToString:@"WRYJCXTPFNR1"]) {
                [zbAry replaceObjectAtIndex:8 withObject:item];
            }
            else if([contentMC isEqualToString:@"YQCSJCXTPFNR1"]) {
                [zbAry replaceObjectAtIndex:9 withObject:item];
            }
            else if([contentMC isEqualToString:@"CYYCLXTPFNR1"]) {
                [zbAry replaceObjectAtIndex:10 withObject:item];
            }
            else if([contentMC isEqualToString:@"ZDQXXTPFNR1"]) {
                [zbAry replaceObjectAtIndex:11 withObject:item];
            }
            else if([contentMC isEqualToString:@"FXYQJCPFNR1"]) {
                [zbAry replaceObjectAtIndex:12 withObject:item];
            }
            else if([contentMC isEqualToString:@"FXYQJCPFNR2"]) {
                [zbAry replaceObjectAtIndex:13 withObject:item];
            }
            else if([contentMC isEqualToString:@"QTWRWCYYCLXTPFNR1"]) {
                [zbAry replaceObjectAtIndex:14 withObject:item];
            }
            else if([contentMC isEqualToString:@"QTWRWCYYCLXTPFNR2"]) {
                [zbAry replaceObjectAtIndex:15 withObject:item];
            }
            else if([contentMC isEqualToString:@"QTWRWCYYCLXTPFNR3"]) {
                [zbAry replaceObjectAtIndex:16 withObject:item];
            }
            else if([contentMC isEqualToString:@"QTWRWCYYCLXTPFNR4"]) {
                [zbAry replaceObjectAtIndex:17 withObject:item];
            }
            else if([contentMC isEqualToString:@"BZQTJCPFNR1"]) {
                [zbAry replaceObjectAtIndex:18 withObject:item];
            }
            else if([contentMC isEqualToString:@"FQXZXTPFNR1"]) {
                [zbAry replaceObjectAtIndex:19 withObject:item];
            }
            else if([contentMC isEqualToString:@"FQXZXTPFNR2"]) {
                [zbAry replaceObjectAtIndex:20 withObject:item];
            }
            else if([contentMC isEqualToString:@"FQXZXTPFNR3"]) {
                [zbAry replaceObjectAtIndex:21 withObject:item];
            }
            else if([contentMC isEqualToString:@"FQXZXTPFNR4"]) {
                [zbAry replaceObjectAtIndex:22 withObject:item];
            }
            else if([contentMC isEqualToString:@"LWQKPFNR1"]) {
                [zbAry replaceObjectAtIndex:23 withObject:item];
            }
            else if([contentMC isEqualToString:@"LWQKPFNR2"]) {
                [zbAry replaceObjectAtIndex:24 withObject:item];
            }
            else if([contentMC isEqualToString:@"FQSJYZXPFNR1"]) {
                [zbAry replaceObjectAtIndex:25 withObject:item];
            }
            else if([contentMC isEqualToString:@"FQSJYZXPFNR2"]) {
                [zbAry replaceObjectAtIndex:26 withObject:item];
            }
            else if([contentMC isEqualToString:@"GLZDPFNR1"]) {
                [zbAry replaceObjectAtIndex:27 withObject:item];
            }
            else if([contentMC isEqualToString:@"GLZDPFNR2"]) {
                [zbAry replaceObjectAtIndex:28 withObject:item];
            }
            else if([contentMC isEqualToString:@"SBZLPFNR1"]) {
                [zbAry replaceObjectAtIndex:29 withObject:item];
            }
            else if([contentMC isEqualToString:@"YXJLDZDAPFNR1"]) {
                [zbAry replaceObjectAtIndex:30 withObject:item];
            }
            else if([contentMC isEqualToString:@"YXJLDZDAPFNR2"]) {
                [zbAry replaceObjectAtIndex:31 withObject:item];
            }
            else if([contentMC isEqualToString:@"YXJLDZDAPFNR3"]) {
                [zbAry replaceObjectAtIndex:32 withObject:item];
            }
        }
        
        NSMutableArray *aryValues = [NSMutableArray arrayWithCapacity:16];
        
        for (int index = 0; index< [zbAry count]; index++) {
            NSMutableArray *cellAry = [NSMutableArray arrayWithCapacity:1];
            NSDictionary *item =[zbAry objectAtIndex:index];
            NSString *pfnr = [item objectForKey:@"PFNR"];
            NSString *contentTmp = [item objectForKey:@"PFXMPFNR"];
            contentTmp = [contentTmp substringToIndex:[contentTmp length]-1];
            NSArray *contentAry =  [pfnr componentsSeparatedByString:@","];
            NSMutableDictionary *cellInfo = [[NSMutableDictionary alloc] initWithCapacity:3];
            NSString *contentKey = [item objectForKey:@"PFXMPFNR"];
            NSString *content = [item objectForKey:@"PFNR"];
            NSString *reasonKey = [item objectForKey:@"PFXMKFYY"];
            NSString *reason    = [item objectForKey:@"KFYY"];
            NSString *scoreKey  = [item objectForKey:@"PFXMDF"];
            NSString *score     = [item objectForKey:@"DF"];
            NSString *FQXZXTBQ      = [item objectForKey:@"FQXZXTBQ"];
            NSString *FQXZXTYZ      = [item objectForKey:@"FQXZXTYZ"];
            NSString *FQXZXTSC      = [item objectForKey:@"FQXZXTSC"];
            NSString *FQSJYZXSC     = [item objectForKey:@"FQSJYZXSC"];
            NSString *FQSJYZXSZ     = [item objectForKey:@"FQSJYZXSZ"];
            NSString *FQSJYZXYZ     = [item objectForKey:@"FQSJYZXYZ"];
            
            [cellInfo setObject:content forKey:contentKey];
            [cellInfo setObject:reason  forKey:reasonKey];
            [cellInfo setObject:score   forKey:scoreKey];
            [cellInfo setObject:FQXZXTBQ  forKey:@"FQXZXTBQ"];
            [cellInfo setObject:FQXZXTYZ  forKey:@"FQXZXTYZ"];
            [cellInfo setObject:FQXZXTSC  forKey:@"FQXZXTSC"];
            [cellInfo setObject:FQSJYZXSC forKey:@"FQSJYZXSC"];
            [cellInfo setObject:FQSJYZXSZ forKey:@"FQSJYZXSZ"];
            [cellInfo setObject:FQSJYZXYZ forKey:@"FQSJYZXYZ"];
            
            [cellAry addObject:cellInfo];
            if ([contentAry count] > 1) {
                [aryValues addObject:cellAry];
            }
            
            else {
                for (int j=index+1; j<[zbAry count]; j++) {
                    NSDictionary *itemTmp = [zbAry objectAtIndex:j];
                    NSString *content1Key = [itemTmp objectForKey:@"PFXMPFNR"];
                    NSString *content1Tmp = [content1Key substringToIndex:[content1Key length]-1];
                    NSMutableDictionary *cellInfo = [[NSMutableDictionary alloc] initWithCapacity:3];
                    NSString *content0Key = [itemTmp objectForKey:@"PFXMPFNR"];
                    NSString *content0    = [itemTmp objectForKey:@"PFNR"];
                    NSString *reason0Key  = [itemTmp objectForKey:@"PFXMKFYY"];
                    NSString *reason0     = [itemTmp objectForKey:@"KFYY"];
                    NSString *score0Key   = [itemTmp objectForKey:@"PFXMDF"];
                    NSString *score0      = [itemTmp objectForKey:@"DF"];
                    NSString *FQXZXTBQ0   = [itemTmp objectForKey:@"FQXZXTBQ"];
                    NSString *FQXZXTYZ0   = [itemTmp objectForKey:@"FQXZXTYZ"];
                    NSString *FQXZXTSC0   = [itemTmp objectForKey:@"FQXZXTSC"];
                    NSString *FQSJYZXSC0  = [itemTmp objectForKey:@"FQSJYZXSC"];
                    NSString *FQSJYZXSZ0  = [itemTmp objectForKey:@"FQSJYZXSZ"];
                    NSString *FQSJYZXYZ0  = [itemTmp objectForKey:@"FQSJYZXYZ"];
                    [cellInfo setObject:content0 forKey:content0Key];
                    [cellInfo setObject:reason0  forKey:reason0Key];
                    [cellInfo setObject:score0   forKey:score0Key];
                    [cellInfo setObject:FQXZXTBQ0  forKey:@"FQXZXTBQ"];
                    [cellInfo setObject:FQXZXTYZ0  forKey:@"FQXZXTYZ"];
                    [cellInfo setObject:FQXZXTSC0  forKey:@"FQXZXTSC"];
                    [cellInfo setObject:FQSJYZXSC0 forKey:@"FQSJYZXSC"];
                    [cellInfo setObject:FQSJYZXSZ0 forKey:@"FQSJYZXSZ"];
                    [cellInfo setObject:FQSJYZXYZ0 forKey:@"FQSJYZXYZ"];
                    
                    if ([content1Tmp isEqual:contentTmp]) {
                        [cellAry addObject:cellInfo];
                    }
                    else {
                        [aryValues addObject:cellAry];
                        index = j-1;
                        break;
                    }
                    
                    if (j == [zbAry count] - 1) {
                        [aryValues addObject:cellAry];
                        index = j;
                    }

                }
            }
        }
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:aryValues forKey:@"content"];
        [dict setObject:totalScore forKey:@"total"];
        [dict setObject:jcdwStr forKey:@"ZFJCDW"];
        [dict setObject:dwmcStr forKey:@"DWMC"];
        [dict setObject:dwdzStr forKey:@"DWDZ"];
        [dict setObject:ywgsStr forKey:@"YWGS"];
        [dict setObject:zdsxStr forKey:@"ZDSX"];
        [dict setObject:cbqkStr forKey:@"ZDJCSJSFYCBQK"];
        [dict setObject:cbzbStr forKey:@"CBZB"];
        
        [self displayRecordDatas:dict];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
}



#pragma mark -
#pragma mark tableview datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *projectArray = [checkDict objectForKey:@"projectArray"];
    NSArray *contentArray = [projectArray objectAtIndex:section];
    return [contentArray count];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *keyArray = [checkDict objectForKey:@"keyArray"];
    return [keyArray count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *keyArray = [checkDict objectForKey:@"keyArray"];
    return [keyArray objectAtIndex:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    NSString *myIdentifier = @"masterCell";
    NSString *score;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier] autorelease];
    }
    
    NSArray *projectArray = [checkDict objectForKey:@"projectArray"];
    NSDictionary *cellContent =  [[projectArray objectAtIndex:section] objectAtIndex:row];
    score = [cellContent objectForKey:@"score"];
    
    if (score != nil) {
        NSString *scoreStr = [NSString stringWithFormat:@"得分%@",score];
        UIImageView *scoreView =  [LKDrawLabBgImage getParameterCreateLabBgImage:scoreStr
                                                                         strFont:[UIFont fontWithName:@"Times New Roman" size:14.0f]];
        cell.accessoryView = scoreView;
    }
    cell.textLabel.text = [cellContent objectForKey:@"title"];
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *currentSelected = [tableView indexPathForSelectedRow];
    if (currentSelected != lastSelected) {
        lastSelected = currentSelected;
    }
    BOOL isSave =  [detailViewController saveLastDetailViewData];
    
    if (!isSave) {
        return lastSelected;
    }
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = [tableView indexPathForSelectedRow];
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    NSArray *projectArray = [checkDict objectForKey:@"projectArray"];
    
    NSDictionary  *tableData = [[[projectArray objectAtIndex:section] objectAtIndex:row] objectForKey:@"content"];
    NSString *score =  [[[projectArray objectAtIndex:section] objectAtIndex:row] objectForKey:@"score"];
    NSString *shortName = [[[projectArray objectAtIndex:section] objectAtIndex:row] objectForKey:@"short"];
    
    detailViewController.tableDict = tableData;
    detailViewController.shortName = shortName;
    detailViewController.scoreTotal = [score intValue];
    [detailViewController reloadTableView];
}

@end
