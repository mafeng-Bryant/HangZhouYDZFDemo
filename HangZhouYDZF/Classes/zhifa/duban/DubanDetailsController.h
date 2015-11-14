//
//  DubanDetailsController.h
//  GMEPS_HZ
//
//  Created by chen on 11-10-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBRWInfoItem.h"
@interface DuBanDetailItem : NSObject{
    NSString* XH;
    NSString* BH;    //督办编号
    NSString* HFXX;  //回复信息
    NSString* HFSJ;  //回复时间
    NSString* HFR;   //回复人
    NSString* HFRDW; //回复人单位
    NSString* DWBH;  //企业单位编号
    NSString* DWMC;  //单位名称
    BOOL      isFinished;
    
}

@property(nonatomic,copy) NSString* XH;
@property(nonatomic,copy) NSString* BH;    
@property(nonatomic,copy) NSString* HFXX;  
@property(nonatomic,copy) NSString* HFSJ;  
@property(nonatomic,copy) NSString* HFR;   
@property(nonatomic,copy) NSString* HFRDW; 
@property(nonatomic,copy) NSString* DWBH; 
@property(nonatomic,copy) NSString* DWMC;


@end

@interface DubanDetailsController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    DBRWInfoItem *aItem;
    
    IBOutlet UITableView *myTableView;
    NSMutableArray *aryDetailItems;
    
    DuBanDetailItem *aDetailItem;
    NSMutableString  *curData;
    int nParserStatus;
    
    NSMutableDictionary *dicBumenName;//key 是部门编号
    BOOL bWebServiceForFinish;//yes表示结束督办任务 
}


@property(nonatomic,retain) DBRWInfoItem *aItem;
@property(nonatomic,retain) UITableView *myTableView;
@property(nonatomic,retain) NSMutableArray *aryDetailItems;
@property(nonatomic,retain) DuBanDetailItem *aDetailItem;
@property(nonatomic,retain) NSMutableString  *curData;
@property(nonatomic,retain) NSMutableDictionary *dicBumenName;
@property(nonatomic,assign) NSInteger currentIndex;

-(IBAction)btnFinishTask:(id)sender;

@end
