//
//  QueryWriteController.h
//  HangZhouOA
//
//  Created by chen on 11-4-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutBaseRecordViewController.h"
#import "PopupDateViewController.h"
#import "CommenWordsViewController.h"
#import "AnyouTableView.h"
#import "WebServiceHelper.h"
#import "WendaDetailsViewController.h"
#import "PersonSelectControllerView.h"

@interface QueryWriteController : OutBaseRecordViewController<WendaDelegate,PopupDateDelegate,AnyouDelegate,UITextFieldDelegate,UIAlertViewDelegate,WordsDelegate,PersonDelegate>{
    
	
	UIPopoverController *wordsPopoverController;
	CommenWordsViewController* wordsSelectViewController;
    
	int currentFieldTag;
	
    UIPopoverController *anyouPopoverController;
    AnyouTableView *anyouSelectView;
    
	  int currentTag;
    UIBarButtonItem *commitBar;
    IBOutlet UILabel     * DLRSSBM; //登录人所属部门
    
    UISegmentedControl *XB; //性别
    UIPopoverController *popController;
    PopupDateViewController *dateController;
    
    NSMutableArray *quesValueAry;
    NSMutableArray *ansValueAry;
    NSMutableArray *surePreson;

    NSString *CYR_ZJH;//检查人证件号
    NSString *LRR_ZJH; //录入人证件号
    NSTimer *timer;
    NSTimer *timer1;
    UIAlertView *alert1;
    BOOL clear;

    
}

@property (nonatomic, retain) IBOutlet UITextField * AY;	//案由
@property (nonatomic, retain) IBOutlet UITextField *QYMC;//企业名称
@property (nonatomic, retain) IBOutlet UITextField *DCXWDD;//调查询问地点
@property (nonatomic, retain) IBOutlet UITextField *GZDW;//工作单位
@property (nonatomic, retain) IBOutlet UITextField *NL;//年龄
@property (nonatomic, retain) IBOutlet UITextField *JTZZ;//家庭住址
@property (nonatomic, retain) IBOutlet UITextField *YB;//邮编
@property (nonatomic, retain) IBOutlet UITextField *DH;//电话
@property (nonatomic, retain) IBOutlet UITextField *CYR;//参与人
@property (nonatomic, retain) IBOutlet UITextField *BXWRMC;//被调查询问人
@property (nonatomic, retain) IBOutlet UITextField *SFZHM; //身份证号码
@property (nonatomic, retain) IBOutlet UITextField *XWKSSJ;//询问开始时间
@property (nonatomic, retain) IBOutlet UITextField *XWJSSJ;//询问结束时间
@property (nonatomic, retain) IBOutlet UITextField *ZW;    //职位或职业
@property (nonatomic, retain) IBOutlet UITextField *YBAGX; //与本案关系
@property (nonatomic, retain) IBOutlet UITextField *XWR;   //询问人
@property (nonatomic, retain) IBOutlet UITextField *JLR;   //记录人
@property (nonatomic, retain) IBOutlet UITextField *ZFRY;  //人员
@property (nonatomic, retain) IBOutlet UITextField *SFQR;  //身份确认
@property (nonatomic, retain) IBOutlet UITextField *ZFZH;  //执法证号
@property (nonatomic, retain) IBOutlet UITextField *SQHB;  //申请回避

@property (nonatomic, retain) IBOutlet UISegmentedControl *XB; //性别
@property (nonatomic, retain) UIPopoverController *popController;
@property (nonatomic, retain) PopupDateViewController *dateController;

@property(nonatomic,retain)UIPopoverController *wordsPopoverController;
@property(nonatomic,retain)CommenWordsViewController* wordsSelectViewController;

@property(nonatomic,retain) UIPopoverController *anyouPopoverController;
@property(nonatomic,retain) AnyouTableView *anyouSelectView;

@property(nonatomic,retain)UIPopoverController *PopPeopleController;
@property(nonatomic,retain)PersonSelectControllerView *peopleController;

@property(nonatomic,retain)NSMutableArray *quesValueAry;
@property(nonatomic,retain)NSMutableArray *ansValueAry;
@property(nonatomic,retain)NSMutableArray *surePreson;

@property (nonatomic, retain) NSString *CYR_ZJH;//检查人证件号
@property (nonatomic, retain) NSString *LRR_ZJH;

@property (nonatomic, strong) NSArray *valuesAry;
@property (nonatomic, strong) NSArray *keysAry;

-(IBAction)NewQuestion:(id)sender;
-(IBAction)touchFromDate:(id)sender;

-(IBAction)backgroundTap:(id)sender;

@end
