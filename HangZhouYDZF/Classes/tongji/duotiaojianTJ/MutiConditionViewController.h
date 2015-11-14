//
//  MutiConditionViewController.h
//  GMEPS_HZ
//
//  Created by sz apple on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "ConditionItem.h"
#import "PopInputView.h"
#import "MBProgressHUD.h"

@interface MutiConditionViewController : UIViewController <NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate> {
    IBOutlet UISegmentedControl *areaSeg;
    IBOutlet UISegmentedControl *industrySeg;
    IBOutlet UISegmentedControl *departSeg;
    IBOutlet UISegmentedControl *businessSeg;
    IBOutlet UIButton *dateButton;
    IBOutlet UITableView *resultTable;
    
    BOOL bArea;
    BOOL bIndustry;
    BOOL bDepart;
    BOOL bBusiness;
    BOOL bItem;
    
    int nParserStatus;
    
    NSString *startDate;
    NSString *endDate;
    
    WebServiceHelper *webservice;
    ConditionItem *oneItem;
    NSMutableString *currentString;
    NSMutableArray *areaAry;
    NSMutableArray *industryAry;
    NSMutableArray *departAry;
    NSMutableArray *businessAry;
    
    NSMutableDictionary *resultDic;
    PopInputView *popView;
    
}

@property (nonatomic,retain) UISegmentedControl *areaSeg;
@property (nonatomic,retain) UISegmentedControl *industrySeg;
@property (nonatomic,retain) UISegmentedControl *departSeg;
@property (nonatomic,retain) UISegmentedControl *businessSeg;
@property (nonatomic,retain) UIButton *dateButton;
@property (nonatomic,retain) UITableView *resultTable;
@property (nonatomic,copy) NSString *startDate;
@property (nonatomic,copy) NSString *endDate;
@property (nonatomic,retain) WebServiceHelper *webservice;
@property (nonatomic,retain) ConditionItem *oneItem;
@property (nonatomic,retain) NSMutableString *currentString;
@property (nonatomic,retain) NSMutableArray *areaAry;
@property (nonatomic,retain) NSMutableArray *industryAry;
@property (nonatomic,retain) NSMutableArray *departAry;
@property (nonatomic,retain) NSMutableArray *businessAry;
@property (nonatomic,retain) NSMutableDictionary *resultDic;
@property (nonatomic,retain) PopInputView *popView;

-(IBAction)dateButtonPressed:(id)sender;
-(IBAction)SegValueChanged:(id)sender;

- (void)initWithBeginDate:(NSString *)bdValue endDate:(NSString *)edValue;
@end
