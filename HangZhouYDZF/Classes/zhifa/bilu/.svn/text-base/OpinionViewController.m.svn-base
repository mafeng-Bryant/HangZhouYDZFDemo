    //
//  OpinionViewController.m
//  EPad
//
//  Created by chen on 11-4-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OpinionViewController.h"
#import "GMEPS_HZAppDelegate.h"
#import "UISearchSitesController.h"
#import "GUIDGenerator.h"
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "SharedInformations.h"
#import "PersonSelectControllerView.h"
extern UserInfo *g_logedUserInfo;
extern GMEPS_HZAppDelegate *g_appDelegate;

#import "GTMBase64.h"
#import "JSONKit.h"
#define T_XCZF_JCYJS @"T_YDZF_JCYJS"


#define kWebService_Commit 2 //提交记录
@implementation OpinionViewController
@synthesize endDateValue;
@synthesize popController,peopleController,dateController;
@synthesize currentTag;
@synthesize valuesAry,keysAry,surePerson;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
        return nil;
	self.tableName = T_XCZF_JCYJS;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    return self;
}


-(void)returnSites:(NSDictionary*)values source:(NSInteger)type{
	if (values == nil) {
		[self.navigationController popViewControllerAnimated:YES];
	}
	else {
		if ([values count] == 1) {
            [btnTitleView setTitle:[values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.wrymc = QYMC.text = [values objectForKey:@"WRYMC"];
            QYDSR.text = [values objectForKey:@"FRDB"];
            self.dwbh = @"";
        }
        else
        {
            self.wrymc = self.title = QYMC.text = [values objectForKey:@"WRYMC"];
            self.dwbh = [values objectForKey:@"WRYBH"];
            QYDSR.text = [values objectForKey:@"FRDB"];
            [btnTitleView setTitle: [values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
        }
        [self generateXCZFBH];

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
    
    HHJGH.text = [infoDic objectForKey:@"HHJGH"];
    JCSJ.text = [infoDic objectForKey:@"JCSJ"];
    SBDZ.text = [infoDic objectForKey:@"SBDZ"];
    JCYJ.text = [infoDic objectForKey:@"JCYJ"];
    WGSJ.text = [infoDic objectForKey:@"WGSJ"];
    QYMC.text = [infoDic objectForKey:@"QYMC"];
    SBSJ.text = [infoDic objectForKey:@"SBSJ"];
    XCJCRY.text = [infoDic objectForKey:@"XCJCRY"];
    JCRDH.text = [infoDic objectForKey:@"LXDH"];
    QYDSR.text = [infoDic objectForKey:@"QYDSR"];
    DSRDH.text = [infoDic objectForKey:@"QYLXDH"];

}

-(void)Signame{
    SignNameController *controller = [[[SignNameController alloc] initWithNibName:@"SignNameController" bundle:nil] autorelease];
    
    controller.delegate = self;
    controller.wrybh = self.dwbh;
    controller.wrymc = QYMC.text;
    controller.xczfbh = self.xczfbh;
    controller.tableName = @"signNameTable";
    controller.lxBH = 7;
    controller.firstName = g_logedUserInfo.userName;
    controller.secondName = @"陪同执法人员";
    
//    if([surePerson count] >=2){
//        UserInfo *aInfo1 = [surePerson objectAtIndex:0];
//        UserInfo *aInfo2 = [surePerson objectAtIndex:1];
//        controller.firstName = aInfo1.userName;
//        controller.secondName = aInfo2.userName;
//    }
    
    
    controller.modalPresentationStyle =  UIModalPresentationFormSheet;
    [self presentModalViewController:controller animated:YES];
    controller.view.superview.frame = CGRectMake(0, 1024-630, 768, 630);
    
}

-(void)signFinished{
    [self commitRecords];
}

//根据值来显示值
-(void)displayRecordDatas:(id)object{
    NSDictionary* values = (NSDictionary*)object;
    [self loadData:values];
}

-(NSDictionary*)getValueData{
    
    NSMutableDictionary *dicValues = [NSMutableDictionary dictionaryWithCapacity:5];
    [dicValues setValue:HHJGH.text forKey:@"HHJGH"];
    [dicValues setValue:JCSJ.text forKey:@"JCSJ"];
    [dicValues setValue:SBDZ.text forKey:@"SBDZ"];
    [dicValues setValue:JCYJ.text forKey:@"JCYJ"];
    [dicValues setValue:WGSJ.text forKey:@"WGSJ"];
    [dicValues setValue:QYMC.text forKey:@"QYMC"];
    [dicValues setValue:SBSJ.text forKey:@"SBSJ"];
    [dicValues setValue:XCJCRY.text forKey:@"XCJCRY"];
    [dicValues setValue:JCRDH.text forKey:@"LXDH"];
    [dicValues setValue:QYDSR.text forKey:@"QYDSR"];
    [dicValues setValue:DSRDH.text forKey:@"QYLXDH"];
    
    return dicValues;
}

-(void)commitRecords {
	NSMutableString *sql = [[NSMutableString alloc] initWithCapacity:400];
	[sql appendString:
     @"insert into T_YDZF_XCJCYJSZ(BH,HHJCH,QYMC,XCJCRY,LXDH,QYDSR,QYLXDH,JCSJ,JCYJ,SBSJ,WGSJ,SBDZ,"
"CJR,CJSJ,ORGID,BZ) values("];
	
	[sql appendFormat:@"'%@','%@','%@','%@','%@','%@','%@',to_date('%@', 'yyyy-mm-dd hh24:mi'),'%@',to_date('%@', 'yyyy-mm-dd hh24:mi'),'%@','%@', ",self.xczfbh,HHJGH.text,QYMC.text,XCJCRY.text,JCRDH.text,QYDSR.text,DSRDH.text,JCSJ.text,JCYJ.text,
	 SBSJ.text,WGSJ.text,SBDZ.text];
	
	[sql appendFormat:@"'%@',sysdate,'%@','%@')",g_logedUserInfo.userName,g_logedUserInfo.userORGID,@""];
    [self commitRecordDatas:sql];
    [sql release];
}

-(void)commitBilu:(id)sender
{
    
    NSString *errMsg = @"";
    if ([HHJGH.text length] <= 0) {
         errMsg = @"审批文号不能为空";
    }
    
    else if ([JCSJ.text length] <= 0) {
        errMsg = @"检查时间不能为空";
    }
    
    else if ([SBSJ.text length] <= 0) {
        errMsg = @"上报时间不能为空";
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
    
    [self Signame];
}



-(IBAction)choosePerson:(id)sender{
    UIControl *control = (UIControl*)sender;
    
    PersonSelectControllerView *tmpController =
    [[PersonSelectControllerView alloc] initWithStyle:UITableViewStyleGrouped];
    tmpController.delegate1 = self;
    tmpController.contentSizeForViewInPopover = CGSizeMake(360, 660);
	self.peopleController = tmpController;
    [tmpController release];
    
    if (g_logedUserInfo!=nil) {
        SharedInformations *info = [SharedInformations sharedSharedInformations];
        if ([surePerson count]==0||surePerson == nil) {
            info.people = [NSMutableArray arrayWithObject:g_logedUserInfo];
        }
        else
            info.people = surePerson;
        
        
        UINavigationController *tmpNav = [[UINavigationController alloc] initWithRootViewController:self.peopleController];
        
        UIPopoverController *tmpPopover = [[UIPopoverController alloc] initWithContentViewController:tmpNav];
        self.popController = tmpPopover;
        [tmpPopover release];
        [tmpNav release];
        
        [self.peopleController.tableView reloadData];
        [self.popController presentPopoverFromRect:control.frame
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionAny
                                          animated:YES] ;
    }
    
}

-(void)returnPersons:(NSMutableArray*)aryPersons{
    self.surePerson = aryPersons;
    
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
    
    XCJCRY.text = names;
    
    if (popController) {
        [self.popController dismissPopoverAnimated:YES];
    }
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"监察意见";
    if ([g_logedUserInfo.BMBH isEqualToString:@"15"]) {
        DLRSSBM.text = @"杭州市环境监察支队依法进行环保执法检查时，发现你单位";
    }
    else
        DLRSSBM.text = [NSString stringWithFormat:@"%@依法进行环保执法检查时，发现你单位",g_logedUserInfo.FSHBJ];
    DLRSSBM.textAlignment = UITextAlignmentRight;
    
    
    
	PopupDateViewController *date = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDate];
	self.dateController = date;
	dateController.delegate = self;
	[date release];
	
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
	
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	//popController.delegate = self;
	[popover release];
	[nav release];
	
	self.endDateValue = [NSDate date];

    JCYJ.layer.borderColor = UIColor.grayColor.CGColor;  //textview边框颜色
    JCYJ.layer.borderWidth = 2;
  
}


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
		if (currentTag == 1) {
            JCSJ.text = dateString;
        }
        else if(currentTag == 2)
        {
            SBSJ.text = dateString;
            self.endDateValue = date;
        }
	}
    if ([SBSJ.text isEqualToString:@""]==NO) {
        if (([JCSJ.text compare:SBSJ.text] == NSOrderedDescending)||
            [JCSJ.text compare:SBSJ.text] == NSOrderedSame)
        {
            
            UIAlertView *alert = [[UIAlertView alloc] 
                                  initWithTitle:@"提示" 
                                  message:@"结束时间要比开始时间晚"  
                                  delegate:self 
                                  cancelButtonTitle:@"确定" 
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            SBSJ.text=@"";  
        }
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


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
    //[self update];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"opinion" object:nil];
}


- (void)dealloc {    
	[endDateValue release];
	[popController release];
	[dateController release];
    [valuesAry release];
    [keysAry release];
    [surePerson release];
    [peopleController release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 111 || textField.tag == 112 || textField.tag == 113) {
        return YES;
    }
	return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGFloat arrange =0;
    if (textField.tag == 111) {
        arrange= -40;
    }
    if (textField.tag == 112) {
        arrange = -100;
    }
    if (textField.tag == 113) {
        arrange = -40;
    }
    
    
    if (textField.tag == 111 ||  textField.tag == 112 || textField.tag == 113) {
        CGRect frame = self.view.frame;
        float orignX = frame.origin.x;
        
        float width =  frame.size.width;
        float height = frame.size.height;
        
        
        [UIView beginAnimations:@"KeyBoard" context:nil];
        frame = CGRectMake(orignX, arrange, width, height);
        self.view.frame = frame;
        [UIView commitAnimations];
    }
}

- (void)keyBoardDidHide:(id)sender {
    CGRect frame = self.view.frame;
    float orignX = frame.origin.x;
    
    float width =  frame.size.width;
    float height = frame.size.height;
    
    
    [UIView beginAnimations:@"KeyBoard" context:nil];
    frame = CGRectMake(orignX, 0, width, height);
    self.view.frame = frame;
    [UIView commitAnimations];

}

@end
