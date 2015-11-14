//
//  TaskDetailsView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskStatisticsItem.h"
#import "WebServiceHelper.h"
#import "SeePhotoViewController.h"

@interface TaskDetailsView : UITableViewController<NSXMLParserDelegate,UIAlertViewDelegate>{
    NSString *xczfbh;       //任务的唯一标识，需要将其传输给服务器以获取详细信息
    
    int nParserStatus;
    WebServiceHelper *webservice;
    NSMutableString *currentString;
    
    BOOL isPhoto;
    NSString *currentNode;
    UIBarButtonItem *anotherButton1;

}

@property (nonatomic, strong) NSMutableArray *tableNames;
@property (nonatomic, strong) NSArray *aryAllBiluNames;
@property (nonatomic, strong) NSArray *aryAllDBTables;
@property (nonatomic, retain) NSDictionary *valueInfo;
@property (nonatomic, copy) NSString *xczfbh;
@property (nonatomic, copy) NSString *wrymc;
@property (nonatomic, retain) WebServiceHelper *webservice;
@property (nonatomic, retain) NSMutableString *currentString;
@property (nonatomic, retain) UIPopoverController *photoPopoverController;
@property (nonatomic, retain) NSMutableDictionary *reponseDict;
@property(nonatomic,retain)SeePhotoViewController * photoSelectViewController;

@end
