//
//  ProjectCheckController.h
//  GMEPS_HZ
//
//  Created by chen on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
// 项目验收

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "WebServiceHelper.h"
#import "PollutionInfoItem.h"

@interface ProjectCheckController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	
	NSMutableArray *wryInfoArr;
	PollutionInfoItem *wryInfoItem;
	int nParserStatus;
	BOOL bItem;
	IBOutlet UITableView *myTableView;
	
	NSMutableString *curData;
	WebServiceHelper *webService;
	NSString *wrybh;
	UIViewController *parentController;
	
}
@property (nonatomic,retain) NSMutableArray *wryInfoArr;
@property (nonatomic,retain) PollutionInfoItem *wryInfoItem;
@property(nonatomic,retain)UITableView *myTableView;

@property(nonatomic,retain) NSMutableString *curData;
@property(nonatomic,retain) WebServiceHelper *webService;
@property(nonatomic,retain) NSString *wrybh;
@property(nonatomic,retain)UIViewController *parentController;
@property(nonatomic,strong)NSString *XH;
@property(nonatomic,strong)NSString *jsonString;

@end