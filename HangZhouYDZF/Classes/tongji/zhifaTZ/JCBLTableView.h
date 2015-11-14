//
//  JCBLTableView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "MBProgressHUD.h"

#define WEBSERVICE_Download 1
@interface JCBLTableView : UITableViewController <NSXMLParserDelegate,UIScrollViewDelegate>{
    //需要向服务器传输的表名标识和任务编号标识
    NSString *tableKey;
    NSString *xczfbh;
    
    WebServiceHelper *webservice;
    NSInteger iWebserviceType;
    NSMutableString *currentString;
    int nParserStatus;
    
    NSArray *titleAry;//表视图左侧信息名称
    NSArray *valueAry;//表视图左侧信息内容
    NSArray *titleAry2;//表视图右侧信息名称
    NSArray *valueAry2;//表视图右侧信息内容
    
    NSString *bh;//编号
    NSString *xcfzr;//现场负责人
    NSString *nl;//年龄
    NSString *xb;//性别
    NSString *sfzhm;//身份证号码
    NSString *gzdw;//工作单位
    NSString *zw;//职务
    NSString *ybagx;//与本案关系
    NSString *jtzz;//家庭住址
    NSString *dh;//电话
    NSString *qtjzr;//其他见证人
    NSString *zfzh;//执法证号
    NSString *qrsf;//确认身份
    NSString *sqhb;//申请回避
    NSString *xcqk;//现场情况
    NSString *yb;//邮编
    NSString *cjsj;//创建时间
    NSString *cjr;//创建人
    NSString *xgsj;//修改时间
    NSString *xgr;//修改人
    NSString *bz;//备注
    NSString *zt;//状态
    
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
@property (nonatomic,copy) NSString *xcfzr;
@property (nonatomic,copy) NSString *nl;
@property (nonatomic,copy) NSString *xb;
@property (nonatomic,copy) NSString *sfzhm;
@property (nonatomic,copy) NSString *gzdw;
@property (nonatomic,copy) NSString *zw;
@property (nonatomic,copy) NSString *ybagx;
@property (nonatomic,copy) NSString *jtzz;
@property (nonatomic,copy) NSString *dh;
@property (nonatomic,copy) NSString *qtjzr;
@property (nonatomic,copy) NSString *zfzh;
@property (nonatomic,copy) NSString *qrsf;
@property (nonatomic,copy) NSString *sqhb;
@property (nonatomic,copy) NSString *xcqk;
@property (nonatomic,copy) NSString *yb;
@property (nonatomic,copy) NSString *cjsj;
@property (nonatomic,copy) NSString *cjr;
@property (nonatomic,copy) NSString *xgsj;
@property (nonatomic,copy) NSString *xgr;
@property (nonatomic,copy) NSString *bz;
@property (nonatomic,copy) NSString *zt;


- (void)initEntryWithNone;
- (void)cancelPressed;

@end
