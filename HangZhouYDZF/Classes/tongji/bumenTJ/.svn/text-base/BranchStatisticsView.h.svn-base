//
//  BranchStatisticsView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "PopupDateViewController.h"
#import "StatisticsListItem.h"
#import "NTChartView.h"
#import "PopInputView.h"

@interface BranchStatisticsView : UIViewController <NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource>{
    WebServiceHelper *webservice;
    NSMutableString *currentString;
    //统计个数，统计条件，统计条件代码以及它们各自对应的解析时标识
    NSMutableArray *staCountArr;
    NSMutableArray *staTypeArr;
    NSMutableArray *staCodeArr;
    BOOL bStaCode;
    BOOL bStaType;
    BOOL bStaCount;
    //开始时间和结束时间
    NSString *beginDateValue;
    NSString *endDateValue;
    
    UITableView *resultTable;//统计结果列表
    
    NTChartView *chartView;//柱状图封装类对象
    PopInputView *popView;//选择时间弹出窗口类对象
}

@property (nonatomic, retain) WebServiceHelper *webservice;
@property (nonatomic, retain) NSMutableString *currentString;
@property (nonatomic, retain) NSMutableArray *staCountArr;
@property (nonatomic, retain) NSMutableArray *staTypeArr;
@property (nonatomic, retain) NSMutableArray *staCodeArr;
@property (nonatomic, retain) NSMutableArray *allInfoArr;
@property (nonatomic, retain) NSArray *tableNameArr;
@property (nonatomic, retain) NSArray *biluNameArr;
@property (nonatomic, retain) NSArray *biluCountArr;

@property (nonatomic, copy) NSString *currentCondition;
@property (nonatomic, copy) NSString *currentCode;

@property (nonatomic, retain) StatisticsListItem *tmpItem;
@property (nonatomic, assign) int nParserStatus;
@property (nonatomic, assign) BOOL bItem;

@property (nonatomic, retain) IBOutlet UITableView *resultTable;
@property (nonatomic, retain) IBOutlet UITableView *resultTable2;
@property (nonatomic, retain) NSString *beginDateValue;
@property (nonatomic, retain) NSString *endDateValue;

@property (nonatomic, retain) NTChartView *chartView;
@property (nonatomic, retain) PopInputView *popView;

- (void)addChart;
- (void)initWithBeginDate:(NSString *)bdValue endDate:(NSString *)edValue;
- (void)popingInputView;

@end
