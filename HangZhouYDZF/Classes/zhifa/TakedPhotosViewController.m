//
//  TakedPhotosViewController.m
//  NanShanApp
//
//  Created by zhang on 12-10-25.
//  Copyright (c) 2012年 zhang. All rights reserved.
//

#import "TakedPhotosViewController.h"
#import "ShowImgController.h"
#import "MBProgressHUD.h"
#import "JSONKit.h"
#import "WebServiceHelper.h"
#import "GMEPS_HZAppDelegate.h"
#import "UserInfo.h"
#import "DDAlertPrompt.h"
#import "GTMBase64.h"

extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;

@interface TakedPhotosViewController ()
@property(nonatomic,copy)NSString *photoDir;
@property(nonatomic,copy)NSString *curUploadFile;
@property(nonatomic,copy)NSMutableString *currentdata;
@property(nonatomic,retain) WebServiceHelper *webService;
@property(nonatomic,retain)MBProgressHUD *HUD;
@property(nonatomic,retain)UIPopoverController *popController;
@property(nonatomic,retain)UIImagePickerController *photopicker;
@end

#define JS_XCKC_FJ  @"JS_XCKC_FJ"
@implementation TakedPhotosViewController
@synthesize scrollView,photoDir,xczfbh,curUploadFile;
@synthesize HUD,popController,photopicker,webService,currentdata;
@synthesize attachSource,nameField,remarkField,myProgressView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)refreshPhotosInScroll{
    if (HUD.superview != nil) {
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }
    NSArray *subViews = [scrollView subviews];
    for(UIView *aView in subViews){
        [aView removeFromSuperview];
    }
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDirectoryEnumerator *dirEnum =
    [fm enumeratorAtPath:[self photoDir]];
    
    NSString *file;
    NSMutableArray *ary = [NSMutableArray arrayWithCapacity:20];
    while (file = [dirEnum nextObject]) {
        [ary addObject:file];
    }
    [ary removeObject:@".DS_Store"];
    int i = 0;
    CGFloat xPos=0,yPos = 0;
    for(NSString *file in ary){
        yPos = 287*(i/3);
        if(i%3 == 0){
            xPos = 0;
            
        }else{
            xPos = 256*i;
        }
        NSString* fullImgPath =  [NSString stringWithFormat:@"%@/%@",[self photoDir],file];
        UICustomPhotoCell *cell = [[UICustomPhotoCell alloc] initWithFrame:CGRectMake(xPos, yPos, 256, 287) ImgPath:fullImgPath andDelegate:self];
        
        [self.scrollView addSubview:cell];
        [cell release];
        i++;
        
    }

}

-(void)deletePhotosInFolder{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDirectoryEnumerator *dirEnum =
    [fm enumeratorAtPath:photoDir];
    
    NSString *file;
    while (file = [dirEnum nextObject]) {
        NSString * fileName = [NSString stringWithFormat:@"%@/%@",[self photoDir],file];
        [fm removeItemAtPath:fileName error:nil];
    }
    
    [self refreshPhotosInScroll];
}

-(void)commitPhoto:(NSString*)name remark:(NSString *)remark {
    NSData *origData = [NSData dataWithContentsOfFile:self.curUploadFile];
	
	NSData *encodedData = [GTMBase64 encodeData:origData];
	NSString *fileData = [[NSString alloc] initWithData:encodedData encoding: NSUTF8StringEncoding];
    
    NSString *url = [NSString stringWithFormat:KATTACH_URL,g_appDelegate.ServerIP];
    NSString *method = @"UploadAttach_Log_UDID";
    NSString *message = [NSString stringWithFormat:@"%@|%@|.png|%@",self.xczfbh,name,remark];
    
    NSString* params = [WebServiceHelper
                        createParametersWithKey:@"attachBinaryStream"
                        value:fileData,@"messages",message,@"attachSource",attachSource,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
   
    self.webService = [[WebServiceHelper alloc] initWithUrl:url
                                                     method:method
                                                       view:self.view nameSpace:KSoapNameSpace parameters:params delegate:self];
    
    webService.hudTitle = @"正在上传附件照片，请稍候...";
    [webService run];
    
    [fileData release];
}



#pragma mark -
#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        DDAlertPrompt *photoPrompt = (DDAlertPrompt *)alertView;
        NSString *photoName   = photoPrompt.nameField.text;
        NSString *photoRemark = photoPrompt.remarkField.text;
    
        
        [self commitPhoto:photoName remark:photoRemark];
        
        NSArray *subViews = [self.view subviews];
        for (UIView *childView in subViews) {
            if ([childView isKindOfClass:[UIButton class]]) {
                childView.userInteractionEnabled = NO;
            }
        }
    }

}


#pragma mark –
#pragma mark UICustomPhotoCellDelegate Methods
-(void)sendImgFile:(NSString*)filePath {
    
/*
    NSString * s= @"fileName" ;
    self.curUploadFile = filePath;
     NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
     [params setObject:JS_XCKC_FJ forKey:@"service"];
     NSString *strUrl = [ServiceUrlString generateUrlByParameters:params];
     
     NSURL *url =[ NSURL URLWithString :strUrl];
     //NSURL *url =[ NSURL URLWithString : @"http://localhost:8080/test/UploadServlet" ];
     self.request = [ ASIFormDataRequest requestWithURL : url ];
     // 字符串使用 GBK 编码，因为 servlet 只识别 GBK
     NSStringEncoding enc= CFStringConvertEncodingToNSStringEncoding ( kCFStringEncodingMacChineseSimp );
     [ request setStringEncoding :enc];
     //[ request setPostValue :JS_XCKC_FJ forKey : @"service" ];
     [ request setPostValue :self.lcbh forKey : @"lcslbh" ];
     [ request setPostValue :bzbh forKey : @"bzslbh" ];
     [ request setPostValue :s forKey : @"fjmc" ];
     [ request setFile :curUploadFile forKey : @"fjl" ];
     [ request setDelegate : self ];
     [request setUploadProgressDelegate:myProgressView];
     [ request setDidFinishSelector : @selector ( responseComplete )];
     [ request setDidFailSelector : @selector (responseFailed)];
    
    if (HUD) {
        [HUD release];
    }
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"正在提交文件，请稍候...";
    [HUD show:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [ request startSynchronous ];
 */
     self.curUploadFile = filePath;
    
    DDAlertPrompt *photoPrompt =  [[DDAlertPrompt alloc] initWithTitle:@"请输入照片的名称与备注" delegate:self cancelButtonTitle:@"取消" otherButtonTitle:@"确定"];
	[photoPrompt show];
	[photoPrompt release];
        
}

-(void)showImgFile:(NSString*)filePath{
    ShowImgController *controller = [[ShowImgController alloc] initWithNibName:@"ShowImgController" bundle:nil];
    controller.imgPath = filePath;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

- (void)didPresentAlertView:(UIAlertView *)alertView {
	if ([alertView isKindOfClass:[DDAlertPrompt class]]) {
		DDAlertPrompt *photoPrompt = (DDAlertPrompt *)alertView;
		[photoPrompt.nameField becomeFirstResponder];
		[photoPrompt setNeedsLayout];
	}
}

-(void)takePhoto:(id)sender{
    UIBarButtonItem *aItem = (UIBarButtonItem *)sender;
    if(photopicker == nil){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        self.photopicker = picker;
        [picker release];
    }
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        
        photopicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:photopicker animated:YES];
        
    }
    else{
        photopicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        popController = [[UIPopoverController alloc] initWithContentViewController:photopicker];
        
    [popController presentPopoverFromBarButtonItem:aItem  permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"附件照片";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.photoDir = [NSString stringWithFormat:@"%@/photofiles",[paths objectAtIndex:0]];

    
    NSFileManager *fm = [NSFileManager defaultManager ];
    BOOL isDir;
    if(![fm fileExistsAtPath:photoDir isDirectory:&isDir])
        [fm createDirectoryAtPath:photoDir withIntermediateDirectories:NO attributes:nil error:nil];
    else
        [self deletePhotosInFolder];
    
    UIBarButtonItem *aItem = [[UIBarButtonItem alloc] initWithTitle:@"拍照" style:UIBarButtonItemStylePlain
															 target:self
															 action:@selector(takePhoto:)];
	self.navigationItem.rightBarButtonItem = aItem;

    //[self takePhoto:aItem];
    [aItem release];
    
}

- (void)saveImage:(UIImage *)image {
    static int i = 0;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentTime = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    [dateFormatter release];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@yjb%d.png",[self photoDir],currentTime,i++];
    
   NSData *compressData  = UIImagePNGRepresentation(image);
    
    CGFloat compress =  (1024*600*1.0)/[compressData length]; //
    if(compress > 1)compress = 1.0;
    NSData *imgData   = UIImageJPEGRepresentation(image,compress);
    [imgData writeToFile:filePath atomically:YES];    
    [self refreshPhotosInScroll];
    
}

#pragma mark –
#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissModalViewControllerAnimated:YES];
    UIImage *image = [[info objectForKey:UIImagePickerControllerEditedImage] retain];
    [self performSelector:@selector(saveImage:)
               withObject:image
               afterDelay:0.5];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark NSXMLParser Delegate

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	
	if( [elementName isEqualToString:@"UploadAttach_Log_UDIDResult"])
	{
		self.currentdata = [[[NSMutableString alloc] init] autorelease];
        
	}	
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (currentdata)
		self.currentdata = [NSMutableString stringWithString:string];
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
	if(currentdata && [elementName isEqualToString:@"UploadAttach_Log_UDIDResult"])
	{
        NSArray *subViews = [self.view subviews];
        for (UIView *childView in subViews) {
            if ([childView isKindOfClass:[UIButton class]]) {
                childView.userInteractionEnabled = YES;
            }
        }

		if([currentdata isEqualToString:@"true"])
		{
            UIAlertView *alert = [[UIAlertView alloc]
								  initWithTitle:@"提示"
								  message:@"成功上传照片!"  delegate:nil
								  cancelButtonTitle:@"确定"
								  otherButtonTitles:nil];
           
			[alert show];
			[alert release];
            
            NSFileManager *fm = [NSFileManager defaultManager];
            [fm removeItemAtPath:curUploadFile error:nil];
            [self refreshPhotosInScroll];

		}
        else {
    
			UIAlertView *alert = [[UIAlertView alloc]
								  initWithTitle:@"提示"
								  message:@"上传照片失败！"  delegate:nil
								  cancelButtonTitle:@"确定"
								  otherButtonTitles:nil];
            [[[alert subviews] objectAtIndex:2] setBackgroundColor:[UIColor colorWithRed:0.5 green:0.0f blue:0.0f alpha:1.0f]];
			[alert show];
			[alert release];
            
		}
	}
}

-(void)dealloc{
    [scrollView release];
    [photoDir release];
    [xczfbh release];
    [curUploadFile release];
    [popController release];
    [photopicker release];
    [attachSource release];
    [webService release];
    [currentdata release];
    [nameField release];
    [remarkField release];
    [myProgressView release];
    [super dealloc];
}

@end
