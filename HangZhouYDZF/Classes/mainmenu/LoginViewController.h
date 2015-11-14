//
//  LoginViewController.h
//  Eve
//
//  Created by yushang on 10-11-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WebServiceHelper.h"
#import "UserInfo.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
@interface LoginViewController :UIViewController<NSXMLParserDelegate,UIAlertViewDelegate> {
	
	IBOutlet UIImageView *imageView;
	IBOutlet UITextField *nameField;
    IBOutlet UITextField *pswField;
	
	IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *pwdLabel;
	IBOutlet UIButton *backgroundBtn;
	IBOutlet UIButton *loginBtn;
	
  IBOutlet UILabel *bbh;
	UserInfo *logedUserInfo;
	WebServiceHelper* webService;
	NSMutableString *currentdata;
    
	int nParserStatus;
	int nLoginStatus;
    int updateStatus;
    MBProgressHUD *HUD;
    Reachability  *_hostReach;
    NSTimer *showHudTimer;

}

@property(nonatomic, retain)  UIImageView *imageView;
@property(nonatomic, retain)  UITextField *nameField;
@property(nonatomic, retain)  UITextField *pswField;
@property(nonatomic, retain)  UILabel *nameLabel;
@property(nonatomic, retain)  UILabel *pwdLabel;
@property(nonatomic, retain)  UIButton *backgroundBtn;
@property (nonatomic, retain) IBOutlet UISwitch *savePwdCtrl;
@property(nonatomic, retain)  UIButton *loginBtn;
@property(nonatomic, retain)  UserInfo *logedUserInfo;
@property (nonatomic, retain) WebServiceHelper* webService;
@property (nonatomic, retain) NSMutableString *currentdata;
@property (nonatomic, retain) NSTimer *showHudTimer;
@property (nonatomic, retain) IBOutlet UILabel *bbh;

-(void)loginWithName:(NSString*)name Password:(NSString*) password;
- (IBAction)toggleLogin:(id)sender;
-(void)enterMainMenuView;
@end
