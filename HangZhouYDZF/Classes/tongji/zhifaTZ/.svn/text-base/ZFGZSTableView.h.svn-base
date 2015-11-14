//
//  ZFGZSTableView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "MBProgressHUD.h"

@interface ZFGZSTableView : UITableViewController <NSXMLParserDelegate>{
    //需要向服务器传输的表名标识和任务编号标识
    NSString *tableName;
    NSString *xczfbh;
    
    WebServiceHelper *webservice;
    NSMutableString *currentString;
    int nParserStatus;
    
    NSArray *titleAry;//表视图左侧信息名称
    NSArray *valueAry;//表视图左侧信息内容
    NSArray *titleAry2;//表视图右侧信息名称
    NSArray *valueAry2;//表视图右侧信息内容
    
    NSString *bh;//编号
    NSString *xh;//序号
    NSString *hhjgh;//杭环监告号
    NSString *wrymc;//污染源名称
    NSString *tzsj;//通知时间
    NSString *qlclsj;//前来处理事件
    NSString *bjcdb;//被检查单位
    NSString *bxwrmc;//被询问人名称
    NSString *dh;//电话
    NSString *jcsj;//检查时间
    NSString *fxdw;//发现该单位
    NSString *wf;//违反的法律法规
    NSString *tzqlsj;//通知前来时间
    NSString *js;//处理科室
    NSString *qt;//其他携带物
    NSString *xwr;//询问人
    NSString *cjsj;//创建时间
    NSString *cjr;//创建人
    NSString *xgsj;//修改时间
    NSString *xgr;//修改人
    NSString *bz;//备注
    NSString *zfrdh;//检查人电话
    
    MBProgressHUD *hud;
}
@property (nonatomic, copy) NSString *tableName;
@property (nonatomic, copy) NSString *xczfbh;

@property (nonatomic,retain) WebServiceHelper *webservice;
@property (nonatomic,retain) NSMutableString *currentString;

@property (nonatomic,retain) NSArray *titleAry;
@property (nonatomic,retain) NSArray *valueAry;
@property (nonatomic,retain) NSArray *titleAry2;
@property (nonatomic,retain) NSArray *valueAry2;

@property (nonatomic,copy) NSString *bh;
@property (nonatomic,copy) NSString *xh;
@property (nonatomic,copy) NSString *hhjgh;
@property (nonatomic,copy) NSString *wrymc;
@property (nonatomic,copy) NSString *tzsj;
@property (nonatomic,copy) NSString *qlclsj;
@property (nonatomic,copy) NSString *bjcdb;
@property (nonatomic,copy) NSString *bxwrmc;
@property (nonatomic,copy) NSString *dh;
@property (nonatomic,copy) NSString *jcsj;
@property (nonatomic,copy) NSString *fxdw;
@property (nonatomic,copy) NSString *wf;
@property (nonatomic,copy) NSString *tzqlsj;
@property (nonatomic,copy) NSString *js;
@property (nonatomic,copy) NSString *qt;
@property (nonatomic,copy) NSString *xwr;
@property (nonatomic,copy) NSString *cjsj;
@property (nonatomic,copy) NSString *cjr;
@property (nonatomic,copy) NSString *xgsj;
@property (nonatomic,copy) NSString *xgr;
@property (nonatomic,copy) NSString *bz;
@property (nonatomic,copy) NSString *zfrdh;

- (void)initEntryWithNone;
- (void)cancelPressed;

@end
