//
//  BaserecordViewController.m
//  GMEPS_HZ
//
//  Created by 文 克远 on 13-4-12.
//
//

#import "OutBaseRecordViewController.h"
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



@interface OutBaseRecordViewController ()
@property(nonatomic,retain)NSMutableString *currentdata;
@property(nonatomic,assign) NSInteger alertType;
@property(nonatomic, retain) UIBarButtonItem *backItem;

@property(nonatomic,retain)UIPopoverController *popRecordController;
@end

@implementation OutBaseRecordViewController
@synthesize currentdata,alertType,tableName,isHisRecord,dicWryInfo;
@synthesize recordStatus,popRecordController,dwbh,wrymc,xczfbh,menuTagID;

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
    [popRecordController release];
    [dwbh release];
    [wrymc release];
    [xczfbh release];
    [_backItem release];
    [super dealloc];
}

-(void)returnSites:(NSDictionary*)values source:(NSInteger)type{
    
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

-(void)commitRecordDatas:(NSString*)commandSql{
    NSString* params = [WebServiceHelper createParametersWithKey:@"cmdTexts"
														   value:commandSql,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    NSString *URL = [NSString  stringWithFormat: KQueueServiceURL,g_appDelegate.ServerIP];
    NSString *method = @"ProcessQueues_Ipad_Log_UDID";
	WebServiceHelper *webService = [[[WebServiceHelper alloc] initWithUrl:URL
                                                 method:method
                                                   view:self.view
                                              nameSpace:KSoapNameSpace
                                             parameters:params
                                               delegate:self] autorelease];
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
    if(res){
        recordStatus= Record_SaveLocal;
        [OMGToast showWithText:@"记录已暂存在本地！" duration:1.0];
    }
    
    [jsonStr release];
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

//查看暂存记录
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

-(void)commitBilu:(id)sender{
    _backItem.enabled = NO;
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


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = wrymc;
    
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
    
    //导航左边部分
    UIToolbar *tool1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 110, 44)];
    _backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backItemPressed)];
    NSMutableArray* buttons1 = [[NSMutableArray alloc] initWithCapacity:8];
    [buttons1 addObject:_backItem];
    [tool1 setItems:buttons1 animated:NO];
    [buttons1 release];
    
    UIBarButtonItem *myBItem1 = [[UIBarButtonItem alloc] initWithCustomView:tool1];
    self.navigationItem.leftBarButtonItem = myBItem1;
    [myBItem1 release];
    [tool1 release];
    

    btnTitleView = [[UIButton buttonWithType:UIButtonTypeRoundedRect ] retain];
    btnTitleView.tintColor = [UIColor lightGrayColor];
    btnTitleView.frame = CGRectMake(0, 0, 350, 35);
    [btnTitleView addTarget:self action:@selector(selectPolutionSrc) forControlEvents:UIControlEventTouchUpInside];
    [btnTitleView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.navigationItem.titleView  = btnTitleView;
    
    [self selectPolutionSrc];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}
#pragma mark -
#pragma mark ChooseRecordDelegate delegate
-(void)returnInfo:(NSDictionary*)valuesData{
    [self displayRecordDatas:valuesData];
    [popRecordController dismissPopoverAnimated:YES];
}


#pragma mark -
#pragma mark delegate
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	
	if( [elementName isEqualToString:@"ProcessQueues_Ipad_Log_UDIDResult"])
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
            recordStatus = Record_Commited_Failed;
		}
      _backItem.enabled = YES;
		
	}
}


@end
