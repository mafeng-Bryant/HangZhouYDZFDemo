//
//  JSXMGZBTableView.h
//  GMEPS_HZ
//
//  Created by power humor on 12-5-24.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "WebServiceHelper.h"
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>

@interface JSXMGZBTableView : UITableViewController<NSXMLParserDelegate>
{
    MBProgressHUD *HUD;
    int nParserStatus;
    NSString *bh;
    NSString *xmmc;
    NSString *jsdd;
    NSString *xzqhdm;
    NSString *jsdw;
    NSString *yqjgrq;
    NSString *xmfzr;
    NSString *lxdh;
    NSString *lxr;
    NSString *lxrdh;
    NSString *spbm;
    NSString *spwh;
    NSString *hylx;
    NSString *ybhy;
    NSString *xmlx;
    NSString *mgcd;
    NSString *ssqk;
    NSString *gzjb;
    NSString *ztgc;
    NSString *sclss;
    NSString *fqclss;
    NSString *zsclss;
    NSString *gfclss;
    NSString *qksm;
    NSString *xfqk;
    NSString *qtspnrlsqk;
    NSString *jcyj;
    NSString *jcrq;
    NSString *cjr;
    NSString *cjsj;
    NSString *xgr;
    NSString *xgsj;
    NSString *gzbh;
    NSString *hbsstzs;
    NSString *hbsstzq;
    NSString *hbsstzzs;
    NSString *hbsstzz;
    
}


@property (nonatomic, strong) NSArray *titleAry;
@property (nonatomic, strong) NSArray *titleAry2;
@property (nonatomic, strong) NSArray *valueAry;//右侧信息名称
@property (nonatomic, strong) NSArray *valueAry2;//右侧信息内容
@property (nonatomic, retain) NSString *xczfbh;
@property (nonatomic, retain) WebServiceHelper *webservice;
@property (nonatomic, retain) NSMutableString *currentString; 
@property (nonatomic,strong) NSString *tableKey;
- (void)initEntryWithNone;
@end

