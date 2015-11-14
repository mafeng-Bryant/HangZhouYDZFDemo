//
//  LoginViewController.m
//  Eve
//
//  Created by yushang on 10-11-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "MainMenuViewController.h"
#import "GMEPS_HZAppDelegate.h"
#import "DataBaseInstaller.h"

extern GMEPS_HZAppDelegate *g_appDelegate;
UserInfo *g_logedUserInfo = nil;
@implementation LoginViewController
@synthesize imageView;
@synthesize nameField, pswField;
@synthesize nameLabel,pwdLabel,backgroundBtn,savePwdCtrl,loginBtn;
@synthesize webService,currentdata,logedUserInfo,showHudTimer;
@synthesize bbh;

//-(void)loginTimeOut{
//	[showHudTimer invalidate];
//	showHudTimer = nil;
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误"
//												   message:@"登录超时！" delegate:nil cancelButtonTitle:@"确定"
//										 otherButtonTitles:nil];
//	[alert show];
//	[alert release];
//	return;
//}

-(void)loginWithName:(NSString*)name Password:(NSString*) password {
    /*MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
    //mainMenuViewController.logedUserInfo = logedUserInfo;
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
    [mainMenuViewController release];
    return;
     */
    //name = @"测试帐号1";
	//password = @"1";
	if (name == nil|| [name isEqualToString:@""]) {
		NSString *msg = @"用户名不能为空";
		
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"提示" 
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"确定" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	
	if (password == nil|| [password isEqualToString:@""]) {
		NSString *msg = @"密码不能为空";
		
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"提示" 
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"确定" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    g_appDelegate.ServerIP = [defaults stringForKey:@"ip_preference"];
	
    if (showHudTimer) {
		[showHudTimer invalidate];
		showHudTimer = nil;
	}
    
//	self.showHudTimer = [NSTimer scheduledTimerWithTimeInterval:30.0f
//														 target:self
//													   selector:@selector(loginTimeOut)
//													   userInfo:nil
//														repeats:NO];
	
    // Regisete for HUD callbacks so we can remove it from the window at the right time

	
	
    
    
	NSString* params = [WebServiceHelper createParametersWithKey:@"userName"
														   value:name,@"userPassword",password,@"UDID",g_appDelegate.udid,nil];
    

    nLoginStatus = 0;
	NSString *URL = [NSString  stringWithFormat: KLogIn_URL,g_appDelegate.ServerIP];
	webService = [[WebServiceHelper alloc] initWithUrl:URL
                                                method:@"GetUserInfo_Log_UDID"
                                                  view:self.view
                                             nameSpace:KSoapNameSpace
                                            parameters:params
                                              delegate:self];
                  
	webService.hudTitle = @"正在登录，请稍候...";
    webService.errMsg = @"登录超时";
    [webService run];
    
}



-(IBAction)toggleLogin:(id)sender {
    //测试无网络时登陆
  //[self enterMainMenuView];
  [self loginWithName:nameField.text Password:pswField.text];
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"用户登录";
    NSString *settingVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    bbh.text = [NSString stringWithFormat:@"版本号：%@",settingVer];
	[self.navigationController setNavigationBarHidden:YES animated:NO];	
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
	NSString *usr = [defaults objectForKey:kUserNameKey];
    NSString *isSave = [defaults objectForKey:kSavePwd];
    NSString *pwd = nil;
    if (isSave != nil) {
        if ([isSave isEqualToString:@"1"]) {
            pwd = [defaults objectForKey:kUserPwdKey];
            savePwdCtrl.on = YES;
        }
    }
	if (usr == nil) usr= @"";
	if (pwd == nil) pwd = @"";
	nameField.text = usr;
	pswField.text  = pwd;
    
    
    
	[[NSNotificationCenter defaultCenter] addObserver:self                                                          
											 selector:@selector(keyboardWillHide:)                                                                  
												 name:UIKeyboardWillHideNotification
											   object:nil];
	
	self.currentdata = [NSMutableString string];
	logedUserInfo = [[UserInfo alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:YES animated:NO];	
    
	
}



#define MOVE_POS -230
- (void)getUp {
	if (self.view.superview.frame.origin.y == MOVE_POS)
		return;
	
    // Set initial location at bottom of superview
    CGRect frame = self.view.superview.frame;
	frame.origin.y = 0;
	self.view.superview.frame = frame;
	
    // Animate to new location
    [UIView beginAnimations:@"presentWithSuperview" context:nil];
	frame.origin.y = MOVE_POS;
	self.view.superview.frame = frame;
    [UIView commitAnimations];
}

- (void)getDown {
	if (self.view.superview.frame.origin.y == 0)
		return;
	
    // Set initial location at bottom of superview
    CGRect frame = self.view.superview.frame;
	frame.origin.y = MOVE_POS;
	self.view.superview.frame = frame;
	
    // Animate to new location
    [UIView beginAnimations:@"presentWithSuperview" context:nil];
	frame.origin.y = 20; //s设置为0会有一段空白 不知何原因
	self.view.superview.frame = frame;
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	//[self getUp];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	
}

- (void)textFieldDoneEditing:(UITextField *)textField {
	//[sender resignFirstResponder];
}

- (IBAction)keyboardWillHide:(NSNotification *)note{
	//[self getDown];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark delegate

#define PARSER_YHMC  0
#define PARSER_YHSJ  1
#define PARSER_ORGID 2
#define PARSER_BMMC  3
#define PARSER_BMBH  4
#define PARSER_ZFZJBH 5
#define PARSER_FSHBJ 7
#define PARSER_ZZDZ 8
#define PARSER_LOGINERR 6 //登录失败 值0 表示密码错误 －1设备未注册
#define PARSER_BBH  9
#define PARSER_YHID  10

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"tableTMP"]){
        nParserStatus = PARSER_LOGINERR;
    }
	else if([elementName isEqualToString:@"YHMC"]){
		nLoginStatus = 1;
		nParserStatus = PARSER_YHMC;
	}
	else if( [elementName isEqualToString:@"YHSJ"]){
		nParserStatus = PARSER_YHSJ;
	}
	else if( [elementName isEqualToString:@"ORGID"]){
		nParserStatus = PARSER_ORGID;
	}
	else if( [elementName isEqualToString:@"BMMC"]){
		nParserStatus = PARSER_BMMC;
	}
	else if( [elementName isEqualToString:@"BMBH"]){
		nParserStatus = PARSER_BMBH;
	}
    else if([elementName isEqualToString:@"ZFZJBH"]){
        nParserStatus = PARSER_ZFZJBH;
    }
    else if([elementName isEqualToString:@"FSHBJ"]){
        nParserStatus = PARSER_FSHBJ;
    }
    else if([elementName isEqualToString:@"ZZDZ"]){
        nParserStatus = PARSER_ZZDZ;
    }else if([elementName isEqualToString:@"YHID"]){
        nParserStatus = PARSER_YHID;
    }
    else if([elementName isEqualToString:@"版本号"]){
        nParserStatus = PARSER_BBH;
    }
	else 
		nParserStatus = -1;
	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (currentdata) 
		[currentdata appendString:string];
    //NSLog(@"44:%@",currentdata);
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if (nParserStatus >= 0) {
        switch (nParserStatus) {
            case PARSER_YHMC:
                logedUserInfo.userName = currentdata;
                break;
            case PARSER_YHSJ:
                logedUserInfo.userPhone = currentdata;
                break;
            case PARSER_ORGID:
                
                logedUserInfo.userORGID = currentdata;
                break;
            case PARSER_BMMC:
                logedUserInfo.userDanwei = currentdata;
                break;
            case PARSER_BMBH:
                logedUserInfo.BMBH = currentdata;
                break;
            case PARSER_ZFZJBH:
                if([currentdata isEqualToString:@"NULL"]||[currentdata isEqualToString:@"null"])//为空 没数据
                    logedUserInfo.ZFZJBH = @"";
                else
                    logedUserInfo.ZFZJBH = currentdata;
                break;
            case PARSER_LOGINERR:
                nLoginStatus = [currentdata intValue];
                break;
            case PARSER_FSHBJ:
                logedUserInfo.FSHBJ = currentdata;
                break;
            case PARSER_ZZDZ:
                logedUserInfo.ZZDZ = currentdata;
                break;
            case PARSER_BBH:
                logedUserInfo.BBH = currentdata;
                break;
            case PARSER_YHID:
                logedUserInfo.YHID = currentdata;
                break;
            default:
                break;
        } 
    }
	
	[currentdata setString:@""];
    nParserStatus = -1;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [showHudTimer invalidate];
    showHudTimer = nil;
    
	if (nLoginStatus == 0) {
        
        NSString *msg = @"登录失败，请检查用户名密码。";
		
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"提示" 
							  message:msg 
							  delegate:nil 
							  cancelButtonTitle:@"确定" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
        
		return;
        
    }
    else if(nLoginStatus == -1) {
        
        NSString *msg = @"设备未注册，请联系技术人员。";
		
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"提示" 
							  message:msg 
							  delegate:nil 
							  cancelButtonTitle:@"确定" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
    }
    else if(nLoginStatus == 1){
        
        g_logedUserInfo = [[UserInfo alloc] initWithUserInfo :logedUserInfo];
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:nameField.text forKey:kUserNameKey];
        if (savePwdCtrl.on) {
            [defaults setObject:pswField.text forKey:kUserPwdKey];
            [defaults setObject:@"1" forKey:kSavePwd];
        }
        else
            [defaults setObject:@"0" forKey:kSavePwd];
        NSString *settingVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        CGFloat appBbh = [settingVer floatValue] *100;
        CGFloat serverBbh = [g_logedUserInfo.BBH floatValue]*100;
        if (serverBbh > appBbh)
        {
             [DataBaseInstaller removeDB];
            updateStatus = updateEdition;
            UIAlertView *alert = [[UIAlertView alloc] 
                                  initWithTitle:@"提示" 
                                  message:@"有新版本，您要更新么？"  
                                  delegate:self 
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:@"取消",nil];
            [alert show];
            [alert release];
            
        }
        else
        {
            [self enterMainMenuView];

        }
		
	}
}

-(void)enterMainMenuView
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];	
    mainMenuViewController.logedUserInfo = logedUserInfo;
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
    [mainMenuViewController release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (updateStatus == updateEdition) {
        if (buttonIndex==0) {
            //http://21.15.124.36/ipad/updateApp.html
            NSString *str = [NSString stringWithFormat:@"http://21.15.124.36/ipad/updateApp.html"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
        else 
        {
            [self enterMainMenuView];
        }
        //[self enterMainMenuView];
        updateStatus = updateEnd;
    }
    /*else if(nLoginStatus == limitUpdate)
     {
     //http://21.15.124.36/ydzf/updateApp.html
     NSString *str = [NSString stringWithFormat:@"http://2.2.2.182:8010/ipad/updateApp.html"];
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
     nLoginStatus = updateEnd;
     }
     */
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[webService release];
	[currentdata release];
	[imageView release];
    [super dealloc];
}


@end
