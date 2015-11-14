//
//  JCJLBaseViewController.m
//  GMEPS_HZ
//
//  Created by 张仁松 on 13-4-19.
//
//

#import "JCJLBaseViewController.h"
#import "FieldInspectionVC.h"
#import "HouseAndPublicArcVC.h"
#import "YingjiViewController.h"
#import "JanSheViewController.h"
#import "GGDMJConfig.h"
#import "SharedInformations.h"
#import "GUIDGenerator.h"
#import "WebServiceHelper.h"
#import "GMEPS_HZAppDelegate.h"
extern GMEPS_HZAppDelegate *g_appDelegate;
#import "UserInfo.h"
extern UserInfo *g_logedUserInfo;
#import "BaseRecordViewController.h"
#import "JianCeSmokeViewController.h"
#import "JianCeWaterViewController.h"
#import "DBHelper.h"
#import "OMGToast.h"
@interface JCJLBaseViewController ()

@property(nonatomic,retain)NSMutableString *currentdata;
@property(nonatomic,retain)NSString *ssqyDM;
@property(nonatomic,retain)NSString *qlsxDM;
@property(nonatomic,retain)NSString *jcsyDM;

@property (nonatomic, retain) UIPopoverController *popController;
@property(nonatomic,retain) UITextField *curField;//当前选择的textfield
@property(nonatomic,retain) NSMutableArray *surePerson;

@property(nonatomic,retain) NSMutableArray *aryMenuViews;//菜单的相关视图
@property(nonatomic,copy) NSString *dwbh;
@property(nonatomic,copy) NSString *wrymc;
@property(nonatomic,copy) NSString *xczfbh;
@property(nonatomic,copy) NSString *jcry;//检查人员
@property(nonatomic,copy) NSString *jcrbh;//检查人员id
@property(nonatomic,copy) NSString *zfzjh;//执法证件号
@property(nonatomic,copy) NSString *jcrbmbh;//检查人部门编号
@property(nonatomic,copy) NSString *wryJD;
@property(nonatomic,copy) NSString *wryWD;
@property(nonatomic,retain)UIButton *btnTitleView;
@property(nonatomic,retain) NSMutableArray *statusAry;
@property(nonatomic, retain) NSDictionary *projectInfo;
@property(nonatomic,retain)UIPopoverController *popRecordController;

@end

@implementation JCJLBaseViewController
@synthesize curField,surePerson;
@synthesize ssqyDM,qlsxDM,jcsyDM,zfzjh,jcrbh,jcrbmbh,wryJD,wryWD;
@synthesize popController,aryMenuViews,popRecordController;
@synthesize dwbh,wrymc,xczfbh,btnTitleView,currentdata;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        recordStatus = Record_None;
        self.statusAry = [NSMutableArray arrayWithObjects:@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",nil];
    }
    return self;
}

-(void)Signame{
    
    SignNameController *controller = [[[SignNameController alloc] initWithNibName:@"SignNameController" bundle:nil] autorelease];
    
    controller.delegate = self;
    controller.wrybh = self.dwbh;
    controller.wrymc = wrymc;
    controller.xczfbh = xczfbh;
    controller.tableName = @"signNameTable";
    controller.lxBH = 1;
    if([surePerson count] >=2){
        UserInfo *aInfo1 = [surePerson objectAtIndex:0];
        UserInfo *aInfo2 = [surePerson objectAtIndex:1];
        controller.firstName = aInfo1.userName;
        controller.secondName = aInfo2.userName;
    }
    
    
    controller.modalPresentationStyle =  UIModalPresentationFormSheet;
    [self presentModalViewController:controller animated:YES];
    controller.view.superview.frame = CGRectMake(0, 1024-630, 768, 630);
    
}

- (void)checkFormToFill{
       
    

}

- (void)commitRecords:(id)sender{
    NSString *errMsg = @"";
    if ([ssqyField.text length] <=0)
        errMsg = @"请选择区域。";
    else if ([jcjssjField.text length] <=0)
        errMsg = @"请选择检查结束时间。";
    else if ([jcryField.text length] <=0)
        errMsg = @"请选择检查人员。";
    else if ([jcsyField.text length] <=0)
        errMsg = @"请填写检查事由。";
    else if([surePerson count] <2){
        errMsg = @"检查人员人数不能少于两人，请添加检查人员。";
    }
    
    if([errMsg length]>0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:errMsg
                              delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }

    NSArray *aryChildRecords = [[DBHelper sharedInstance] queryRecordByXCZFBH:xczfbh];
    if([aryChildRecords count] <=0)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"请完成相关子记录！"
                              delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
    [self Signame];
}

-(void)signFinished{
    [self commitRecord];
}

//处理监测评分字符串
-(NSArray*)parseJiancePFStr:(NSString*)dataStr andType:(NSString*)type{
    NSDictionary* dicItem =  [NSJSONSerialization JSONObjectWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    if(dicItem == nil)return nil;
    NSMutableArray *aryZBItems = [NSMutableArray arrayWithCapacity:10];
    NSArray *contentAry = [dicItem objectForKey:@"content"];
    NSString *lx = [type isEqualToString:@"smoke"]?@"1":@"2";
    NSString *bh = [dicItem objectForKey:@"BH"];
    for(NSArray *aryChild in contentAry){
        for(NSDictionary *dicChildItem in aryChild){
            NSMutableDictionary *dicResult = [NSMutableDictionary dictionaryWithCapacity:4];
            [dicResult setObject:lx forKey:@"LX"];
            [dicResult setObject:[GUIDGenerator generateGUID] forKey:@"XH"];
            [dicResult setObject:bh forKey:@"BH"];
            //  [dicResult setObject:[dicChildItem objectForKey:@"BH"] forKey:@"BH"];
            NSArray *aryChildItemKeys = [dicChildItem allKeys];
            for(NSString *key in aryChildItemKeys){
                NSString *flag = [key substringWithRange:NSMakeRange([key length] -3, 2)];
                if([flag isEqualToString:@"NR"]){//评分内容
                    NSString *str = [NSString stringWithFormat:@"%@",[dicChildItem objectForKey:key]];
                    [dicResult setObject:str forKey:@"PFNR"];
                    [dicResult setObject:key forKey:@"PFXMPFNR"];
                    
                }else if([flag isEqualToString:@"YY"]){//评分内容
                    NSString *str = [NSString stringWithFormat:@"%@",[dicChildItem objectForKey:key]];
                    [dicResult setObject:str forKey:@"KFYY"];
                    [dicResult setObject:key forKey:@"PFXMKFYY"];
                }else if([flag isEqualToString:@"DF"]){//评分内容
                    NSString *str = [NSString stringWithFormat:@"%@",[dicChildItem objectForKey:key]];
                    [dicResult setObject:str forKey:@"DF"];
                    [dicResult setObject:key forKey:@"PFXMDF"];
                }else{
                    [dicResult setObject:[dicChildItem objectForKey:key] forKey:key];
                }
                
            }
            //一行子表
            [aryZBItems addObject:dicResult];
            
        }
    }
    
    return aryZBItems;
}

//水、气有主表T_YDZF_ZXXCDFB 和子表T_YDZF_ZXXCDFBZB
-(void)commitRecord{
    NSArray *aryChildRecords = [[DBHelper sharedInstance] queryRecordByXCZFBH:xczfbh];
    NSMutableDictionary *dicValues = [self restoreValues];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:60*60]];
    [dateFormatter release];
    [dicValues setValue:dateString forKey:@"TJSJ"];
    

    NSArray *aryJbxx = [NSArray arrayWithObject:dicValues];    
    NSMutableDictionary *dicAllRecords = [NSMutableDictionary dictionaryWithCapacity:6];
    [dicAllRecords setObject:aryJbxx forKey:@"T_YDZF_JBXX"];
    
    for(NSDictionary *dicChildItem in aryChildRecords){
        NSString *valueJson = [dicChildItem objectForKey:@"JSON"];
        //评分的jsonstr
        NSString*tableName = [dicChildItem objectForKey:@"TABLENAME"];
        
        if([tableName isEqualToString:@"T_YDZF_ZXXCDFBZB"]){
            NSString *tablelx = [dicChildItem objectForKey:@"TYPE"];
            
            NSArray *aryZBItems = [self parseJiancePFStr:valueJson andType:tablelx];
            NSMutableArray *arySaveItems = [dicAllRecords objectForKey:@"T_YDZF_ZXXCDFBZB"];
            if(arySaveItems == nil)
                arySaveItems = [NSMutableArray arrayWithCapacity:3];
            if (aryZBItems) {
                [arySaveItems addObjectsFromArray:aryZBItems];
                
            }
            [dicAllRecords setObject:arySaveItems forKey:tableName];
        }
        else if([tableName isEqualToString:@"T_YDZF_ZXXCDFB"]){
            
            NSMutableArray *aryItems = [dicAllRecords objectForKey:@"T_YDZF_ZXXCDFB"];
            if(aryItems == nil){
                aryItems = [NSMutableArray arrayWithCapacity:3];
            }
            
            NSDictionary* dataInfo =  [NSJSONSerialization JSONObjectWithData:[valueJson dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
            NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithDictionary:dataInfo];
            [dicParams setValue:g_logedUserInfo.userName forKey:@"CJR"];
            [dicParams setValue:dateString forKey:@"CJSJ"];
            [aryItems addObject:dicParams];
            [dicAllRecords setObject:aryItems forKey:@"T_YDZF_ZXXCDFB"];
            
        }
        else if ([tableName isEqualToString:@"signNameTable"]) {
            
        }
        else if([tableName isEqualToString:@"T_YDZF_ZFGSZ"]) {
            
        }
        else{
            NSDictionary* dataInfo =  [NSJSONSerialization JSONObjectWithData:[valueJson dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
            NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithDictionary:dataInfo];
            [dicParams setValue:g_logedUserInfo.userName forKey:@"CJR"];
            NSArray *aryTmp = [NSArray arrayWithObject:dicParams];
            [dicAllRecords setObject:aryTmp forKey:tableName];
        }
        
    }
    
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicAllRecords options:NSJSONWritingPrettyPrinted error:&error];
    
    
    NSString *jsonStr = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@",jsonStr);
    NSString* params = [WebServiceHelper createParametersWithKey:@"commandString"														   value:jsonStr,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    
    NSString *url = [NSString  stringWithFormat: KQueueServiceURL,g_appDelegate.ServerIP];
    WebServiceHelper *webService = [[WebServiceHelper alloc]
                                     initWithUrl:url
                                     method:@"ProcessQueueT_Log_UDID"
                                     view:self.view
                                     nameSpace:KSoapNameSpace
                                     parameters:params
                                     delegate:self];
    [webService run];
    [jsonStr release];
}


-(void)initUIDatas{
    fddbrdhField.delegate = self;
    
    hblxrdhField.delegate = self;
    
    jcryField.delegate= self;
    [jcryField addTarget:self action:@selector(choosePerson:) forControlEvents:UIControlEventTouchDown];
    jcsjField.delegate= self;
    [jcsjField addTarget:self action:@selector(touchFromDate:) forControlEvents:UIControlEventTouchDown];
    jcjssjField.delegate = self;
    [jcjssjField addTarget:self action:@selector(touchFromDate:) forControlEvents:UIControlEventTouchDown];
    ssqyField.delegate= self;
    [ssqyField addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchDown];
    qlsxField.delegate= self;
    [qlsxField addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchDown];
    jcsyField.delegate= self;
    [jcsyField addTarget:self action:@selector(touchJCSYField:) forControlEvents:UIControlEventTouchDown];
    
    //导航中间部分
    btnTitleView = [[UIButton buttonWithType:UIButtonTypeRoundedRect ] retain];
    btnTitleView.tintColor = [UIColor lightGrayColor];
    btnTitleView.frame = CGRectMake(0, 0, 380, 35);
    [btnTitleView addTarget:self action:@selector(selectPolutionSrc) forControlEvents:UIControlEventTouchUpInside];
    [btnTitleView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.navigationItem.titleView  = btnTitleView;
    
    
    UIBarButtonItem *anotherButton0 = [[UIBarButtonItem alloc] initWithTitle:@"获取暂存记录" style:UIBarButtonItemStyleDone
                                                                      target:self action:@selector(qyBilu:)];
    
    UIBarButtonItem *anotherButton1 = [[UIBarButtonItem alloc] initWithTitle:@"暂存" style:UIBarButtonItemStyleDone
                                                                      target:self action:@selector(saveRecord)];
    
    UIBarButtonItem *anotherButton2 = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(commitRecords:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:anotherButton2,anotherButton0,anotherButton1, nil];
    
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
}

-(void)generateXCZFBH{
    if([[DBHelper sharedInstance] hasCommitBL:self.wrymc andTableName:@"T_YDZF_JBXX"]){
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
        
    }else{
        self.xczfbh = [[DBHelper sharedInstance] getXCZFBHByMc:self.wrymc];
        alertType = kAlert_Choose;
    }
    
}

-(void)resetDefaultDatas{
    
    [self generateXCZFBH];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    jcsjField.text = dateString;
    
    if(aryMenuViews == nil) {
        
        self.aryMenuViews = [NSMutableArray arrayWithCapacity:6];
    }
    else{
        for(UIView *aView in aryMenuViews){
            [aView removeFromSuperview];
        }
        [aryMenuViews removeAllObjects];
    }
    hylxSegCtrl.selectedSegmentIndex = 6;
    jcsyField.text = @"日常监察";
    
    qlsxField.text = @"环境保护现场检查";
    

    self.jcsyDM = @"5601";
    self.qlsxDM = @"HZ01HB-JG-0001";
    [self returnJCSYDMNRs:[NSArray arrayWithObject:@"日常监察"] andDMZs:[NSArray arrayWithObject:@"5601"]];
}

-(void)changeRecordStatus:(NSNotification*)notify{
    NSInteger tagID = [notify.object integerValue];
    [self.statusAry replaceObjectAtIndex:tagID -1 withObject:@"YES"];
    for(UIView *aView in aryMenuViews){
        if([aView isKindOfClass:[UILabel class]] && aView.tag ==tagID ){
            UILabel *label = (UILabel*)aView;
            label.textColor = [UIColor blueColor];
            label.text = @"已填写";
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //NSArray *ary = [[DBHelper sharedInstance] queryYinziByType:@"FS"];
    //NSLog(@"%@",[ary objectAtIndex:0]);
    
    [self initUIDatas];
    [self selectPolutionSrc];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRecordStatus:) name:@"RecordStatus" object:nil];
}

-(void)selectPolutionSrc{
	UISearchSitesController *controller = [[UISearchSitesController alloc] initWithNibName:@"UISearchSitesController" bundle:nil];
    controller.isEnable = YES;
	[controller setDelegate:self];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
	nav.modalPresentationStyle =  UIModalPresentationFormSheet;
	[self presentModalViewController:nav animated:YES];
	nav.view.superview.frame = CGRectMake(30, 100, 700, 748);
	 nav.view.superview.center = self.view.center;
    
	
	[controller release];
	[nav release];
	
}

-(void)addMenuBtnTitle:(NSString*)title ImgName:(NSString*)imgName Frame:(CGRect)rect TagID:(NSInteger)tagID{
    if(aryMenuViews == nil) {
        self.aryMenuViews = [NSMutableArray arrayWithCapacity:6];
    }
    
    UIButton *btn =[[UIButton alloc] initWithFrame:
                    rect];
    btn.tag = tagID ;
    
    btn.backgroundColor = [UIColor clearColor];
    [btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    
    
    [btn addTarget:self action:@selector(btnMenuPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [aryMenuViews addObject:btn];
    [btn release];
    
    UILabel *btnLabel = [[UILabel alloc] initWithFrame:
                         CGRectMake(rect.origin.x-10,
                                    rect.origin.y+rect.size.height-20,
                                    rect.size.width+20, 50)];
    btnLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    btnLabel.numberOfLines = 2;
    btnLabel.text = title;
    btnLabel.textAlignment = UITextAlignmentCenter;
    btnLabel.backgroundColor = [UIColor clearColor];
    btnLabel.contentMode =  UIViewContentModeTop;
    [self.view addSubview:btnLabel];
    [aryMenuViews addObject:btnLabel];
    [btnLabel release];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:
                          CGRectMake(rect.origin.x-10,
                                     rect.origin.y+rect.size.height + 30,
                                     rect.size.width+20, 22)];
    infoLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    if ([[self.statusAry objectAtIndex:tagID-1] isEqualToString:@"YES"]) {
        infoLabel.textColor = [UIColor blueColor];
        infoLabel.text = @"已填写";
    }
    else{
        infoLabel.textColor = [UIColor redColor];
        infoLabel.text = @"未完成";
    }
    
    infoLabel.tag = tagID;
    infoLabel.textAlignment = UITextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.contentMode =  UIViewContentModeTop;
    [self.view addSubview:infoLabel];
    [aryMenuViews addObject:infoLabel];
    [infoLabel release];
    
}


-(IBAction)getLocation:(id)sender{
//    if (![CLLocationManager locationServicesEnabled]) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在系统设置中打开\"定位服务\"来允许\"环保执法通\"确定你的位置 " delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
//        [alertView show];
//        [alertView release];
//        return;
//    }
    UIButton *btn = (UIButton*)sender;
    WryLocationVC *location = [[WryLocationVC alloc] initWithNibName:@"WryLocationVC" bundle:nil];
    location.delegate =self;
    UIPopoverController *tmppopover = [[UIPopoverController alloc] initWithContentViewController:location];
    self.popController = tmppopover;
	[location release];
   [tmppopover release];
    
	[self.popController presentPopoverFromRect: btn.frame
                                        inView:self.view
                      permittedArrowDirections:UIPopoverArrowDirectionAny
                                      animated:YES];
    
}

-(void)dismissLocation {
    if (popController) {
        [popController dismissPopoverAnimated:YES];
    }
}


-(void)btnMenuPressed:(id)sender{
    NSInteger tag = [sender tag];
    
    NSMutableDictionary *dicValues = [NSMutableDictionary dictionaryWithCapacity:15];
    [dicValues setValue:g_logedUserInfo.userORGID forKey:@"ORGID"];
    [dicValues setValue:jcryField.text forKey:@"JCR"];
    [dicValues setValue:jcdwField.text forKey:@"JCRBM"];
    [dicValues setValue:zfzhField.text forKey:@"ZJH"];
    [dicValues setValue:jcsjField.text forKey:@"JCSJ"];
    [dicValues setValue:jcjssjField.text forKey:@"JCJSSJ"];
    [dicValues setValue:dwmcField.text forKey:@"DWMC"];
    [dicValues setValue:dwdzField.text forKey:@"DWDZ"];
    [dicValues setValue:fddbrField.text forKey:@"DWFZR"];
    [dicValues setValue:fddbrdhField.text forKey:@"DWFZRDH"];
    [dicValues setValue:hblxrField.text forKey:@"HBFZR"];
    [dicValues setValue:hblxrdhField.text forKey:@"HBFZRDH"];
    [dicValues setValue:ssqyField.text forKey:@"SSQYNR"];
    [dicValues setValue:ssqyDM forKey:@"SSQY"];
    [dicValues setValue:jdField.text forKey:@"WRYJD"];
    [dicValues setValue:wdField.text forKey:@"WRYWD"];
    [dicValues setValue:dwbh forKey:@"DWBH"];
    
    NSArray *aryGllb = [NSArray arrayWithObjects:@"9901",@"9902",@"9903",@"9904",@"9905", nil];
    NSArray *aryHylx = [NSArray arrayWithObjects:@"3301",@"3302",@"3303",@"3304",@"3305",@"3306",@"33999", nil];
    NSString *strGllb = [aryGllb objectAtIndex:gllbSegCtrl.selectedSegmentIndex];
    NSString *strHylx = [aryHylx objectAtIndex:hylxSegCtrl.selectedSegmentIndex];
    [dicValues setValue:strGllb forKey:@"GLLB"];
    [dicValues setValue:strHylx forKey:@"SSHY"];
    [dicValues setValue:g_logedUserInfo.userName forKey:@"LRR"];
    
    
    
    NSString *isSave = [self.statusAry objectAtIndex:tag-1];
    
    UIButton *btn = (UIButton*)sender;
    BaseRecordViewController *controller = nil;
    if (btn.tag == BTNMenu_1) {
        controller = [[FieldInspectionVC alloc] init];
    }
    else if (btn.tag == BTNMenu_2) {
        controller = [[JanSheViewController alloc] initWithNibName:@"JanSheViewController" bundle:nil];
    }
    else if (btn.tag == BTNMenu_3) {
        controller = [[HouseAndPublicArcVC alloc] init];
    }
    else if (btn.tag == BTNMenu_4) {
        controller = [[YingjiViewController alloc] init];
    }
    else if (btn.tag == BTNMenu_5) {
        JianCeWaterViewController *vc= [[JianCeWaterViewController alloc] initWithNibName:@"JianCeWaterViewController" bundle:nil];
        vc.tableBH = [GUIDGenerator generateGUID];
        vc.tableName = @"T_YDZF_ZXXCDFBZB";
        vc.xczfbh = xczfbh;
        vc.menuTagID = btn.tag;
        vc.isSaveRecord = [isSave boolValue];
        vc.dicWryInfo = dicValues;
        vc.wrymc =wrymc;
        
        [self.navigationController pushViewController:vc animated:YES];
		[vc release];
        return;
    }
    else if (btn.tag == BTNMenu_6) {
        JianCeSmokeViewController *vc= [[JianCeSmokeViewController alloc] initWithNibName:@"JianCeSmokeViewController" bundle:nil];
        vc.xczfbh = xczfbh;
        vc.wrymc =wrymc;
        vc.tableBH = [GUIDGenerator generateGUID];
        vc.tableName = @"T_YDZF_ZXXCDFBZB";
        vc.menuTagID = btn.tag;
        vc.isSaveRecord = [isSave boolValue];
        vc.dicWryInfo = dicValues;
        
        [self.navigationController pushViewController:vc animated:YES];
		[vc release];
        return;
    }
    
    if (controller != nil) {
        controller.menuTagID = btn.tag;
        controller.xczfbh = xczfbh;
        controller.wrymc = wrymc;
        controller.dwbh = dwbh;
        controller.isSaveRecord = [isSave boolValue];
        controller.dicWryInfo = dicValues;
        if (btn.tag == BTNMenu_2 || btn.tag == BTNMenu_3) {
            controller.dicWryInfo = self.projectInfo;
        }
        
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
	}
    
}

-(void)beginEditing:(id)sender{
	UITextField *ctrl = (UITextField*)sender;
    self.curField = ctrl;
    CommenWordsViewController *tmpController = [[CommenWordsViewController alloc] initWithNibName:@"CommenWordsViewController" bundle:nil ];
	tmpController.contentSizeForViewInPopover = CGSizeMake(200, 350);
	tmpController.delegate = self;
    if (ctrl.tag==TAG_QLSX) {
        tmpController.contentSizeForViewInPopover = CGSizeMake(500, 450);
        tmpController.wordsAry = [GGDMJConfig getDMNRByDMJBH:@"XZJG"];
        
    }
    else if(ctrl.tag == TAG_SSQY)
    {
        tmpController.contentSizeForViewInPopover = CGSizeMake(200, 350);
        tmpController.wordsAry = [GGDMJConfig getDMNRByDMJBH:@"SSQY"];
    }
    
    UIPopoverController *tmppopover = [[UIPopoverController alloc] initWithContentViewController:tmpController];
    self.popController = tmppopover;
	[tmpController release];
    [tmppopover release];
    
	[self.popController presentPopoverFromRect: ctrl.frame
                                        inView:self.view
                      permittedArrowDirections:UIPopoverArrowDirectionAny
                                      animated:YES];
}


-(void)touchFromDate:(id)sender{
    PopupDateViewController *dateController = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDateAndTime];
    dateController.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
    
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.popController = popover;
    
    [popover release];
    [nav release];
    [dateController release];
    
	UIControl *btn =(UIControl*)sender;
    currentTag = btn.tag;
	[popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)touchJCSYField:(id)sender{
    SelectJcsyViewController *jcsyController = [[SelectJcsyViewController alloc] initWithStyle:UITableViewStyleGrouped];
    jcsyController.delegate = self;
    jcsyController.jcsyStr = jcsyField.text;
    jcsyController.contentSizeForViewInPopover = CGSizeMake(320, 330);
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:jcsyController];
    
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.popController = popover;
    
    [popover release];
    [nav release];
    [jcsyController release];
    UIControl *btn =(UIControl*)sender;
    [popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)Saved selectedDate:(NSDate*)date{
	[popController dismissPopoverAnimated:YES];
	if (Saved) {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
		NSString *dateString = [dateFormatter stringFromDate:date];
		[dateFormatter release];
        if (currentTag == TAG_KSSJ) {
            jcsjField.text =  dateString;
        }
        if (currentTag == TAG_JSSJ) {
            jcjssjField.text =  dateString;
            if (([jcsjField.text compare:jcjssjField.text] == NSOrderedDescending)||
                [jcsjField.text compare:jcjssjField.text] == NSOrderedSame)
            {
                
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"提示"
                                      message:@"检查结束时间不能早于等于开始时间"
                                      delegate:nil
                                      cancelButtonTitle:@"确定"
                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
                [jcjssjField becomeFirstResponder];
                jcjssjField.text=@"";
                
            }
        }
	}
    
}

-(void)choosePerson:(id)sender{
    UIControl *control = (UIControl*)sender;
    PersonSelectControllerView *tmpController =
    [[PersonSelectControllerView alloc] initWithStyle:UITableViewStyleGrouped];
    tmpController.delegate1 = self;
    tmpController.contentSizeForViewInPopover = CGSizeMake(350, 700);
    SharedInformations *info = [SharedInformations sharedSharedInformations];
    if ([surePerson count]==0||surePerson == nil) {
        info.people = [NSMutableArray arrayWithObject:g_logedUserInfo];
    }
    else
        info.people = surePerson;
    
    UINavigationController *tmpNav = [[UINavigationController alloc] initWithRootViewController:tmpController];
    
    UIPopoverController *tmpPopover = [[UIPopoverController alloc] initWithContentViewController:tmpNav];
    self.popController = tmpPopover;
    [tmpPopover release];
    [tmpNav release];
    [tmpController release];
    
    [self.popController presentPopoverFromRect:control.frame
                                        inView:self.view
                      permittedArrowDirections:UIPopoverArrowDirectionAny
                                      animated:YES];
}

-(void)returnLatitude:(NSString*)latitude Longitude:(NSString*)longitude{
    
    NSArray *jdAry = [longitude componentsSeparatedByString:@"."];
    NSArray *wdAry = [latitude componentsSeparatedByString:@"."];
    NSString *degree = [jdAry objectAtIndex:0];
    NSString *minute = [jdAry objectAtIndex:1];
    NSString *second = [jdAry objectAtIndex:2];
    
    self.wryJD = [NSString stringWithFormat:@"%f",[degree intValue]+[minute floatValue]/60+[second floatValue]/3600];
    jdField.text = [NSString stringWithFormat:@"%@°%@′%@′′",degree,minute,second];
    
    degree = [wdAry objectAtIndex:0];
    minute = [wdAry objectAtIndex:1];
    second = [wdAry objectAtIndex:2];
    self.wryWD = [NSString stringWithFormat:@"%f",[degree intValue]+[minute floatValue]/60+[second floatValue]/3600];
    
    
    wdField.text = [NSString stringWithFormat:@"%@°%@′%@′′",degree,minute,second];
    
    [popController dismissPopoverAnimated:YES];
}

-(void)returnSites:(NSDictionary*)values source:(NSInteger)type{
    if (values == nil) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    else if(type == 0){
        if ([values count] == 1) {
            [self.btnTitleView setTitle:[values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.wrymc  =dwmcField.text = [values objectForKey:@"WRYMC"];
            self.dwbh  = @"";
            dwdzField.text = @"";
            fddbrField.text = @"";
            //fddbrdhField.text = @"";
            self.ssqyDM = @"";
            ssqyField.text = @"";
            jcdwField.text = @"";
            jcryField.text = @"";
            hblxrdhField.text = @"";
            hblxrField.text = @"";
            jdField.text =@"";
            zfzhField.text = @"";
            wdField.text = @"";
        }
        else
        {
            self.dwbh  = [values objectForKey:@"WRYBH"];
            
            self.wrymc  = dwmcField.text = [values objectForKey:@"WRYMC"];
            
            dwdzField.text = [values objectForKey:@"DWDZ"];
            fddbrField.text = [values objectForKey:@"FRDB"];
            //fddbrdhField.text =  [values objectForKey:@"FRDBDH"];
            self.ssqyDM = [values objectForKey:@"SZXZQ"];
            ssqyField.text = [GGDMJConfig getDMNRByDMJBH:@"SSQY" andDM:ssqyDM];
            jcdwField.text = g_logedUserInfo.userDanwei;
            jcryField.text = g_logedUserInfo.userName;
            zfzhField.text = g_logedUserInfo.ZFZJBH;
            hblxrdhField.text = [values objectForKey:@"HBRLXDH"];
            hblxrField.text = [values objectForKey:@"HBLXR"];
            
            NSString *degree = [values objectForKey:@"JDD"];
            NSString *minute = [values objectForKey:@"JDM"];
            NSString *second = [values objectForKey:@"JDF"];
            self.wryJD = [NSString stringWithFormat:@"%f",[degree intValue]+[minute floatValue]/60+[second floatValue]/3600];
            
            NSString *strJD = [NSString stringWithFormat:@"%@°%@′%@′′",[values objectForKey:@"JDD"],[values objectForKey:@"JDF"],[values objectForKey:@"JDM"]];
            
            degree = [values objectForKey:@"WDD"];
            minute = [values objectForKey:@"WDM"];
            second = [values objectForKey:@"WDF"];
            self.wryWD = [NSString stringWithFormat:@"%f",[degree intValue]+[minute floatValue]/60+[second floatValue]/3600];
            
            NSString *strWD = [NSString stringWithFormat:@"%@°%@′%@′′",[values objectForKey:@"WDD"],[values objectForKey:@"WDF"],[values objectForKey:@"WDM"]];
            jdField.text = strJD;
            wdField.text = strWD;
            NSInteger gllb = [[values objectForKey:@"QYGM"] integerValue] ;
            if(gllb > 0)
                gllbSegCtrl.selectedSegmentIndex = gllb;
            else
                gllbSegCtrl.selectedSegmentIndex = 4;
            [self.btnTitleView setTitle: self.wrymc forState:UIControlStateNormal];
        }
        
    }
    else {
        mcLabel.text = @"建设项目名称：";
        dzLabel.text = @"建设地址：";
        [self.btnTitleView setTitle:[values objectForKey:@"XMMC"] forState:UIControlStateNormal];
        //self.wrymc  =dwmcField.text = [values objectForKey:@"TZDW"];
        self.dwbh  = @"";
        //dwdzField.text = [values objectForKey:@"TZDWDZ"];
        self.wrymc   = [values objectForKey:@"XMMC"];
        dwmcField.text = [values objectForKey:@"XMMC"];
        dwdzField.text = [values objectForKey:@"JSDD"];
        fddbrField.text =[values objectForKey:@"FRDB"];
        fddbrdhField.text =[values objectForKey:@"FRLXDH"] ;
        self.ssqyDM = @"";
        ssqyField.text = [values objectForKey:@"XZQH"];
        jcdwField.text = g_logedUserInfo.userDanwei;
        jcryField.text = g_logedUserInfo.userName;
        zfzhField.text = g_logedUserInfo.ZFZJBH;
        
        hblxrdhField.text = @"";
        hblxrField.text = @"";
        jdField.text =@"";
        wdField.text = @"";
        
        NSString *jsdd =  [values objectForKey:@"JSDD"];
        NSString *xmmc = [values objectForKey:@"XMMC"];
        NSString *frdb = [values objectForKey:@"FRDB"];
        NSString *frlxdh = [values objectForKey:@"FRLXDH"];
        NSString *lxr =  [values objectForKey:@"LXR"];
        NSString *lxdh = [values objectForKey:@"LXRTEL"];
        NSString *spwh = [values objectForKey:@"SPWH"];
        NSString *sprq = [values objectForKey:@"SPRQ"];
        NSString *xmlx = [values objectForKey:@"XMLXMC"];
        
        self.projectInfo = [NSDictionary dictionaryWithObjectsAndKeys:xmmc,@"XMMC",jsdd,@"JSDZ",frdb,@"FRDB",frlxdh,@"FRLXDB",lxr,@"XMLXR",lxdh,@"XMLXDH",spwh,@"SPWH",sprq,@"SPSJ",xmlx,@"XMLX",nil];
    }
    [self resetDefaultDatas];
    
}

-(void)returnJCSYDMNRs:(NSArray*)jcsys andDMZs:(NSArray*)dms{
    [popController dismissPopoverAnimated:YES];
    NSMutableString *strDMNR = [NSMutableString stringWithCapacity:20];
    NSMutableString *strDM = [NSMutableString stringWithCapacity:20];
    for(NSString  *str in dms){
        if([str length] >0){
            if([strDM length] > 0)
                [strDM appendFormat:@",%@",str];
            else
                [strDM appendFormat:@"%@",str];
        }
    }
    
    for(NSString  *str in jcsys){
        if([str length] >0){
            if([strDMNR length] > 0)
                [strDMNR appendFormat:@",%@",str];
            else
                [strDMNR appendFormat:@"%@",str];
        }
        
    }
    
    if(aryMenuViews == nil)
        self.aryMenuViews = [NSMutableArray arrayWithCapacity:6];
    else{
        for(UIView *aView in aryMenuViews){
            [aView removeFromSuperview];
        }
        [aryMenuViews removeAllObjects];
    }
    
     
    self.jcsyDM = strDM;

    jcsyField.text = strDMNR;
    CGFloat xPos = 80,yPos = 750;

    if([dms containsObject:@"5601"] || [dms containsObject:@"5602"] || [dms containsObject:@"5603"]|| [dms containsObject:@"5607"]){
        
        [self addMenuBtnTitle:@"现场监察记录" ImgName:@"jcjl_1_1.png" Frame:CGRectMake(xPos,yPos,85,85) TagID:BTNMenu_1];
        xPos += 110;
    }
    
    if([dms containsObject:@"5604"] ){
        [self addMenuBtnTitle:@"工业项目三同时跟踪表" ImgName:@"jcjl_1_2.png" Frame:CGRectMake(xPos,yPos,85,85) TagID:BTNMenu_2];
        xPos += 110;
        
        [self addMenuBtnTitle:@"非工业项目三同时跟踪表" ImgName:@"jcjl_1_3.png" Frame:CGRectMake(xPos,yPos,85,85) TagID:BTNMenu_3];
        xPos += 110;
        
    }
    if([dms containsObject:@"5605"] ){
        
        [self addMenuBtnTitle:@"在线打分(水)" ImgName:@"jcjl_1_5.png" Frame:CGRectMake(xPos,yPos,85,85) TagID:BTNMenu_5];
        xPos += 110;
        
        [self addMenuBtnTitle:@"在线打分(气)" ImgName:@"jcjl_1_6.png" Frame:CGRectMake(xPos,yPos,85,85) TagID:BTNMenu_6];
        xPos += 110;
        
    }
    
    if([dms containsObject:@"5606"] ){
        [self addMenuBtnTitle:@"应急检查" ImgName:@"jcjl_1_4.png" Frame:CGRectMake(xPos,yPos,85,85) TagID:BTNMenu_4];
        
        
    }
    
    
}


- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row{
    
    curField.text = words;
    
    if (popController != nil) {
        [popController dismissPopoverAnimated:YES];
    }
    
}

-(void)returnPersons:(NSMutableArray*)aryPersons
{
    self.surePerson = aryPersons;
    [popController dismissPopoverAnimated:YES];
    NSMutableString *names = [NSMutableString stringWithCapacity:20]; //AA,BB
    NSMutableString *zjhStr = [NSMutableString stringWithCapacity:20];
    NSMutableString *jcrbmbhStr = [NSMutableString stringWithCapacity:20];
    NSMutableString  *jcrbhStr  = [NSMutableString stringWithCapacity:20];
    
    for (UserInfo *aInfo in aryPersons) {
        if ([names isEqualToString:@""]) {
            [names appendString:aInfo.userName];
            [zjhStr appendString:aInfo.ZFZJBH];
            [jcrbmbhStr appendString:aInfo.BMBH];
            [jcrbhStr appendString:aInfo.YHID];
            
        }
        else{
            [names appendFormat:@",%@",aInfo.userName];
            [zjhStr appendFormat:@",%@",aInfo.ZFZJBH];
            [jcrbmbhStr appendFormat:@",%@",aInfo.BMBH];
            [jcrbhStr appendFormat:@",%@",aInfo.YHID];
            
        }
    }
    jcryField.text = names;
    zfzhField.text = zjhStr;
    
    self.zfzjh = zjhStr;
    self.jcrbmbh = jcrbmbhStr;
    self.jcrbh = jcrbhStr;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [curField release];
    [surePerson release];

    [ssqyDM release];
    [qlsxDM release];
    [jcsyDM release];
    [popController release];
    [aryMenuViews release];
    [dwbh release];
    [wrymc release];
    [xczfbh release];
    [btnTitleView release];
    [currentdata release];
    [super dealloc];
}


-(void)backItemPressed{
    if(recordStatus == Record_Commited_Success )
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:@"您还未提交到服务器，确定返回吗？"
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:@"取消",nil];
    alert.alpha = 1.0f;
    [alert show];
    [alert release];
    return;
}


#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField tag] == TAG_PHONE) {
        return YES;
    }
	return NO;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:PHONE] invertedSet];
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入数字或分隔符'-'"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];
        return NO;
        
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (recordStatus == Record_Commited_Success) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    else if (alertType == kAlert_Choose) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    else if(alertType == kAlert_GenXCZFBH){
        if (buttonIndex == 0) {
            self.xczfbh = [GUIDGenerator generateBHByWryName:self.wrymc];
        }else{
            [self selectPolutionSrc];
        }
        alertType = kAlert_Choose;
        
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

#pragma mark -
#pragma mark NSXMLParser Delegate

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	
	if( [elementName isEqualToString:@"ProcessQueueT_Log_UDIDResult"])
	{
		self.currentdata = [NSMutableString string];
        
	}else if([elementName isEqualToString:@"faultcode"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"错误"
                              message:@"提交数据到服务器失败！"  delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [[[alert subviews] objectAtIndex:2] setBackgroundColor:[UIColor colorWithRed:0.5 green:0.0f blue:0.0f alpha:1.0f]];
        [alert show];
        [alert release];
        
    }
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (currentdata)
		[currentdata appendString:string];
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
	if(currentdata && [elementName isEqualToString:@"ProcessQueueT_Log_UDIDResult"])
	{
        
		if([currentdata isEqualToString:@"true"])
		{
            recordStatus = Record_Commited_Success;
			UIAlertView *alert = [[UIAlertView alloc]
								  initWithTitle:@"提示"
								  message:@"数据已成功提交至服务器！"  delegate:self
								  cancelButtonTitle:@"确定"
								  otherButtonTitles:nil];
			[alert show];
			[alert release];
            [[DBHelper sharedInstance] saveXCZFBH:self.xczfbh Wrymc:self.wrymc TableName:@"T_YDZF_JBXX"];
		}
        else {
			recordStatus = Record_Commited_Failed;
			UIAlertView *alert = [[UIAlertView alloc]
								  initWithTitle:@"错误"
								  message:@"提交数据到服务器失败！"  delegate:nil
								  cancelButtonTitle:@"确定"
								  otherButtonTitles:nil];
            [[[alert subviews] objectAtIndex:2] setBackgroundColor:[UIColor colorWithRed:0.5 green:0.0f blue:0.0f alpha:1.0f]];
			[alert show];
			[alert release];
            
		}
	}
}

-(NSMutableDictionary*)restoreValues{
    NSMutableDictionary *dicValues = [NSMutableDictionary dictionaryWithCapacity:5];
    self.ssqyDM = [GGDMJConfig getDMByDMJBH:@"SSQY" andDMNR:ssqyField.text];
    self.qlsxDM = [GGDMJConfig getDMByDMJBH:@"XZJG" andDMNR:qlsxField.text];
    [dicValues setObject:xczfbh forKey:@"XCZFBH"];
    [dicValues setObject:[GUIDGenerator generateGUID] forKey:@"BH"];
    [dicValues setValue:ssqyDM forKey:@"SSQY"];
    [dicValues setValue:qlsxDM forKey:@"QLSX"];
    [dicValues setValue:jcsyDM forKey:@"JCSY"];
    [dicValues setValue:jcdwField.text forKey:@"JCRBM"];
    [dicValues setValue:dwbh forKey:@"DWBH"];
    [dicValues setValue:dwmcField.text forKey:@"DWMC"];
    [dicValues setValue:dwdzField.text forKey:@"DWDZ"];
    [dicValues setValue:fddbrField.text forKey:@"DWFZR"];
    [dicValues setValue:fddbrdhField.text forKey:@"DWLXDH"];
    [dicValues setValue:hblxrField.text forKey:@"HBFZR"];
    [dicValues setValue:hblxrdhField.text forKey:@"HBFZRDH"];
    [dicValues setValue:jcsjField.text forKey:@"JCSJ"];
    [dicValues setValue:jcjssjField.text forKey:@"JCJSSJ"];
    [dicValues setValue:jcryField.text forKey:@"JCR"];
    [dicValues setValue:self.jcrbh forKey:@"JCRBH"];
    [dicValues setValue:self.wryJD forKey:@"GPSSWE"];
    [dicValues setValue:self.wryWD forKey:@"GPSDWN"];
    [dicValues setValue:zfzhField.text forKey:@"ZJH"];
    [dicValues setValue:jcrbmbh forKey:@"JCRBMBH"];
    [dicValues setValue:g_logedUserInfo.userName forKey:@"LRR"];
    [dicValues setValue:g_logedUserInfo.userORGID forKey:@"ORGID"];
    
    [dicValues setValue:[self getGllbValue] forKey:@"GLLX"];
    [dicValues setValue:[self getHylxValue] forKey:@"SSHY"];
    [dicValues setValue:g_logedUserInfo.userName forKey:@"CJR"];
    return dicValues;
}
//暂存
-(void)saveRecord{
    
    NSMutableDictionary *dicValues = [self restoreValues];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicValues options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    
    DBHelper *helper = [DBHelper sharedInstance];
    BOOL res = [helper saveRecord:jsonStr XCZFBH:xczfbh WRYMC:wrymc TableName:@"T_YDZF_JBXX" JCR:g_logedUserInfo.userName];
    [jsonStr release];
    if(res){
        recordStatus= Record_SaveLocal;
        [OMGToast showWithText:@"记录已暂存在本地！" duration:1.0];
       
    }
}

-(void)displayRecordDatas:(NSDictionary*)dataValues{
    
    
    self.ssqyDM = [dataValues objectForKey:@"SSQY"];
    self.qlsxDM = [dataValues objectForKey:@"QLSX"];
    self.jcsyDM = [dataValues objectForKey:@"JCSY"];
    jcdwField.text = [dataValues objectForKey:@"JCRBM"];
    
    self.dwbh = [dataValues objectForKey:@"DWBH"];
    dwmcField.text = [dataValues objectForKey:@"DWMC"];
    [self.btnTitleView setTitle:dwmcField.text forState:UIControlStateNormal];
    dwdzField.text = [dataValues objectForKey:@"DWDZ"];
    
    fddbrField.text = [dataValues objectForKey:@"DWFZR"];
    fddbrdhField.text = [dataValues objectForKey:@"DWLXDH"];
    hblxrField.text = [dataValues objectForKey:@"HBFZR"];
    hblxrdhField.text = [dataValues objectForKey:@"HBFZRDH"];
    jcsjField.text = [dataValues objectForKey:@"JCSJ"];
    jcjssjField.text = [dataValues objectForKey:@"JCJSSJ"];
    
    jcryField.text = [dataValues objectForKey:@"JCR"];
    self.jcrbh = [dataValues objectForKey:@"JCRBH"];
    self.wryJD = [dataValues objectForKey:@"GPSSWE"];
    self.wryWD = [dataValues objectForKey:@"GPSDWN"];
    zfzhField.text = [dataValues objectForKey:@"ZJH"];

    self.jcrbmbh = [dataValues objectForKey:@"JCRBMBH"];
    self.wryWD = [dataValues objectForKey:@"GPSDWN"];
    self.wryWD = [dataValues objectForKey:@"GPSDWN"];
    
    NSString *gllb = [dataValues objectForKey:@"GLLX"];
    NSArray *aryGllb = [NSArray arrayWithObjects:@"9901",@"9902",@"9903",@"9904",@"9905", nil];
    gllbSegCtrl.selectedSegmentIndex = [aryGllb indexOfObject:gllb];

    NSString *hylx = [dataValues objectForKey:@"GLLX"];
    NSArray *aryHylx = [NSArray arrayWithObjects:@"3301",@"3302",@"3303",@"3304",@"3305",@"3306",@"33999", nil];
    hylxSegCtrl.selectedSegmentIndex = [aryHylx indexOfObject:hylx];
    
    [self resetDefaultDatas];
}

#pragma mark -
#pragma mark ChooseRecordDelegate delegate
-(void)returnInfo:(id)valuesData{
    NSDictionary *values = (NSDictionary *)valuesData;
    [self displayRecordDatas:values];
    [popRecordController dismissPopoverAnimated:YES];
}



//查看历史暂存记录
-(void)qyBilu:(id)sender{
    if (popRecordController == nil) {
        ChooseRecordViewController *tmpController =
        [[ChooseRecordViewController alloc] initWithStyle:UITableViewStylePlain];
        tmpController.blName = @"T_YDZF_JBXX";
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

-(NSString*)getGllbValue{
    NSArray *aryGllb = [NSArray arrayWithObjects:@"9901",@"9902",@"9903",@"9904",@"9905", nil];
    
    return [aryGllb objectAtIndex:gllbSegCtrl.selectedSegmentIndex];
    
}

-(NSString*)getHylxValue{
    NSArray *aryHylx = [NSArray arrayWithObjects:@"3301",@"3302",@"3303",@"3304",@"3305",@"3306",@"33999", nil];
    return [aryHylx objectAtIndex:hylxSegCtrl.selectedSegmentIndex];
}
@end
