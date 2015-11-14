//
//  STListController.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STStatisticsItem.h"
#import "WebServiceHelper.h"
#import "UserInfo.h"
@interface STListController : UITableViewController <NSXMLParserDelegate>{
    
    NSMutableString *currentString;
    NSMutableArray *STInfoArr;//将所有任务信息存放在数组中
    
    STStatisticsItem *STInfoItem;//存放在督办任务列表中每一栏显示的一条任务主要内容的封装类对象
    //TaskDetailsView *childView;
    
    int nParserStatus;
    BOOL bItem;
    
    NSString *beginDateStr;//开始时间
    NSString *endDateStr;//结束时间
    
    NSString *codeStr;       //作为websevice传输的条件编号
    NSString *STTypeStr;
}

@property (nonatomic,retain) NSMutableString *currentString;
@property (nonatomic,retain) NSMutableArray *STInfoArr;

@property (nonatomic,retain) STStatisticsItem *STInfoItem;

@property (nonatomic,retain) NSString *beginDateStr;
@property (nonatomic,retain) NSString *endDateStr;

@property (nonatomic,retain) NSString *codeStr;       
@property (nonatomic,retain) NSString *STTypeStr;
@end
