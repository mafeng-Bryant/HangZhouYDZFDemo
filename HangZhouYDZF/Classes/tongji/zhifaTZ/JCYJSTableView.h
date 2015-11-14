//
//  JCYJSTableView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "MBProgressHUD.h"

@interface JCYJSTableView : UITableViewController <NSXMLParserDelegate>{
    //需要向服务器传输的表名标识和任务编号标识
    NSString *tableKey;
    NSString *xczfbh;   
    
    WebServiceHelper *webservice;
    NSMutableString *currentString;
    int nParserStatus;
    
    NSArray *titleAry;  //表视图左侧信息名称
    NSArray *valueAry;  //表视图左侧信息内容
    NSArray *titleAry2; //表视图右侧信息名称
    NSArray *valueAry2; //表视图右侧信息内容
    
    NSString *bh;       //编号
    NSString *hhjch;    //杭环监察号
    NSString *qymc;     //企业名称
    NSString *sbsj;     //上报时间
    NSString *wgsj;     //违规事件
    NSString *sbdz;     //上报地址
    NSString *xcjcry;   //现场检查人员
    NSString *qydsr;    //企业当事人
    NSString *lxdh;     //联系电话
    NSString *qylxdh;   //企业联系电话
    NSString *orgid;    //行政区划代码
    NSString *jcsj;     //检查时间
    NSString *jcyj;     //监察意见
    NSString *cjsj;     //创建时间
    NSString *cjr;      //创建人
    NSString *xgsj;     //修改时间
    NSString *xgr;      //修改人
    NSString *bz;       //备注
    
    MBProgressHUD *hud;
}
@property (nonatomic,retain) NSString *tableKey;
@property (nonatomic,retain) NSString *xczfbh;

@property (nonatomic,retain) WebServiceHelper *webservice;
@property (nonatomic,retain) NSMutableString *currentString;

@property (nonatomic,retain) NSArray *titleAry;
@property (nonatomic,retain) NSArray *valueAry;
@property (nonatomic,retain) NSArray *titleAry2;
@property (nonatomic,retain) NSArray *valueAry2;

@property (nonatomic,copy) NSString *bh;
@property (nonatomic,copy) NSString *hhjch;
@property (nonatomic,copy) NSString *qymc;
@property (nonatomic,copy) NSString *sbsj;
@property (nonatomic,copy) NSString *wgsj;
@property (nonatomic,copy) NSString *sbdz;
@property (nonatomic,copy) NSString *xcjcry;
@property (nonatomic,copy) NSString *qydsr;
@property (nonatomic,copy) NSString *lxdh;
@property (nonatomic,copy) NSString *qylxdh;
@property (nonatomic,copy) NSString *orgid;
@property (nonatomic,copy) NSString *jcsj;
@property (nonatomic,copy) NSString *jcyj;
@property (nonatomic,copy) NSString *cjsj;
@property (nonatomic,copy) NSString *cjr;
@property (nonatomic,copy) NSString *xgsj;
@property (nonatomic,copy) NSString *xgr;
@property (nonatomic,copy) NSString *bz;

- (void)initEntryWithNone;
- (void)cancelPressed;
@end
