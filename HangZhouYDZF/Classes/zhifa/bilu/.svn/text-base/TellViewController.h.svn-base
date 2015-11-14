//
//  TellViewController.h
//  EPad
//
//  Created by chen on 11-4-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupDateViewController.h"
#import "OutBaseRecordViewController.h"
#import "SignNameController.h"
#import "PersonSelectControllerView.h"

@interface TellViewController : OutBaseRecordViewController <PopupDateDelegate,UITextFieldDelegate,PersonDelegate,SignameDelegate>{

    IBOutlet UILabel  * DLRSSBM; //登录人所属部门
    IBOutlet UILabel  * DLRSSBMDZ; //登录人所属部门和地址
    IBOutlet UITextField  *HHJGH;      //杭环监号
	UITextField * YY;
	UITextField * WFLL;
	UITextField * JCSJ;
	UITextField * TZSJ;
	UITextField * JSCLSJ;
	UITextField * JS;
	UITextField * QTZJ;

	UITextField * YY2;//将YY的值赋给它
	UITextField * QYDW;//企业单位
	UITextField * QYDW2;//将QYDW的值赋给它
	UITextField * JSCLSJ2;//将JSCLSJ的值赋给它
	
	
	NSDate *JCSJDateValue;
	NSDate *TZSJDateValue;
	NSDate *JSCLSJDateValue;
    
    
	
	PopupDateViewController *dateController;
	
	int currentTag;
    UIPopoverController *anyouPopoverController;
    
    IBOutlet UIButton *bringBtn1;
    IBOutlet UIButton *bringBtn2;
    IBOutlet UIButton *bringBtn3;
    IBOutlet UIButton *bringBtn4;
    IBOutlet UIButton *bringBtn5;
    IBOutlet UIButton *bringBtn6;
    IBOutlet UIButton *bringBtn7;
    IBOutlet UIButton *bringBtn8;
    
}

@property (nonatomic, retain) UILabel     * DLRSSBM; //登录人所属部门
@property (nonatomic, retain) UILabel     * DLRSSBMDZ; //登录人所属部门和地址
@property (nonatomic, retain) IBOutlet UITextField * YY;
@property (nonatomic, retain) IBOutlet UITextField * WFLL;
@property (nonatomic, retain) IBOutlet UITextField * JCSJ;
@property (nonatomic, retain) IBOutlet UITextField * TZSJ;
@property (nonatomic, retain) IBOutlet UITextField * JSCLSJ;
@property (nonatomic, retain) IBOutlet UITextField * JS;
@property (nonatomic, retain) IBOutlet UITextField * QTWP;

@property (nonatomic, retain) IBOutlet UITextField * DWDSR;
@property (nonatomic, retain) IBOutlet UITextField * DSRDH;
@property (nonatomic, retain) IBOutlet UITextField * XCJCRY;
@property (nonatomic, retain) IBOutlet UITextField * JCRDH;

@property (nonatomic, retain) IBOutlet UITextField * YY2;
@property (nonatomic, retain) IBOutlet UITextField * QYDW;
@property (nonatomic, retain) IBOutlet UITextField * JSCLSJ2;
@property (nonatomic, retain) IBOutlet UITextField * QYDW2;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *surePerson;

@property (nonatomic, retain) NSMutableArray *bringContentAry;
@property (nonatomic, copy)   NSMutableString *bringContentStr;
@property (nonatomic, retain) NSDate *JCSJDateValue;
@property (nonatomic, retain) NSDate *TZSJDateValue;
@property (nonatomic, retain) NSDate *JSCLSJDateValue;

@property (nonatomic, retain) UIPopoverController *popController;
@property (nonatomic, retain) PersonSelectControllerView *peopleController;
@property (nonatomic, retain) PopupDateViewController *dateController;

-(IBAction)selectBringContent:(id)sende;
-(IBAction)touchFromDate:(id)sender;
-(IBAction)choosePerson:(id)sender;

@end

