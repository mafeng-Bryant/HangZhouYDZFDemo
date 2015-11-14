//
//  BaserecordViewController.m
//  GMEPS_HZ
//
//  Created by 文 克远 on 13-4-12.
//
//

#import "BaseRecordViewController.h"
#import "WebServiceHelper.h"
#import "UserInfo.h"
extern UserInfo *g_logedUserInfo;
#import "GMEPS_HZAppDelegate.h"
extern GMEPS_HZAppDelegate *g_appDelegate;
#import "JSONKit.h"
#import "SharedInformations.h"
#import "GUIDGenerator.h"

#import "OMGToast.h"
#import "DBHelper.h"
#import "GGDMJConfig.h"
#define kAlert_None       0
#define kAlert_Choose     1 //选择提交、暂存、丢弃
#define kAlert_SureCommit 2 //确定提交
#define kAlert_Commit_Success 3 //提交成功


@interface BaseRecordViewController ()
@property(nonatomic,retain)NSMutableString *currentdata;
@property(nonatomic,assign) NSInteger alertType;

@property(nonatomic,retain)UIPopoverController *popRecordController;
@end

@implementation BaseRecordViewController
@synthesize currentdata,alertType,tableName,isSaveRecord,isHisRecord,dicWryInfo;
@synthesize recordStatus,popRecordController,dwbh,jcdw,jcry,zfzh,jcsj,jcjssj,wrymc,xczfbh,menuTagID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    [currentdata release];
    [tableName release];
    [dicWryInfo release];
    [popRecordController release];
    [dwbh release];
    [jcdw release];
    [jcry release];
    [zfzh release];
    [jcsj release];
    [jcjssj release];
    [wrymc release];
    [xczfbh release];
    [super dealloc];
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

/*
 
-(void)commitRecordDatas:(NSDictionary*)values{
    
}*/

- (void)loadLocalSaveRecord{
    NSArray *chooseAry = [[DBHelper sharedInstance] queryRecordByWrymc:wrymc andTableName:tableName];
    NSDictionary *dic = [chooseAry objectAtIndex:0];
    NSString *valueJson = [dic objectForKey:@"JSON"];
    NSDictionary *dataInfo =  [NSJSONSerialization JSONObjectWithData:[valueJson dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    [self displayRecordDatas:dataInfo];
    
}

-(void)requestServerHisRecord{
    
    NSString* params = [WebServiceHelper createParametersWithKey:@"tableName"														   value:tableName,@"xczfbh",xczfbh,@"lx",@"",@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    
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

//根据值来显示值
-(void)displayRecordDatas:(id)values{
    
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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RecordStatus" object:[NSNumber numberWithInt:menuTagID]];
    }
}

//查看历史记录
-(void)historyButClick:(id)sender{
    
    if (popRecordController == nil) {
        ChooseRecordViewController *tmpController =
        [[ChooseRecordViewController alloc] initWithStyle:UITableViewStylePlain];
        tmpController.blName = tableName;
        tmpController.wrymc = wrymc;
        tmpController.isGetHistory = YES;
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
    [popRecordController dismissPopoverAnimated:NO];
    UINavigationController *navVC = (UINavigationController *)popRecordController.contentViewController;
    NSArray *contrArr = navVC.childViewControllers;
    if (contrArr.count>0) {
        ChooseRecordViewController *tmpController = [contrArr objectAtIndex:0];
        tmpController.isGetHistory = YES;
    }
	[self.popRecordController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

//查看历史暂存记录
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

-(void)saveBilu:(id)sender{
    
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

- (void)viewDidLoad
{
   
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   
    
    if(!isHisRecord){
      
        NSDictionary *dic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:self.wrymc,self.tableName, nil] forKeys:[NSArray arrayWithObjects:@"strDWMC",@"TableName", nil]];
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"history"];
        
        //导航右边部分
        UIToolbar* tools = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 260, 44)];
        [tools setTintColor:[self.navigationController.navigationBar tintColor]];
        [tools setAlpha:[self.navigationController.navigationBar alpha]];
        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:3];
        
        UIBarButtonItem *historyButton = [[UIBarButtonItem alloc] initWithTitle:@"获取历史记录" style:UIBarButtonItemStyleDone
                                                                         target:self action:@selector(historyButClick:)];
        
        UIBarButtonItem *anotherButton0 = [[UIBarButtonItem alloc] initWithTitle:@"获取暂存记录" style:UIBarButtonItemStyleDone
                                                                          target:self action:@selector(qyBilu:)];
        
        UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                     target:self action:nil];
        fixedButton.width = 4.0f;
        UIBarButtonItem *anotherButton1 = [[UIBarButtonItem alloc] initWithTitle:@"暂存" style:UIBarButtonItemStyleDone
                                                                          target:self action:@selector(saveBilu:)];
        [buttons addObject:historyButton];
        [historyButton release];
        
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

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(isHisRecord){
        [self requestServerHisRecord];
    }

}

#pragma mark -
#pragma mark ChooseRecordDelegate delegate
-(void)returnInfo:(id)valuesData{
    NSDictionary *values = (NSDictionary *)valuesData;
    [self displayRecordDatas:values];
    [popRecordController dismissPopoverAnimated:YES];
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	
	if( [elementName isEqualToString:@"GetChildsDetialsjson_Log_UDIDResult"])
	{
		self.currentdata = [NSMutableString string];
        
	}else if([elementName isEqualToString:@"faultcode"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"错误"
                              message:@"失败！"  delegate:nil
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
    
	if(currentdata && [elementName isEqualToString:@"GetChildsDetialsjson_Log_UDIDResult"])
	{
      NSString *jsonData = currentdata;
      jsonData = [jsonData stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        NSArray *dataInfo =  [NSJSONSerialization JSONObjectWithData:[jsonData dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if(dataInfo && [dataInfo count] >0){
            NSDictionary *dic = [dataInfo objectAtIndex:0];
            [self displayRecordDatas:dic];
        }

	}
}


@end
