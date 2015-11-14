//
//  OpinionViewController.h
//  EPad
//
//  Created by chen on 11-4-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAPKit/MAPKit.h>
#import "PopupDateViewController.h"
#import "OutBaseRecordViewController.h"
#import "SignNameController.h"
#import "PersonSelectControllerView.h"
@interface OpinionViewController : OutBaseRecordViewController<PopupDateDelegate,UITextFieldDelegate,SignameDelegate,PersonDelegate> {
	
	IBOutlet UILabel     * DLRSSBM; //登录人所属部门
	IBOutlet UITextField *  HHJGH;		//杭环监告号
    IBOutlet UITextField *  JCSJ;       //检查时间
	IBOutlet UITextField *  SBDZ;		//上报单位
	IBOutlet UITextView  *  JCYJ;		//监察意见
	IBOutlet UITextField *  WGSJ;		//违规事件
	IBOutlet UITextField * QYMC;        //企业名称
	IBOutlet UITextField *  SBSJ;		//上报时间
    IBOutlet UITextField * XCJCRY;      //现场检查人员
    IBOutlet UITextField * JCRDH;      //现场检查人员电话
    IBOutlet UITextField * QYDSR;       //企业当事人
    IBOutlet UITextField * DSRDH;       //企业当事人电话
	
	NSDate *endDateValue;

}

@property (nonatomic, copy) NSDate *endDateValue;
@property(nonatomic,assign)int currentTag;	

@property (nonatomic, retain) UIPopoverController *popController;
@property (nonatomic, retain) PopupDateViewController *dateController;
@property (nonatomic, retain) PersonSelectControllerView *peopleController;
@property (nonatomic, retain) NSArray *valuesAry;
@property (nonatomic, retain) NSArray *keysAry;
@property (nonatomic, retain) NSMutableArray *surePerson;

-(IBAction)touchFromDate:(id)sender;
-(IBAction)choosePerson:(id)sender;
@end
