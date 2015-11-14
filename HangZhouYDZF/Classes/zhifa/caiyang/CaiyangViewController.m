    //
//  CaiyangViewController.m
//  EPad
//
//  Created by chen on 11-5-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CaiyangViewController.h"
#import "CaiyangSubView.h"
#import <QuartzCore/QuartzCore.h>
#import "GMEPS_HZAppDelegate.h"
#import "GUIDGenerator.h"
extern GMEPS_HZAppDelegate *g_appDelegate;
#import "LoginViewController.h"
extern UserInfo *g_logedUserInfo;
#define T_XCZF_CYB @"T_YDZF_CYB"
#import "DBHelper.h"

#import "GTMBase64.h"
#import "JSONKit.h"

@implementation CaiyangViewController
@synthesize myTableView,sampleList;
@synthesize PFFSL,CYFS, PFFS, BCDWMC,BZ,XCJC;
@synthesize  GRW,XMMC,DZ;
@synthesize   QW,TQZK, YZQK,CYRQ,SCFH,GDJJRQK,GFHQK,YB;
@synthesize popController,dateController,CYRQDate;
@synthesize wordsSelectViewController,wordsPopoverController;
@synthesize esPopoverController,standardController;


-(void)returnSelectedStandards:(NSArray*)aryStandards {
    [esPopoverController dismissPopoverAnimated:YES];
    NSMutableString *standardString = [[NSMutableString alloc] init];
    NSString *standard;
    
    for (standard in aryStandards) {
        if ([standardString length] == 0)
            [standardString appendFormat:@"%@",standard];
        else
            [standardString appendFormat:@"\n%@",standard];
    }
    
    BZ.text = standardString;
    [standardString release];
}



-(IBAction)chooseStandards:(id)sender {
    UIButton *btn =(UIButton*)sender;
	[esPopoverController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)commitBilu:(id)sender
{
    NSString *message;
    if ([sampleList count]==0) {
        message = @"请添加样品!";
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"提示" 
                              message:message  
                              delegate:self 
                              cancelButtonTitle:@"确定" 
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return ;
    }
    
    

    nBilusToCommit =1+ [sampleList count];
    successCount = 0;

   
	NSMutableString *sql = [[NSMutableString alloc] initWithCapacity:400];
	[sql appendString:@"insert into T_YDZF_WRYFSCY(PFFSL,BH,BJCDWMC,CYFS,PFFS,BZ,XCJC,GRW,XMMC,JYSJ,TQZK,QW,YZQK,SCFH,GDJJRQK,GFHQK,CJSJ,CJR,ORGID) values("];
	
	[sql appendFormat:@"'%@','%@','%@','%@','%@','%@','%@','%@',",PFFSL.text,self.xczfbh,BCDWMC.text,CYFS.text,PFFS.text,
	 BZ.text,XCJC.text,GRW.text];
	[sql appendFormat:@"'%@',to_date('%@' , 'yyyy-MM-dd hh24:mi'),'%@','%@','%@',",XMMC.text,CYRQ.text,TQZK.text,QW.text,YZQK.text];
	
	[sql appendFormat:@"'%@','%@','%@',sysdate,'%@','%@')",SCFH.text,GDJJRQK.text,GFHQK.text,g_logedUserInfo.userName,g_logedUserInfo.userORGID];
    
//    [self commitRecordDatas:sql];
//    [sql release];
    
    
    
    int samplesCount = [sampleList count];
    Sample *aSample = nil;
    
	for (int i=0; i< samplesCount;i++ )
    {
        //  //NSLog(@"222%d",i); 
		aSample = [sampleList objectAtIndex:i];
        [sql appendString:@" ^ insert into T_YDZF_WRYFSCYZB(ORGID,BH,XH,YPBH,CYDMC,CYSJ,JCXM1,SYWG1,LS,KD,"
         "SD,LL,PFL,CJSJ,CJR,XGSJ,XGR) values("];
        [sql appendFormat:@"'%@','%@','%d','%@','%@',to_date('%@', 'yyyy-MM-dd hh24:mi'),'%@','%@','%@','%@',",g_logedUserInfo.userORGID,self.xczfbh,i,aSample.number,aSample.name,aSample.date,aSample.testColumnsNo,aSample.waterOutlet,aSample.speed,aSample.width];
        [sql appendFormat:@"'%@','%@','%@',sysdate,'%@',sysdate,'%@')",aSample.depth,aSample.flow,aSample.DischargeVolume,
         g_logedUserInfo.userName, g_logedUserInfo.userName];
        ////NSLog(@"%@",sql);
        
    }
    
     [self commitRecordDatas:sql];
    [sql release];
}

-(void)saveBilu:(id)sender
{
    NSDictionary *dicData = [self getValueData];
    NSMutableDictionary *dicValue = [NSMutableDictionary dictionaryWithDictionary:dicData];
    [dicValue setValue:self.xczfbh forKey:@"XCZFBH"];
    [self saveLocalRecord:dicValue];
}

-(void) saveSampleItems:(NSString *)bh
{
    int samplesCount = [sampleList count];
    Sample *aSample = nil;
    NSMutableString *sql = [[NSMutableString alloc]initWithCapacity:400];
	for (int i=0; i< samplesCount;i++ )
    {
      //  //NSLog(@"222%d",i);
		aSample = [sampleList objectAtIndex:i];
        [sql appendString:@"insert into T_YDZF_WRYFSCYZB(BH,XH,YPBH,CYDMC,CYSJ,JCXM1,SYWG1,LS,KD,"
         "SD,LL,PFL,CJSJ,CJR,XGSJ,XGR) values("];
        [sql appendFormat:@"'%@','%d','%@','%@',to_date('%@', 'yyyy-MM-dd hh24:mi'),'%@','%@','%@','%@',",bh,i,aSample.number,aSample.name,aSample.date,aSample.testColumnsNo,aSample.waterOutlet,aSample.speed,aSample.width];
        [sql appendFormat:@"'%@','%@','%@',sysdate,'%@',sysdate,'%@')",aSample.depth,aSample.flow,aSample.DischargeVolume,
         g_logedUserInfo.userName, g_logedUserInfo.userName];
        ////NSLog(@"%@",sql);
        [self commitRecordDatas:sql];
        [sql setString:@""];
    }
    
    [sql release];
}


-(void)returnSites:(NSDictionary*)values source:(NSInteger)type{
	
	if (values == nil) {
		[self.navigationController popViewControllerAnimated:YES];
	}
	else {
        if ([values count] == 1) {
            [btnTitleView setTitle:[values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.wrymc = BCDWMC.text = [values objectForKey:@"WRYMC"];
            self.dwbh = @"";
            DZ.text = @"";
        }
        else
        {
            self.dwbh  = [values objectForKey:@"WRYBH"];
            self.wrymc = self.title = BCDWMC.text = [values objectForKey:@"WRYMC"];
            DZ.text = [values objectForKey:@"DWDZ"];
            [btnTitleView setTitle: [values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
        }
        [self  generateXCZFBH];
	}
}



- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date{ 
	[popController dismissPopoverAnimated:YES];
	if (bSaved) {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
		NSString *dateString = [dateFormatter stringFromDate:date];
		[dateFormatter release];  
		
		switch (currentTag) {
			case 1:				
				CYRQ.text = dateString;
				self.CYRQDate = date; 
				break;
			default:
				break;
		}
	}
}


-(void)saveSample{
	[self.myTableView reloadData];
}

-(void)cancelSample{
    if(!bModifySample)
        [sampleList  removeLastObject];
}

-(IBAction)addSamples:(id)sender{
	bModifySample = NO;
	Sample *aSample = [[Sample alloc] init];
	[sampleList addObject:aSample];
	CaiyangSubView *controller = [[CaiyangSubView alloc] initWithNibName:@"CaiyangSubView" bundle:nil];
	controller.aSample = aSample;
    controller.bLoadSample = bModifySample;
	controller.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    nav.modalPresentationStyle =  UIModalPresentationFormSheet;
    [self presentModalViewController:nav animated:YES];
    nav.view.superview.frame = CGRectMake(0, 400, 768, 600);
    [nav release];
    [controller release];
    [aSample release];
}


-(IBAction)beginEditing:(id)sender{
    UIControl *ctrl = (UIControl*)sender;
	currentFieldTag = ctrl.tag;
    CommenWordsViewController *tmpController = [[CommenWordsViewController alloc] initWithNibName:@"CommenWordsViewController" bundle:nil ];
	tmpController.contentSizeForViewInPopover = CGSizeMake(100, 176);
	tmpController.delegate = self;
    if (ctrl.tag==101) {
        tmpController.wordsAry = [NSArray arrayWithObjects:@"混合",@"连续",@"间歇",@"瞬时",nil];
        
    }
    else if(ctrl.tag == 105)
    {
        tmpController.wordsAry = [NSArray arrayWithObjects:@"晴",@"多云",@"阵雨",@"暴雨",nil];
    }
    else if(ctrl.tag == 103)
    {
        tmpController.wordsAry = [NSArray arrayWithObjects:@"连续",@"间歇",nil];
    }
    UIPopoverController *tmppopover = [[UIPopoverController alloc] initWithContentViewController:tmpController];
	self.wordsSelectViewController = tmpController;
    self.wordsPopoverController = tmppopover;
	[tmpController release];
    [tmppopover release];
    
	CGRect rect;
	rect.origin.x = ctrl.frame.origin.x;	
	rect.origin.y = ctrl.frame.origin.y+5;
	rect.size.width = ctrl.frame.size.width;
	rect.size.height = ctrl.frame.size.height;
	[wordsSelectViewController.tableView reloadData];
	[self.wordsPopoverController presentPopoverFromRect:rect
												 inView:self.view
							   permittedArrowDirections:UIPopoverArrowDirectionUp
											   animated:YES];
}

- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row{
	if (currentFieldTag == CYFS.tag) {
        CYFS.text = words;
        //[CYFS resignFirstResponder];
    }
	else if(currentFieldTag == TQZK.tag)
    {
        TQZK.text = words;
        //[TQZK resignFirstResponder];
    }
    else if(currentFieldTag == PFFS.tag)
    {
        PFFS.text = words;
        //[PFFS resignFirstResponder];
    }
	if (wordsPopoverController != nil) {
		[wordsPopoverController dismissPopoverAnimated:YES];
	}

	
}

-(NSDictionary*)getValueData{
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithCapacity:20];
    //[dicParams setObject:sampleList forKey:@"sampleList"];
    NSArray *ary = [NSArray arrayWithObjects:XMMC,BCDWMC,DZ,YB,CYRQ,CYFS,PFFS,PFFSL,TQZK,QW,YB,GDJJRQK,GFHQK,GRW,YZQK,SCFH,XCJC,BZ,nil];
    UITextField *tmpField;
    for (int i = 0; i < [ary count]; i++) {
        tmpField = [ary objectAtIndex:i];
        if (tmpField.text==nil) {
            tmpField.text = @"";
        }
    }
    [dicParams setObject:XMMC.text forKey:@"XMMC"];
    [dicParams setObject:BCDWMC.text forKey:@"WRYMC"];
    [dicParams setObject:DZ.text forKey:@"DZ"];
    [dicParams setObject:YB.text  forKey:@"YB"];
    [dicParams setObject:CYRQ.text forKey:@"CYRQ"];
    [dicParams setObject:CYFS.text forKey:@"CYFS"];
    
    [dicParams setObject:PFFS.text forKey:@"PFFS"];
    [dicParams setObject:PFFSL.text forKey:@"PFFSL"];
    [dicParams setObject:TQZK.text forKey:@"TQZK"];
    [dicParams setObject:QW.text  forKey:@"QW"];
    
    [dicParams setObject:GDJJRQK.text forKey:@"GDJJRQK"];
    [dicParams setObject:GFHQK.text forKey:@"GFHQK"];
    [dicParams setObject:GRW.text forKey:@"GRW"];
    [dicParams setObject:YZQK.text  forKey:@"YZQK"];
    [dicParams setObject:SCFH.text forKey:@"SCFH"];
    [dicParams setObject:XCJC.text forKey:@"XCJC"];
    [dicParams setObject:BZ.text forKey:@"BZ"];
    
    return dicParams;

}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    self.tableName = T_XCZF_CYB;
    [super viewDidLoad];
    
    self.XMMC.text = @"飞行监测";
	self.CYRQDate = [NSDate date];
    
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
	NSString *dateString = [dateFormatter stringFromDate:CYRQDate];
	[dateFormatter release];
	CYRQ.text = dateString;
    
	[self.navigationController setNavigationBarHidden:NO animated:YES];
    
    BZ.layer.borderColor = UIColor.grayColor.CGColor;  //textview边框颜色
    BZ.layer.borderWidth = 2;
    
   
    
	sampleList = [[NSMutableArray alloc] initWithCapacity:10];
	
	NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:@"white" ofType:@"png"];
	UIImage *backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
	myTableView.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
   
    
	PopupDateViewController *date = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDateAndTime];
	self.dateController = date;
	dateController.delegate = self;
	[date release];	
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];	
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	//popController.delegate = self;
	[popover release];
	[nav release];
	
    EmissionStandardsViewController *tmpController = 
    [[EmissionStandardsViewController alloc] initWithNibName:@"EmissionStandardsViewController" bundle:nil];
	self.standardController = tmpController;
	standardController.delegate = self;
    [tmpController release];
    UINavigationController *tmpNav = [[UINavigationController alloc] initWithRootViewController:standardController];
	UIPopoverController *tmpPopover = [[UIPopoverController alloc] initWithContentViewController:tmpNav];
	self.esPopoverController = tmpPopover;
    [tmpPopover release];
	[tmpNav release];
    //CYFS.tag = 1;
    //TQZK.tag = 2;
    //PFFS.tag = 3;
	
    CYFS.delegate = self;
    [CYFS addTarget:self action:@selector(beginEditing:) forControlEvents: UIControlEventTouchDown];
    
    TQZK.delegate = self;
	[TQZK addTarget:self action:@selector(beginEditing:) forControlEvents: UIControlEventTouchDown];
    [PFFS addTarget:self action:@selector(beginEditing:) forControlEvents: UIControlEventTouchDown];
    
}


-(IBAction)touchFromDate:(id)sender{
	UIButton *btn =(UIButton*)sender;
	[popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	currentTag = btn.tag;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [sampleList count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	Sample * aSample = [sampleList objectAtIndex:indexPath.row];
	if(aSample.name == nil) aSample.name=@"";
	if(aSample.testColumns == nil) aSample.testColumns=@"";
	cell.textLabel.text = [NSString stringWithFormat:@"采样点名称:%@ 监测项目:%@", aSample.name,aSample.testColumns];
    // Configure the cell...
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.

	bModifySample = YES;
    Sample *aSample = [sampleList objectAtIndex:[indexPath row]];
	CaiyangSubView *controller = [[CaiyangSubView alloc] initWithNibName:@"CaiyangSubView" bundle:nil];
	controller.aSample = aSample;
    controller.bLoadSample = bModifySample;
	controller.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    nav.modalPresentationStyle =  UIModalPresentationFormSheet;
    [self presentModalViewController:nav animated:YES];
    nav.view.superview.frame = CGRectMake(0, 424, 768, 600);
    [nav release];
    [controller release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark ChooseRecordDelegate delegate

-(void)displayRecordDatas:(id)values{


    UITextField *tmpField;
    NSArray *valuesAry = [NSArray arrayWithObjects:XMMC,BCDWMC,DZ,YB,CYFS,CYRQ,QW,PFFS,PFFSL,TQZK,GDJJRQK,GFHQK,GRW,XCJC,YZQK,SCFH,nil];
    NSArray *keysAry = [NSArray arrayWithObjects:@"XMMC",@"WRYMC",@"DZ",@"YB",@"CYFS",@"CYRQ",@"QW",@"PFFS",@"PFFSL",@"TQZK",@"GDJJRQK",@"GFHQK",@"GRW",@"XCJC",@"YZQK",@"SCFH",nil];
    if (values!=nil) {
        for (int i = 0; i < [valuesAry count]; i++) {
            tmpField = [valuesAry objectAtIndex:i];
            tmpField.text = [values objectForKey:[keysAry objectAtIndex:i]];
            //if (tmpField.text==nil) tmpField.text = @"";
        }
        BZ.text = [values objectForKey:@"BZ"];
        //self.sampleList = [values objectForKey:@"sampleList"];
        [myTableView reloadData];
    }


}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)dealloc {
	[myTableView release];
	[sampleList release];
	
    [PFFSL release];
	[CYFS release];
	[PFFS release];
	[BCDWMC release];
	[BZ release];
	[XCJC release];
	[GRW release];
	[XMMC release];
	[DZ release];
	[QW release];
	
	[TQZK release];
	[YZQK release];
	[CYRQ release];
	[SCFH release];
	[GDJJRQK release];
    [GFHQK release];
	[YB release];
	[popController release];
	[dateController release];
    [esPopoverController release];
    [standardController release];


	[CYRQDate release];
    

    [super dealloc];
}

// 用户输入时向上滚动视图，避免键盘遮挡输入框
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

@end
