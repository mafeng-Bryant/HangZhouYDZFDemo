    //
//  QueryWriteController.m
//  HangZhouOA
//
//  Created by chen on 11-4-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QueryWriteController.h"
#import "GMEPS_HZAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "SharedInformations.h"
#import "LoginViewController.h"
#import "GUIDGenerator.h"
extern UserInfo *g_logedUserInfo;

#import "WendaDetailsViewController.h"
#import "PersonSelectControllerView.h"
#import "JSONKit.h"
#import "GTMBase64.h"

extern GMEPS_HZAppDelegate *g_appDelegate;
#define T_XCZF_XWBL @"T_YDZF_XWBL"

@implementation QueryWriteController
@synthesize wordsSelectViewController,wordsPopoverController,AY,QYMC;

@synthesize DCXWDD,GZDW,NL,JTZZ,YB,DH,CYR,BXWRMC,SFZHM,XWKSSJ,XWJSSJ,XB,ZW,YBAGX,JLR,ZFRY,SFQR,ZFZH,SQHB,XWR;
@synthesize popController,dateController;
@synthesize anyouPopoverController,anyouSelectView;
@synthesize quesValueAry,ansValueAry;
@synthesize CYR_ZJH,LRR_ZJH;
@synthesize PopPeopleController,peopleController;
@synthesize surePreson;
@synthesize valuesAry,keysAry;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
        return nil;
    
    self.tableName = T_XCZF_XWBL;
	
    return self;
}



-(IBAction)backgroundTap:(id)sender
{
    [SQHB resignFirstResponder];
    [SFQR resignFirstResponder];
    [BXWRMC resignFirstResponder];
    [NL resignFirstResponder];
    [ZW resignFirstResponder];
    [SFZHM resignFirstResponder];
    [JTZZ resignFirstResponder];
    [YB resignFirstResponder];
    [DH resignFirstResponder];
    [YBAGX resignFirstResponder];
    [CYR resignFirstResponder];
    
}

-(IBAction)beginEditing:(id)sender{
    
	UIControl *ctrl = (UIControl*)sender;
	CGRect rect;
	rect.origin.x = ctrl.frame.origin.x;	
	rect.origin.y = ctrl.frame.origin.y;
	rect.size.width = ctrl.frame.size.width;
	rect.size.height = ctrl.frame.size.height;
	[wordsSelectViewController.tableView reloadData];
 
    
	[self.wordsPopoverController presentPopoverFromRect:rect
												 inView:self.view
							   permittedArrowDirections:UIPopoverArrowDirectionUp
											   animated:YES];
     
}
- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row{
	
	YBAGX.text = words;
	if (wordsPopoverController != nil) {
		[wordsPopoverController dismissPopoverAnimated:YES];
	}
}

-(IBAction)NewQuestion:(id)sender
{
    WendaDetailsViewController *controller = [[WendaDetailsViewController alloc] initWithNibName:@"WendaDetailsViewController" bundle:nil];	

    controller.QYMC = QYMC.text;
    controller.delegate = self;
    if([quesValueAry count] > 0){
        controller.quesValueAry = quesValueAry;
        controller.ansValueAry = ansValueAry; 
    }
    else{
        controller.quesValueAry = [NSMutableArray arrayWithCapacity:15];
        controller.ansValueAry = [NSMutableArray arrayWithCapacity:15];
    }
    
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
    

}

- (void)returnSelectedAnyou:(NSString *)anyou andRow:(NSInteger)row{
	
	AY.text = anyou;
    SharedInformations *info = [SharedInformations sharedSharedInformations];
    info.reasonToSurvey = anyou;
	if (anyouPopoverController != nil) {
		[anyouPopoverController dismissPopoverAnimated:YES];
	}
}

-(IBAction)touchFromDate:(id)sender{
	UIControl *btn =(UIControl*)sender;
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
		
		switch (currentTag) {
			case 102:				
				XWKSSJ.text = dateString;
           //     //NSLog(@"11%@",XWKSSJ);
            //  self.TZSJDateValue = date; 
				break;
			case 2:
				XWJSSJ.text = dateString;
            //  self.JSCLSJDateValue = date;
				
				break;
			default:
				break;
		}
	}
    NSLog(@"start:%@ end:%@",XWKSSJ.text,XWJSSJ.text);
    if (([XWKSSJ.text compare:XWJSSJ.text] == NSOrderedDescending)||
        [XWKSSJ.text compare:XWJSSJ.text] == NSOrderedSame)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"提示" 
                              message:@"结束时间不能早于开始时间"  
                              delegate:self 
                              cancelButtonTitle:@"确定" 
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        XWJSSJ.text=@"";
        
    }

}

-(void)returnquesAry:(NSMutableArray*)values returnansAry:(NSMutableArray*)values1{
	self.quesValueAry = values;
    self.ansValueAry = values1;
}


-(void)returnSites:(NSDictionary*)values source:(NSInteger)type{
	if (values == nil) {
		[self.navigationController popViewControllerAnimated:YES];
	}
	else {
        if ([values count] == 1) {
            [btnTitleView setTitle:[values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.wrymc = GZDW.text = QYMC.text = [values objectForKey:@"WRYMC"];
            self.dwbh = @"";
            self.DCXWDD.text = @"";
        }
        else
        {
            self.wrymc =  GZDW.text = QYMC.text = [values objectForKey:@"WRYMC"];
            self.dwbh = [values objectForKey:@"WRYBH"];
            self.DCXWDD.text = [values objectForKey:@"DWDZ"];
            [btnTitleView setTitle: [values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
        }
        [self  generateXCZFBH];
       
	}
}

-(void)returnSelectedPersons:(NSArray*)aryPersons{
    NSMutableString *names = [NSMutableString stringWithCapacity:20]; //AA,BB
    NSMutableString *certIDs = [NSMutableString stringWithCapacity:20];
    
    for (UserInfo *aInfo in aryPersons) {
        if ([names isEqualToString:@""]) {
            [names appendString:aInfo.userName];
        }
        else{
            [names appendFormat:@",%@",aInfo.userName];
        }
        
        if ([certIDs isEqualToString:@""]) {
            [certIDs appendString:aInfo.ZFZJBH];
        }
        else if(![aInfo.ZFZJBH isEqualToString:@""]){
            [certIDs appendFormat:@",%@",aInfo.ZFZJBH];
        }
    }
    
    if (currentTag == 114) {
        
        XWR.text = names; 
        //self.CYR_ZJH = certIDs;
    }
    else if(currentTag == 115) {
        JLR.text = names;
        //self.LRR_ZJH = certIDs;
    }
    else if(currentTag == 117)
    {
        ZFRY.text = names;
        ZFZH.text = certIDs;
    }
}

-(IBAction)choosePerson:(id)sender{
    UIControl *control = (UIControl*)sender;
    currentTag = control.tag;
    PersonSelectControllerView *tmpController = 
    [[PersonSelectControllerView alloc] initWithStyle:UITableViewStyleGrouped];
    tmpController.delegate1 = self;
    tmpController.contentSizeForViewInPopover = CGSizeMake(350, 700);
	self.peopleController = tmpController;
    [tmpController release];
    
    if (g_logedUserInfo!=nil) {
        SharedInformations *info = [SharedInformations sharedSharedInformations];
        if ([surePreson count]==0||surePreson == nil) {
            info.people = [NSMutableArray arrayWithObject:g_logedUserInfo];
        }
        else
            info.people = surePreson;
        
        
        UINavigationController *tmpNav = [[UINavigationController alloc] initWithRootViewController:self.peopleController];
        
        UIPopoverController *tmpPopover = [[UIPopoverController alloc] initWithContentViewController:tmpNav];
        self.PopPeopleController = tmpPopover;
        [tmpPopover release];
        [tmpNav release];
        UIPopoverArrowDirection arrowDirection = nil;
        if (currentTag==114)
            arrowDirection = UIPopoverArrowDirectionLeft;
        else if(currentTag==115)
            arrowDirection = UIPopoverArrowDirectionLeft;
        else if(currentTag==117)
            arrowDirection = UIPopoverArrowDirectionRight;
        [self.peopleController.tableView reloadData];
        [self.PopPeopleController presentPopoverFromRect:control.frame
                                                  inView:self.view
                                permittedArrowDirections:arrowDirection
                                                animated:YES] ;

    }
    	
}

-(void)commitBilu:(id)sender
{
    NSString *message = nil;
    if([XWKSSJ.text isEqualToString:@""])
        message = @"开始时间不能为空";
    else if([XWJSSJ.text isEqualToString:@""])
        message = @"结束时间不能为空";
    else if([quesValueAry count]==0)
        message = @"问答不能为空";
    
    if (message != nil) {
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"提示" 
                              message:message  
                              delegate:nil
                              cancelButtonTitle:@"确定" 
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return ;
    }
    

	NSMutableString *sql = [[NSMutableString alloc] initWithCapacity:400];
	NSMutableString *sql1 = [[NSMutableString alloc]initWithCapacity:400];
	int sizeQA = [quesValueAry count];
    for (int i=0; i< sizeQA; i++) 
    {
        [sql1 appendFormat:@"问:%@答:%@",[quesValueAry objectAtIndex:i],[ansValueAry objectAtIndex:i]];
    }
    
    [sql appendString:@"insert into T_YDZF_DCXWBL(BH,ORGID,AY,WD,CJSJ,CJR,DCXWDD,BXWRMC,XB,NL,ZW,SFZHM,XWKSSJ,XWJSSJ,GZDW,JTZZ,YB,YBAGX,XWR,JLR,CYR,ZFRY,SFQR,ZFZH,SQHB,DH,XH,HJBHT) values"];
    [sql appendFormat:@"('%@','%@','%@','%@',sysdate,'%@','%@','%@','%@','%@','%@','%@',to_date('%@', 'yyyy-mm-dd hh24:mi'),",self.xczfbh,g_logedUserInfo.userORGID,AY.text,sql1,g_logedUserInfo.userName,DCXWDD.text,BXWRMC.text,(XB.selectedSegmentIndex == 0)?@"男":@"女",NL.text,ZW.text,SFZHM.text,XWKSSJ.text];
    
    [sql appendFormat:@"to_date('%@', 'yyyy-mm-dd hh24:mi'),'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",XWJSSJ.text,GZDW.text,JTZZ.text,YB.text,YBAGX.text,XWR.text,JLR.text,CYR.text,ZFRY.text,SFQR.text,ZFZH.text,SQHB.text,DH.text,self.dwbh,g_logedUserInfo.FSHBJ];
    
    [self commitRecordDatas:sql];
    [sql1 release];
    [sql release];
}


-(void)returnPersons:(NSMutableArray*)aryPersons;
{
    self.surePreson = aryPersons;
    [self.PopPeopleController dismissPopoverAnimated:YES];
    NSMutableString *names = [NSMutableString stringWithCapacity:20]; //AA,BB
    NSMutableString *certIDs = [NSMutableString stringWithCapacity:20];
    
    for (UserInfo *aInfo in aryPersons) {
        if ([names isEqualToString:@""]) {
            [names appendString:aInfo.userName];
        }
        else{
            [names appendFormat:@",%@",aInfo.userName];
        }
        
        if ([certIDs isEqualToString:@""]) {
            [certIDs appendString:aInfo.ZFZJBH];
        }
        else {
            [certIDs appendFormat:@",%@",aInfo.ZFZJBH];
        }
    }
    if (currentTag == 114) {
        XWR.text = names;
    }
    if (currentTag == 115) {
        JLR.text = names;
    }
    if (currentTag == 117) {
        ZFRY.text = names;
        ZFZH.text = certIDs;
    }
}


-(void)saveBilu:(id)sender
{
    NSDictionary *dicData = [self getValueData];
    NSMutableDictionary *dicValue = [NSMutableDictionary dictionaryWithDictionary:dicData];
    [dicValue setValue:self.xczfbh forKey:@"XCZFBH"];
    [self saveLocalRecord:dicValue];
    
}

- (void)loadData:(NSDictionary *)infoDic{
    UITextField *tmpField;
    for (int i = 0; i < [keysAry count]; i++) {
        tmpField = [valuesAry objectAtIndex:i];
        tmpField.text = [infoDic objectForKey:[keysAry objectAtIndex:i]];
    }
    
}

//根据值来显示值
-(void)displayRecordDatas:(id)object{
    NSDictionary* values = (NSDictionary*)object;
    [self loadData:values];
}

-(NSDictionary*)getValueData{
    
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithCapacity:15];

    UITextField *tmpField;
    for (int i = 0; i < [keysAry count]; i++) {
        tmpField = [valuesAry objectAtIndex:i];
        [dicParams setObject:tmpField.text forKey: [keysAry objectAtIndex:i]];
    }
    
    
    NSMutableString *sql1 = [[NSMutableString alloc]initWithCapacity:400];
	int sizeQA = [quesValueAry count];
    for (int i=0; i< sizeQA; i++)
    {
        [sql1 appendFormat:@"问：%@|答：%@|",[quesValueAry objectAtIndex:i],[ansValueAry objectAtIndex:i]];
    }
    [dicParams setObject:sql1 forKey:@"SOA_WT"];
    [sql1 release];
    return dicParams;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.valuesAry = [NSArray arrayWithObjects:QYMC,AY,DCXWDD,GZDW,NL,JTZZ,YB,DH,CYR,BXWRMC,SFZHM,XWKSSJ,XWJSSJ,ZW,YBAGX,XWR,JLR,ZFRY,SFQR,ZFZH,SQHB,nil];
    self.keysAry = [NSArray arrayWithObjects:@"DWMC",@"AY",@"DCXWDD",@"GZDW",@"NL",@"JTZZ",@"YB",@"DH",@"CYR",@"BXWRMC",@"SFZHM",@"DCSJ",@"DCJSSJ",@"ZW",@"YBAGX",@"XWR",@"JLR",@"ZFRY",@"SFQR",@"ZFZH",@"SQHB",nil];
    self.title = @"询问记录";
    JLR.text = ZFRY.text = g_logedUserInfo.userName;
    self.LRR_ZJH = ZFZH.text = g_logedUserInfo.ZFZJBH;
    SFQR.text = @"已确认";
    SQHB.text = @"听清楚了，不申请回避。";
    
    self.surePreson = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    
    DLRSSBM.text = [NSString stringWithFormat:@"我们是%@执法人员:",g_logedUserInfo.FSHBJ];
    
    
    PopupDateViewController *tmpdate = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDateAndTime];
	self.dateController = tmpdate;
	dateController.delegate = self;
	[tmpdate release];
	
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
	
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	[popover release];
	[nav release];
    
    
    CommenWordsViewController *tmpController2 = [[CommenWordsViewController alloc] initWithNibName:@"CommenWordsViewController" bundle:nil ];
	tmpController2.contentSizeForViewInPopover = CGSizeMake(180, 132);
	tmpController2.delegate = self;
	tmpController2.wordsAry = [NSArray arrayWithObjects:@"法人代表",@"受委托人",
                               @"旁证",nil];
    
    UIPopoverController *tmppopover2 = [[UIPopoverController alloc] initWithContentViewController:tmpController2];
	self.wordsSelectViewController = tmpController2;
    self.wordsPopoverController = tmppopover2;
    [tmpController2 release];
    [tmppopover2 release];
    
    
	AY.text = @"";

	
    //案由浮动窗口初始化
    
	AnyouTableView *anyouController = [[AnyouTableView alloc] initWithNibName:@"AnyouTableView" bundle:nil ];
	anyouController.contentSizeForViewInPopover = CGSizeMake(600, 800);
	anyouController.delegate = self;
    
    UINavigationController *nav2 = [[UINavigationController alloc] 
                                   initWithRootViewController:anyouController];
    
    UIPopoverController *anyouPopover = [[UIPopoverController alloc] initWithContentViewController:nav2];
	self.anyouSelectView = anyouController;
    self.anyouPopoverController = anyouPopover;

    [anyouPopover release];
    [anyouController release];
    [nav2 release];

    
    NSDate *time = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
	NSString *dateString = [dateFormatter stringFromDate:time];
	[dateFormatter release];  
	
	XWKSSJ.text = dateString;

    self.CYR_ZJH = @"";
    self.LRR_ZJH = @"";
}


-(void)viewDidAppear:(BOOL)animated{
	if (wordsPopoverController != nil) {
		[wordsPopoverController dismissPopoverAnimated:YES];
	}
    
}


	
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}




- (void)dealloc {
    [AY release];
    [QYMC release];
    [DCXWDD release];
    [GZDW release];
    [NL release];
    [JTZZ release];
    [YB release];
    [DH release];
    [CYR release];
    [BXWRMC release];
    [SFZHM release];
    [XWKSSJ release];
    [XWJSSJ release];
    [ZW release];
    [YBAGX release];
    [XWR release];
    [JLR release];
    [ZFRY release];
    [SFQR release];
    [ZFZH release];
    [SQHB release];
    [XB release];
    [ansValueAry release];
    [quesValueAry release];
    [commitBar release];

    [popController release];
    [dateController release];
    [wordsPopoverController release];
    [wordsSelectViewController release];
    [PopPeopleController release];
    
    [valuesAry release];
    [keysAry release];

    [super dealloc];
}

#pragma mark -
#pragma mark textfieldDelegate delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 119 || textField.tag == 120) {
        return YES;
    }
    return NO;
}


// 用户输入时向上滚动视图，避免键盘遮挡输入框
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGFloat arrange = 0.0;
    if (textField.tag == 119) {
        arrange = - 20;
    }
    if (textField.tag == 120) {
        arrange = - 150;
    }
    
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height;
    CGRect rect=CGRectMake(0.0f,arrange,width,height);//上移，按实际情况设置
    self.view.frame=rect;
    [UIView commitAnimations];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 120){
        NSTimeInterval animationDuration=0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width=self.view.frame.size.width;
        float height=self.view.frame.size.height;
        CGRect rect=CGRectMake(0.0f,0.0f,width,height);
        self.view.frame=rect;
        [UIView commitAnimations];
    }
}

@end
