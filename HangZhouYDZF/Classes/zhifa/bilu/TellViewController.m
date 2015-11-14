    //
//  TellViewController.m
//  EPad
//
//  Created by chen on 11-4-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TellViewController.h"
#import "GMEPS_HZAppDelegate.h"
#import "GUIDGenerator.h"
#import "SharedInformations.h"
extern GMEPS_HZAppDelegate *g_appDelegate;
#import "LoginViewController.h"
extern UserInfo *g_logedUserInfo;
#import "GTMBase64.h"

#import "JSONKit.h"
#define T_XCZF_ZFGZS @"T_YDZF_ZFGSZ"


@implementation TellViewController
@synthesize YY,WFLL,JCSJ,TZSJ,JSCLSJ,JS,QTWP;
@synthesize QYDW,YY2,JSCLSJ2,QYDW2;
@synthesize JCSJDateValue,TZSJDateValue,JSCLSJDateValue;
@synthesize peopleController,popController,dateController;
@synthesize DWDSR,DSRDH,XCJCRY,JCRDH;
@synthesize DLRSSBM,DLRSSBMDZ,surePerson,bringContentAry,bringContentStr,scrollView;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
        return nil;
    
    self.tableName = T_XCZF_ZFGZS;
    self.bringContentAry = [NSMutableArray array];
    self.bringContentStr =  [NSMutableString stringWithFormat:@"|||||||"];
	
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    return self;
}


-(BOOL)saveDatas{
	
	return YES;
}

//选中携带内容
-(IBAction)selectBringContent:(id)sender {
    NSInteger tag = [sender tag];
    UIButton *selectBtn = (UIButton *)sender;
    NSMutableArray  *strAry =  [NSMutableArray arrayWithArray:[bringContentStr componentsSeparatedByString:@"|"]];
    NSString *titleStr = nil;
    switch (tag) {
        case 1:
            titleStr = @"工商营业执照";
            break;
        case 2:
            titleStr = @"组织机构代码证";
            break;
        case 3:
            titleStr = @"污染物排放许可证";
            break;
        case 4:
            titleStr = @"排污发票";
            break;
        case 5:
            titleStr = @"建设项目环境影响评价及环保审批验收资料";
            break;
        case 6:
            titleStr = @"违反法律法规的书面检查";
            break;
        case 7:
            titleStr = @"单位法定代表人的授权委托书(复印件需加盖单位公章)";
            break;
        case 8:
            titleStr = @"身份证复印件";
            break;
        default:
            break;
    }
    
    if ([bringContentAry containsObject:titleStr]) {
        [bringContentAry removeObject:titleStr];
        [strAry replaceObjectAtIndex:tag-1 withObject:@""];
        [selectBtn setImage:[UIImage imageNamed:@"noSelect.png"] forState:UIControlStateNormal];
    }
    else {
        [bringContentAry addObject:titleStr];
        [strAry replaceObjectAtIndex:tag-1 withObject:titleStr];
        [selectBtn setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
    }
    
    NSMutableString *selectContent = [NSMutableString string];
    for (int i=0; i < [strAry count]; i++  ) {
        NSString *title  =  [strAry objectAtIndex:i];
        if (i == 0) {
            [selectContent appendString:title];
        }
            
        else {
            [selectContent appendFormat:@"|%@",title];
        }
    }
    
    self.bringContentStr = selectContent;

}


//把记录的公共值存储起来
-(void)savePublicValues{
    SharedInformations *info = [SharedInformations sharedSharedInformations];
    info.reasonToSurvey = YY.text;
}

//执法记录公共的值
-(void)blPublicValue{
    SharedInformations *info = [SharedInformations sharedSharedInformations];
    YY.text = info.reasonToSurvey;
    YY2.text = info.reasonToSurvey;
}


-(void)returnSites:(NSDictionary*)values source:(NSInteger)type{
	if (values == nil) {
		[self.navigationController popViewControllerAnimated:YES];
	}
	else {
        if ([values count] == 1) {
            [btnTitleView setTitle:[values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.wrymc = self.title = QYDW2.text = QYDW.text = [values objectForKey:@"WRYMC"];
            self.dwbh = @"";
            
        }
        else
        {
            self.dwbh  = [values objectForKey:@"WRYBH"];
            self.wrymc = self.title = self.QYDW2.text = self.QYDW.text = [values objectForKey:@"WRYMC"];
            [btnTitleView setTitle: [values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
        }
         [self  generateXCZFBH];
        [self blPublicValue];
	}
}

-(void)Signame{
    SignNameController *controller = [[[SignNameController alloc] initWithNibName:@"SignNameController" bundle:nil] autorelease];
    
    controller.delegate = self;
    controller.wrybh = self.dwbh;
    controller.wrymc = self.wrymc;
    controller.xczfbh = self.xczfbh;
    controller.tableName = @"signNameTable";
    controller.lxBH = 5;
   
    
        if([surePerson count] >=2){
            UserInfo *aInfo1 = [surePerson objectAtIndex:0];
            UserInfo *aInfo2 = [surePerson objectAtIndex:1];
            controller.firstName = aInfo1.userName;
            controller.secondName = aInfo2.userName;
        }
        else {
            controller.firstName = g_logedUserInfo.userName;
            controller.secondName = @"陪同执法人员";
        }
    
    
    controller.modalPresentationStyle =  UIModalPresentationFormSheet;
    [self presentModalViewController:controller animated:YES];
    controller.view.superview.frame = CGRectMake(0, 1024-630, 768, 630);
    
}

-(void)signFinished{
    [self commitRecords];
}

- (void)commitRecords {
    NSMutableString *sql = [[NSMutableString alloc] initWithCapacity:400];
	[sql appendString:@"insert into T_YDZF_XCZFGZS(BH,HHJGH,WRYMC,YWF,FXDW,JCSJ,TZSJ,QLCLSJ,BJCDB,BXWRMC,DH,TZQLSJ,WF,JS,QT,XWR,ZFRDH,CJSJ,CJR,XDNR) values("];
	//YWF->YY WF->WFLL QT->QTZS
	[sql appendFormat:@"'%@','%@','%@','%@','%@',to_date('%@' , 'yyyy-mm-dd hh24:mi'),"
	 "to_date('%@' , 'yyyy-mm-dd hh24:mi'),to_date('%@' , 'yyyy-mm-dd hh24:mi'),'%@','%@','%@',to_date('%@' , 'yyyy-mm-dd hh24:mi'),'%@','%@','%@','%@','%@',sysdate,'%@','%@')",
	 self.xczfbh,HHJGH.text,QYDW.text,YY.text,YY2.text,JCSJ.text,TZSJ.text,JSCLSJ.text,QYDW2.text,DWDSR.text,DSRDH.text,JSCLSJ2.text,WFLL.text, JS.text, QTWP.text,XCJCRY.text,JCRDH.text,g_logedUserInfo.userName,bringContentStr];
    
    [self commitRecordDatas:sql];
	[sql release];
    //[_BH release];
    SharedInformations *info = [SharedInformations sharedSharedInformations];
	[info.dicStoreTempData removeAllObjects];
}

-(void)saveBilu:(id)sender
{
    NSDictionary *dicData = [self getValueData];
    NSMutableDictionary *dicValue = [NSMutableDictionary dictionaryWithDictionary:dicData];
    [dicValue setValue:self.xczfbh forKey:@"XCZFBH"];
    [self saveLocalRecord:dicValue];

}

-(void)commitBilu:(id)sender
{
    NSString *errMsg = @"";
    if ([HHJGH.text length] <= 0) {
        errMsg = @"审批文号不能为空";
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

-(NSDictionary*)getValueData{
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithCapacity:12];
    NSArray *ary = [NSArray arrayWithObjects:QYDW,YY,TZSJ,JSCLSJ,QYDW2,JCSJ,YY2,WFLL,JSCLSJ2,JS,QTZJ,nil];
    UITextField *tmpField;
    for (int i = 0; i < [ary count]; i++) {
        tmpField = [ary objectAtIndex:i];
        if (tmpField.text==nil) {
            tmpField.text = @"";
        }
    }
    [dicParams setObject:QYDW.text forKey:@"WRYMC"];
    [dicParams setObject:YY.text forKey:@"YWF"];
    [dicParams setObject:TZSJ.text forKey:@"TZSJ"];
    [dicParams setObject:JSCLSJ.text  forKey:@"QLCLSJ"];
    [dicParams setObject:QYDW2.text forKey:@"BJCDB"];
    [dicParams setObject:JCSJ.text  forKey:@"JCSJ"];
    [dicParams setObject:YY2.text forKey:@"FXDW"];
    [dicParams setObject:WFLL.text  forKey:@"WF"];
    [dicParams setObject:JSCLSJ2.text forKey:@"TZQLSJ"];
    [dicParams setObject:JS.text forKey:@"JS"];
    [dicParams setObject:QTWP.text forKey:@"QT"];
    [dicParams setObject:bringContentStr forKey:@"XDNR"];
    [dicParams setObject:HHJGH.text forKey:@"HHJGH"];
    [dicParams setObject:DWDSR.text forKey:@"BXWRMC"];
    [dicParams setObject:DSRDH.text forKey:@"DH"];
    [dicParams setObject:XCJCRY.text forKey:@"XWR"];
    [dicParams setObject:JCRDH.text forKey:@"ZFRDH"];
    
    if (g_logedUserInfo.FSHBJ!=nil){
        if ([g_logedUserInfo.BMBH isEqualToString:@"15"]){
            [dicParams setObject:@"杭州市环境监察支队" forKey:@"BT2"];
            [dicParams setObject:@"杭州市环境监察支队" forKey:@"BT4"];
        }
        else{
            [dicParams setObject:g_logedUserInfo.FSHBJ forKey:@"BT2"];
            [dicParams setObject:g_logedUserInfo.FSHBJ forKey:@"BT4"];
        }
        [dicParams setObject:g_logedUserInfo.ZZDZ forKey:@"DZ"];
    }
        
    return dicParams;
    
}

-(void)displayRecordDatas:(NSDictionary*)valueDatas{
    HHJGH.text = [valueDatas objectForKey:@"HHJGH"];
    QYDW.text = [valueDatas objectForKey:@"WRYMC"];
    YY.text = [valueDatas objectForKey:@"YWF"];
    TZSJ.text = [valueDatas objectForKey:@"TZSJ"];
    JSCLSJ.text = [valueDatas objectForKey:@"QLCLSJ"];
    QYDW2.text = [valueDatas objectForKey:@"BJCDB"];
    JCSJ.text = [valueDatas objectForKey:@"JCSJ"];
    YY2.text = [valueDatas objectForKey:@"WF"];
    JSCLSJ2.text = [valueDatas objectForKey:@"TZQLSJ"];
    JS.text = [valueDatas objectForKey:@"JS"];
    DWDSR.text = [valueDatas objectForKey:@"BXWRMC"];
    DSRDH.text = [valueDatas objectForKey:@"DH"];
    XCJCRY.text = [valueDatas objectForKey:@"XWR"];
    JCRDH.text = [valueDatas objectForKey:@"ZFRDH"];
    QTWP.text = [valueDatas objectForKey:@"QT"];
    
    
    NSString *bringStr = [valueDatas objectForKey:@"XDNR"];
    
    NSArray *contentAry = [NSArray arrayWithObjects:@"工商营业执照",@"组织机构代码证",@"污染物排放许可证",@"排污发票",@"建设项目环境影响评价及环保审批验收资料",@"违反法律法规的书面检查",@"单位法定代表人的授权委托书(复印件需加盖单位公章)",@"身份证复印件",nil];
    
    NSArray *bringAry = [bringStr componentsSeparatedByString:@"|"];
    for (int n=0; n < [bringAry count]; n++ ) {
        NSString *contentStr = [bringAry objectAtIndex:n];
        if (n ==0 && ![contentStr isEqualToString:@""]) {
            [bringBtn1 setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
        }
        if (n == 1 && ![contentStr isEqualToString:@""]) {
             [bringBtn2 setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
        }
        if (n == 2 && ![contentStr isEqualToString:@""]) {
            [bringBtn3 setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
        }
        if (n == 3 && ![contentStr isEqualToString:@""]) {
            [bringBtn4 setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
        }if (n == 4 && ![contentStr isEqualToString:@""]) {
            [bringBtn5 setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
        }
        if (n == 5 && ![contentStr isEqualToString:@""]) {
            [bringBtn6 setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
        }
        if (n == 6 && ![contentStr isEqualToString:@""]) {
            [bringBtn7 setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
        }
        if (n == 7 && ![contentStr isEqualToString:@""]) {
            [bringBtn8 setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
        }
        
        
        if (![contentAry containsObject:contentStr]) {
            QTZJ.text = contentStr;
        }
    }
    
    self.bringContentStr = [NSMutableString stringWithString:bringStr];
    
    
    WFLL.text = [valueDatas objectForKey:@"WF"];
    HHJGH.text = [valueDatas objectForKey:@"HHJGH"];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([g_logedUserInfo.BMBH isEqualToString:@"15"]) {
        DLRSSBM.text = @"时，杭州市环境监察支队依法进行环保执法检查时，";
        DLRSSBMDZ.text = [NSString stringWithFormat:@"时前来杭州市环境监察支队（%@",g_logedUserInfo.ZZDZ];
    }
    else{
        DLRSSBM.text = [NSString stringWithFormat:@"时，%@依法进行环保执法检查时，",g_logedUserInfo.FSHBJ];
        DLRSSBMDZ.text = [NSString stringWithFormat:@"时前来%@（%@",g_logedUserInfo.FSHBJ,g_logedUserInfo.ZZDZ];
    }
    
    DLRSSBMDZ.textAlignment = UITextAlignmentRight;
    DLRSSBM.textAlignment = UITextAlignmentRight;
    
    
    XCJCRY.text = g_logedUserInfo.userName;
    
  

	
	self.JCSJDateValue = [NSDate date];
	self.TZSJDateValue = [NSDate date];
	self.JSCLSJDateValue = [NSDate date];
	
	
    SharedInformations *info = [SharedInformations sharedSharedInformations];
    YY.text = YY2.text = info.reasonToSurvey;

    [scrollView setContentSize:CGSizeMake(768, 1500)];
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

-(IBAction)touchFromDate:(id)sender{
	UIControl *btn =(UIControl*)sender;
    
    PopupDateViewController *date = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDateAndTime];
	self.dateController = date;
	dateController.delegate = self;
	[date release];
	
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
	
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	[popover release];
	[nav release];
    
    
	[self.popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
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
				TZSJ.text = dateString;
				self.TZSJDateValue = date; 
				break;
			case 103:
				JSCLSJ.text = dateString;
				self.JSCLSJDateValue = date;
				JSCLSJ2.text = dateString;
				break;
			case 105:
				JCSJ.text = dateString;
				self.JCSJDateValue = date;
				break;
			default:
				break;
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


#pragma mark -
#pragma makr UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 101||textField.tag==110 || textField.tag == 112 ) {
        return YES;
    }
	return NO;
}


// 用户输入时向上滚动视图，避免键盘遮挡输入框
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGFloat arrange =0;
    if (textField.tag == 110) {
         arrange= -190;
    }
    if (textField.tag == 112) {
        arrange = -150;
    }
    
   
    if (textField.tag == 110 ||  textField.tag == 112) {
        CGRect frame = self.view.frame;
        float orignX = frame.origin.x;
        
        float width =  frame.size.width;
        float height = frame.size.height;
        
       
        [UIView beginAnimations:@"KeyBoard" context:nil];
        frame = CGRectMake(orignX, arrange, width, height);
        self.view.frame = frame;
        [UIView commitAnimations];

    }
    
    NSLog(@"y:%f",self.view.frame.origin.y);
    
      
   
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 101) {
        YY2.text = textField.text;
    }
    
    
   
//        NSMutableString *bringStr = [NSMutableString stringWithString:bringContentStr];
//        [bringStr  appendFormat:@"|%@",QTZJ.text];
//        self.bringContentStr = bringStr;

  
}

- (void)keyBoardDidHide:(NSNotification *)sender {
    CGRect frame = self.view.frame;
    float orignX = frame.origin.x;
    
    float width =  frame.size.width;
    float height = frame.size.height;
    
    
    [UIView beginAnimations:@"KeyBoard" context:nil];
    frame = CGRectMake(orignX, 0, width, height);
    self.view.frame = frame;
    [UIView commitAnimations];

}

- (void)dealloc {
	
	[YY release];
	[WFLL release];
	[JCSJ release];
	[TZSJ release];
	[JSCLSJ release];
	[JS release];
	[QTZJ release];
    
    
    [DWDSR release];;
    [DSRDH release];
    [XCJCRY release];
    [JCRDH release];
	
	[JCSJDateValue release];
	[TZSJDateValue release];
	[JSCLSJDateValue release];
	 
	[JSCLSJ2 release];
	[YY2 release];
	[QYDW release];
	[QYDW2 release];
	
	[popController release];
	[dateController release];

    [surePerson release];
    [bringContentAry release];
    [bringContentStr release];
    [anyouPopoverController release];
    [peopleController release];

    [super dealloc];
}


@end
