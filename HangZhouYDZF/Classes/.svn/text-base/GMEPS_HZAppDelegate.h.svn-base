//
//  GMEPS_HZAppDelegate.h
//  GMEPS_HZ
//
//  Created by chen on 11-9-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

#import "BMapKit.h"
@interface GMEPS_HZAppDelegate : NSObject <UIApplicationDelegate,BMKGeneralDelegate> {
	UIWindow *window;
    UINavigationController *navigationController;
    
    NSString *ServerIP;
    NSMutableArray *aryUncommitedSQL;//待提交的记录
	time_t timeEnterBackground;
    //int nParserStatus;
    //NSMutableString *curData;
    //NSString *bbh;  //版本号
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property(nonatomic, copy) NSString *ServerIP;
@property(nonatomic, copy) NSString *yyydIP;//
@property(nonatomic, copy) NSString *udid;
@property(nonatomic, assign) BOOL isSave;
//@property (nonatomic, strong) WebServiceHelper *webservice;
//@property (nonatomic, strong) NSString *bbh;  //版本号

@end

