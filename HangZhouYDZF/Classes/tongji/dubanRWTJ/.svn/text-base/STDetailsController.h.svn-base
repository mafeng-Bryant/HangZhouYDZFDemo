//
//  STDetailsController.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STZBInfoItem.h"
#import "WebServiceHelper.h"
#import "UserInfo.h"
@interface STDetailsController : UITableViewController <NSXMLParserDelegate>{
    WebServiceHelper *webservice;
    NSMutableString *currentString;
    STZBInfoItem *zbItem;//回复信息封装类
    NSMutableArray *zbArray;
    int nParserStatus;
    BOOL bZBItem;
    
    NSString *xmlCode; 
    
    NSArray *titleAry;//表视图左侧信息名称
    NSArray *valueAry;//表视图左侧信息内容
    NSArray *titleAry2;//表视图右侧信息名称
    NSArray *valueAry2;//表视图右侧信息内容
    
    NSMutableArray *zbMainInfoAry;//由于回复信息可能有多个，故用数组存放
    
    NSString *dbbh;     //督办编号
    NSString *rwlx;     //督办任务类型
    NSString *dwbh;     //单位编号
    NSString *dwmc;     //单位名称
    NSString *szqy;     //所在区域
    NSString *ssjd;     //所在街道
    NSString *dbr;      //督办人
    NSString *dbrdw;    //督办人单位
    NSString *jsr;      //接收人
    NSString *jsrdw;    //接收人单位
    NSString *dbxx;     //督办信息
    NSString *zt;       //督办主题
    NSString *ydbz;     //疑点备注
    NSString *dbsj;     //督办时间
    NSString *qx;       //期限
    NSString *sfglzf;   //是否关联执法
    NSString *sfzb;     //是否转办
    NSString *dbrsfbj;  //督办人是否办结
    NSString *dbrbjsj;  //督办人办结时间
    NSString *dbbjr;    //督办办结人
    NSString *jsrsfbj;  //接收人是否办结
    NSString *jsrbjsj;  //接收人办结时间
    NSString *jsbjr;    //接收办结人
    NSString *cjr;      //创建人
    NSString *cjsj;     //创建时间
    NSString *xgr;      //修改人
    NSString *xgsj;     //修改时间
}

@property (nonatomic,retain) WebServiceHelper *webservice;
@property (nonatomic,retain) NSMutableString *currentString;
@property (nonatomic,retain) STZBInfoItem *zbItem;
@property (nonatomic,retain) NSMutableArray *zbArray;

@property (nonatomic,retain) NSString *xmlCode;

@property (nonatomic,retain) NSArray *titleAry;
@property (nonatomic,retain) NSArray *valueAry;
@property (nonatomic,retain) NSArray *titleAry2;
@property (nonatomic,retain) NSArray *valueAry2;
@property (nonatomic,retain) NSMutableArray *zbMainInfoAry;

@property (nonatomic,copy) NSString *dbbh;     //督办编号
@property (nonatomic,copy) NSString *rwlx;     //督办任务类型
@property (nonatomic,copy) NSString *dwbh;     //单位编号
@property (nonatomic,copy) NSString *dwmc;     //单位名称
@property (nonatomic,copy) NSString *szqy;     //所在区域
@property (nonatomic,copy) NSString *ssjd;     //所在街道
@property (nonatomic,copy) NSString *dbr;      //督办人
@property (nonatomic,copy) NSString *dbrdw;    //督办人单位
@property (nonatomic,copy) NSString *jsr;      //接收人
@property (nonatomic,copy) NSString *jsrdw;    //接收人单位
@property (nonatomic,copy) NSString *dbxx;     //督办信息
@property (nonatomic,copy) NSString *zt;       //督办主题
@property (nonatomic,copy) NSString *ydbz;     //疑点备注
@property (nonatomic,copy) NSString *dbsj;     //督办时间
@property (nonatomic,copy) NSString *qx;       //期限
@property (nonatomic,copy) NSString *sfglzf;   //是否关联执法
@property (nonatomic,copy) NSString *sfzb;     //是否转办
@property (nonatomic,copy) NSString *dbrsfbj;  //督办人是否办结
@property (nonatomic,copy) NSString *dbrbjsj;  //督办人办结时间
@property (nonatomic,copy) NSString *dbbjr;    //督办办结人
@property (nonatomic,copy) NSString *jsrsfbj;  //接收人是否办结
@property (nonatomic,copy) NSString *jsrbjsj;  //接收人办结时间
@property (nonatomic,copy) NSString *jsbjr;    //接收办结人
@property (nonatomic,copy) NSString *cjr;      //创建人
@property (nonatomic,copy) NSString *cjsj;     //创建时间
@property (nonatomic,copy) NSString *xgr;      //修改人
@property (nonatomic,copy) NSString *xgsj;     //修改时间
@end
