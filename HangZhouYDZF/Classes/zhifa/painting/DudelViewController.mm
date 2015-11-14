//
//  DudelViewController.m
//  Dudel
//
//  Created by JN on 2/23/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "DudelViewController.h"
#import "DudelView.h"
#import "WebServiceHelper.h"

#import "EraserTool.h"
#import "TextTool.h"
#import "LoginViewController.h"
#import "OMGToast.h"

extern UserInfo *g_logedUserInfo;
#import "GMEPS_HZAppDelegate.h"
#import "GTMBase64.h"
#import "GUIDGenerator.h"
extern GMEPS_HZAppDelegate *g_appDelegate;
#import <QuartzCore/QuartzCore.h>
#import "ImgDrawingInfo.h"
#import "TextDrawingInfo.h"
#import "SharedInformations.h"
#import "DBHelper.h"
#import "BackgroundDrawingInfo.h"
#import "ArrowLine.h"
#define T_XCZF_KYT @"T_YDZF_KYT"
//保存图片的名称，方便获取图片
@implementation UIMyImageView

@synthesize name;

@end

@implementation DudelViewController
@synthesize currentTool, fillColor, strokeColor,font, strokeWidth,commitBar;
@synthesize WRYBH,WRYMC,iconsAry,textInfoAry;
@synthesize mapListController,popMapListController;
@synthesize xczfbh,flag;
@synthesize popGraphToolsController,popController;
@synthesize textButton,eraserButton,redoButton,pensButton,iconsButton,undoButton;
@synthesize backPosButton,clearButton,moveHandButton,moveHandLabel;
@synthesize dicLocation;
@synthesize imName;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}


-(void)changeBtnImageStatus:(NSInteger)tagId{
    static int lastPressedBtn = 0;
    if(lastPressedBtn == tagId)return;
    UIButton *btn = nil;
    NSString *imageName = nil;
    switch (lastPressedBtn) {
        case 0:
            btn = pensButton;
            imageName = @"pens.png";
            break;
        case 1:
            btn = iconsButton;
            imageName = @"customicons.png";
            break;
        case 2:
            btn = textButton;
            imageName = @"inserttext.png";
            break;
        case 3:
            btn = eraserButton;
            imageName = @"eraser.png";
            break;
        case 4:
            btn = undoButton;
            imageName = @"undo.png";
            break;
        case 5:
            btn = redoButton;
            imageName = @"redo.png";
            break;
        case 6:
            btn = backPosButton;
            imageName = @"backpos.png";
            break;
        case 7:
            btn = clearButton;
            imageName = @"clear.png";
            break;
        case 8:
            btn = moveHandButton;
            imageName = @"movehand.png";
            break;
        default:
            break;
    }
    lastPressedBtn = tagId;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
}


- (void)setCurrentTool:(id <Tool>)t {
  [currentTool deactivate];
  if (t != currentTool) {
    [currentTool release];
    currentTool = [t retain];
    currentTool.delegate = self;
    //[self deselectAllToolButtons];
  }
    //isMobile = YES;
  //[currentTool activate];
  //self.strokeColor = [UIColor blackColor];
  [dudelView setNeedsDisplay];
}


- (IBAction)touchTextItem:(id)sender{
    if (isCanMove == NO) {
    self.strokeColor = [UIColor blackColor];
    self.currentTool = [TextTool sharedTextTool];
	[textButton setImage:[UIImage imageNamed:@"inserttext_highlighted.png"] forState:UIControlStateNormal];
    [self changeBtnImageStatus:textButton.tag];
    }
}

- (IBAction)touchEraserItem:(id)sender{
   if (isCanMove == NO) {
	self.strokeColor = [UIColor whiteColor];
	self.currentTool = [EraserTool sharedEraserTool];
    [eraserButton setImage:[UIImage imageNamed:@"eraser_highlighted.png"] forState:UIControlStateNormal];
     [self changeBtnImageStatus:eraserButton.tag];
   }
}

- (IBAction)touchClearAllItem:(id)sender{
    alertType = ALERT_REASEMAP;
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"提示" 
                          message:@"您要清空画布吗?" 
                          delegate:self 
                          cancelButtonTitle:@"确定" 
                          otherButtonTitles:@"取消",nil];
    [alert show];
    [alert release];	
    [clearButton setImage:[UIImage imageNamed:@"clear_highlighted.png"] forState:UIControlStateNormal];
    [self changeBtnImageStatus:clearButton.tag];

}

//手势缩放
- (void)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer
{
    
    //[self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    UIView *big = [gestureRecognizer view];
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        if (big.tag == 101) {
            if (isCanMove == NO) {
                [gestureRecognizer view].transform = CGAffineTransformScale([gestureRecognizer view].transform, 1, 1);
            }
            else{
                [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
                [gestureRecognizer setScale:1];
                
            }

        }
        else
        {
            [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
            [gestureRecognizer setScale:1];
            
        }
        
    }
}


-(void)Zoom:(UIView*)sender 
{
    UIPinchGestureRecognizer *pinchGesture1 = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scalePiece:)];
    //[pinchGesture setDelegate:self];
    [sender addGestureRecognizer:pinchGesture1];
    [pinchGesture1 release];
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        if ([toModifyView isKindOfClass:[UIMyImageView class]])
        {
             toModifyView.transform = CGAffineTransformScale(toModifyView.transform, 1.2, 1.2);
        }
        else
        {
            UITextView * curTextView = (UITextView*)toModifyView;
            CGFloat aFontSize = curTextView.font.pointSize + 3;//变化后字体大 
            
            CGFloat Factor = aFontSize/curTextView.font.pointSize;
            CGRect oldRect = curTextView.frame;
            CGRect newRect = oldRect;
            newRect.size.width *= Factor;
            newRect.size.height *= Factor;
            curTextView.frame = newRect;
            curTextView.font = [UIFont systemFontOfSize:aFontSize];
            
        }
         toModifyView.layer.borderWidth=0;       

    }
    else if(buttonIndex == 1)
    {
        if ([toModifyView isKindOfClass:[UIMyImageView class]])
        {
            toModifyView.transform = CGAffineTransformScale(toModifyView.transform, 0.8, 0.8);
        }
        else
        {
            UITextView * curTextView = (UITextView*)toModifyView;
            
            
            CGFloat oldFontSize = curTextView.font.pointSize;//开始前字体大小
            CGFloat newFontSize = oldFontSize - 3;
            
            CGFloat Factor = newFontSize/oldFontSize;
            CGRect oldRect = curTextView.frame;
            CGRect newRect = oldRect;
            newRect.size.width *= Factor;
            newRect.size.width = newRect.size.width+3;
            newRect.size.height *= Factor;
            //newRect.size.height = InputField.contentSize.height;
            curTextView.frame = newRect;
            curTextView.font = [UIFont systemFontOfSize:newFontSize];
   
        }
        toModifyView.layer.borderWidth=0;
        
    }
    else if(buttonIndex == 2)
    {

        NSString *archiverPath = [[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"tmpCopyArchivePath.plist"] retain];
        ////NSLog(@"archiverPath : %@", archiverPath);
        
        BOOL isOK = [NSKeyedArchiver archiveRootObject:toModifyView toFile:archiverPath];
        if (isOK) {
           // //NSLog(@"archiver success");
        }
        UIView *copyView = (UIView*)[NSKeyedUnarchiver unarchiveObjectWithFile:archiverPath];
        if (copyView) {
            copyView.center = CGPointMake(toModifyView.center.x + 30, toModifyView.center.y + 30);
            
            if ([toModifyView isKindOfClass:[UIMyImageView class]]) {
                UIMyImageView *myImage = (UIMyImageView*)toModifyView;
                UIMyImageView *myImage1 = (UIMyImageView*)copyView;
                myImage1.name = myImage.name;
                [iconsAry addObject:myImage1];
            }
            else
                [textInfoAry addObject:copyView];
            [dudelView addSubview:copyView];
        }
        [archiverPath release];
        toModifyView.layer.borderWidth=0;
    }
    else if (buttonIndex == 3) {
        if (toModifyType == IMG_COMPONET) {
            [toModifyView removeFromSuperview];
            [iconsAry removeObject:toModifyView];
            toModifyView = nil;
        }
        else if (toModifyType == LABEL_COMPONET){
            [toModifyView removeFromSuperview];
            [textInfoAry removeObject:toModifyView];
            toModifyView = nil;
        }
        
    }
    else if(buttonIndex == 4)
    {
        UITextView * curTextView = (UITextView*)toModifyView;
        curTextView.userInteractionEnabled = YES;
        curTextView.editable = YES;
        [curTextView becomeFirstResponder];
        
    }
        
}

-(void)toModifyViewPressed:(id)sender{
    UIActionSheet *sheet;
    UIView *aView = (UIView *)sender;
    if ([sender isKindOfClass:[UIMyImageView class]])
    {
        sheet = [[ UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"放大",@"缩小",@"复制",@"删除",nil];
    }
    else
    {
        UITextView * curTextView = (UITextView*)toModifyView;
        sheet = [[ UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"放大",@"缩小",@"复制",@"删除",@"编辑",nil];
        curTextView.delegate = self;
        
    }
    [sheet showFromRect:aView.frame inView:dudelView animated:YES];
    [sheet release];
    toModifyView = aView;
}



-(void)selectedItemImageName:(NSString*)imgName{
    [self setCurrentTool:nil];//去掉正在使用的图形
    
    UIMyImageView *imgView = [[UIMyImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
    imgView.name = imgName;
    [dudelView addSubview:imgView];
    imgView.userInteractionEnabled = YES;
    imgView.tag = 1;
    imgView.center = self.view.center;
    [self Zoom:imgView];//图片缩放
    [iconsAry addObject:imgView];
    //[dicName setObject:imgName forKey:imgView];
    
    [imgView release];
    
    [popController dismissPopoverAnimated:YES];
}


-(void)mobileDrawing:(id)sender
{
    
    if (isCanMove == NO) {
        [moveHandLabel setText:@"关闭手势"];
        [moveHandButton setImage:[UIImage imageNamed:@"movehand_highlighted.png"] forState:UIControlStateNormal];
    }
    else{
        [moveHandLabel setText:@"开启手势"];
        [moveHandButton setImage:[UIImage imageNamed:@"movehand.png"] forState:UIControlStateNormal];
    }   
    isCanMove = !isCanMove;
    [self setCurrentTool:nil];//去掉正在使用的图形
    
    [self changeBtnImageStatus:moveHandButton.tag];
}

-(void)returnSelectedTool:(id <Tool>)aTool{
    [self setCurrentTool:aTool];
    self.strokeColor = [UIColor blackColor];
    [popGraphToolsController dismissPopoverAnimated:YES];
}


-(IBAction)touchTools:(id)sender{
    
    if (isCanMove == YES) return;
    UIButton *btn = (UIButton*)sender;
    [pensButton setImage:[UIImage imageNamed:@"pens_highlighted.png"] forState:UIControlStateNormal];
    [self changeBtnImageStatus:btn.tag];
    if (popGraphToolsController == nil) {
        UIGraphicToolsController *toolsViewController = [[[UIGraphicToolsController alloc] initWithNibName:@"UIGraphicToolsController" bundle:nil] autorelease]; 
        toolsViewController.delegate = self;
        self.popGraphToolsController = [[[UIPopoverController alloc] initWithContentViewController:
                                         toolsViewController] autorelease];
        
    }
    [popController dismissPopoverAnimated:YES];
    [popGraphToolsController presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

- (IBAction)touchImageItem:(id)sender{
    UIButton *btn = (UIButton*)sender;
    
    [iconsButton setImage:[UIImage imageNamed:@"customicons_highlighted.png"] forState:UIControlStateNormal];
    [self changeBtnImageStatus:btn.tag];
    
    if (popController == nil) {
        CustomIconsViewController *iconsViewController = [[[CustomIconsViewController alloc] initWithNibName:@"CustomIconsViewController" bundle:nil] autorelease]; 
        iconsViewController.delegate = self;
        self.popController = [[[UIPopoverController alloc] initWithContentViewController:
                               iconsViewController] autorelease];
        
        
    }
    [popGraphToolsController dismissPopoverAnimated:YES];
    [popController presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
}

- (IBAction)touchUndoItem:(id)sender{//撤销
    
    UIButton *btn = (UIButton*)sender;
    [undoButton setImage:[UIImage imageNamed:@"undo_highlighted.png"] forState:UIControlStateNormal];
    [self changeBtnImageStatus:btn.tag];
    
    if ([dudelView.drawables count] > 0) {
        if (deletedDrawInfoAry == nil) {
            deletedDrawInfoAry = [[NSMutableArray alloc ] initWithCapacity:10];
        }
        id lastDeletedDrawInfo =[[dudelView.drawables lastObject] retain];
        [deletedDrawInfoAry addObject:lastDeletedDrawInfo];
        //[currentTool deleteLastPoint:YES];
        [dudelView.drawables removeLastObject];
        [lastDeletedDrawInfo release];
        [dudelView setNeedsDisplay];
        
    }
    
}

- (IBAction)touchRedoItem:(id)sender{//重做
    UIButton *btn = (UIButton*)sender;
    [redoButton setImage:[UIImage imageNamed:@"redo_highlighted.png"] forState:UIControlStateNormal];
    [self changeBtnImageStatus:btn.tag];
    
    if (deletedDrawInfoAry && [deletedDrawInfoAry count]>0) {
        id lastDeletedDrawInfo =[[deletedDrawInfoAry lastObject] retain];
        [dudelView.drawables addObject:lastDeletedDrawInfo];
        [deletedDrawInfoAry removeLastObject];
        
        [lastDeletedDrawInfo release];
        [dudelView setNeedsDisplay];
    }
    
}

-(void)downloadHisMap:(NSString*)sender flag:(NSString*)value{
    
    iWebserviceType = WEBSERVICE_Download;
    NSString* params =[WebServiceHelper createParametersWithKey:@"bh"
                                                          value:sender,@"flag",flag, nil];
    
    NSString *URL = [NSString  stringWithFormat: PHOTO_URL,
                     g_appDelegate.ServerIP];
    WebServiceHelper *webService = [[[WebServiceHelper alloc] initWithUrl:URL
                                                                   method:@"GetEnforcementLedgerImage"
                                     view:self.view
                                                                nameSpace:KSoapNameSpace
                                                               parameters:params 
                                                                 delegate:self] autorelease];	
    [webService run];
    [popMapListController dismissPopoverAnimated:YES];}


-(void)returnSelectedMap:(NSString*)strMap flag:(NSString *)fa
{
    if ([strMap isEqualToString:@"取消"]) {
        [popMapListController dismissPopoverAnimated:YES];
        return;
    }
    self.xczfbh = strMap;
    self.flag = fa;
    alertType = ALERT_RequestHisMap;
    UIAlertView *alert = [[UIAlertView alloc] 
                            initWithTitle:@"提示" 
                            message:@"获取的历史勘验图将会覆盖已绘的图片，还需获取吗？"  
                            delegate:self 
                            cancelButtonTitle:@"确定" 
                            otherButtonTitles:@"取消",nil];
    [alert show];
    [alert release];
        

}

-(void)Warning
{
    
}


- (IBAction)touchHisImageItem:(id)sender{
    MapListControllerView *tmpController = 
    [[MapListControllerView alloc] initWithStyle:UITableViewStyleGrouped];

    tmpController.contentSizeForViewInPopover = CGSizeMake(700, 400);
	self.mapListController = tmpController;
    self.mapListController.delegate = self;
    [tmpController release];
    
	mapListController.QYBH = WRYBH;
    mapListController.QYMC = WRYMC;
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"MapList" object:nil];
	UINavigationController *tmpNav = [[UINavigationController alloc] initWithRootViewController:self.mapListController];
	
	UIPopoverController *tmpPopover = [[UIPopoverController alloc] initWithContentViewController:tmpNav];
	self.popMapListController = tmpPopover;
    [tmpPopover release];
	[tmpNav release];

    
	[mapListController.tableView reloadData];
	[self.popMapListController presentPopoverFromBarButtonItem:sender 
							   permittedArrowDirections:UIPopoverArrowDirectionUp
											   animated:YES];
    
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UIView * curTextView = (UIView*)toModifyView;
    [curTextView resignFirstResponder];
    if (isSwitch == YES) {
        isTwoFinger = YES;
        [dudelView setMultipleTouchEnabled:YES];
    }
    else{
        isTwoFinger = NO;
        //[dudelView setMultipleTouchEnabled:NO];
    }
    isSwitch = YES;
    if ([touches count]==2) {
        if (isTwoFinger == YES) {
            [currentTool touchesEnded:touches withEvent:event];
            [dudelView setNeedsDisplay];
        }
        return;
    }
    if (isTwoFinger == NO) {
        if (isCanMove == YES) {
            UITouch *touch = [touches anyObject];
            CGPoint pt = [touch locationInView:self.view];
            movePt =  pt;
            if (CGRectContainsPoint(dudelView.frame, pt)) {
                isTouchIn = YES;
            }
        }
        
        
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:dudelView];
        for (UIMyImageView *icon in iconsAry) {
            if (CGRectContainsPoint(icon.frame ,location)) {
                toModifyView = icon;
                toModifyView.layer.borderColor = [UIColor orangeColor].CGColor;  //textview边框颜色
                toModifyView.layer.borderWidth = 2;
                toModifyType = IMG_COMPONET;
                if ([touch tapCount] >=2 ) {
                    
                    [self toModifyViewPressed:toModifyView];
                    
                }
                break;
            }
        }
        if (toModifyView == nil) {
            for(UITextView * aLabel in textInfoAry ) {
                if (CGRectContainsPoint(aLabel.frame ,location)) {
                    toModifyView = aLabel;
                    toModifyView.layer.borderColor = [UIColor orangeColor].CGColor;  //textview边框颜色
                    toModifyView.layer.borderWidth = 2;
                    toModifyType = LABEL_COMPONET;
                    if ([touch tapCount] >=2 ) {
                        
                        [self toModifyViewPressed:toModifyView];
                        
                    }
                    break;
                }
            }
        }

        [currentTool touchesBegan:touches withEvent:event];
        [dudelView setNeedsDisplay];
        
    }
    
    //isTwoFinger = YES;
          
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count]==2) {
        if (isTwoFinger == YES) {
            [currentTool touchesEnded:touches withEvent:event];
            [dudelView setNeedsDisplay];
        }
        isSwitch = NO;
        isTouchIn = NO;
        return;
    }
    if (isTwoFinger == NO) {
        [dudelView setMultipleTouchEnabled:YES];
        if ([touches count]==1) {
            [currentTool touchesCancelled:touches withEvent:event];
            [currentTool touchesEnded:touches withEvent:event];
            [dudelView setNeedsDisplay];
            isSwitch = NO;
            isTouchIn = NO;
        }
    }
    else
    {
        [currentTool touchesEnded:touches withEvent:event];
        [dudelView setNeedsDisplay];
        isSwitch = NO;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count]==2) {
        isSwitch = NO;
        isTouchIn = NO;
        return;
    }
    if (isTwoFinger == NO) {
        if (toModifyView != nil ) {
            toModifyView.layer.borderWidth = 0;
            toModifyView = nil;
        }
        else{
            [currentTool touchesEnded:touches withEvent:event];
            [dudelView setNeedsDisplay];
        }
        isTouchIn = NO;
        isSwitch = NO;
    }
    else
        isSwitch = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count]==2) {
        if (isTwoFinger == YES) {
            [currentTool touchesEnded:touches withEvent:event];
            [dudelView setNeedsDisplay];
        }
        return;
    }
    if (isTwoFinger == NO) {
        //isSwitch = YES;
        if (isTouchIn == YES && isCanMove == YES) {
            UITouch *touch = [touches anyObject];
            CGPoint pt = [touch locationInView:self.view];
            
            dudelView.center = CGPointMake(dudelView.center.x + (pt.x - movePt.x), dudelView.center.y + (pt.y - movePt.y));
            
            movePt = pt;
        }
        
        
        if (toModifyView != nil ) {
            UITouch *touch = [[event allTouches] anyObject];
            //UITouch *touch =  [[event touchesForView:dudelView]anyObject];
            CGPoint location = [touch locationInView:dudelView];
            toModifyView.center = location;
        }
        else{
            [currentTool touchesMoved:touches withEvent:event];
            [dudelView setNeedsDisplay];     
        }
        //isSwitch = NO;
    }
    
        
}


#pragma mark ToolDelegate

- (void)addDrawable:(id <Drawable>)d {
  [dudelView.drawables addObject:d];
  [dudelView setNeedsDisplay];
}

- (void) addTextLabel:(UITextView*)aLabel{
    if (textInfoAry == nil) {
        textInfoAry = [[NSMutableArray alloc] initWithCapacity:10];
    }
    //aLabel.userInteractionEnabled = YES;
    aLabel.tag = 1;
    [self Zoom:aLabel];
    [dudelView addSubview:aLabel];
    [textInfoAry addObject:aLabel];
    
    
    //InputField = [aLabel copy];
    self.currentTool = nil;
}

- (UIView *)viewForUseWithTool:(id <Tool>)t {
  return dudelView;
}

- (UIView *)viewForOwner:(id <Tool>)t{
    return self.view;
}

#pragma mark DudelViewDelegate
- (void)drawTemporary {
  [self.currentTool drawTemporary];
}

-(void)returnSites:(NSDictionary*)values source:(NSInteger)type{
	
	//NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//[defaults setObject:[values objectForKey:@"WRYBH"] forKey:KCurrentPolutionSite];	
	//NSString *currentCaseNo = [defaults stringForKey:KCurrentPolutionSite];
	if (values == nil) {
		[self.navigationController popViewControllerAnimated:YES];
	}
	else {
        if ([values count] == 1) {
            [btnTitleView setTitle:[values objectForKey:@"WRYMC"] forState:UIControlStateNormal];
            self.WRYMC = [values objectForKey:@"WRYMC"];
            self.WRYBH = @"";
            [dicLocation removeAllObjects];
            
        }
        else
        {
            self.WRYBH  = [values objectForKey:@"WRYBH"];
            self.WRYMC = [values objectForKey:@"WRYMC"];
            [dicLocation setObject:[values objectForKey:@"JDD"] forKey:@"JDD"];
            [dicLocation setObject:[values objectForKey:@"JDF"] forKey:@"JDF"];
            [dicLocation setObject:[values objectForKey:@"JDM"] forKey:@"JDM"];
            [dicLocation setObject:[values objectForKey:@"WDD"] forKey:@"WDD"];
            [dicLocation setObject:[values objectForKey:@"WDF"] forKey:@"WDF"];
            [dicLocation setObject:[values objectForKey:@"WDM"] forKey:@"WDM"];
            [btnTitleView setTitle:WRYMC forState:UIControlStateNormal];
        }
        [self getSaveInfo];
	}
    
}

-(void)sureCommitBilu:(id)sender
{
    UIGraphicsBeginImageContext(dudelView.bounds.size);
    for (UIMyImageView *icon in iconsAry) {
        ImgDrawingInfo *info = [[ImgDrawingInfo alloc] initWithLocation:icon.center andSize:icon.frame.size andImage:icon.image];
        [self addDrawable:info];
        [info release];
    }
    [iconsAry removeAllObjects];
    
    for (UITextView *aLabel in textInfoAry) {
        
        TextDrawingInfo *info = [TextDrawingInfo textDrawingInfoWithPath:[UIBezierPath bezierPathWithRect:aLabel.frame] text:aLabel.text strokeColor:aLabel.textColor font:aLabel.font];
        [self addDrawable:info];
    }
    [textInfoAry removeAllObjects];
    
    [dudelView drawRect:dudelView.bounds];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
	NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/现场勘验图.jpg"]; 
	// Write image to PNG  
	[UIImageJPEGRepresentation(image,0.7) writeToFile:jpgPath atomically:YES];
    
  
    // NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/现场勘验图.jpg"]; 
	NSData *origData = [NSData dataWithContentsOfFile:jpgPath];
	
	NSData *encodedData = [GTMBase64 encodeData:origData];
	NSString *fileData = [[NSString alloc] initWithData:encodedData encoding: NSUTF8StringEncoding];
    ////NSLog(@"len = %d",[fileData length]);
    NSString *zfbh = [[DBHelper sharedInstance] getXCZFBHByMc:self.WRYMC];
    NSString* params = [WebServiceHelper createParametersWithKey:@"QYID"
														   value:WRYBH,@"QYMC",WRYMC,
                        @"CQFBUT",fileData,@"BH",zfbh,@"CJR",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    //保存现场执法编号
	[[DBHelper sharedInstance] saveXCZFBH:zfbh Wrymc:self.WRYMC TableName:T_XCZF_KYT];
    NSString *URL = [NSString  stringWithFormat: KATTACH_URL,
                     g_appDelegate.ServerIP];
    iWebserviceType = WEBSERVICE_Commit;
	WebServiceHelper *webService = [[[WebServiceHelper alloc] initWithUrl:URL
                                                                   method:@"ProcessQueueCQFBT_Log_UDID"
                                     view:self.view
                                                                nameSpace:KSoapNameSpace
                                                               parameters:params 
                                                                 delegate:self] autorelease];	
	[webService run];
    [fileData release];
    self.commitBar.enabled=NO;
    //[currentTool activate];//自动连接清除所有节点
    SharedInformations *info = [SharedInformations sharedSharedInformations];
	[info.dicStoreTempData removeAllObjects];
}

-(void)sureSelectPolutionSrc{
    UISearchSitesController *controller = [[UISearchSitesController alloc] initWithNibName:@"UISearchSitesController" bundle:nil];
    [controller setDelegate:self];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    nav.modalPresentationStyle =  UIModalPresentationFormSheet;
    [self presentModalViewController:nav animated:YES];
    nav.view.superview.frame = CGRectMake(30, 100, 700, 700);
    // nav.view.superview.center = self.view.center;
    
    [controller release];
    [nav release];
}


-(void)selectPolutionSrc:(id)sender{
	
    if ([dudelView.drawables count] != 0||[iconsAry count]!=0||[textInfoAry count]!=0) {
        alertType = ALERT_REASEMAP;
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"提示" 
                              message:@"您要清空画布吗？"  
                              delegate:self
                              cancelButtonTitle:@"确定" 
                              otherButtonTitles:@"取消",nil];
        [alert show];
        [alert release];
        
    }
	
    [self sureSelectPolutionSrc];	
}

-(void)backItemPressed{

    if(alertType == Record_SaveLocal)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    alertType = COMMIT_BILU_ALERT;
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"提示"
                          message:@"您输入的数据还未提交到服务器，请选择操作"
                          delegate:self
                          cancelButtonTitle:@"暂存数据"
                          otherButtonTitles:@"丢弃数据",nil];
    alert.alpha = 1.0f;
    [alert show];
    [alert release];
    return;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

-(IBAction)Weighing:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    [backPosButton setImage:[UIImage imageNamed:@"backpos_highlighted.png"] forState:UIControlStateNormal];
    [self changeBtnImageStatus:btn.tag];
    
    CGRect Original ;
    Original.origin.x = 0.0;
    Original.origin.y = 0.0;
    Original.size.width = dudelView.frame.size.width;
    Original.size.height = dudelView.frame.size.height;
    dudelView.frame = Original;
    dudelView.center = centerPoint;
}

-(void)getSaveInfo{
    NSDictionary *allDate = [TemporarySave returnPlistDate:T_XCZF_KYT qymc:WRYMC];
    //UITextView *tmpView;
    if (allDate!=nil) {
        NSDictionary *dicTextView = [allDate objectForKey:@"TextView"];
        NSDictionary *dicImageView = [allDate objectForKey:@"imageView"];
        if (dicTextView) {
            for (int i = 0; i < [[dicTextView allKeys] count]; i++) {
                NSDictionary *dicTextView1 = [[dicTextView allValues] objectAtIndex:i];
                UITextView *tmpView = [[UITextView alloc] initWithFrame:CGRectFromString([dicTextView1 objectForKey:@"frame"])];
                tmpView.text = [dicTextView1 objectForKey:@"text"];
                float point = [[dicTextView1 objectForKey:@"font_point"] floatValue];
                tmpView.font  = [UIFont systemFontOfSize:(CGFloat)point];
                //tmpView.font.fontName = [dicPfgx1 objectForKey:@"font_point"];
                tmpView.backgroundColor = [UIColor whiteColor];
                [tmpView setContentMode:UIViewContentModeTop];
                tmpView.editable = NO;
                tmpView.scrollEnabled = NO;
                tmpView.userInteractionEnabled = NO;
                //tmpView.font = [dicPfgx1 objectForKey:@"font"];
                [dudelView.drawables addObject:tmpView];
                [dudelView addSubview:tmpView];
                [textInfoAry addObject:tmpView];
                [tmpView release];
                [dudelView setNeedsDisplay];
            }
        }
        if (dicImageView) {
            for (int i = 0; i < [[dicImageView allKeys] count]; i++){
                NSDictionary *dicImageView1 = [[dicImageView allValues] objectAtIndex:i];
                UIMyImageView *imgView = [[UIMyImageView alloc] initWithImage:[UIImage imageNamed:[dicImageView1 objectForKey:@"name"]]];
                imgView.name = [dicImageView1 objectForKey:@"name"];
                [dudelView addSubview:imgView];
                imgView.userInteractionEnabled = YES;
                imgView.tag = 1;
                imgView.frame = CGRectFromString([dicImageView1 objectForKey:@"frame"]);
                [self Zoom:imgView];//图片缩放
                [iconsAry addObject:imgView];
                
                [imgView release];

            }
        }
        //通过plist文件获取保存的数据，然后把数据写入到指定的文件
        NSData *data = [[allDate objectForKey:@"KYT"] dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        data = [GTMBase64 decodeData:data];
        if ([data length] <=0 ) {
            return;
        }
        NSString* tmpDirectory  = [NSHomeDirectory()
                                   stringByAppendingPathComponent:@"Documents/HistoryMap.jpg"];
        ////NSLog(@"%@",tmpDirectory);
        
        NSFileManager *manager = [NSFileManager defaultManager];
        if ([manager fileExistsAtPath: tmpDirectory])
            [manager removeItemAtPath:tmpDirectory error:NULL];
        
        NSURL *url = [NSURL fileURLWithPath:tmpDirectory];
        [data writeToURL:url atomically:NO];
        [dudelView.drawables removeAllObjects];
        dudelView.bDrawBgImage = YES;
        [dudelView setNeedsDisplay]; //该方法获取指定文件的数据并显示到画板上
    }
}

-(void)chooseTemplate{
    
    //把整个dudelView转为图片然后存到文件中，然后读取文件中的数据并保存
    UIGraphicsBeginImageContext(dudelView.bounds.size);
    //[textInfoAry removeAllObjects];
    
    [dudelView drawRect:dudelView.bounds];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
	NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/现场勘验图.jpg"];
	// Write image to PNG
	[UIImageJPEGRepresentation(image,0.7) writeToFile:jpgPath atomically:YES];
    NSData *origData = [NSData dataWithContentsOfFile:jpgPath];
	NSData *encodedData = [GTMBase64 encodeData:origData];
	NSString *fileData = [[NSString alloc] initWithData:encodedData encoding: NSUTF8StringEncoding];
     
    /******************************************/
    
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:zancunBilu];
    
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:plistPath isDirectory:NO];
    NSMutableDictionary *dictplist = [[NSMutableDictionary alloc] init];
    
    //定义第一个插件的属性
    NSMutableDictionary *plugin1 = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *plugin2 = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *plugin3 = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *plugin4 = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicName1 = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *dicImageView = [[NSMutableDictionary alloc]init];
    
    NSString *copyData = [fileData copy];
    [plugin1 setObject:copyData forKey:@"KYT"];
    [copyData release];
    [fileData release];
    
    
    //NSMutableArray *textAry = [NSMutableArray arrayWithCapacity:45];
    for (int i = 0; i < [textInfoAry count]; i++) {
        UITextView *tmpView = [textInfoAry objectAtIndex:i];
        if (tmpView.text==nil) tmpView.text = @"";
        NSString *frame = NSStringFromCGRect(tmpView.frame);
        float pFloat = (CGFloat)tmpView.font.pointSize;
        NSString *pointStr = [NSString stringWithFormat:@"%f",pFloat];
        
        [plugin4 setObject:tmpView.text forKey:@"text"];
        [plugin4 setObject:frame forKey:@"frame"];
        [plugin4 setObject:pointStr forKey:@"font_point"];
        [plugin4 setObject:tmpView.font.fontName forKey:@"font_name"];
        NSDictionary *copyPlugin4 = [plugin4 copy];
        [plugin3 setObject:copyPlugin4 forKey:[NSString stringWithFormat:@"%d",i]];
        [copyPlugin4 release];
        NSDictionary *copyPlugin3 = [plugin3 copy];
        [plugin1 setObject:copyPlugin3 forKey:@"TextView"];
        [copyPlugin3 release];
    }
    for (int i = 0; i < [iconsAry count]; i++){
        UIMyImageView *imageView = [iconsAry objectAtIndex:i];
        NSString *frame = NSStringFromCGRect(imageView.frame);
        [dicName1 setObject:imageView.name forKey:@"name"];
        [dicName1 setObject:frame forKey:@"frame"];
        NSDictionary *copyDictName1  = [dicName1 copy];
        [dicImageView setObject:copyDictName1 forKey:[NSString stringWithFormat:@"%d",i]];
        [copyDictName1 release];
        [plugin1 setObject:dicImageView forKey:@"imageView"];
    }
    //设置属性值
    if (isExist==YES) {
        dictplist = [dictplist initWithContentsOfFile:plistPath];
    }
    if ([dictplist objectForKey:T_XCZF_KYT]==nil) {
        [plugin2 setObject:plugin1 forKey:WRYMC];
        [dictplist setObject:plugin2 forKey:T_XCZF_KYT];
    }
    else{
        [[dictplist objectForKey:T_XCZF_KYT] setObject:plugin1 forKey:WRYMC];
    }
    
    //写入文件
    [dictplist writeToFile:plistPath atomically:YES];
    [dictplist release];
    [plugin1 release];
    [plugin2 release];
    [plugin3 release];
    [plugin4 release];
    [dicImageView release];
    [dicName1 release];
    //[self.navigationController popViewControllerAnimated:YES];
     
    if (g_appDelegate.isSave == NO) {
        alertType = Record_SaveLocal;
        [OMGToast showWithText:@"笔录已暂存在本地！" duration:1.0];
    }
    
}

-(void)returnMapImage:(UIImage *)image{
    
    [dudelView.drawables removeAllObjects];
    BackgroundDrawingInfo *info = [[BackgroundDrawingInfo alloc] initWithImage:image];
    [dudelView.drawables addObject:info];
    [info release];
    //[dudelView drawImage];
    [dudelView setNeedsDisplay];
     
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dudelView.userInteractionEnabled = YES;
    [dudelView setMultipleTouchEnabled:YES ];
    isTouchIn = NO;
    isCanMove = NO;
    isSwitch = NO;

    WRYBH = @"";
    WRYMC = @"";

    self.dicLocation = [[[NSMutableDictionary alloc] initWithCapacity:10] autorelease];
    self.iconsAry = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    self.textInfoAry = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    centerPoint = dudelView.center;
    dudelView.layer.borderColor = UIColor.grayColor.CGColor;
    dudelView.layer.borderWidth = 2;
    dudelView.tag = 101;
    [self Zoom:dudelView];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backItemPressed)];
    
    UIToolbar *tools2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    [tools2 setTintColor:[self.navigationController.navigationBar tintColor]]; 
	[tools2 setAlpha:[self.navigationController.navigationBar alpha]];
    
    NSMutableArray* buttons2 = [NSMutableArray arrayWithObjects:backButton, nil];
    
    [backButton release];
    
    [tools2 setItems:buttons2 animated:NO];
    
    UIBarButtonItem *myBItem2 = [[UIBarButtonItem alloc] initWithCustomView:tools2];
    self.navigationItem.leftBarButtonItem = myBItem2;
    [myBItem2 release];
    [tools2 release];
    
    btnTitleView = [[UIButton buttonWithType:UIButtonTypeRoundedRect ] retain];
    btnTitleView.tintColor = [UIColor lightGrayColor];
    btnTitleView.frame = CGRectMake(0, 0, 400, 35);
    [btnTitleView addTarget:self action:@selector(selectPolutionSrc:) forControlEvents:UIControlEventTouchUpInside];
    [btnTitleView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.navigationItem.titleView  = btnTitleView;
    
    self.fillColor = [UIColor clearColor];
    self.strokeColor = [UIColor blackColor];
    self.strokeWidth = 2.0;
    self.font = [UIFont systemFontOfSize:24.0];
     
    UIBarButtonItem *aItem = [[UIBarButtonItem alloc] initWithTitle:@"下载历史勘验图" style:UIBarButtonItemStyleDone target:self action:@selector(touchHisImageItem:)];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"暂存" style:UIBarButtonItemStyleDone target:self action:@selector(chooseTemplate)];
    
    UIBarButtonItem *aItem2 = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(sureCommitBilu:)];
    
    UIToolbar *tools1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
    [tools1 setTintColor:[self.navigationController.navigationBar tintColor]]; 
	[tools1 setAlpha:[self.navigationController.navigationBar alpha]]; 
    NSMutableArray* buttons1 = [[NSMutableArray alloc] initWithCapacity:8];
    [buttons1 addObject:aItem];
    [buttons1 addObject:saveItem];
    [buttons1 addObject:aItem2];
    
    
    [aItem release];
    [aItem2 release];
    [tools1 setItems:buttons1 animated:NO];
    [buttons1 release];
    
    UIBarButtonItem *myBItem1 = [[UIBarButtonItem alloc] initWithCustomView:tools1];
	self.navigationItem.rightBarButtonItem = myBItem1;
    [myBItem1 release]; 
	[tools1 release];
    
    [self selectPolutionSrc:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dudelview" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(update) name:@"dudelview" object:nil];
    //isClear = YES;
}

- (void)update
{
    [self chooseTemplate];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)dealloc {
    self.currentTool = nil;
    self.fillColor = nil;
    self.strokeColor = nil;
    [dicLocation release];
  //[currentTool deactivate];
  [super dealloc];
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    if (currentdata == nil) 
        currentdata = [[NSMutableString alloc] initWithCapacity:100];
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (currentdata) 
        [currentdata appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"bbb:%@",elementName);
    if (iWebserviceType == WEBSERVICE_Commit) {
        if(currentdata && [elementName isEqualToString:@"ProcessQueueCQFBT_Log_UDIDResult"])
        {
            
            if([currentdata isEqualToString:@"true"])
            {
                alertType = ALERT_CommitMap;
                UIAlertView *alert = [[UIAlertView alloc] 
                                      initWithTitle:@"提示" 
                                      message:@"数据已成功提交至服务器"  
                                      delegate:self 
                                      cancelButtonTitle:@"确定" 
                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
                //bCommited = YES;
                
            }
            else {
                //将delegate设置为nil
                UIAlertView *alert = [[UIAlertView alloc] 
                                      initWithTitle:@"错误" 
                                      message:@"提交数据到服务器失败！"  delegate:nil
                                      cancelButtonTitle:@"确定" 
                                      otherButtonTitles:nil];
                [[[alert subviews] objectAtIndex:2] setBackgroundColor:[UIColor colorWithRed:0.5 green:0.0f blue:0.0f alpha:1.0f]];
                [alert show];
                [alert release];
                self.commitBar.enabled=YES;
            }
            
        }
    }
    else{//ProcessQueueXZCQFBTResult
        if(currentdata && [elementName isEqualToString:@"GetEnforcementLedgerImageResult"])
        {
            NSData *data = [currentdata dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]; 
            data = [GTMBase64 decodeData:data]; 
            if ([data length] <=0 ) {
                return;
            }
            NSString* tmpDirectory  = [NSHomeDirectory() 
                                       stringByAppendingPathComponent:@"Documents/HistoryMap.jpg"];
            ////NSLog(@"%@",tmpDirectory);

            NSFileManager *manager = [NSFileManager defaultManager];
            if ([manager fileExistsAtPath: tmpDirectory]) 
                [manager removeItemAtPath:tmpDirectory error:NULL];
            
            NSURL *url = [NSURL fileURLWithPath:tmpDirectory];
            [data writeToURL:url atomically:NO];
            [dudelView.drawables removeAllObjects];
            dudelView.bDrawBgImage = YES;
            isMap = YES;
            [dudelView setNeedsDisplay];
            
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    if (isMap == NO&&iWebserviceType != WEBSERVICE_Commit) {
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"提示" 
                              message:@"该次执法未上传勘验图"  
                              delegate:nil 
                              cancelButtonTitle:@"确定" 
                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else
        isMap = NO;
    
    [currentdata release];
    currentdata = nil;
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ([alertView.message isEqualToString:@"数据已成功提交至服务器"]) {
        [TemporarySave deletePlistFileContent:T_XCZF_KYT qymc:WRYMC];
        [self.navigationController popViewControllerAnimated:YES];
    }
     
    if(alertType == ALERT_RequestHisMap){
        if (buttonIndex == 1) {
            return;//按取消按钮
        }
        else
        {
            [dudelView.drawables removeAllObjects];
            for (UIImageView *icon in iconsAry) {
                [icon removeFromSuperview];
                icon = nil;
            }
            [iconsAry removeAllObjects];
            for(UITextView *aLabel in textInfoAry) {
                    
                [aLabel removeFromSuperview];
                aLabel = nil;
            }
            [textInfoAry removeAllObjects];
            [dudelView setNeedsDisplay];
            [currentTool deactivate];
        
            [self downloadHisMap:self.xczfbh flag:self.flag];
        }
        
    }
    if(alertType == ALERT_REASEMAP){
        if (buttonIndex == 0) {
            [dudelView.drawables removeAllObjects];
            for (UIImageView *icon in iconsAry) {
                [icon removeFromSuperview];
                icon = nil;
            }
            [iconsAry removeAllObjects];
            for(UITextView *aLabel in textInfoAry) {
                
                [aLabel removeFromSuperview];
                aLabel = nil;
            }
            [textInfoAry removeAllObjects];
            [dudelView setNeedsDisplay];
            [currentTool deactivate];
        } 
    }
    else if (alertType == COMMIT_BILU_ALERT) {
        if (buttonIndex == 0) {
            [self chooseTemplate];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if(buttonIndex == 1){
            [self.navigationController popViewControllerAnimated:YES];
            //[currentTool activate];//自动连接清除所有节点
        }
    }
    
    else  if (alertType == ALERT_CHOOSENEWWRY){
        if (buttonIndex == 0) {
            [self sureSelectPolutionSrc];
        }
        
    }

}

-(void)textViewDidBeginEditing:(UITextView *)textView
{

}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    CGSize size = [textView.text sizeWithFont:textView.font constrainedToSize:textView.frame.size];
    CGRect rect = textView.frame;
    rect.size.height = textView.contentSize.height;
    rect.size.width = size.width+20;
    textView.frame = rect;
    //NSLog(@"%f %f",size.width,size.height);
    textView.userInteractionEnabled = NO;
    textView.layer.borderWidth=0; 

}


- (IBAction)rotateImg:(id)sender{
    static CGFloat i = 0;
    i+=0.1;
    dudelView.transform = CGAffineTransformMakeRotation(M_PI * i);
}



@end
