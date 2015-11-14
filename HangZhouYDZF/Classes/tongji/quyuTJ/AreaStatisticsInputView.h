//
//  AreaStatisticsInputView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTChartView.h"
#import "PopInputView.h"
#import "StatisticsListItem.h"
#import "MBProgressHUD.h"

@interface AreaStatisticsInputView : UIViewController <NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate> {
    
    NSMutableString *currentString;
    NSMutableArray *staCountArr;//统计个数
    NSMutableArray *staTypeArr;//统计条件

    NSString *beginDateValue;//开始时间
    NSString *endDateValue;//结束时间

    UITableView *resultTable;//结果列表
    
    NTChartView *chartView;//柱状图封装类对象
    PopInputView *popView;//选择日期弹出窗口类对象
}


@property (nonatomic, retain) NSMutableString *currentString;
@property (nonatomic, retain) NSMutableArray *allInfoArr;
@property (nonatomic, retain) NSArray *tableNameArr;
@property (nonatomic, retain) NSArray *biluNameArr;
@property (nonatomic, retain) NSArray *biluCountArr;
@property (nonatomic, retain) NSMutableArray *staCountArr;//统计个数
@property (nonatomic, retain) NSMutableArray *staTypeArr;//统计条件

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
