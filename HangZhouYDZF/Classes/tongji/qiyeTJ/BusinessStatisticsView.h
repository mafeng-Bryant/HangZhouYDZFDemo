//
//  BusinessStatisticsView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "PopupDateViewController.h"
#import "TaskStatisticsItem.h"
#import "NTChartView.h"
#import "PopInputView.h"

@interface BusinessStatisticsView : UIViewController <NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource>{
    WebServiceHelper *webservice;
    NSMutableString *currentString;
    //统计结果，统计条件名称，统计条件编号及它们对应的解析时标识
    NSMutableArray *staCountArr;
    NSMutableArray *staTypeArr;
    NSMutableArray *staCodeArr;
    BOOL bStaCode;
    BOOL bStaType;
    BOOL bStaCount;
    
    NSString *beginDateValue;//开始时间
    NSString *endDateValue;//结束时间
    
    UITableView *resultTable;//统计结果列表
    
    NTChartView *chartView;//柱状图封装类对象
    PopInputView *popView;//选择时间弹出窗口类对象
}

@property (nonatomic, retain) WebServiceHelper *webservice;
@property (nonatomic, retain) NSMutableString *currentString;
@property (nonatomic, retain) NSMutableArray *staCountArr;
@property (nonatomic, retain) NSMutableArray *staTypeArr;
@property (nonatomic, retain) NSMutableArray *staCodeArr;

@property (nonatomic, retain) IBOutlet UITableView *resultTable;
@property (nonatomic, retain) NSString *beginDateValue;
@property (nonatomic, retain) NSString *endDateValue;

@property (nonatomic, retain) NTChartView *chartView;
@property (nonatomic, retain) PopInputView *popView;

- (void)addChart;
- (void)initWithBeginDate:(NSString *)bdValue endDate:(NSString *)edValue;
- (void)popingInputView;
@end
