//
//  CaiyangSubView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "CaiyangSubView.h"
#import "GMEPS_HZAppDelegate.h"

extern sqlite3 *data_db;
@implementation CaiyangSubView
@synthesize ypbh;
@synthesize cydmc;
@synthesize cysj;
@synthesize sywg;
@synthesize jcxm;
@synthesize ls;
@synthesize kd; 
@synthesize sd; 
@synthesize ll;
@synthesize pfl; 
@synthesize aSample;
@synthesize bLoadSample;
@synthesize delegate;
@synthesize jcxmNoStr;
@synthesize popController;
@synthesize dateController;
@synthesize wordsSelectViewController;
@synthesize wordsPopoverController;
@synthesize dataResultArray;
@synthesize popYinziController;
@synthesize yinziController;


-(void)returnSelectedYinzi:(NSString *)strName andNo:(NSString*)strNo{
    [popYinziController dismissPopoverAnimated:YES];
    
    jcxm.text = strName;
    self.jcxmNoStr = strNo;
}

-(IBAction)chooseYinzi:(id)sender{
	UIButton *btn =(UIButton*)sender;
    
	[popYinziController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

-(IBAction)beginEditing:(id)sender{
    UIControl *ctrl = (UIControl*)sender;
    currentFieldTag = ctrl.tag;
    CommenWordsViewController *tmpController = [[CommenWordsViewController alloc] initWithNibName:@"CommenWordsViewController" bundle:nil ];
	
	tmpController.delegate = self;
    CGRect rect = CGRectZero;
    if (ctrl.tag==1) {
        tmpController.contentSizeForViewInPopover = CGSizeMake(100, 200);
        tmpController.wordsAry = [NSArray arrayWithObjects:@"清晰",@"透明",@"浑浊",
                                  @"红色",@"黄色",@"绿色",@"黑色",@"紫色",@"蓝色",nil];
        rect.origin.x = ctrl.frame.origin.x;	
        rect.origin.y = ctrl.frame.origin.y+5;
        rect.size.width = ctrl.frame.size.width;
        rect.size.height = ctrl.frame.size.height;
        [wordsSelectViewController.tableView reloadData];
        
    }
    else if (ctrl.tag==2) {
        tmpController.contentSizeForViewInPopover = CGSizeMake(200, 176);
        tmpController.wordsAry = [NSArray arrayWithObjects:@"总排口",@"标排口",@"外排口",@"雨水排口",nil];
        rect.origin.x = ctrl.frame.origin.x;	
        rect.origin.y = ctrl.frame.origin.y+5;
        rect.size.width = ctrl.frame.size.width;
        rect.size.height = ctrl.frame.size.height;
        [wordsSelectViewController.tableView reloadData];
        
    }

    UIPopoverController *tmppopover = [[UIPopoverController alloc] initWithContentViewController:tmpController];
	self.wordsSelectViewController = tmpController;
    self.wordsPopoverController = tmppopover;
	[tmpController release];
    [tmppopover release];
    	
	[self.wordsPopoverController presentPopoverFromRect:rect
												 inView:self.view
							   permittedArrowDirections:UIPopoverArrowDirectionDown
											   animated:YES];
}

- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row{
    if (currentFieldTag == sywg.tag) {
        sywg.text = words;
        [sywg resignFirstResponder];
    }
    else if (currentFieldTag == cydmc.tag)
    {
        cydmc.text = words;
        [cydmc resignFirstResponder];
    }

	if (wordsPopoverController != nil) {
		[wordsPopoverController dismissPopoverAnimated:YES];
	}
	
}



- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date{ 
	[popController dismissPopoverAnimated:YES];
	if (bSaved) {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
		NSString *dateString = [dateFormatter stringFromDate:date];
		[dateFormatter release];  
		
        cysj.text = dateString;
	}
}


-(IBAction)touchFromDate:(id)sender{
	UIButton *btn =(UIButton*)sender;
	[popController presentPopoverFromRect:[btn bounds] inView:btn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


-(IBAction)cancel:(id)sender{
	
	[self dismissModalViewControllerAnimated:YES];
	[delegate cancelSample];
	
}


- (IBAction)save:(id)sender{
    if (![ypbh.text isEqualToString:@""]) {
        NSString *copyYpbh = [ypbh.text copy];
        aSample.number = copyYpbh;
        [copyYpbh release];
    }
    else
        aSample.number = @"";
    
    if (![cydmc.text isEqualToString:@""]) {
        NSString *copyCydmc = [cydmc.text copy];
        aSample.name = copyCydmc;
        [copyCydmc release];
    }
    else
        aSample.name = @"";
    
    if (![cysj.text isEqualToString:@""]) {
        NSString *copyCysj = [cysj.text copy];
        aSample.date = copyCysj;
        [copyCysj release];
    }
    else
        aSample.date = @"";
    
    if (![sywg.text isEqualToString:@""]) {
       NSString *copyCywg = [sywg.text copy];
        aSample.waterOutlet = copyCywg;
        [copyCywg release];
    }
    else
        aSample.waterOutlet = @"";
    
    if (![jcxm.text isEqualToString:@""]){
        NSString *copyJcxm = [jcxm.text copy];
        aSample.testColumns = copyJcxm;
        [copyJcxm release];
        
        aSample.testColumnsNo = jcxmNoStr;
    }
    else{
        aSample.testColumns = @"";
        aSample.testColumnsNo = @"";
    }
    
    
    if (![ls.text isEqualToString:@""]) {
        NSString *copyLs = [ls.text copy];
        aSample.speed =  copyLs;
        [copyLs release];
    }
    else
        aSample.speed = @"";
    
    if (![kd.text isEqualToString:@""]) {
        NSString *copyKd = [kd.text copy];
        aSample.width = copyKd;
        [copyKd release];
    }
    else
        aSample.width = @"";
    
    if (![sd.text isEqualToString:@""]) {
        NSString *copySd = [sd.text copy];
        aSample.depth = copySd;
        [copySd release];
    }
    else
        aSample.depth = @"";
    
    if (![ll.text isEqualToString:@""]) {
        NSString *copyLl = [ll.text copy];
        aSample.flow = copyLl;
        [copyLl release];
    }
    else
        aSample.flow = @"";
    
    if (![pfl.text isEqualToString:@""]) {
        NSString *copyPfl = [pfl.text copy];
        aSample.DischargeVolume = copyPfl;
        [copyPfl release];
    }
    else
        aSample.DischargeVolume = @"";
    
    if ([ypbh.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"样品编号不能为空" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return;
    }
    else {
        [self dismissModalViewControllerAnimated:YES];
        [delegate saveSample];

    }
    
}

- (void)dealloc
{
    [ypbh release];
    [cydmc release];
    [cysj release];
    [sywg release];
    [jcxm release];
    [ls release];
    [kd release]; 
    [sd release]; 
    [ll release];
    [pfl release]; 
    [aSample release];
    [jcxmNoStr release];
    [popController release];
    [dateController release];
    [dataResultArray release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"样品信息录入";
    
    if (bLoadSample) {
        ypbh.text = aSample.number;
        cydmc.text = aSample.name;
        cysj.text = aSample.date;
        jcxm.text = aSample.testColumns;
        sywg.text = aSample.waterOutlet;
        ls.text = aSample.speed;
        kd.text = aSample.width;
        sd.text = aSample.depth;
        ll.text = aSample.flow;
        pfl.text = aSample.DischargeVolume;
    }
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
									 initWithTitle:@"取消"
									 style:UIBarButtonItemStylePlain
									 target:self
									 action:@selector(cancel:)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
	
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
								   initWithTitle:@"保存" 
								   style:UIBarButtonItemStyleDone
								   target:self
								   action:@selector(save:)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
    
    YinziViewController *tmpController = 
    [[YinziViewController alloc] initWithNibName:@"YinziViewController" bundle:nil];
	self.yinziController = tmpController;
	yinziController.delegate = self;
    [tmpController release];
    UINavigationController *tmpNav = [[UINavigationController alloc] initWithRootViewController:yinziController];
	UIPopoverController *tmpPopover = [[UIPopoverController alloc] initWithContentViewController:tmpNav];
	self.popYinziController = tmpPopover;
    [tmpPopover release];
	[tmpNav release];
    
    
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
    sywg.tag = 1;
    cydmc.tag = 2;
    //jcxm.tag = 2;
    
    [sywg addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchDown];
    [cydmc addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchDown];
    //[jcxm addTarget:self action:@selector(beginEditing:) forControlEvents: UIControlEventEditingDidBegin];
    
    NSString *sqlStr = @"SELECT * FROM T_COMN_JCXM WHERE SFYX='1' and WRWLB='FS'  ORDER BY PXM ASC";
	const char *utfsql = [sqlStr cStringUsingEncoding:NSUTF8StringEncoding];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	sqlite3_stmt *statement; 
	if (sqlite3_prepare_v2(data_db, utfsql, -1, &statement, nil)==SQLITE_OK) { 
        //NSLog(@"select OK");
	}
//	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:20];
    dataResultArray = [[NSMutableArray alloc]initWithCapacity:400];
	char *name;
	NSString *text;
	while (sqlite3_step(statement)==SQLITE_ROW) { 
		
        name=(char *)sqlite3_column_text(statement, 2); 
		text = [NSString stringWithCString:name  encoding:enc];
        [dataResultArray addObject:text];
        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	return NO;
}
@end
