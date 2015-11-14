//
//  CaiyangSubView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sample.h"
#import "PopupDateViewController.h"
#import "CommenWordsViewController.h"
#import "YinziViewController.h"

@protocol SaveOneSampleDelegate
-(void)saveSample;
-(void)cancelSample;
@end

@interface CaiyangSubView : UIViewController <PopupDateDelegate,WordsDelegate,YinziSelectDelegate,UITextFieldDelegate>{
    UITextField *ypbh;      //样品编号
    UITextField *cydmc;     //采样点名称
    UITextField *cysj;      //采样时间
    UITextField *sywg;      //水样外观
    UITextField *jcxm;      //监测项目
    UITextField *ls;        //流速
    UITextField *kd;        //宽度
    UITextField *sd;        //深度
    UITextField *ll;        //流量
    UITextField *pfl;       //排放量
    
    Sample *aSample;
    BOOL bLoadSample;
    id<SaveOneSampleDelegate> delegate;
    NSString *jcxmNoStr;//存储对应的编号
    
    UIPopoverController *popController;
	PopupDateViewController *dateController;
    NSMutableArray *dataResultArray;
    int currentFieldTag;
    
    UIPopoverController *wordsPopverController;
    CommenWordsViewController *wordsSelectViewController;
    
    UIPopoverController *popYinziController;
    YinziViewController *yinziController;
}

@property (nonatomic,retain) IBOutlet UITextField *ypbh;      //样品编号
@property (nonatomic,retain) IBOutlet UITextField *cydmc;     //采样点名称
@property (nonatomic,retain) IBOutlet UITextField *cysj;      //采样时间
@property (nonatomic,retain) IBOutlet UITextField *sywg;      //水样外观
@property (nonatomic,retain) IBOutlet UITextField *jcxm;      //监测项目
@property (nonatomic,retain) IBOutlet UITextField *ls;        //流速
@property (nonatomic,retain) IBOutlet UITextField *kd;        //宽度
@property (nonatomic,retain) IBOutlet UITextField *sd;        //深度
@property (nonatomic,retain) IBOutlet UITextField *ll;        //流量
@property (nonatomic,retain) IBOutlet UITextField *pfl;       //排放量

@property (nonatomic,retain) Sample *aSample;
@property (nonatomic,assign) BOOL bLoadSample;
@property (nonatomic,retain) id<SaveOneSampleDelegate> delegate;
@property (nonatomic,retain) NSString *jcxmNoStr;

@property (nonatomic,retain) UIPopoverController *popController;
@property (nonatomic, retain) UIPopoverController *wordsPopoverController;
@property (nonatomic,retain) PopupDateViewController *dateController;
@property (nonatomic, retain) CommenWordsViewController* wordsSelectViewController;
@property(nonatomic,retain)NSMutableArray *dataResultArray;

@property (nonatomic, retain) UIPopoverController *popYinziController;
@property (nonatomic, retain) YinziViewController *yinziController;

-(IBAction)touchFromDate:(id)sender;
-(IBAction)chooseYinzi:(id)sender;
@end
