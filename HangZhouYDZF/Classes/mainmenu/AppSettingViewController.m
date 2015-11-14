//
//  AppSettingViewController.m
//  GMEPS_HZ
//
//  Created by ZHONGWEN on 13-5-24.
//
//

#import "AppSettingViewController.h"
#import "WebServiceHelper.h"
#import "UserInfo.h"
#import "GMEPS_HZAppDelegate.h"

extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;
@interface AppSettingViewController () 



@end

@implementation AppSettingViewController
@synthesize password0Field,password1Field,oldPasswordField;
- (void)dealloc {
    [webService release];
    [oldPasswordField release];
    [password0Field release];
    [password1Field release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)cancelModifyPassword:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)commitModifyPassword:(id)sender {
    if ([oldPasswordField.text length] <1) {
        UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"初始密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alerview show];
        [alerview release];
    }
    else if(([password0Field.text length] < 1) || ([password1Field.text length] < 1)) {
        UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"新密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alerview show];
        [alerview release];

    }
    else if(![password0Field.text isEqualToString:password1Field.text]) {
        UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次输入的新密码不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alerview show];
        [alerview release];
    }
    
    else {
    NSString* params = [WebServiceHelper createParametersWithKey:@"UserName" value:g_logedUserInfo.YHID,@"PwdOld",oldPasswordField.text,@"PwdNew",password0Field.text,@"UDID",g_appDelegate.udid,nil];
    NSString *method = @"UpdatePwd";
    NSString *nameSpace = @"http://tempuri.org/";
   
    NSString *URL = [NSString  stringWithFormat: KLogIn_URL,g_appDelegate.ServerIP];
    
    webService = [[WebServiceHelper alloc] initWithUrl:URL
                                                method:method
                                             nameSpace:nameSpace
                                            parameters:params
                                              delegate:self];
    [webService run];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
     UIBarButtonItem *CancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelModifyPassword:)];
    UIBarButtonItem *DoneItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:@selector(commitModifyPassword:)];
    self.navigationItem.leftBarButtonItem = CancelItem;
    self.navigationItem.rightBarButtonItem = DoneItem;
    [CancelItem release];
    [DoneItem release];
    [oldPasswordField becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"UpdatePwdResult"]) {
        currentNode = elementName;
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([currentNode isEqualToString:@"UpdatePwdResult"]) {
        if ([string isEqualToString:@"true"]) {
            _modifyStatus = YES;
        }
        else {
            _modifyStatus = NO;
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (_modifyStatus) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"0" forKey:kSavePwd];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码修改成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        [self dismissModalViewControllerAnimated:YES];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码修改失败，请重新输入" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        [oldPasswordField becomeFirstResponder];

    }
}


@end