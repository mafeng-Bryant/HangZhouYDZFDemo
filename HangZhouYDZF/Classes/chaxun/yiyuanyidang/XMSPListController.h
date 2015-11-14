//
//  XMSPListController.h
//  GMEPS_HZ
//
//  Created by chen on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "PollutionInfoItem.h"
#import "WebServiceHelper.h"
#import "UserInfo.h"

@interface XMSPListController : UIViewController<UITableViewDelegate,UITableViewDataSource> {

	//项目审批
	NSMutableArray *wryInfoArr;                 //包含全部污染源信息的数组
	PollutionInfoItem *wryInfoItem;             //污染源描述
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

@property(strong,nonatomic)NSString *jsonString;
@end
