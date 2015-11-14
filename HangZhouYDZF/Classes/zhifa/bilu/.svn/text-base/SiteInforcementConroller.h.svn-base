//
//  SiteInforcementConroller.h
//  EPad
//
//  Created by chen on 11-4-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PersonSelectControllerView.h"
#import "CommenWordsViewController.h"
#import "OutBaseRecordViewController.h"
#import "PopupDateViewController.h"

@interface SiteInforcementConroller : OutBaseRecordViewController
<UITextFieldDelegate,UITextViewDelegate,PopupDateDelegate,PersonDelegate,WordsDelegate> {
    

    IBOutlet UILabel     * DLRSSBM; //登录人所属部门
    int currentTag;

    UIPopoverController *PopPeopleController;
    PersonSelectControllerView *peopleController;
    
    UIPopoverController *wordsPopoverController;
	CommenWordsViewController* wordsSelectViewController;
    UITextField *QYMC;

}


@property (nonatomic, retain) IBOutlet UITextField *QYMC;//企业名称
@property (nonatomic, retain) IBOutlet UITextField * XCFZR;	//现场负责人
@property (nonatomic, retain) IBOutlet UITextField * NL;	//年龄
@property (nonatomic, retain) IBOutlet UITextField * SFZHM;	//身份证号码

@property (nonatomic, retain) IBOutlet UITextField * GZDW;	//工作单位
@property (nonatomic, retain) IBOutlet UITextField * ZW;	//职务
@property (nonatomic, retain) IBOutlet UITextField * YBAGX;	//与本案关系

@property (nonatomic, retain) IBOutlet UITextField * JTZZ;	//家庭住址
@property (nonatomic, retain) IBOutlet UITextField * DH;	//电话

@property (nonatomic, retain) IBOutlet UITextField * QTJZR;	//其他见证人
@property (nonatomic, retain) IBOutlet UITextField * ZFRY;
@property (nonatomic, retain) IBOutlet UITextField * ZFZH;	//执法证号

@property (nonatomic, retain) IBOutlet UITextField * QRSF;	//对执法人身份的确认
@property (nonatomic, retain) IBOutlet UITextField * SQHB;	//申请回避答案
@property (nonatomic, retain) IBOutlet UITextView  * XCQK;	//现场情况
@property (nonatomic, retain) IBOutlet UITextField * YB;	//邮编
@property (nonatomic, retain) IBOutlet UITextField *KYKSSJ; //勘验开始时间
@property (nonatomic, retain) IBOutlet UITextField *KYJSSJ; //勘验结束时间
@property (nonatomic, retain) IBOutlet UITextField *KYDD;   //勘验地点

@property (nonatomic, retain) IBOutlet UISegmentedControl *XB; //性别



@property(nonatomic,strong)NSMutableArray *surePreson;
@property (nonatomic, retain) UIPopoverController *PopPeopleController;
@property (nonatomic, retain) PersonSelectControllerView *peopleController;

@property (nonatomic, retain) UIPopoverController *wordsPopoverController;
@property (nonatomic, retain) UIPopoverController *popController;
@property (nonatomic, retain) PopupDateViewController *dateController;
@property (nonatomic, retain) CommenWordsViewController* wordsSelectViewController;


-(IBAction)choosePerson:(id)sender;
-(IBAction)beginEditing:(id)sender;
-(IBAction)touchFromDate:(id)sender;
@end
