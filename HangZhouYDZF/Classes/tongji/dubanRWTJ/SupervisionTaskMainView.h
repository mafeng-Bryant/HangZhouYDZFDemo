//
//  SupervisionTaskMainView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
// 督办任务统计

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "PopInputView.h"
#import "NTChartView.h"
#import "ConditionItem.h"
#import "MBProgressHUD.h"

@interface SupervisionTaskMainView : UIViewController <NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>{
    WebServiceHelper *webservice;
    NSMutableString *currentString;
    ConditionItem *tjItem;//统计条件和个数封装类对象
    NSMutableArray *aryForTable;//存放所有上边对象的数组
    int nParserStatus;
    BOOL bItem;
    
    NSString *beginDateValue;//开始时间
    NSString *endDateValue;//结束时间
    NSString *supervisionType;//督办任务统计类型
    int currentTag;
    
    UITableView *resultTable;//结果列表
    
    NTChartView *chartView;//柱状图封装类对象
    PopInputView *popView;//选择时间弹出窗口类对象
    MBProgressHUD *HUD;
}

@property (nonatomic,retain) WebServiceHelper *webservice;
@property (nonatomic,retain) NSMutableString *currentString;
@property (nonatomic,retain) ConditionItem *tjItem;
@property (nonatomic,retain) NSMutableArray *aryForTable;

@property (nonatomic,copy) NSString *beginDateValue;
@property (nonatomic,copy) NSString *endDateValue;
@property (nonatomic,copy) NSString *supervisionType;

@property (nonatomic,retain) IBOutlet UITableView *resultTable;

@property (nonatomic,retain) NTChartView *chartView;
@property (nonatomic,retain) PopInputView *popView;

- (void)addChart;
- (void)initWithBeginDate:(NSString *)bdValue endDate:(NSString *)edValue;
- (void)popingInputView;
- (IBAction)buttonPressed:(id)sender;
@end
