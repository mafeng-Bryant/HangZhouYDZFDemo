//
//  ScoreViewController.h
//  EPad
//
//  Created by chen on 11-4-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//统计企业评分

#import <UIKit/UIKit.h>
#import "BECheckBox.h"
#import "DetailsItemViewController.h"
#import "WebServiceHelper.h"
#import "UISearchSitesController.h"
#import "ChooseRecordViewController.h"
#import "TemporarySave.h"
#import "SignNameController.h"
#import "OutBaseRecordViewController.h"
#define ITEMS_SUM    41
#define Section_SUM  13


@interface XizeDetailItems : NSObject {
    NSString *reasons;
    NSArray  *aryDetailsIndex;
    //存储对应的编号 第一项细则1为101 细则2为102
}
@property(nonatomic,copy)NSString *reasons;
@property(nonatomic,retain)NSArray  *aryDetailsIndex;
@end

@interface ScoreViewController : UIViewController 
<UITableViewDelegate,UITableViewDataSource, SelectSitesDelegate,ReasonsDelegate,UITextViewDelegate,ChooseRecordDelegate,SignameDelegate> {
	//分组

	NSArray *arySectionTitles; //大的评分项标题
    NSArray *arySectionSubItems;// 评分子项
    
	int scoreItems[ITEMS_SUM];
	BOOL bItems[ITEMS_SUM];
	NSMutableDictionary *dicDetailReasons; // 扣分原因 存储 DetailItem
	
	UIPopoverController *popController;
	DetailsItemViewController *itemsController;

	NSDictionary *itemsDic;
    IBOutlet UITableView *myTableView;
	
	int failedNum;//提交失败的记录个数
	int haveCommitedNum;//已提交记录个数
	int sumToCommit;
	UIBarButtonItem *finishBarItem;//完成按钮
	NSMutableString *currentdata;
	IBOutlet UILabel *curScoreLabel;
    NSMutableArray *aryBZTextView; //存储所有备注UITextView
    
    BOOL bCommited;
    int iAlertViewType;
    UIButton *btnTitleView;
    BOOL isclear;
    NSInteger iWebServiceType;
    NSInteger alertType;
}

@property(nonatomic,assign) NSInteger recordStatus;
@property (nonatomic, retain) NSMutableDictionary *dicDetailReasons;
@property (nonatomic, retain) UIPopoverController *popController;
@property (nonatomic, retain) DetailsItemViewController *itemsController;
@property (nonatomic, retain) NSDictionary *itemsDic;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, copy)   NSString *xczfbh;//现场执法编号
@property (nonatomic, copy)   NSString *wrybh;//污染源编号
@property (nonatomic, copy)   NSString *wrydz;//地址
@property (nonatomic, copy)   NSString *wrymc;//污染源名称
@property (nonatomic, copy)   NSString *tableName;
@property (nonatomic, retain) IBOutlet  UITextField *QYMC;//污染源名称

@property (nonatomic, retain) UIBarButtonItem *finishBarItem;
@property (nonatomic, retain)UILabel *curScoreLabel;
@property (nonatomic, retain)NSMutableArray *aryBZTextView; 
@property (nonatomic, retain)NSArray *arySectionTitles; //大的评分项标题
@property (nonatomic, retain)NSArray *arySectionSubItems;// 评分子项

@property(nonatomic,retain)UIPopoverController *popRecordController;
@property(nonatomic,retain)ChooseRecordViewController *recordController;

-(int)calculateScore;
-(NSInteger)calculateSectionByIndex:(NSInteger) index;
-(void)sumScores:(id)sender;
-(void)selectPolutionSrc:(id)sender;
@end
