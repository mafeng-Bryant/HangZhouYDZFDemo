//
//  ImgListController.h
//  GMEPS_HZ
//
//  Created by sz apple on 11-12-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"

@interface ImgListItem : NSObject
@property (nonatomic,copy) NSString *mc;
@property (nonatomic,copy) NSString *ljdz;
@property (nonatomic,copy) NSString *gs;//格式
@property (nonatomic,copy) NSString *sl;//数量
@end

@interface ImgListController : UITableViewController <NSXMLParserDelegate>

@property (nonatomic,strong) NSString *wrybh;
@property (nonatomic,strong) NSString *dm;

@property (nonatomic,strong) WebServiceHelper *webservice;
@property (nonatomic,strong) NSMutableString *currentString;
@property (nonatomic,strong) NSMutableArray *resultAry;
@property (nonatomic,strong) ImgListItem *myListItem;
@property (nonatomic,assign) BOOL bItem;
@property (nonatomic,assign) int nParserStatus;
@end
