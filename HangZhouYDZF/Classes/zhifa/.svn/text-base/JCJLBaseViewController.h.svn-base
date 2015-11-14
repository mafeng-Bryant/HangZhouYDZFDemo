//
//  JCJLBaseViewController.h
//  GMEPS_HZ
//
//  Created by 张仁松 on 13-4-19.
//
//

#import <UIKit/UIKit.h>
#import "SelectJcsyViewController.h"
#import "PopupDateViewController.h"
#import "CommenWordsViewController.h"
#import "PersonSelectControllerView.h"
#import "UISearchSitesController.h"
#import "SignNameController.h"
#import "WryLocationVC.h"
#import "ChooseRecordViewController.h"

#define BTNMenu_1 1
#define BTNMenu_2 2
#define BTNMenu_3 3
#define BTNMenu_4 4
#define BTNMenu_5 5
#define BTNMenu_6 6

#define TAG_SSQY 101
#define TAG_KSSJ 102
#define TAG_JSSJ 103
#define TAG_JCR  104
#define TAG_JCSY 105
#define TAG_QLSX 106

#define TAG_PHONE 111

#define PHONE @"0123456789-"

@interface JCJLBaseViewController : UIViewController<SelectJcsyDelegate,UITextFieldDelegate,PopupDateDelegate,WordsDelegate,PersonDelegate,SelectSitesDelegate,SignameDelegate,LocationDelegate,ChooseRecordDelegate>{

    IBOutlet UITextField *jcdwField;
    IBOutlet UITextField *dwmcField;
    IBOutlet UITextField *dwdzField;
    IBOutlet UITextField *ssqyField;//区域
    IBOutlet UITextField *fddbrField;
    IBOutlet UITextField *fddbrdhField;
    IBOutlet UITextField *hblxrdhField;
    IBOutlet UITextField *hblxrField;
    IBOutlet UITextField *jcsjField;
    IBOutlet UITextField *jcjssjField;
    IBOutlet UITextField *jcryField;//检查人员


    IBOutlet UITextField *qlsxField;
    IBOutlet UITextField *jcsyField;//检查事由
    IBOutlet UITextField *jdField;
    IBOutlet UITextField *wdField;
    IBOutlet UITextField *zfzhField;
    IBOutlet UILabel *mcLabel;
    IBOutlet UILabel *dzLabel;
    NSInteger currentTag;

    IBOutlet UISegmentedControl *gllbSegCtrl;//管理类别
    IBOutlet UISegmentedControl *hylxSegCtrl;//行业类型
    NSInteger alertType;
    NSInteger recordStatus;
}
-(IBAction)getLocation:(id)sender;
@end
