//
//  IndustryStatisticsMainView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "NTChartView.h"
#import "PopInputView.h"

@interface IndustryStatisticsMainView : UIViewController <NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    WebServiceHelper *webservice;
    NSMutableString *currentString;
    //统计条件，统计个数，统计条件编号以及它们各自对应的解析时专用标识
    NSMutableArray *staTypeArr;
    NSMutableArray *staCountArr;
    NSMutableArray *staCodeArr;
    BOOL bStaCode;
    BOOL bStaType;
    BOOL bStaCount;
    
    //开始时间和结束时间
    NSString *beginDateValue;
    NSString *endDateValue;
    
    UITableView *resultTable;//结果列表
    
    NTChartView *chartView;//柱状图封装类对象
    PopInputView *popView;//选择时间日期弹出窗口类对象
}

@property (nonatomic, retain) WebServiceHelper *webservice;
@property (nonatomic, retain) NSMutableString *currentString;
@property (nonatomic, retain) NSMutableArray *staTypeArr;
@property (nonatomic, retain) NSMutableArray *staCountArr;
@property (nonatomic, retain) NSMutableArray *staCodeArr;

@property (nonatomic, retain) NSString *beginDateValue;
@property (nonatomic, retain) NSString *endDateValue;

@property (nonatomic, retain) IBOutlet UITableView *resultTable;
@property (nonatomic, retain) NTChartView *chartView;
@property (nonatomic, retain) PopInputView *popView;

- (void)addChart;
- (void)initWithBeginDate:(NSString *)bdValue endDate:(NSString *)edValue;
- (void)popingInputView;
@end
