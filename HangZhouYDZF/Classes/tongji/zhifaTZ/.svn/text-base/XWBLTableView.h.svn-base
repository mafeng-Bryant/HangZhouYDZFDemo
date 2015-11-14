//
//  XWBLTableView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "MBProgressHUD.h"

@interface XWBLTableView : UITableViewController <NSXMLParserDelegate>{
    //需要向服务器传输的表名标识和任务编号标识
    NSString *tableKey;
    NSString *xczfbh;
    
    WebServiceHelper *webservice;
    NSMutableString *currentString;
    int nParserStatus;
    
    NSArray *titleAry;      //表视图左侧信息名称
    NSArray *valueAry;      //表视图左侧信息内容
    NSArray *titleAry2;     //表视图右侧信息名称
    NSArray *valueAry2;     //表视图右侧信息内容
    
    NSString *bh;                           //任务编号
    NSString *xh;                           //单位编号
    NSString *orgid;                        //行政区域代码
    NSString *ay;                           //案由
    NSString *wd;                           //询问内容
    NSString *dcxwdd;                       //调查询问地点
    NSString *xb;                           //性别
    NSString *bxwrmc;                       //被调查询问人
    NSString *nl;                           //年龄
    NSString *zw;                           //职务
    NSString *sfzhm;                        //身份证号码
    NSString *xwkssj;                       //询问开始时间
    NSString *xwjssj;                       //询问结束时间
    NSString *gzdw;                         //工作单位
    NSString *jtzz;                         //家庭住址
    NSString *yb;                           //邮编
    NSString *cjsj;                         //创建时间
    NSString *cjr;                          //创建人
    NSString *xgsj;                         //修改时间
    NSString *xgr;                          //修改人
    NSString *ybagx;                        //与本案关系
    NSString *xwr;                          //调查询问人
    NSString *jlr;                          //记录人
    NSString *cyr;                          //参与人
    NSString *zfry;                         //执法人员
    NSString *sfqr;                         //对执法人员身份确认
    NSString *zfzh;                         //执法证号
    NSString *sqhb;                         //申请回避
    NSString *dh;                           //电话
    NSInteger viewHeight ;   
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
@property (nonatomic,copy) NSString *xh;
@property (nonatomic,copy) NSString *orgid;
@property (nonatomic,copy) NSString *ay;
@property (nonatomic,copy) NSString *wd;
@property (nonatomic,copy) NSString *dcxwdd;
@property (nonatomic,copy) NSString *xb;
@property (nonatomic,copy) NSString *bxwrmc;
@property (nonatomic,copy) NSString *nl;
@property (nonatomic,copy) NSString *zw;
@property (nonatomic,copy) NSString *sfzhm;
@property (nonatomic,copy) NSString *xwkssj;
@property (nonatomic,copy) NSString *xwjssj;
@property (nonatomic,copy) NSString *gzdw;
@property (nonatomic,copy) NSString *jtzz;
@property (nonatomic,copy) NSString *yb;
@property (nonatomic,copy) NSString *cjsj;
@property (nonatomic,copy) NSString *cjr;
@property (nonatomic,copy) NSString *xgsj;
@property (nonatomic,copy) NSString *xgr;
@property (nonatomic,copy) NSString *ybagx;
@property (nonatomic,copy) NSString *xwr;
@property (nonatomic,copy) NSString *jlr;
@property (nonatomic,copy) NSString *cyr;
@property (nonatomic,copy) NSString *zfry;
@property (nonatomic,copy) NSString *sfqr;
@property (nonatomic,copy) NSString *zfzh;
@property (nonatomic,copy) NSString *sqhb;
@property (nonatomic,copy) NSString *dh;

- (void)initEntryWithNone;
- (void)cancelPressed;
@end
