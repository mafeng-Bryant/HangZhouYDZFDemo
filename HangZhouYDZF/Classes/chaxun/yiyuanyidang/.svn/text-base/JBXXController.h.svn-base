//
//  JBXXController.h
//  GMEPS_HZ
//
//  Created by chen on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "JSONKit.h"
#import "UserInfo.h"

@interface JBXXController : UIViewController<UITableViewDelegate,UITableViewDataSource >{
	//基本信息
	NSArray *jbxxTitleItems;
	NSArray *jbxxItemKeys;
	NSMutableDictionary *dicJBXX;
	
	IBOutlet UIWebView *jbxxWebView;
	NSString *wrybh;
	
	NSMutableString *curData;
	WebServiceHelper *webService;
	
	
}
@property(nonatomic,retain) UIWebView *jbxxWebView;
@property(nonatomic,retain) NSArray *jbxxTitleItems;
@property(nonatomic,retain) NSArray *jbxxItemKeys;
@property(nonatomic,retain) NSMutableDictionary *dicJBXX;
@property(nonatomic,retain) NSString *wrybh;
@property(nonatomic,strong) NSString *jsonString;
@property(nonatomic,retain) NSMutableString *curData;
@property(nonatomic,retain) WebServiceHelper *webService;
@end
