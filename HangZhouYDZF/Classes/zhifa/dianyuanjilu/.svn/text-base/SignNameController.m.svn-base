//
//  SignNameController.m
//  GMEPS_HZ
//
//  Created by 张 仁松 on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SignNameController.h"
#import "GTMBase64.h"
#import "WebServiceHelper.h"
#import "LoginViewController.h"
#import "GUIDGenerator.h"
#import "UIImage+Scale.h"
#import "DBHelper.h"
#import "OMGToast.h"
extern UserInfo *g_logedUserInfo;
#import "GMEPS_HZAppDelegate.h"
extern GMEPS_HZAppDelegate *g_appDelegate;
#import "UIImage+Scale.h"
@implementation SignNameController
@synthesize signView,delegate,wrybh,wrymc,currentdata,firstName,secondName,xczfbh,tableName,popRecordController,signImageView,lxBH;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    [signView release];
    [wrybh release];
    [wrymc release];
    [currentdata release];
    [firstName release];
    [secondName release];
    [xczfbh release];
    [popRecordController release];
    [signImageView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


-(IBAction)clearPressed:(id)sender{
    _isRecord = NO;
    if (signImageView.superview != nil) {
        [signImageView removeFromSuperview];
    }
    signView.needsErase = YES;
    [signView erase];
}



//lx 1表示执法人员签名 2表示被检查人签名
-(void)uploadSignature:(NSString*)filePath andLX:(NSString*)lx{
    NSData *origData = [NSData dataWithContentsOfFile:filePath];
	
	NSData *encodedData = [GTMBase64 encodeData:origData];
	NSString *fileData = [[NSString alloc] initWithData:encodedData encoding: NSUTF8StringEncoding];

    NSString* params = [WebServiceHelper createParametersWithKey:@"BH"
														   value:xczfbh,@"QYID",wrybh,@"QYMC",wrymc,
                @"CQFBUT",fileData,@"CJR",g_logedUserInfo.userName,@"CQFBTMC",lx ,@"UDID",g_appDelegate.udid,nil];
	
    NSString *URL = [NSString  stringWithFormat: KATTACH_URL,
                     g_appDelegate.ServerIP];

	WebServiceHelper *webService = [[[WebServiceHelper alloc] initWithUrl:URL
            method:@"UploadSignature_Log_UDID"
            view:self.view
       nameSpace:KSoapNameSpace
      parameters:params
        delegate:self] autorelease];
    
    webService.hudTitle = @"正在上传签名，请稍候...";
    webService.errMsg = @"提交签名超时！";
	[webService run];
    
    [fileData release];
}


-(IBAction)commitPressed:(id)sender{
    //[self  saveLocalSignImageDB:sender];
    //企业负责人 (0,0,590,190)   
    //执法人员   (0,210,590,190*2) 需要对图片进行分割
    
    UIImage* origImage = nil;
    if (_isRecord) {
        NSString  *signImagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/signImage.jpg"];
        origImage = [[UIImage alloc] initWithContentsOfFile:signImagePath];
    }
    else {
         origImage =  [[signView capturePaintingImage] retain];
    }
    
    
    
//    NSString *signaturePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/signature.jpg"];
//    [UIImageJPEGRepresentation(origImage,1.0) writeToFile:signaturePath atomically:YES];

    
    CGImageRef imageFuzeren = CGImageCreateWithImageInRect (origImage.CGImage,CGRectMake(0,0,590,190));
    
    CGImageRef imageZhifaren = CGImageCreateWithImageInRect (origImage.CGImage,CGRectMake(0,210,590,380));
    
    UIImage *fuzerenImg = [[UIImage alloc] initWithCGImage:imageFuzeren];
    UIImage *zhifarenImg = [[UIImage alloc] initWithCGImage:imageZhifaren];
    
    [origImage release];
    
    
    UIImage* scaledFuzerenImage = [fuzerenImg scaleToSize:CGSizeMake(590*0.2, 190*0.2)];
    UIImage* scaledZhifarenImage = [zhifarenImg scaleToSize:CGSizeMake(590*0.2,380*0.2)];
    
    
	NSString  *zfrJpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/zfrSignname.jpg"];
	[UIImageJPEGRepresentation(scaledZhifarenImage,0.7) writeToFile:zfrJpgPath atomically:YES];
    
    //负责人图片
    
    NSString  *fzrJpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/fzrSignname.jpg"];
    [UIImageJPEGRepresentation(scaledFuzerenImage,0.7) writeToFile:fzrJpgPath atomically:YES];
    
    
    CGImageRelease(imageFuzeren);
    CGImageRelease(imageZhifaren);
    //[fuzerenImg release];
    //[zhifarenImg release];
    
    commitStatus = 0;
  	
    // Regisete for HUD callbacks so we can remove it from the window at the right time
   
	
	
//    [NSThread detachNewThreadSelector:@selector(uploadZfrSignature:) toTarget:self withObject:zfrJpgPath];
    [self uploadSignature:zfrJpgPath andLX:[NSString stringWithFormat:@"%d",lxBH]];
   // [NSThread detachNewThreadSelector:@selector(uploadFzrSignature:) toTarget:self withObject:fzrJpgPath];
     
}

- (void)saveLocalSignImageDB:(id)sender{
    //UIImage   *signImage =  [UIImage imageNamed:@"Signname.jpg"];
    UIImage* signImage =  [signView capturePaintingImage];
    DBHelper *helper = [DBHelper sharedInstance];
//    NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Signname" ofType:@"jpg"]];
    
    NSData *imageData = UIImageJPEGRepresentation(signImage, 0.01);
    
    BOOL res = [helper saveSignName:imageData XCZFBH:xczfbh WRYMC:wrymc TableName:tableName JCR:g_logedUserInfo.userName];
    if(res){
        [OMGToast showWithText:@"签名已暂存在本地！" duration:1.0];
    }
}

- (void)loadLocalSignImageDB:(id)sender {
    if (popRecordController == nil) {
        ChooseRecordViewController *tmpController =
        [[ChooseRecordViewController alloc] initWithStyle:UITableViewStylePlain];
        tmpController.blName = tableName;
        tmpController.wrymc = wrymc;
        tmpController.isGetHistory = NO;
        tmpController.contentSizeForViewInPopover = CGSizeMake(600, 400);
        tmpController.delegate = self;
        
        
        UINavigationController *tmpNav = [[UINavigationController alloc] initWithRootViewController:tmpController];
        UIPopoverController *tmpPopover = [[UIPopoverController alloc] initWithContentViewController:tmpNav];
        self.popRecordController = tmpPopover;
        [tmpController.tableView reloadData];
        [tmpPopover release];
        [tmpNav release];
        [tmpController release];
    }
    UINavigationController *navVC = (UINavigationController *)popRecordController.contentViewController;
    NSArray *contrArr = navVC.childViewControllers;
    if (contrArr.count>0) {
        ChooseRecordViewController *tmpController = [contrArr objectAtIndex:0];
        tmpController.isGetHistory = NO;
    }
    [popRecordController dismissPopoverAnimated:NO];
    
	[self.popRecordController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)displaySignImageView:(UIImage *)signImage {
    //signView.userInteractionEnabled = NO;
    NSString  *signImagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/signImage.jpg"];
    [UIImageJPEGRepresentation(signImage,0.1) writeToFile:signImagePath atomically:YES];

   
    signImageView = [[UIImageView alloc] initWithImage:signImage];
    signView.frame = CGRectMake(54, 61, 600, 529);
    [signView addSubview:signImageView];
   
}

-(void)returnInfo:(id)valuesData{
    _isRecord = YES;
    NSData *values = (NSData *)valuesData;
    UIImage *signImage = [UIImage imageWithData:values];
    [signImage scaleToSize:CGSizeMake(600, 590)];
    [self displaySignImageView:signImage];
    [popRecordController dismissPopoverAnimated:YES];
}


-(void)cancelSignName:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.title = @"现场执法签名";
    firstNameLabel.text = firstName;
    secondNameLabel.text = secondName;
    
    UIToolbar *signToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 768.0, 44.0)];
    signToolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelSignName:)];
    
    UIBarButtonItem *spaceItem0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem *titleItem = [[UIBarButtonItem alloc] initWithTitle:@"现场执法签名" style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *spaceItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
//    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake((768-120)/2, 0.0, 120, 44)];
//    titleLable.text = @"现场执法签名";
//    titleLable.font = [UIFont systemFontOfSize:18];
//    titleLable.textAlignment = UITextAlignmentCenter;
//    titleLable.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"暂存签名" style:UIBarButtonItemStyleBordered target:self action:@selector(saveLocalSignImageDB:)];
    UIBarButtonItem *loadItem = [[UIBarButtonItem alloc] initWithTitle:@"获取暂存签名" style:UIBarButtonItemStyleBordered target:self action:@selector(loadLocalSignImageDB:)];
    signToolBar.items = [NSArray arrayWithObjects:cancelItem,spaceItem0,titleItem,spaceItem1,loadItem,saveItem,nil];
    
    [cancelItem release];
    [titleItem  release];
    [spaceItem0 release];
    [spaceItem1 release];
    [loadItem   release];
    [saveItem   release];
    
    [self.view addSubview:signToolBar];
    [signToolBar release];
 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"UploadSignature_Log_UDIDResult"]) 
        currentdata = [[NSMutableString alloc] initWithCapacity:100];
    else if([elementName isEqualToString:@"faultcode"]){
        [self commitFailed];
        NSLog(@"error");
    }
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (currentdata) 
        [currentdata appendString:string];
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{

        if(currentdata && [elementName isEqualToString:@"UploadSignature_Log_UDIDResult"])
        {
            
            if([currentdata isEqualToString:@"true"])
            {
                commitStatus++;
                if(commitStatus == 1){
                    
                    
                    NSString  *fzrJpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/fzrSignname.jpg"];
                    [self uploadSignature:fzrJpgPath andLX:[NSString stringWithFormat:@"%d",lxBH+1]];
                }else if(commitStatus == 2){
                    [self dismissModalViewControllerAnimated:YES];
                    [delegate signFinished];
                }
            }
            else {
                commitStatus = -1;
                [self commitFailed];
            }
            
        }

}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [currentdata release];
    currentdata = nil;

}

-(void)commitFailed{
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:@"提交签名到服务器失败！"  delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil];
    [[[alert subviews] objectAtIndex:2] setBackgroundColor:[UIColor colorWithRed:0.5 green:0.0f blue:0.0f alpha:1.0f]];
    [alert show];
    [alert release];
    
}

@end
