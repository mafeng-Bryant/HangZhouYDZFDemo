//
//  ExamineDetailsView.h
//  RetrieveExamine
//
//  Created by hejunhua on 11-9-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "TotalOpinionView.h"
#import "SPDetailsInfoItem.h"

@interface ExamineDetailsView : UIViewController <UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>{	
	WebServiceHelper *webservice;
	NSMutableString *currentString;
	SPDetailsInfoItem *infoItem;//审批项目详细信息封装类对象
	NSString *xhCode;           //编号是审批项目的唯一标识，要查看哪个项目的详细信息必须向服务器传输编号
	
	int nParserStatus;
	
	UITableView *detail;    //用于显示详细信息的表视图
    
	NSArray *titlesAry;
    NSArray *valueAry;
    NSInteger viewHeight;
}

@property (nonatomic,retain) WebServiceHelper *webservice;
@property (nonatomic, retain) NSMutableString *currentString;
@property (nonatomic,retain) SPDetailsInfoItem *infoItem;
@property (nonatomic,retain) NSString *xhCode;

@property (nonatomic,retain) IBOutlet UITableView *detail;
@property (nonatomic,retain) NSArray *titlesAry;
@property (nonatomic,retain) NSArray *valueAry;

@end
