//
//  UISendDubanController.h
//  GMEPS_HZ
//
//  Created by chen on 11-9-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "CommenWordsViewController.h"
#import "PopupDateViewController.h"
#import "PersonSelectControllerView.h"
#import "ContactListViewController.h"

@interface UISendDubanController : UIViewController
<UIPickerViewDelegate,UIPickerViewDataSource,WordsDelegate,
PopupDateDelegate,UITextFieldDelegate,selectLinkManDelegate>{
    
    IBOutlet UITextField* duBanRenField;        //督办人
    IBOutlet UITextField* dubanDWFiled;         //督办单位
    IBOutlet UITextField* jieShouRenField;      //接收人
    IBOutlet UITextField* jieShouDWField;       //接收单位
    IBOutlet UITextField* jieShourenSJField;    //接收人手机号码
    
    IBOutlet UITextField* subjectField; //主题
    IBOutlet UISegmentedControl* typeSegment;    //督办类型
    IBOutlet UITextView * contentText; //督办信息
    IBOutlet UITextField* deadlineField; //截止时间
   
    
    WebServiceHelper* webService;
    NSMutableString *currentdata;
    IBOutlet UIButton *btnSend;
    
    IBOutlet UIPickerView *areaPickerView;
    IBOutlet UIPickerView *streetPickerView;
    
    NSArray *areaNameAry;
    NSArray *xzqhdmAry;//区域对应的行政区划代码
    NSMutableArray *streetAry;
    NSMutableArray *streetBHAry;
    
    NSString *dbdwBH;//督办人单位编号
    NSString *jsdwBH;//接收人单位编号
    
    NSMutableArray *bumenNameAry;
    NSMutableArray *bumenBHAry;
    UIPopoverController *wordsPopoverController;
	CommenWordsViewController* wordsSelectViewController;
    int currentTag;
    
    UIPopoverController *popController;

    
    NSInteger recordStatus;
    BOOL bCommited;
    NSMutableDictionary *dicSsjd;
    
}
@property(nonatomic,retain) UITextField* duBanRenField;   //督办人
@property(nonatomic,retain) UITextField* dubanDWFiled;    //督办单位
@property(nonatomic,retain) UITextField* jieShouRenField; //接收人
@property(nonatomic,retain) UITextField* jieShouDWField;  //接收单位
@property(nonatomic,retain) UITextField* jieShourenSJField;    //接收人手机号码
@property(nonatomic,strong) IBOutlet UISegmentedControl* sffsdxSegment;    //是否发送短信
@property(nonatomic,retain) UITextField* subjectField; //主题
@property(nonatomic,retain) UISegmentedControl* typeSegment;    //督办类型
@property(nonatomic,retain) UITextView * contentText; //督办类型
@property(nonatomic,retain) UITextField* deadlineField; //截止时间


@property(nonatomic,retain) WebServiceHelper* webService;
@property(nonatomic,retain) NSMutableString *currentdata;
@property(nonatomic,retain) UIButton *btnSend;
@property(nonatomic,retain) UIPickerView *areaPickerView;
@property(nonatomic,retain)  UIPickerView *streetPickerView;

@property(nonatomic,retain) NSArray *areaNameAry;
@property(nonatomic,retain) NSArray *xzqhdmAry;
@property(nonatomic,retain) NSMutableArray *streetAry;
@property(nonatomic,retain) NSMutableArray *streetBHAry;

@property(nonatomic,copy) NSString *dbdwBH;//督办人单位编号
@property(nonatomic,copy) NSString *jsdwBH;//接收人单位编号
@property(nonatomic,retain) NSMutableArray *bumenNameAry;
@property(nonatomic,retain) NSMutableArray *bumenBHAry;
@property(nonatomic,retain)UIPopoverController *wordsPopoverController;
@property(nonatomic,retain)CommenWordsViewController* wordsSelectViewController;
@property (nonatomic, retain) UIPopoverController *popController;

@property (nonatomic, strong)UIPopoverController *PopPeopleController;      //人员框

-(IBAction)sendTask:(id)sender;
-(IBAction)btnSelectPressed:(id)sender;
-(IBAction)touchFromDate:(id)sender;
-(IBAction)choosePerson:(id)sender;
@end
