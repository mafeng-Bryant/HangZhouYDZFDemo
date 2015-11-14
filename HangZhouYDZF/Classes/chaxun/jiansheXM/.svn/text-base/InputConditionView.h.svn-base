//
//  InputConditionView.h
//  RetrieveExamine
//
//  Created by hejunhua on 11-9-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "XMInfoItem.h"
#import "PopupDateViewController.h"
#import "CommenWordsViewController.h"
#import "MBProgressHUD.h"

@interface InputConditionView : UIViewController 
<NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,PopupDateDelegate,WordsDelegate,UITextFieldDelegate,MBProgressHUDDelegate>{
	WebServiceHelper *webservice;

	XMInfoItem *infoItem;   //审批主要信息封装类对象，存储需要在查询结果表栏中显示的信息
	NSMutableArray *infoArr;//存储查询到的所有审批项目
	NSString *segValue;
    int nParserStatus;
	BOOL bItem;
	
	UITextField *xmmc;//项目名称输入栏
	UITextField *startDate;//开始时间输入栏
	UITextField *endDate;//结束时间输入栏
	UITextField *xzqh;//行政区划输入栏
	UISegmentedControl *sftg;//是否通过选择按钮
	UIButton *makeSure;//确定按钮
	
	UIPopoverController *popController;
	PopupDateViewController *dateController;
	UITableView *listTableView;
	int currentTag;
    int currentPageIndex;
    BOOL isLoading;
    BOOL isEnd;
    UIActivityIndicatorView *refreshSpinner;
	
	UIPopoverController *wordsPopoverController;
	CommenWordsViewController* wordsSelectViewController;
    MBProgressHUD *HUD;
}

@property (nonatomic, retain) WebServiceHelper *webservice;
@property (nonatomic, retain) NSMutableString *currentString;
@property (nonatomic, retain) NSMutableArray *infoArr;
@property (nonatomic, copy) NSString *segValue;
@property (nonatomic, retain) XMInfoItem *infoItem;

@property (nonatomic, retain) IBOutlet UITextField *xmmc;       //项目名称输入栏
@property (nonatomic, retain) IBOutlet UITextField *startDate;  //开始时间输入栏
@property (nonatomic, retain) IBOutlet UITextField *endDate;    //结束时间输入栏
@property (nonatomic, retain) IBOutlet UITextField *xzqh;       //行政区划输入栏
@property (nonatomic, retain) IBOutlet UISegmentedControl *sftg;//是否通过选择按钮
@property (nonatomic, retain) IBOutlet UIButton *makeSure;      //确定按钮
//时间选择浮动窗口及其内视图
@property (nonatomic, retain) UIPopoverController *popController;
@property (nonatomic, retain) PopupDateViewController *dateController;

@property (nonatomic, retain) IBOutlet UITableView *listTableView;//查询结果输出列表
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;//系统正忙的动画标识

//行政区划选择的浮动窗口及其内视图
@property(nonatomic,retain)UIPopoverController *wordsPopoverController;
@property(nonatomic,retain)CommenWordsViewController* wordsSelectViewController;

- (IBAction)makeSurePressed:(id)sender; //确定按钮按下后调用的方法
- (IBAction)segChanged:(id)sender;      //选择按钮按下后调用的方法
- (IBAction)backgroundTag:(id)sender;   //点击背景调用的方法
-(IBAction)touchFromDate:(id)sender;    //选择日期按钮按下后调用的方法
-(IBAction)beginEditing:(id)sender;     //行政区划输入栏开始编辑时调用的方法，用于弹出浮动窗口
@end
