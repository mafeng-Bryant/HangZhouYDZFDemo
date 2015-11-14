//
//  MainMenuViewController.m
//  Eve
//
//  Created by yushang on 10-11-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ButtonViewController.h"
#import "CaiyangViewController.h"
#import "ScoreViewController.h"
#import "SiteInforcementConroller.h"
#import "TellViewController.h"
#import "DubanViewController.h"
#import "UIYYYDViewController.h"
#import "UIChargeController.h"
#import "InputConditionView.h"
#import "psMainViewController.h"
#import "AreaStatisticsInputView.h"
#import "IndustryStatisticsMainView.h"

#import "BranchStatisticsView.h"
#import "OpinionViewController.h"
#import "UISendDubanController.h"
#import "SupervisionTaskMainView.h"
#import "LedgerListViewController.h"
#import "DudelViewController.h"
#import "MutiConditionViewController.h"
#import "SharedInformations.h"
#import "JCJLBaseViewController.h"
#import "handbookNewViewController.h"
#import "InquiryWasterViewController.h"
#import "QueryWriteController.h"
#import "AppSettingViewController.h"
#import "SendMessageViewController.h"
extern UserInfo *g_logedUserInfo;
static NSUInteger kNumberOfPages = 4;

@implementation MainMenuViewController
@synthesize scrollView, pageControl, viewControllers;
@synthesize  titlePage1,titlePage2,titlePage3,titlePage4;
@synthesize logedUserInfo;




- (IBAction)modifyPassword:(id)sender {
    AppSettingViewController *appSettingViewController = [[AppSettingViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:appSettingViewController];
    nav.modalPresentationStyle =  UIModalPresentationFormSheet;
    [self presentModalViewController:nav animated:YES];
    nav.view.superview.frame = CGRectMake(177, 282, 414, 460);
    [nav release];
    [appSettingViewController release];
}

- (void)toggleFromByPage:(NSInteger) nPage ByIndex:(NSInteger) nIndex {
	UIViewController *controller = nil;
    SharedInformations *info = [SharedInformations sharedSharedInformations];
    
	switch (nPage) {
		case 0:
			if (nIndex == 0) {
                controller = [[JCJLBaseViewController alloc] initWithNibName:@"JCJLBaseViewController" bundle:nil];
                
            }
			else if(nIndex == 1){
                controller = [[OpinionViewController alloc] initWithNibName:@"OpinionViewController" bundle:nil];
				
			}
			else if(nIndex == 2){
                
                controller = [[ScoreViewController alloc] initWithNibName:@"ScoreViewController" bundle:nil];
                
                
                
			}
			else if(nIndex == 3){
                controller = [[CaiyangViewController alloc] initWithNibName:@"CaiyangViewController" bundle:nil];
                
                
			}
			else if(nIndex == 4){
                
                controller = [[SiteInforcementConroller alloc] initWithNibName:@"SiteInforcementConroller" bundle:nil];
                
			}
			else if(nIndex == 5){
                controller = [[DudelViewController alloc] initWithNibName:@"DudelViewController" bundle:nil];
                
                
			}
			else if(nIndex == 6){
                controller = [[QueryWriteController alloc] initWithNibName:@"QueryWriteController" bundle:nil];
				
			}
			else if(nIndex == 7){
                controller = [[TellViewController alloc] initWithNibName:@"TellViewController" bundle:nil];
			}
            else if(nIndex == 8){
                controller = [[DubanViewController alloc]initWithNibName:@"DubanViewController" bundle:nil];
                
				
			}
            else if(nIndex == 9){
                if (![g_logedUserInfo.userORGID isEqualToString:@"330100"])
                {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"提示"
                                          message:@"您没有操作该功能的权限"
                                          delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
                    [alert show];
                    [alert release];
                    return;
                }
                
                controller = [[info.dicStoreTempData objectForKey: @"UISendDubanController"] retain];
                [info.dicStoreTempData removeObjectForKey:@"UISendDubanController"];
                if (controller == nil) {
                    controller = [[UISendDubanController alloc] initWithNibName:@"UISendDubanController" bundle:nil];
                }
                
			}else if(nIndex == 10) {
                SendMessageViewController   *sendMessageController = [[SendMessageViewController alloc]initWithNibName:@"SendMessageViewController" bundle:nil] ;
                sendMessageController.modalPresentationStyle =  UIModalPresentationPageSheet;
                [self presentModalViewController:sendMessageController animated:YES];
                [sendMessageController release];
                  
            }
            
			break;
		case 1:
			if (nIndex == 0) {
				controller = [[UIYYYDViewController alloc] initWithNibName:@"UIYYYDViewController" bundle:nil];
			}
			else if(nIndex == 1){
                controller = [[InputConditionView alloc] initWithNibName:@"InputConditionView" bundle:nil];
               
			}
            
			break;
		case 2:
			if (nIndex == 0) {//执法台帐
                controller = [[LedgerListViewController alloc] initWithNibName:@"LedgerListViewController" bundle:nil];
			}
			else if(nIndex == 1){
                controller = [[MutiConditionViewController alloc] initWithNibName:@"MutiConditionViewController" bundle:nil];
			}
			else if(nIndex == 2){
                controller = [[psMainViewController alloc] initWithNibName:@"psMainViewController" bundle:nil];
			}
			else if(nIndex == 3){
                controller = [[SupervisionTaskMainView alloc] initWithNibName:@"SupervisionTaskMainView" bundle:nil];
			}
			else if(nIndex == 4){
                controller = [[AreaStatisticsInputView alloc] initWithNibName:@"AreaStatisticsInputView" bundle:nil];
                
                
			}
			else if(nIndex == 5){
				controller = [[IndustryStatisticsMainView alloc] initWithNibName:@"IndustryStatisticsMainView" bundle:nil];
			}
			else if(nIndex == 6){
                controller = [[BranchStatisticsView alloc] initWithNibName:@"BranchStatisticsView" bundle:nil];
            }
			
			break;
		case 3:
			if(nIndex<=1)
            {
                NSString *str = [titlePage4 objectAtIndex:nIndex];
                UIChargeController *controller1 = [[UIChargeController alloc] initWithNibName:@"UIChargeController" bundle:nil];
                [self.navigationController pushViewController:controller1 animated:YES];
                if(nIndex == 0)
                    [controller1 searchByFIDH:@"899" root:str];
                else
                    [controller1 searchByFIDH:@"12" root:str];
                [controller1 release];
                //controller = nil;
            }
            if(nIndex == 2)
            {
                handbookNewViewController *controller2 = [[handbookNewViewController alloc]initWithNibName:@"handbookNewViewController" bundle:nil];
                [self.navigationController pushViewController:controller2 animated:YES];
                [controller2 release];
            }
            if (nIndex == 3) {
                InquiryWasterViewController *controller3 =[[InquiryWasterViewController alloc] initWithNibName:@"InquiryWasterViewController" bundle:nil];
                [self.navigationController pushViewController:controller3 animated:YES];
                [controller3 release];
            }
			
			
			break;
            
		default:
			break;
	}
	if (controller != nil) {
        		[self.navigationController pushViewController:controller animated:YES];
		[controller release];
	}
	
    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"主功能界面";
    [super viewDidLoad];
	
	titlePage1 = [[NSArray alloc] initWithObjects:@"监察记录",@"监察意见",@"企业评分",@"采样",@"现场勘验",@"绘制勘验图",@"询问记录",@"执法告知",@"办理督办任务",@"下发督办任务",@"发送信息",nil];//@"点源记录表",
    
	titlePage2 = [[NSArray alloc] initWithObjects:@"一源一档查询",@"建设项目查询",nil];
	titlePage3 = [[NSArray alloc] initWithObjects:@"执法台账",@"执法统计",@"污染源统计",@"督办任务统计",@"按区域统计",@"按行业统计",
				  @"按部门统计",nil];
	titlePage4 = [[NSArray alloc] initWithObjects:@"法律法规",@"监察指南",@"危险化学品",@"危险废物",nil];
	
	[self setupPage];
	
    
}


- (void)viewWillAppear:(BOOL)animated {
	//self.navigationItem.hidesBackButton = YES;
	[self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
	//self.navigationItem.hidesBackButton = YES;
	[self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidDisappear:(BOOL)animated {
	
	[super viewDidDisappear:animated];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    
	[viewControllers release];
    [scrollView release];
    [pageControl release];
    [titlePage1 release];
    [titlePage2 release];
    [titlePage3 release];
    [titlePage4 release];
    [super dealloc];
}

#pragma mark -
#pragma mark The Guts
- (void)setupPage
{
	NSMutableArray *controllers = [[NSMutableArray alloc] init];
	for (unsigned i = 0; i < kNumberOfPages; i++) {
		[controllers addObject:[NSNull null]];
	}
	self.viewControllers = controllers;
	[controllers release];
	
	scrollView.delegate = self;
	
	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;
	scrollView.scrollEnabled = YES;
	scrollView.pagingEnabled = YES;
	scrollView.backgroundColor = [UIColor clearColor];
	
	CGFloat cx = 0;
	for (int i = 0; i < kNumberOfPages; i++) {
		// replace the placeholder if necessary
		ButtonViewController *controller = [viewControllers objectAtIndex:i];
		if ((NSNull *)controller == [NSNull null]) {
			controller = [[ButtonViewController alloc] initWithPage:i];
			controller.parent = self;
			[viewControllers replaceObjectAtIndex:i withObject:controller];
			[controller release];
		}
		
		// add the controller's view to the scroll view
		if (nil == controller.view.superview) {
			CGRect frame = scrollView.frame;
			frame.origin.x = frame.size.width * i;
			frame.origin.y = 0;
			//frame.size.height = frame.size.height + 20;
			controller.view.frame = frame;
			[scrollView addSubview:controller.view];
		}
		
		cx += scrollView.frame.size.width;
	}
	
	self.pageControl.numberOfPages = kNumberOfPages;
	[scrollView setContentSize:CGSizeMake(cx, [scrollView bounds].size.height)];
}

#pragma mark -
#pragma mark UIScrollViewDelegate stuff
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    if (pageControlIsChangingPage) {
        return;
    }
	
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    pageControlIsChangingPage = NO;
}

#pragma mark -
#pragma mark PageControl stuff
- (IBAction)changePage:(id)sender
{
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
	
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControlIsChangingPage = YES;	
}

@end
