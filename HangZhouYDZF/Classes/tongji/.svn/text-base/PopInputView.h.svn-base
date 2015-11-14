//
//  PopInputView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupDateViewController.h"

@class AreaStatisticsInputView;
@class IndustryStatisticsMainView;
@class BranchStatisticsView;
@class BusinessStatisticsView;
@class SupervisionTaskMainView;
@class MutiConditionViewController;

@interface PopInputView : UIViewController <PopupDateDelegate,UITextFieldDelegate>{
    UITextField *beginDateField;
    UITextField *endDateField;
    UIButton *makeSure;
   
    //选择日期的浮动窗口及其内视图
    UIPopoverController *popController;
    PopupDateViewController *dateController;
    int currentTag; //标识开始时间输入栏和结束时间输入栏的变量，1为开始时间2为结束时间
    
    AreaStatisticsInputView *areaParentView;    //区域统计父视图
    IndustryStatisticsMainView *industryParentView;//行业统计父视图
    BranchStatisticsView *branchParentView;     //部门统计父视图
    BusinessStatisticsView *businessParentView; //企业统计父视图
    SupervisionTaskMainView *supervisionParentView;//督办任务统计父视图
    MutiConditionViewController *mutiConditionParentView;//多条件统计父视图
    
    int parentTag;
}

@property (nonatomic, retain) IBOutlet UITextField *beginDateField;
@property (nonatomic, retain) IBOutlet UITextField *endDateField;

@property (nonatomic, retain) IBOutlet UIButton *makeSure;

@property (nonatomic, retain) UIPopoverController *popController;
@property (nonatomic, retain) PopupDateViewController *dateController;

@property (nonatomic, assign) int parentTag;
@property (nonatomic, retain) AreaStatisticsInputView *areaParentView;
@property (nonatomic, retain) IndustryStatisticsMainView *industryParentView;
@property (nonatomic, retain) BranchStatisticsView *branchParentView;
@property (nonatomic, retain) BusinessStatisticsView *businessParentView;
@property (nonatomic, retain) SupervisionTaskMainView *supervisionParentView;
@property (nonatomic, retain) MutiConditionViewController *mutiConditionParentView;

- (IBAction)makeSurePressed:(id)sender;
- (IBAction)backgroundTag:(id)sender;
- (IBAction)touchFromDate:(id)sender;
- (void)cancelPressed;
@end
