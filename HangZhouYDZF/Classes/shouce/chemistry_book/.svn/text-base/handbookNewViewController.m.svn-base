//
//  handbookNewViewController.m
//  handbookNew
//
//  Created by chen on 11-4-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "handbookNewViewController.h"
#import "CategoryViewController.h"
#import "CnNameViewController.h"
#import "EnNameViewController.h"
#import "SearchViewController.h"
#import "GMEPS_HZAppDelegate.h"

extern sqlite3 *data_db;
extern NSArray *tableColumn;

@implementation handbookNewViewController

@synthesize categoryBtn,cnBihuaBtn,enAlphaBtn,searchBtn;
@synthesize cnameText;
@synthesize enameText;
@synthesize estatecodeText;
@synthesize cascodeText,imgView;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	if (orientation == UIInterfaceOrientationPortrait 
		||orientation ==  UIInterfaceOrientationPortraitUpsideDown) {
		return YES;
	}
	NSTimeInterval animationDuration=0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	float width=self.view.frame.size.width;
	float height=self.view.frame.size.height;
	CGRect rect=CGRectMake(0.0f,-230,width,height);//上移，按实际情况设置
	self.view.frame=rect;
	[UIView commitAnimations];
	return YES;
}

- (IBAction)keyboardWillHide:(NSNotification *)note{
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	if (orientation == UIInterfaceOrientationPortrait 
		||orientation ==  UIInterfaceOrientationPortraitUpsideDown) {
		return ;
	}
	NSTimeInterval animationDuration=0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	float width=self.view.frame.size.width;
	float height=self.view.frame.size.height;
	CGRect rect=CGRectMake(0.0f,0.0f,width,height);
	self.view.frame=rect;
	[UIView commitAnimations];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//self.title = @"主界面";
	[[NSNotificationCenter defaultCenter] addObserver:self                                                          
											 selector:@selector(keyboardWillHide:)                                                                  
												 name:UIKeyboardWillHideNotification
											   object:nil];
}


- (void)viewWillDisappear:(BOOL)animated {
	//self.navigationController.navigationBar.hidden = YES;
	
    [super viewWillDisappear:animated];
}

//在此调整横竖屏显示
- (void)viewWillAppear:(BOOL)animated {
	//self.navigationController.navigationBar.hidden = NO;
    /*
	UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
	if (statusBarOrientation == UIInterfaceOrientationPortrait ||statusBarOrientation ==  UIInterfaceOrientationPortraitUpsideDown) {
		[imgView setImage:[UIImage imageNamed:@"welcome_portrait.jpg"]];
		categoryBtn.frame = CGRectMake(52, 139, 664, 47);
		cnBihuaBtn.frame = CGRectMake(52, 201, 664, 47);
		enAlphaBtn.frame = CGRectMake(52, 259, 664, 47);
		searchBtn.frame = CGRectMake(330, 474, 116, 36);;
		
		cnameText.frame = CGRectMake(217, 387, 150, 31);
		enameText.frame = CGRectMake(513,387, 150, 31);
		estatecodeText.frame = CGRectMake(217, 434,150, 31);
		cascodeText.frame = CGRectMake(513, 434, 150, 31);
		
	}
	else {
		[imgView setImage:[UIImage imageNamed:@"welcome_landscape.jpg"]];
		categoryBtn.frame = CGRectMake(196, 174, 664, 47);
		cnBihuaBtn.frame = CGRectMake(196, 237, 664, 47);
		enAlphaBtn.frame = CGRectMake(196, 295, 664, 47);
		searchBtn.frame = CGRectMake(480, 522, 113, 36);;
		
		cnameText.frame = CGRectMake(363, 422, 150, 31);
		enameText.frame = CGRectMake(660, 422, 150, 31);
		estatecodeText.frame = CGRectMake(363, 467,150, 31);
		cascodeText.frame = CGRectMake(660, 467, 150, 31);
	}
	*/
	
    [super viewWillAppear:animated];
	[categoryBtn setAlpha:0.02];
	[cnBihuaBtn setAlpha:0.02];
	[enAlphaBtn setAlpha:0.02];
	[searchBtn setAlpha:0.02];

}

-(IBAction)categoryClicked:(id)sender{

	[categoryBtn setAlpha:0.5];
	[categoryBtn setBackgroundImage:[UIImage imageNamed:@"hightlight.png"] forState:UIControlStateNormal];
	CategoryViewController *controller = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
	[self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

-(IBAction)cnBihuaBtnClicked:(id)sender{
	[cnBihuaBtn setAlpha:0.5];
	[cnBihuaBtn setBackgroundImage:[UIImage imageNamed:@"hightlight.png"] forState:UIControlStateNormal];
	CnNameViewController *controller = [[CnNameViewController alloc] initWithNibName:@"CnNameViewController" bundle:nil];
	[self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

-(IBAction)enAlphaBtnClicked:(id)sender{
	
	[enAlphaBtn setAlpha:0.5];
	[enAlphaBtn setBackgroundImage:[UIImage imageNamed:@"hightlight.png"] forState:UIControlStateNormal];
	EnNameViewController *controller = [[EnNameViewController alloc] initWithNibName:@"EnNameViewController" bundle:nil];
	[self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

-(IBAction)searchBtnClicked:(id)sender{
		
	if ([cnameText.text isEqualToString:@""]
		&& [enameText.text isEqualToString:@""]
		&&[estatecodeText.text isEqualToString:@""]
		&&[cascodeText.text isEqualToString:@""]) {
    
		NSString *msg = @"请输入搜索条件";
		
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"提示" 
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"确定" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
		
	}
	NSMutableString *sqlStr = [NSMutableString stringWithString:@"select * from dangerchem where "];
	NSString *tmp;
	BOOL bHaveAdded = NO;
	if (![cnameText.text isEqualToString:@""]) {
		tmp = [NSString stringWithFormat:@" CNAME like '%%%@%%'",cnameText.text];
		
		[sqlStr appendString:tmp];
		bHaveAdded = YES;
	}
	
	if (![enameText.text isEqualToString:@""]) {
		if(bHaveAdded)
			tmp = [NSString stringWithFormat:@" and ENAME like '%%%@%%'",enameText.text];
		else
			tmp = [NSString stringWithFormat:@" ENAME like '%%%@%%'",enameText.text];
		
		[sqlStr appendString:tmp];
		//bHaveAdded = YES;
	}
	
	if (![estatecodeText.text isEqualToString:@""]) {
		if(bHaveAdded)
			tmp = [NSString stringWithFormat:@" and ESTATECODE like '%%%@%%'",estatecodeText.text];
		else
			tmp = [NSString stringWithFormat:@" ESTATECODE like '%%%@%%'",estatecodeText.text];
		
		[sqlStr appendString:tmp];
		//bHaveAdded = YES;
	}
	
	if (![cascodeText.text isEqualToString:@""]) {
		if(bHaveAdded)
			tmp = [NSString stringWithFormat:@" and CASCODE like '%%%@%%'",cascodeText.text];
		else
			tmp = [NSString stringWithFormat:@" CASCODE like '%%%@%%'",cascodeText.text];
        
		[sqlStr appendString:tmp];
		//bHaveAdded = YES;
	}
	
	/*FMDatabase* db = g_appDelegate.db;
	 //FMResultSet *rs = [db executeQuery:sqlStr];
	 FMResultSet *rs = [db executeQuery:@"select * from dangerchem where CNAME like '%苯%'"];
	 while ([rs next]) {
	 // just print out what we've got in a number of formats.
	 NSLog(@"%@ ",
	 [rs stringForColumn:@"CNAME"]);
	 
	 }
	 // close the result set.
	 // it'll also close when it's dealloc'd, but we're closing the database before
	 // the autorelease pool closes, so sqlite will complain about it.
	 [rs close];  
	 
	 */
	
	
	SearchViewController *controller = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
	//const char *selectSql="select * from dangerchem where CNAME like '%苯%'";
	NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:130];	
	controller.dataResultArray = ary;
	[ary release];
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	const char *utfsql = [sqlStr cStringUsingEncoding:enc];
	printf("%s\n",utfsql);
	NSLog(@"%@",sqlStr);
	sqlite3_stmt *statement; 
	if (sqlite3_prepare_v2(data_db, utfsql, -1, &statement, nil)==SQLITE_OK) {
		NSLog(@"select ok."); 
	}
	
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:20];
	int i =0;
	char *name;
	NSString *text;
    
	[controller.dataResultArray removeAllObjects];
	while (sqlite3_step(statement)==SQLITE_ROW) { 
		
		for ( i= 0; i<6; i++) {
			name=(char *)sqlite3_column_text(statement,i ); 		  
			text = [NSString stringWithCString:name  encoding:enc];
            if (text == nil) text = @"";
            
			[dictionary setObject:text forKey:[tableColumn objectAtIndex:i]];
			
		}
		
		for ( i= 7; i<19; i++) {
			name=(char *)sqlite3_column_text(statement, i); 		  
			text = [NSString stringWithCString:name  encoding:enc];
            if (text == nil) text = @"";
			[dictionary setObject:text forKey:[tableColumn objectAtIndex:i]];
		}
        
		[controller.dataResultArray addObject:[dictionary copy]];
	}
    
	[dictionary release];
	
	sqlite3_finalize(statement);
	
	[searchBtn setAlpha:0.5];
	[searchBtn setBackgroundImage:[UIImage imageNamed:@"hightlight.png"] forState:UIControlStateNormal];
	
	[self.navigationController pushViewController:controller animated:YES];
    [controller release];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    /*
	if (toInterfaceOrientation == UIInterfaceOrientationPortrait ||toInterfaceOrientation ==  UIInterfaceOrientationPortraitUpsideDown) {
		[imgView setImage:[UIImage imageNamed:@"welcome_portrait.jpg"]];
		categoryBtn.frame = CGRectMake(52, 139, 664, 47);
		cnBihuaBtn.frame = CGRectMake(52, 201, 664, 47);
		enAlphaBtn.frame = CGRectMake(52, 259, 664, 47);
		searchBtn.frame = CGRectMake(330, 474, 116, 36);;
		
		cnameText.frame = CGRectMake(217, 387, 150, 31);
		enameText.frame = CGRectMake(513,387, 150, 31);
		estatecodeText.frame = CGRectMake(217, 434,150, 31);
		cascodeText.frame = CGRectMake(513, 434, 150, 31);
		
	}
	else {
		[imgView setImage:[UIImage imageNamed:@"welcome_landscape.jpg"]];
		categoryBtn.frame = CGRectMake(196, 174, 664, 47);
		cnBihuaBtn.frame = CGRectMake(196, 237, 664, 47);
		enAlphaBtn.frame = CGRectMake(196, 295, 664, 47);
		searchBtn.frame = CGRectMake(480, 522, 113, 36);;
		
		cnameText.frame = CGRectMake(363, 422, 150, 31);
		enameText.frame = CGRectMake(660, 422, 150, 31);
		estatecodeText.frame = CGRectMake(363, 467,150, 31);
		cascodeText.frame = CGRectMake(660, 467, 150, 31);
	}
     */
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
