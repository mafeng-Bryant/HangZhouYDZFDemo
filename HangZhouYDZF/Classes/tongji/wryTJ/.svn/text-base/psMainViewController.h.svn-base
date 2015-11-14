//
//  psMainViewController.h
//  PollutionStatistics
//
//  Created by hejunhua on 11-9-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "StatisticsItem.h"
#import "MBProgressHUD.h"

@interface psMainViewController : UIViewController <NSXMLParserDelegate>{
	NSArray *viewController;
    
    WebServiceHelper *webservice;
    NSMutableString *currentString;
    
    NSArray *districts;//区域统计信息数组
    NSArray *business;//企业统计信息数组
    NSArray *industry;//行业统计信息数组
    NSArray *firmSize;//规模统计信息数组
    NSArray *regulatoryLevel;//监管级别统计信息数组
    
    StatisticsItem *staItem;//统计信息封装类
    int nParserStatus;
    
    //对应上面5种统计
    BOOL bDItem;
    BOOL bBItem;
    BOOL bIItem;
    BOOL bFItem;
    BOOL bRItem;
    
    int currentTag;
    UIView *childView;
    
}

@property (nonatomic, retain) NSArray *viewController;

@property (nonatomic, retain) WebServiceHelper *webservice;
@property (nonatomic, retain) NSMutableString *currentString;

@property (nonatomic, retain) NSArray *districts;
@property (nonatomic, retain) NSArray *business;
@property (nonatomic, retain) NSArray *industry;
@property (nonatomic, retain) NSArray *firmSize;
@property (nonatomic, retain) NSArray *regulatoryLevel;

@property (nonatomic, retain) StatisticsItem *staItem;
@property (nonatomic, retain) IBOutlet UIView *childView;


- (IBAction)buttonPressed:(id)sender;
@end
