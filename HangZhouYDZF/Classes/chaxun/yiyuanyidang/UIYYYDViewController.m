    //
//  UIYYYDViewController.m
//  EPad
//
//  Created by chen on 11-9-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIYYYDViewController.h"
#import "URLWebViewController.h"
#import "XMSPListController.h"
#import "ProjectCheckController.h"
#import "JBXXController.h"
#import "HJJCController.h"
#import "ImgListController.h"
#import "UISearchSitesController.h"
#import "GMEPS_HZAppDelegate.h"
extern GMEPS_HZAppDelegate *g_appDelegate;
#define TYPE_JBXX 0 //基本信息
#define TYPE_DAXX 1 //档案信息
#define TYPE_XMSP 2 //项目审批
#define TYPE_HJJC 3 //环境监测

@implementation UIYYYDViewController
@synthesize popController,menuController,WRYBH;

-(void)SelectMenu:(id)sender{
	UIBarButtonItem *aBtn = (UIBarButtonItem *)sender;
	[popController presentPopoverFromBarButtonItem:aBtn
						  permittedArrowDirections:UIPopoverArrowDirectionAny
										  animated:YES];
	
		
}

-(void)returnSites:(NSDictionary*)values source:(NSInteger)type{
	
	if (values == nil) {
		[self.navigationController popViewControllerAnimated:YES];
	}
	else {
		 
		self.WRYBH = [values objectForKey:@"WRYBH"];
        self.WRYMC = [values objectForKey:@"WRYMC"];
        JBXXController *controler = [[JBXXController alloc] initWithNibName:@"JBXXController" bundle:nil];
        controler.wrybh = WRYBH;

        controler.view.frame = CGRectMake(0, 0, 768, 960);
        [self.view addSubview:controler.view];
        [controler release];
    
	}

}


-(IBAction)selectPolutionSrc:(id)sender{
	
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//self.title = @"企业基本信息";
	UIBarButtonItem *aButton = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStyleBordered  
															   target:self action:@selector(SelectMenu:)];
	
	self.navigationItem.rightBarButtonItem = aButton;	
	[aButton release]; 
	
	MenuTableController *controller = [[MenuTableController alloc] initWithStyle:UITableViewStylePlain];	
	controller.yyydController = self;
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
	self.popController = popover;
	self.menuController = controller;
	[controller release];
	[popover release];
	[nav release];

	[self selectPolutionSrc:nil];

}

//PWXKZ   排污许可证
//PWSB   排污申报
//WRYPC   污染源普查
//HJTJ  环境统计
//QYDA  企业档案

-(void)switchViewToFront:(int)tag title:(NSString*)values{


	UIViewController *curController = nil;
	switch (tag) {

		case 0://档案信息
		{//GetWryQydaFjInfo
            
			ImgListController *controler = [[ImgListController alloc] initWithStyle:UITableViewStyleGrouped];
			controler.wrybh = WRYBH;
			curController = controler;
			
		}
			break;
		case 1://项目审批
		{
			XMSPListController *controler = [[XMSPListController alloc] initWithNibName:@"XMSPListController"
																				 bundle:nil];
			controler.wrybh = WRYBH;
			controler.parentController = self;
			curController = controler;
			
		}
			break;
		case 2: //项目验收
		{
			ProjectCheckController *controler = [[ProjectCheckController alloc] initWithNibName:@"ProjectCheckController"
																		 bundle:nil];
			controler.wrybh = WRYBH;
			controler.parentController = self;
			curController = controler;
		}
			break;
		case 3: //历史执法记录
		{
            RecentLawEnforcementViewController *controller = [[RecentLawEnforcementViewController alloc] initWithWRYBH:self.WRYBH];
			curController = controller;
		}
			break;

		case 4:
		{
			HJJCController *controler = [[HJJCController alloc] initWithNibName:@"HJJCController"
																		 bundle:nil];
			controler.wrybh = WRYBH;
			curController = controler;
			
		}
			break;
		case 5:
		{
			URLWebViewController *controler = [[URLWebViewController alloc] initWithNibName:@"URLWebViewController"
																					 bundle:nil];
			NSString *urlStr = [NSString stringWithFormat:KYYYDURL_FMT,g_appDelegate.yyydIP,WRYBH,@"pwsb"];
			
			controler.urlStr = urlStr;	
			curController = controler;
			
		}
			break;
		case 6:
		{
			URLWebViewController *controler = [[URLWebViewController alloc] initWithNibName:@"URLWebViewController"
																					 bundle:nil];
			NSString *urlStr = [NSString stringWithFormat:KYYYDURL_FMT,g_appDelegate.yyydIP,WRYBH,@"wrypc"];
			controler.urlStr = urlStr;
			curController = controler;
			//NSLog(@"wrypc");
            
			
		}
			break;
		case 7:
		{
			URLWebViewController *controler = [[URLWebViewController alloc] initWithNibName:@"URLWebViewController"
																					 bundle:nil];
			NSString *urlStr = [NSString stringWithFormat:KYYYDURL_FMT,g_appDelegate.yyydIP,WRYBH,@"hjtj"];
			 NSLog(@"url:%@",urlStr);
			controler.urlStr = urlStr;
			curController = controler;
		}
			break;			
		default:
			break;
	}
    curController.title = values;
	
	[self.navigationController pushViewController:curController animated:YES];
	[self.popController dismissPopoverAnimated:YES];
    
    [curController release];
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

-(void)viewWillDisappear:(BOOL)animated{
    [popController dismissPopoverAnimated:YES];
    [super viewWillDisappear:animated];
}


- (void)dealloc {

	[popController release];
	[menuController release];	
	[WRYBH release];
	
    [super dealloc];
}


@end
