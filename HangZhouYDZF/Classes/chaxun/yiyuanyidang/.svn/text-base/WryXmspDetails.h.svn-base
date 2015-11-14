//
//  WryXmspDetails.h
//  WryXmsp
//
//  Created by hejunhua on 11-9-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "UserInfo.h"
#import "WebServiceHelper.h"
#import "PollutionInfoItem.h"
#import "TotalOpinionView.h"
#import "AccessoryItem.h"
#import "AccessoryLsitViewController.h"
#import "LTZProjectApprovalOpinionDetailViewController.h"

@interface WryXmspDetails : UIViewController <NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource>{
	WebServiceHelper *webservice;
	NSMutableString *currentString;
	PollutionInfoItem *selectedItem;
	NSMutableArray *detailsArr;
	int nParserStatus;                                          //解析XML文档的状态值
	
	UITableView *detailsTable;
	
	UIPopoverController *opinionController;
    TotalOpinionView *totalOpinion;
    
    BOOL bHasPFYJ;                          //是否有批复意见
    NSString *strPFYJ;
}

@property (nonatomic,retain) WebServiceHelper *webservice;
@property (nonatomic,retain) NSMutableString *currentString;        //解析XML文档的字符串
@property (nonatomic,retain) PollutionInfoItem *selectedItem;
@property (nonatomic,retain) NSMutableArray *detailsArr;
@property (nonatomic,retain) IBOutlet UITableView *detailsTable;
@property (nonatomic,retain) TotalOpinionView *totalOpinion;
@property (nonatomic,retain) UIPopoverController *opinionController;

@property (strong,nonatomic) NSString *jsonString;
@property (strong,nonatomic) NSString *urlStringOfAccessory;        //附件的下载地址
@property (strong,nonatomic) NSString *noOfAccessory;               //附件的序号
@property (assign,nonatomic) BOOL isDownloadAccessory;              //是否在下载附件
@property (assign,nonatomic) BOOL isXMSPInfo;                       //是否是项目审批网络请求
@property (assign,nonatomic) BOOL isXMSPAccessory;                  //是否是项目审批
@property (strong,nonatomic) NSMutableArray *accessoryArray;        //包含所有附件信息的数组
@property (strong,nonatomic) NSString *methodName;                  //执行网络请求方法名
@property(strong,nonatomic)IBOutlet UITableViewCell *clikedCell;
@property(strong,nonatomic)IBOutlet UIButton *clikedButton;

- (void)initSelectedItem:(id)aItem;
-(IBAction)clikedButton:(id)sender;

@end
