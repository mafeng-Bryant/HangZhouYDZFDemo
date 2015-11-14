//
//  CaiyangViewController.h
//  EPad
//
//  Created by chen on 11-5-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
// 采样

#import <UIKit/UIKit.h>
#import "CaiyangSubView.h"
#import "Sample.h"
#import "PopupDateViewController.h"
#import "CommenWordsViewController.h"
#import "EmissionStandardsViewController.h"
#import "OutBaseRecordViewController.h"

@interface CaiyangViewController : OutBaseRecordViewController
<UITableViewDelegate,UITableViewDataSource,SaveOneSampleDelegate,PopupDateDelegate,WordsDelegate,StandardSelectDelegate,UITextFieldDelegate> {
    int currentFieldTag;
	UITableView *myTableView;
	NSMutableArray *sampleList;
	BOOL bModifySample;   //修改样品
	IBOutlet UITextField * PFFSL;  //排放方式量
	IBOutlet UITextField * CYFS; //采样方式
	IBOutlet UITextField * PFFS; //排放方式
	IBOutlet UITextField * BCDWMC;//被测单位名称
	IBOutlet UITextView  * BZ;  //备注
	IBOutlet UITextField * XCJC; //现场监测仪器设备名称型号及编号
	IBOutlet UITextField * GRW; //样品可能含有的干扰物
	IBOutlet UITextField * XMMC;//项目名称
	IBOutlet UITextField * DZ;//地址
	IBOutlet UITextField * QW; //气温
	
	IBOutlet UITextField * TQZK; //天气状况
	IBOutlet UITextField * YZQK; //设施运转情况
	IBOutlet UITextField * CYRQ;  //采样日期
	IBOutlet UITextField * SCFH; //生产负荷
    IBOutlet UITextField * GFHQK; //规范化情况
	IBOutlet UITextField * GDJJRQK; //固定剂加入情况
	IBOutlet UITextField * YB; //邮编
	
	int currentTag;
	UIPopoverController *popController;
	PopupDateViewController *dateController;
	
	NSDate *CYRQDate;
		

	
	UIPopoverController *wordsPopoverController;
	CommenWordsViewController* wordsSelectViewController;
    
    UIPopoverController *esPopoverController;
    EmissionStandardsViewController *standardController;
    
    int nBilusToCommit; //要提交的记录个数
    int successCount; //提交成功个数


}

@property(nonatomic,retain)IBOutlet UITableView *myTableView;
@property(nonatomic,retain)NSMutableArray *sampleList;

@property (nonatomic, retain) UIBarButtonItem *finishBarItem;
@property (nonatomic, retain) UITextField * PFFSL;  //排放方式量
@property (nonatomic, retain) UITextField * CYFS; //采样方式
@property (nonatomic, retain) UITextField * PFFS; //排放方式
@property (nonatomic, retain) UITextField * BCDWMC;//被测单位名称
@property (nonatomic, retain) UITextView * BZ;  //备注
@property (nonatomic, retain) UITextField * XCJC; //现场监测仪器设备名称型号及编号
@property (nonatomic, retain) UITextField * GRW; //样品可能含有的干扰物
@property (nonatomic, retain) UITextField * XMMC;//项目名称

@property (nonatomic, retain) UITextField * DZ;//地址

@property (nonatomic, retain) UITextField * QW; //气温

@property (nonatomic, retain) UITextField * TQZK; //天气状况
@property (nonatomic, retain) UITextField * YZQK; //设施运转情况
@property (nonatomic, retain) UITextField * CYRQ;  //采样日期
@property (nonatomic, retain) UITextField * SCFH; //生产负荷
@property (nonatomic, retain) UITextField * GDJJRQK; //固定剂加入情况
@property (nonatomic, retain) UITextField * GFHQK;
@property (nonatomic, retain) UITextField * YB; //邮编
@property (nonatomic, retain) NSDate *CYRQDate;


@property (nonatomic, retain) UIPopoverController *popController;
@property (nonatomic, retain) PopupDateViewController *dateController;
@property (nonatomic, retain) UIPopoverController *wordsPopoverController;
@property (nonatomic, retain) CommenWordsViewController* wordsSelectViewController;
@property (nonatomic, retain) UIPopoverController *esPopoverController;
@property (nonatomic, retain) EmissionStandardsViewController *standardController;

-(IBAction)addSamples:(id)sender;
-(IBAction)touchFromDate:(id)sender;
-(IBAction)chooseStandards:(id)sender;
-(void) saveSampleItems:(NSString*)bh;
@end
