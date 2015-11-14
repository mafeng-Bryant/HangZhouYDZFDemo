//
//  ReplyDubanController.h
//  GMEPS_HZ
//
//  Created by chen on 11-9-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "DBRWInfoItem.h"
#import "CommenWordsViewController.h"
#import "UISearchSitesController.h"

@interface ReplyDubanController : UIViewController<WordsDelegate,SelectSitesDelegate> {
    IBOutlet UITextField *replyPerson;
    IBOutlet UITextField *replyUnit;
    IBOutlet UITextView  *relpyInfo;
    IBOutlet UITextField *relatedCompanies;
    
    IBOutlet UITextField *zhuanBanPerson;
    IBOutlet UITextField *zhuanBanUnit;
    
    WebServiceHelper* webService;
    NSMutableString *currentdata;
    
    DBRWInfoItem *aItem;
    
    NSString *hfdwBH;//回复人单位编号
    NSString *jsdwBH;//接收人单位编号
    
    NSMutableArray *bumenNameAry;
    NSMutableArray *bumenBHAry;
    UIPopoverController *wordsPopoverController;
	CommenWordsViewController* wordsSelectViewController;
    int currentTag;
    
    IBOutlet UIButton *btnReplySend;
    IBOutlet UIButton *btnZhuanBanSend;
    IBOutlet UISwitch *isTaskFinished;
    
    
    BOOL bReply;//回复信息
    BOOL bAddNewZhuanBan;//是否添加了新转办
    NSString *ZBBH;
    
    NSString *companyBH;
    
}

@property(nonatomic,retain) UITextField *replyPerson;
@property(nonatomic,retain) UITextField *replyUnit;
@property(nonatomic,retain) UITextView  *relpyInfo;
@property(nonatomic,retain) UITextField *relatedCompanies;

@property(nonatomic,retain) UITextField *zhuanBanPerson;
@property(nonatomic,retain) UITextField *zhuanBanUnit;
@property(nonatomic,retain) UIButton *btnReplySend;

@property(nonatomic,retain) NSMutableString *currentdata;
@property(nonatomic,retain) DBRWInfoItem *aItem;

@property(nonatomic,copy)   NSString *hfdwBH;//督办人单位编号
@property(nonatomic,copy)   NSString *jsdwBH;//接收人单位编号
@property(nonatomic,retain) NSMutableArray *bumenNameAry;
@property(nonatomic,retain) NSMutableArray *bumenBHAry;
@property(nonatomic,retain) UIPopoverController *wordsPopoverController;
@property(nonatomic,retain) CommenWordsViewController* wordsSelectViewController;
@property(nonatomic,retain) UIButton *btnZhuanBanSend;
@property(nonatomic,retain) UISwitch *isTaskFinished;
@property(nonatomic,retain) NSString *ZBBH;
@property(nonatomic,retain) NSString *companyBH;
-(IBAction)replyDuban:(id)sender;
-(IBAction)zhuanBanDuban:(id)sender;
-(IBAction)selectCompany:(id)sender;
@end
