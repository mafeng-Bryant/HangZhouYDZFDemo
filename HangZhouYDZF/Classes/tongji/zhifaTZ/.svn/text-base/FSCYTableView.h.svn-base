//
//  FSCYTableView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "FSCYSubItem.h"
#import "MBProgressHUD.h"

@interface FSCYTableView : UITableViewController <NSXMLParserDelegate>{
    //需要向服务器传输的表名标识和任务编号标识
    NSString *tableKey;
    NSString *xczfbh;
    
    WebServiceHelper *webservice;
    NSMutableString *currentString;
    int nParserStatus;
    FSCYSubItem *aSubTable;//字表信息封装类对象
    NSMutableArray *zbAry;//由于字表可能有多个所以用一个数组来存储
    BOOL bItem;
    
    NSArray *titleAry;//表视图左侧信息名称
    NSArray *valueAry;//表视图左侧信息内容
    NSArray *titleAry2;//表视图右侧信息名称
    NSArray *valueAry2;//表视图右侧信息内容
    NSArray *zbTitleAry;//字表信息名称
    NSMutableArray *zbValueAry;//字表信息内容
    
    NSString *gfhqk;//规范化情况
    NSString *bh;//编号
    NSString *xmmc;//项目名称
    NSString *bjcdwmc;//被检查单位名称
    NSString *cyfs;//采样方式
    NSString *pffs;//排放方式
    NSString *tqzk;//天气状况
    NSString *qw;//气温
    NSString *cyz;//采样者
    NSString *xhz;//校核者
    NSString *jyz;//接样者
    NSString *xcjc;//现场监测设备
    NSString *grw;//干扰物
    NSString *jysj;//接样时间
    NSString *yzqk;//设备运转情况
    NSString *scfh;//生产负荷
    NSString *gdjjrqk;//固定剂加入情况
    NSString *cjsj;//创建时间
    NSString *cjr;//创建人
    NSString *xgsj;//修改时间
    NSString *xgr;//修改人
    NSString *bz;//备注
    NSString *orgid;//行政区划代码
    NSString *xh;//序号
    
    MBProgressHUD *hud;
}
@property (nonatomic,retain) NSString *tableKey;
@property (nonatomic,retain) NSString *xczfbh;

@property (nonatomic,retain) WebServiceHelper *webservice;
@property (nonatomic,retain) NSMutableString *currentString;
@property (nonatomic,retain) FSCYSubItem *aSubTable;
@property (nonatomic,retain) NSMutableArray *zbAry;

@property (nonatomic,retain) NSArray *titleAry;
@property (nonatomic,retain) NSArray *valueAry;
@property (nonatomic,retain) NSArray *titleAry2;
@property (nonatomic,retain) NSArray *valueAry2;
@property (nonatomic,retain) NSArray *zbTitleAry;
@property (nonatomic,retain) NSMutableArray *zbValueAry;

@property (nonatomic,copy) NSString *gfhqk;
@property (nonatomic,copy) NSString *bh;
@property (nonatomic,copy) NSString *xmmc;
@property (nonatomic,copy) NSString *bjcdwmc;
@property (nonatomic,copy) NSString *cyfs;
@property (nonatomic,copy) NSString *pffs;
@property (nonatomic,copy) NSString *tqzk;
@property (nonatomic,copy) NSString *qw;
@property (nonatomic,copy) NSString *cyz;
@property (nonatomic,copy) NSString *xhz;
@property (nonatomic,copy) NSString *jyz;
@property (nonatomic,copy) NSString *xcjc;
@property (nonatomic,copy) NSString *grw;
@property (nonatomic,copy) NSString *jysj;
@property (nonatomic,copy) NSString *yzqk;
@property (nonatomic,copy) NSString *scfh;
@property (nonatomic,copy) NSString *gdjjrqk;
@property (nonatomic,copy) NSString *cjsj;
@property (nonatomic,copy) NSString *cjr;
@property (nonatomic,copy) NSString *xgsj;
@property (nonatomic,copy) NSString *xgr;
@property (nonatomic,copy) NSString *bz;
@property (nonatomic,copy) NSString *orgid;
@property (nonatomic,copy) NSString *xh;

- (void)initEntryWithNone;
- (void)cancelPressed;
@end
