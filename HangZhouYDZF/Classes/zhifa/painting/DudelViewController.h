//
//  DudelViewController.h
//  Dudel
//
//  Created by JN on 2/23/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "UISearchSitesController.h"
#import "Tool.h"
#import "DudelView.h"
#import "MBProgressHUD.h"
#import "MapListControllerView.h"
#import "CustomIconsViewController.h"
#import "UIGraphicToolsController.h"
#import "CustomIconsViewController.h"

#import "BMapKit.h"
#import "TemporarySave.h"
#define ALERT_RequestHisMap 1
#define ALERT_CommitMap     2
#define ALERT_REASEMAP      3
#define ALERT_CHOOSENEWWRY  4//重新选择污染源

#define WEBSERVICE_Download 1
#define WEBSERVICE_Commit   2

#define IMG_COMPONET   1
#define LABEL_COMPONET 2
@interface UIMyImageView:UIImageView

@property(nonatomic,strong)NSString *name;
@end

@interface DudelViewController : UIViewController <ToolDelegate, DudelViewDelegate,SelectSitesDelegate,MBProgressHUDDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UITextViewDelegate,MapListDelegate,CustomIconDelegate,CustomIconDelegate,SelectGraphToolDelegate,BMKGeneralDelegate> {
  
    id <Tool> currentTool;
   
    IBOutlet DudelView *dudelView;
    //IBOutlet UIView *drawingView;

    UIColor *strokeColor;
    UIColor *fillColor;
    CGFloat strokeWidth;
    UIFont *font;
    UIBarButtonItem *commitBar;
    UIBarButtonItem *touchButton;
    
    NSString *WRYBH;//污染源编号
    NSString *WRYMC;//污染源名称
    NSMutableString *currentdata;
    MBProgressHUD *HUD;
    
    NSInteger alertType;
    NSInteger iWebserviceType;
    BOOL bHaveShowIcons;


    NSMutableArray *iconsAry;//存放界面上所画的图标
    
    
    NSMutableArray *deletedDrawInfoAry;
    
    NSMutableArray *textInfoAry;//存放输入的信息 UILabel 可拖动
    UITextView *curLabel;
    
    UIView *toModifyView;
    int toModifyType;
    BOOL bCommited;
    BOOL isMap;              //是否有图
    
    UIButton *btnTitleView;

    BOOL             isTouchIn;
    BOOL             isCanMove;
    BOOL             isSwitch;
    BOOL             isTwoFinger;
    CGPoint			 movePt;
    CGPoint          centerPoint;

}

@property (retain, nonatomic) id <Tool> currentTool;
@property (retain, nonatomic) UIColor *strokeColor;
@property (retain, nonatomic) UIColor *fillColor;
@property (assign, nonatomic) CGFloat strokeWidth;
@property (retain, nonatomic) UIFont *font;
@property (nonatomic, retain) UIBarButtonItem *commitBar;
@property (nonatomic, retain) NSString *WRYBH;//污染源编号
@property (nonatomic, retain) NSString *WRYMC;//污染源名称

@property (nonatomic, retain) NSMutableArray *iconsAry;
@property (nonatomic, retain) NSMutableArray *textInfoAry;


@property(nonatomic,retain)UIPopoverController *popController;
@property(nonatomic,retain)UIPopoverController *popGraphToolsController;


@property (nonatomic, retain) MapListControllerView *mapListController;
@property (nonatomic, retain) UIPopoverController *popMapListController;
@property (nonatomic, retain) NSString *xczfbh;
@property (nonatomic, retain) NSString *flag;

@property (nonatomic, retain)IBOutlet UIButton *textButton;
@property (nonatomic, retain)IBOutlet UIButton *eraserButton;
@property (nonatomic, retain)IBOutlet UIButton *redoButton;
@property (nonatomic, retain)IBOutlet UIButton *pensButton;
@property (nonatomic, retain)IBOutlet UIButton *iconsButton;
@property (nonatomic, retain)IBOutlet UIButton *undoButton;
@property (nonatomic, retain)IBOutlet UIButton *backPosButton;
@property (nonatomic, retain) IBOutlet UIButton *clearButton;
@property (nonatomic, retain) IBOutlet UIButton *moveHandButton;
@property (nonatomic, retain) IBOutlet UILabel *moveHandLabel;
@property (nonatomic, retain) NSMutableDictionary *dicLocation;

@property (nonatomic, retain) NSString *imName;

- (IBAction)touchTextItem:(id)sender;

- (IBAction)touchEraserItem:(id)sender;

- (IBAction)touchClearAllItem:(id)sender;
- (IBAction)touchImageItem:(id)sender;

- (IBAction)touchUndoItem:(id)sender;//撤销
- (IBAction)touchRedoItem:(id)sender;//重做
-(void)mobileDrawing:(id)sender;//开启手势
-(IBAction)Weighing:(id)sender;
-(void)sureCommitBilu:(id)sender;

-(IBAction)touchTools:(id)sender; //选择画笔工具
@end

