    //
//  SiteInforcementConroller.m
//  EPad
//
//  Created by chen on 11-4-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SiteInforcementConroller.h"
#import "DudelViewController.h"
#import "GMEPS_HZAppDelegate.h"
#import "LoginViewController.h"
#import "UISearchSitesController.h"
#import "GUIDGenerator.h"
#import "SharedInformations.h"
#import <QuartzCore/QuartzCore.h>
#import "JSONKit.h"
#import "GTMBase64.h"

extern UserInfo *g_logedUserInfo;
extern GMEPS_HZAppDelegate *g_appDelegate;

@implementation SiteInforcementConroller

@synthesize XCFZR,NL,XB,SFZHM,GZDW,ZW,YBAGX,JTZZ,DH,QTJZR,ZFZH,QRSF,SQHB,XCQK,YB,ZFRY,QYMC,KYKSSJ,KYJSSJ,KYDD;
@synthesize PopPeopleController,peopleController,wordsPopoverController,popController,wordsSelectViewController,dateController;
@synthesize surePreson;

#define T_XCZF_XCKYBL @"T_YDZF_XCKYBL"
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
        return nil;
    self.tableName = T_XCZF_XCKYBL;
    return self;
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

-(IBAction)touchFromDate:(id)sender{
	UIControl *btn =(UIControl*)sender;
    
    PopupDateViewController *tmpdate = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDateAndTime];
	self.dateController = tmpdate;
	dateController.delegate = self;
	[tmpdate release];
	
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
	
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	[popover release];
	[nav release];

	[self.popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	currentTag = btn.tag;
}

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date {
    [popController dismissPopoverAnimated:YES];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
		NSString *dateString = [dateFormatter stringFromDate:date];
		[dateFormatter release];
		
		switch (currentTag) {
			case 102:
				KYKSSJ.text = dateString;
                //     //NSLog(@"11%@",XWKSSJ);
                //  self.TZSJDateValue = date;
				break;
			case 103:
				KYJSSJ.text = dateString;
                //  self.JSCLSJDateValue = date;
				
				break;
			default:
				break;
		}
    
    
    NSLog(@"start:%@ end:%@",KYKSSJ.text,KYJSSJ.text);
    if (([KYKSSJ.text compare:KYJSSJ.text] == NSOrderedDescending)||
        [KYKSSJ.text compare:KYJSSJ.text] == NSOrderedSame)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"结束时间不能早于开始时间"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        KYJSSJ.text=@"";
        
    }
    

    
}

- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row{
	
	YBAGX.text = words;
	if (wordsPopoverController != nil) {
		[wordsPopoverController dismissPopoverAnimated:YES];
	}
}


-(void)commitBilu:(id)sender
{
    
    NSString *message = nil;
    if([KYKSSJ.text isEqualToString:@""])
        message = @"开始时间不能为空";
    else if([KYJSSJ.text isEqualToString:@""])
        message = @"结束时间不能为空";
    
    
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
	[sql appendString:@"insert into t_ydzf_kybl(BH,XCFZR,NL,XB,SFZHM,"
	 "GZDW,ZW,YBAGX,JTZZ,DH,QTJZR,ZFZH,QRSF,SQHB,XCQK,YB,JCKSSJ,JCJSSJ,JCDD,ORGID,CJSJ,CJR) values("];
	
	[sql appendFormat:@"'%@','%@','%@','%@','%@','%@','%@','%@',",self.xczfbh,
	 XCFZR.text, NL.text,(XB.selectedSegmentIndex == 0)?@"男":@"女",SFZHM.text,GZDW.text,ZW.text,YBAGX.text];
	[sql appendFormat:@"'%@','%@','%@','%@','%@','%@','%@','%@',to_date('%@', 'yyyy-mm-dd hh24:mi'),to_date('%@', 'yyyy-mm-dd hh24:mi'),'%@','%@',sysdate,'%@')",
	 JTZZ.text, DH.text,QTJZR.text,ZFZH.text,QRSF.text,SQHB.text,XCQK.text,YB.text,KYKSSJ.text,KYJSSJ.text,KYDD.text,g_logedUserInfo.userORGID,g_logedUserInfo.userName];
	
	[self commitRecordDatas:sql];
	[sql release];
  
}



-(NSDictionary*)getValueData{

    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithCapacity:25];
    [dicParams setObject:QYMC.text forKey:@"BJCRMC"];
    [dicParams setObject:XCFZR.text forKey:@"XCFZR"];
    [dicParams setObject:NL.text forKey:@"NL"];
    [dicParams setObject:KYKSSJ.text forKey:@"JCKSSJ"];
    [dicParams setObject:KYJSSJ.text forKey:@"JCJSSJ"];
    [dicParams setObject:KYDD.text forKey:@"JCDD"];
    [dicParams setObject:SFZHM.text forKey:@"SFZHM"];
    [dicParams setObject:ZW.text forKey:@"ZW"];
    [dicParams setObject:GZDW.text forKey:@"GZDW"];
    [dicParams setObject:JTZZ.text  forKey:@"DZ"];
    [dicParams setObject:DH.text forKey:@"DH"];
    [dicParams setObject:YBAGX.text forKey:@"YBAGY"];
    [dicParams setObject:QTJZR.text forKey:@"QTJZR"];
    if (g_logedUserInfo.FSHBJ!=nil){
        [dicParams setObject:g_logedUserInfo.FSHBJ forKey:@"JCR_WMS"];
    }
    [dicParams setObject:YB.text forKey:@"YB"];
    [dicParams setObject:ZFRY.text forKey:@"ZFRY"];
    [dicParams setObject:ZFZH.text forKey:@"ZFZH"];
    [dicParams setObject:QRSF.text forKey:@"QRJL"];
    [dicParams setObject:SQHB.text forKey:@"SQHB"];
    [dicParams setObject:XCQK.text forKey:@"XCQK"];
    
    NSString *xb = [NSString stringWithFormat:@"%d",XB.selectedSegmentIndex];
    [dicParams setObject:xb forKey:@"XB"];

    return dicParams;
}

-(void)saveBilu:(id)sender
{
    
    NSDictionary *dicData = [self getValueData];
    NSMutableDictionary *dicValue = [NSMutableDictionary dictionaryWithDictionary:dicData];
    [dicValue setValue:self.xczfbh forKey:@"XCZFBH"];
    [self saveLocalRecord:dicValue];

}


-(void)displayRecordDatas:(NSDictionary*)valueDatas{
    
    ZFRY.text = [valueDatas objectForKey:@"ZFRY"];
    ZFZH.text = [valueDatas objectForKey:@"ZFZH"];
    QRSF.text = [valueDatas objectForKey:@"QRJL"];
    SQHB.text = [valueDatas objectForKey:@"SQHB"];
    XCQK.text = [valueDatas objectForKey:@"XCQK"];
    
    KYKSSJ.text = [valueDatas objectForKey:@"JCKSSJ"];
    KYJSSJ.text = [valueDatas objectForKey:@"JCJSSJ"];
    KYDD.text = [valueDatas objectForKey:@"JCDD"];
    XB.selectedSegmentIndex = [[valueDatas objectForKey:@"XB"] integerValue];
    
    QYMC.text = [valueDatas objectForKey:@"BJCRMC"];
    XCFZR.text = [valueDatas objectForKey:@"XCFZR"];
    NL.text = [valueDatas objectForKey:@"NL"];
    SFZHM.text = [valueDatas objectForKey:@"SFZHM"];
    ZW.text = [valueDatas objectForKey:@"ZW"];

    GZDW.text = [valueDatas objectForKey:@"GZDW"];
    JTZZ.text = [valueDatas objectForKey:@"DZ"];
    DH.text = [valueDatas objectForKey:@"DH"];
    YBAGX.text = [valueDatas objectForKey:@"YBAGY"];
    QTJZR.text = [valueDatas objectForKey:@"QTJZR"];
    YB.text = [valueDatas objectForKey:@"YB"];
}



-(void)returnSites:(NSDictionary*)values source:(NSInteger)type{
	if (values == nil) {
		[self.navigationController popViewControllerAnimated:YES];
	}
	else {
        if ([values count] == 1) {
            [btnTitleView setTitle:[values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
             self.wrymc = self.title =  self.GZDW.text = QYMC.text = [values objectForKey:@"WRYMC"];
             self.dwbh = @"";
        }
        else
        {
            self.dwbh     = [values objectForKey:@"WRYBH"];
            self.wrymc = self.title =  GZDW.text = QYMC.text = [values objectForKey:@"WRYMC"];
            [btnTitleView setTitle: [values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
        }
        [self  generateXCZFBH];
	}
}

-(void)returnPersons:(NSMutableArray*)aryPersons;
{
    self.surePreson = aryPersons;
    [PopPeopleController dismissPopoverAnimated:YES];
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
        else{
            if ([aInfo.ZFZJBH isEqualToString:@""]) {
                aInfo.ZFZJBH = @"";
            }
            [certIDs appendFormat:@",%@",aInfo.ZFZJBH];
        }
    }
    
    ZFRY.text = names;
    ZFZH.text = certIDs;
    
    
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
        
        
        [peopleController.tableView reloadData];
        [self.PopPeopleController presentPopoverFromRect:control.frame
                                                  inView:self.view
                                permittedArrowDirections:UIPopoverArrowDirectionAny
                                                animated:YES];
    }
    
}





// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"现场勘验记录";
    
	 //bCommited = NO;
    if (g_logedUserInfo.FSHBJ==nil) 
        g_logedUserInfo.FSHBJ = @"";
    if ([g_logedUserInfo.BMBH isEqualToString:@"15"]) 
        DLRSSBM.text = @"检查(勘察)人：我们是杭州市环境监察支队执法人员";
    else
        DLRSSBM.text = [NSString stringWithFormat:@"检查(勘察)人：我们是%@执法人员",g_logedUserInfo.FSHBJ];

    XCQK.layer.borderColor = UIColor.grayColor.CGColor;  //textview边框颜色
    XCQK.layer.borderWidth = 2;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *current = [NSDate date];
    NSString *currentStr = [dateFormatter stringFromDate:current];
    [dateFormatter release];
    
    KYKSSJ.text = currentStr;
    
    
    
    CommenWordsViewController *tmpController2 = [[CommenWordsViewController alloc] initWithNibName:@"CommenWordsViewController" bundle:nil ];
	tmpController2.contentSizeForViewInPopover = CGSizeMake(320, 132);
	tmpController2.delegate = self;
	tmpController2.wordsAry = [NSArray arrayWithObjects:@"法人代表",@"受委托人",
                              @"旁证",nil];
    
    UIPopoverController *tmppopover2 = [[UIPopoverController alloc] initWithContentViewController:tmpController2];
	self.wordsSelectViewController = tmpController2;
    self.wordsPopoverController = tmppopover2;
    [tmpController2 release];
    [tmppopover2 release];
    
}

- (void)update
{
    [self saveBilu:nil];
    
}

-(void)viewDidAppear:(BOOL)animated{
	[XCFZR resignFirstResponder];
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

//// 对应的UITextview控件设置delegate就会响应此函数
- (void)textViewDidBeginEditing:(UITextView *)textView{

	NSTimeInterval animationDuration=0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	float width=self.view.frame.size.width;
	float height=self.view.frame.size.height;
	CGRect rect=CGRectMake(0.0f,-240,width,height);//上移，按实际情况设置
	self.view.frame=rect;
	[UIView commitAnimations];
	return ;
}

- (void)textViewDidEndEditing:(UITextView *)textView{

	NSTimeInterval animationDuration=0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	float width=self.view.frame.size.width;
	float height=self.view.frame.size.height;
	CGRect rect=CGRectMake(0.0f,0.0f,width,height);
	self.view.frame=rect;
	[UIView commitAnimations];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	return NO;
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
    //[self update];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"siteinfor" object:nil];
}

- (void)dealloc {
    [QYMC release];
	[XCFZR release];
	[NL release];
	[XB release];
	[SFZHM release];
	[GZDW release];
	[ZW release];
	[YBAGX release];
	[JTZZ release];
	[DH release];
	[QTJZR release];
	[YB release];
    
    [ZFRY release];
	[ZFZH release];
	[QRSF release];
	[SQHB release];
	[XCQK release];
    [KYKSSJ release];
    [KYJSSJ release];

	[PopPeopleController release];
    [peopleController release];
    [wordsPopoverController release];
    [wordsSelectViewController release];
    [dateController release];

    [super dealloc];
}

@end
