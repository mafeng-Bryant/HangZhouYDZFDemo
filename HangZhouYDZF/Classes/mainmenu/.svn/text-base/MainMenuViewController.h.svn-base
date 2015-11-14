//
//  MainMenuViewController.h
//  Eve
//
//  Created by yushang on 10-11-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "UserInfo.h"

@interface MainMenuViewController : UIViewController <UIScrollViewDelegate,UIAlertViewDelegate,MBProgressHUDDelegate>{
	UIScrollView *scrollView;
    UIPageControl *pageControl;
	BOOL pageControlIsChangingPage;
	
	NSMutableArray *viewControllers;
	
	NSArray *titlePage1;
	NSArray *titlePage2;
	NSArray *titlePage3;
	NSArray *titlePage4;
	

	UserInfo *logedUserInfo;
    
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;

@property (nonatomic, retain) NSArray *titlePage1;
@property (nonatomic, retain) NSArray *titlePage2;
@property (nonatomic, retain) NSArray *titlePage3;
@property (nonatomic, retain) NSArray *titlePage4;

@property (nonatomic, retain)UserInfo *logedUserInfo;

- (IBAction)changePage:(id)sender;
- (void)setupPage;
- (void)toggleFromByPage:(NSInteger) nPage ByIndex:(NSInteger) nIndex;
- (IBAction)modifyPassword:(id)sender;

@end
