//
//  TaskListView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "TaskDetailsView.h"
#import "MBProgressHUD.h"

@interface TaskListView : UIViewController <NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource> {
    WebServiceHelper *webservice;
    NSMutableString *currentString;
    NSMutableArray *taskInfoArr;    //存储所有任务的数组
    
    UITableView *listTable;     //满足条件的任务列表
    TaskDetailsView *childView; //点击任务列表表栏将导航到的视图
    
    int nParserStatus;
    BOOL bItem;
    
    NSString *beginDateStr;     //开始时间
    NSString *endDateStr;       //结束时间
    
    NSString *conditionStr;       //作为websevice传输的条件编号
    int statisticsTag;
    NSString *districtStr;  //标识区域统计的符号
    NSString *businessStr;  //标识企业类型统计的符号
    NSString *industryStr;  //标识行业类型统计的符号
    NSString *branchStr;    //标识部门统计的符号
    
    MBProgressHUD *HUD;
}

@property (nonatomic, retain) WebServiceHelper *webservice;
@property (nonatomic, retain) NSMutableString *currentString;
@property (nonatomic, strong) NSMutableDictionary *taskItemDic;
@property (nonatomic, retain) NSMutableArray *taskInfoArr;

@property (nonatomic, retain) IBOutlet UITableView *listTable;
@property (nonatomic, retain) TaskDetailsView *childView;

@property (nonatomic, retain) NSString *beginDateStr;
@property (nonatomic, retain) NSString *endDateStr;

@property (nonatomic, assign) int statisticsTag;
@property (nonatomic, copy) NSString *tableName;
@property (nonatomic, retain) NSString *conditionStr;
@property (nonatomic, retain) NSString *districtStr;
@property (nonatomic, retain) NSString *businessStr;
@property (nonatomic, retain) NSString *industryStr;
@property (nonatomic, retain) NSString *branchStr;
@end
