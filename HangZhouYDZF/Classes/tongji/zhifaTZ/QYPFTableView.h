//
//  QYPFTableView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "MBProgressHUD.h"

@interface QYPFTableView : UITableViewController <NSXMLParserDelegate>{
    //需要向服务器传输的表名标识和任务编号标识
    NSString *tableKey;
    NSString *xczfbh;
    
    WebServiceHelper *webservice;
    NSMutableString *currentString;
    int nParserStatus;
    
    NSArray *titleAry;//表视图左侧信息名称
    NSArray *valueAry;//表视图左侧信息内容
    NSArray *titleAry2;//表视图右侧信息名称
    NSArray *valueAry2;//表视图右侧信息内容
    
    NSString *orgid;//行政区划代码
    NSString *bh;//编号
    NSString *qyid;//企业ID
    NSMutableString *pfnrid;//评分内容
    NSString *qymc;//企业名称
    NSString *qydz;//企业地址
    NSString *kfs;//扣分数
    NSMutableString *khxz;//考核细则
    NSString *cjr;//创建人
    NSString *xgr;//修改人
    NSString *cjsj;//创建时间
    NSString *xgsj;//修改时间
    NSString *bz;//备注
}
@property (nonatomic,retain) NSString *tableKey;
@property (nonatomic,retain) NSString *xczfbh;
@property (nonatomic,retain) NSMutableArray *pfArr;
@property (nonatomic,retain) WebServiceHelper *webservice;
@property (nonatomic,retain) NSMutableString *currentString;

@property (nonatomic,retain) NSArray *titleAry;
@property (nonatomic,retain) NSArray *valueAry;
@property (nonatomic,retain) NSArray *titleAry2;
@property (nonatomic,retain) NSArray *valueAry2;

@property (nonatomic,copy) NSString *bh;
@property (nonatomic,retain) NSMutableString *pfnrid;
@property (nonatomic,copy) NSString *qymc;
@property (nonatomic,copy) NSString *qydz;
@property (nonatomic,copy) NSString *kfs;
@property (nonatomic,retain) NSMutableString *khxz;
@property (nonatomic,copy) NSString *cjr;
@property (nonatomic,copy) NSString *xgr;
@property (nonatomic,copy) NSString *cjsj;
@property (nonatomic,copy) NSString *xgsj;
@property (nonatomic,copy) NSString *bz;

- (void)initEntryWithNone;
- (void)cancelPressed;
@end
