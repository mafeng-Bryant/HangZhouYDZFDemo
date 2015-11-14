//
//  HJJCController.h
//  GMEPS_HZ
//
//  Created by chen on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//环境监测数据


#import <UIKit/UIKit.h>
#import "HJJCInfoItem.h"
#import "WebServiceHelper.h"

@interface HJJCController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	IBOutlet UITableView *myTableView;
	WebServiceHelper* webService;
	NSMutableString *curData;
	
	NSMutableDictionary *dicJianCeInfo; //key为监测日期 value为存储HJJCInfoItem的array
	NSMutableArray *jcKeysAry;//监测日期 key
	HJJCInfoItem *jcInfoItem;
	
	int nParserStatus;
	NSString *wrybh;
}

@property(nonatomic,retain) NSMutableString *curData;
@property(nonatomic,retain)UITableView *myTableView;

@property (nonatomic,retain)NSMutableDictionary *dicJianCeInfo;
@property (nonatomic,retain)HJJCInfoItem *jcInfoItem;
@property (nonatomic,retain)NSMutableArray *jcKeysAry;
@property(nonatomic,retain) NSString *wrybh;
@end
