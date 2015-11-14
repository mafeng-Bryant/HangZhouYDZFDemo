//
//  MapListControllerView.h
//  GMEPS_HZ
//
//  Created by Apple on 12-3-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
// 历史勘验图列表

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "MBProgressHUD.h"
@protocol MapListDelegate

-(void)returnSelectedMap:(NSString*)strMap flag:(NSString*)fa;

@end
@interface MapListControllerView : UITableViewController<NSXMLParserDelegate,MBProgressHUDDelegate>
{
    id<MapListDelegate> delegate;
    WebServiceHelper *webservice;
    NSMutableString *currentString;
    
    //需要显示在列表上的值
    NSMutableArray *mcAry;          
    NSMutableArray *jcrAry;         
    NSMutableArray *dcjssjAry;
    NSMutableArray *xczfbhAry;
    NSMutableArray *isajAry;
    NSMutableArray *flagAry;
    
    BOOL bMc;
    BOOL bJcr;
    BOOL bDcjssj;
    BOOL bXczfbh;
    BOOL bIsaj;
    BOOL bFlag;
    MBProgressHUD *HUD;
}
@property (nonatomic, assign) id<MapListDelegate> delegate;
@property (nonatomic, strong) WebServiceHelper *webservice;
@property (nonatomic, strong) NSString *QYMC;
@property (nonatomic, strong) NSString *QYBH;
@end
