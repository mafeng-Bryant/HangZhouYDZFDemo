//
//  YingjiViewController.m
//  GMEPS_HZ
//
//  Created by 文 克远 on 13-4-15.
//
//

#import "YingjiViewController.h"
#import "YingjiFirstView.h"
#import "YingjiSecondView.h"
#import "GUIDGenerator.h"
#import "WryLocationVC.h"
#import "GGDMJConfig.h"
#import "DBHelper.h"
#import "UserInfo.h"
#import "OMGToast.h"
#import "GMEPS_HZAppDelegate.h"
#import "TakedPhotosViewController.h"

extern UserInfo *g_logedUserInfo;
extern GMEPS_HZAppDelegate *g_appDelegate;
@interface YingjiViewController ()
@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)YingjiFirstView *firstView;
@property(nonatomic,retain)YingjiSecondView *secondView;
@property(nonatomic,retain) UITextField *curField;
@property (nonatomic, retain) UIPopoverController *popController;
@property (nonatomic, copy) NSString *wryJD;
@property (nonatomic, copy) NSString *wryWD;
@property (nonatomic, copy) NSString *mgdJD;
@property (nonatomic, copy) NSString *mgdWD;

@end

@implementation YingjiViewController
@synthesize scrollView,firstView,secondView,curField,popController;

- (id)init
{
    self = [super init];
    if (self) {

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        // Custom initialization
        
    }
    return self;
}

-(void)dealloc{
    [_wryJD release];
    [_wryWD release];
    [_mgdJD release];
    [_mgdWD release];
    [scrollView release];
    [firstView release];
    [secondView release];
    [curField release];
    [popController release];
    
    [super dealloc];
}

-(void)addAllViews{
    YingjiFirstView *view1 =[[YingjiFirstView alloc] init];    
    [self.scrollView addSubview:view1];
    [view1.systemlastField addTarget:self action:@selector(touchFromDate:) forControlEvents:UIControlEventTouchDown];
    view1.systemlastField.delegate = self;
    [view1.systemEditTimeField addTarget:self action:@selector(touchFromDate:) forControlEvents:UIControlEventTouchDown];
    
    NSString *wryName    = [self.dicWryInfo objectForKey:@"DWMC"];
    NSString *wryLocate  = [self.dicWryInfo objectForKey:@"SSQYNR"];
    NSString *wryAddress = [self.dicWryInfo objectForKey:@"DWDZ"];
    NSString *wryJingDu  = [self.dicWryInfo objectForKey:@"WRYJD"];
    NSString *wryWeiDu   = [self.dicWryInfo objectForKey:@"WRYWD"];
    NSString *hbManager  = [self.dicWryInfo objectForKey:@"HBFZR"];
    NSString *hbNumber   = [self.dicWryInfo objectForKey:@"HBFZRDH"];
    
    if (wryJingDu) {
        NSArray *jdAry = [wryJingDu componentsSeparatedByString:@"°"];
        NSString *degree = [jdAry objectAtIndex:0];
        NSString *jingDu = [jdAry objectAtIndex:1];
        
        jdAry = [jingDu componentsSeparatedByString:@"′"];
        NSString *minute = [jdAry objectAtIndex:0];
        NSString *second = [jdAry objectAtIndex:1];
        
        self.wryJD = [NSString stringWithFormat:@"%f",[degree intValue]+[minute floatValue]/60+[second floatValue]/3600];
        self.mgdJD = [NSString stringWithFormat:@"%f",[degree intValue]+[minute floatValue]/60+[second floatValue]/3600];
         wryJingDu = [NSString stringWithFormat:@"%@°%@′%@″",degree,minute,second];
    }
    
    if (!wryJingDu) {
        wryJingDu = @"";
    }
    
    if (wryWeiDu) {
        NSArray *wdAry = [wryWeiDu componentsSeparatedByString:@"°"];
        NSString * degree = [wdAry objectAtIndex:0];
        NSString * jingDu = [wdAry objectAtIndex:1];
        
        wdAry = [jingDu componentsSeparatedByString:@"′"];
        NSString *minute = [wdAry objectAtIndex:0];
        NSString *second = [wdAry objectAtIndex:1];
        
        
        self.wryWD = [NSString stringWithFormat:@"%f",[degree intValue]+[minute floatValue]/60+[second floatValue]/3600];
        self.mgdWD = [NSString stringWithFormat:@"%f",[degree intValue]+[minute floatValue]/60+[second floatValue]/3600];
        wryWeiDu = [NSString stringWithFormat:@"%@°%@′%@″",degree,minute,second];
    }
    
    if (!wryWeiDu) {
        wryWeiDu = @"";
    }
    
    view1.systemEditTimeField.delegate = self;
    view1.dwmcField.text = wryName;
    view1.dwmcField.delegate = self;
    view1.dwLocate.text = wryLocate;
    view1.dwdzField.text = wryAddress;
    view1.dwdzField.delegate = self;
    view1.dwjingdu.text = wryJingDu;
    view1.dwjingdu.delegate = self;
    view1.dwweidu.text = wryWeiDu;
    view1.dwweidu.delegate= self;
    view1.huanbaozg.text = hbManager;
    view1.huanbaozg.delegate = self;
    view1.linkNumber.text = hbNumber;
    view1.linkNumber.delegate = self;
    view1.mgdJingdu.text = wryJingDu;
    view1.mgdJingdu.delegate = self;
    view1.mgdWeidu.text = wryWeiDu;
    view1.mgdWeidu.delegate = self;
    
    view1.dwLocate.delegate = self;
    [view1.dwLocate addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchDown];
    
    view1.fswryzField.delegate = self;
    [view1.fswryzField addTarget:self action:@selector(touchFactorField:) forControlEvents:UIControlEventTouchDown];
    
    view1.fqwryzField.delegate = self;
    [view1.fqwryzField addTarget:self action:@selector(touchFactorField:) forControlEvents:UIControlEventTouchDown];
    
    [view1.productCase addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [view1.emergencyPeople addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [view1.systemisExer addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    view1.fspfqxField.delegate = self;
    [view1.fspfqxField addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchDown];
    view1.mgdTypeField.delegate = self;
    [view1.mgdTypeField addTarget:self action:@selector(touchMgdTypeField:) forControlEvents:UIControlEventTouchDown];
    view1.systemisPrefectField.delegate = self;
     [view1.systemisPrefectField addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchDown];
    
    [view1.locateButton addTarget:self action:@selector(getLocation:) forControlEvents:UIControlEventTouchUpInside];
   
    
    self.firstView = view1;
    [view1 release];
    
    YingjiSecondView *view2 =[[YingjiSecondView alloc] init];
    view2.frame = CGRectMake(0, 1250,768 ,1600 );
    view2.wxpzjStorage1.delegate = self;
    [view2.wxpzjStorage1 addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchDown];
    
    view2.wxpzjStorage2.delegate = self;
    [view2.wxpzjStorage2 addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchDown];
    
    view2.wxpzjStorage3.delegate = self;
    [view2.wxpzjStorage3 addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchDown];
    
    view2.wxpzjType1.delegate = self;
    [view2.wxpzjType1 addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchDown];
    
    view2.wxpzjType2.delegate = self;
    [view2.wxpzjType2 addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchDown];
    
    view2.wxpzjType3.delegate = self;
    [view2.wxpzjType3 addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventTouchDown];
    
    [view2.yjccSegCtr addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    [view2.gqsffhSegCtr addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    [view2.yjcsffhSegCtr addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    [view2.yjfmsfwsSegCtr addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    [view2.gqfmSegCtr addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    [view2.ywflSegCtr addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
     [view2.fsclssSegCtr addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
     [view2.fqclssSegCtr addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
     [view2.ydqtSegCtr addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.secondView = view2;
  
    
    [self.scrollView addSubview:view2];
    [view2 release];

    [scrollView setContentSize:CGSizeMake(768, 1800+1250)];
    
}

-(void)dismissLocation {
    if (popController) {
        [popController dismissPopoverAnimated:YES];
    }
}


-(void)getLocation:(id)sender{
    UIButton *btn = (UIButton*)sender;
    WryLocationVC *location = [[WryLocationVC alloc] initWithNibName:@"WryLocationVC" bundle:nil];
    location.delegate =self;
    UIPopoverController *tmppopover = [[UIPopoverController alloc] initWithContentViewController:location];
    self.popController = tmppopover;
	[location release];
    [tmppopover release];
    
	[self.popController presentPopoverFromRect: btn.frame
                                        inView:self.firstView
                      permittedArrowDirections:UIPopoverArrowDirectionAny
                                      animated:YES];
    
}

-(void)beginEditing:(id)sender {
    UITextField *ctrl = (UITextField*)sender;
    self.curField = ctrl;
    CommenWordsViewController *tmpController = [[CommenWordsViewController alloc] initWithNibName:@"CommenWordsViewController" bundle:nil ];
	tmpController.contentSizeForViewInPopover = CGSizeMake(200, 350);
	tmpController.delegate = self;
    NSInteger section =  ctrl.tag /100;
    
    
    if(ctrl.tag == TAG_YJXS)
    {
        tmpController.contentSizeForViewInPopover = CGSizeMake(200, 350);
        tmpController.wordsAry = [GGDMJConfig getDMNRByDMJBH:@"SSQY"];
    }

    
    if (ctrl.tag == TAG_FSQX) {
        tmpController.contentSizeForViewInPopover = CGSizeMake(200, 132);
        tmpController.wordsAry = [NSArray arrayWithObjects:@"纳管",@"河道",@"其他", nil];
    }
   
    if (ctrl.tag == TAG_YJWS) {
        tmpController.contentSizeForViewInPopover = CGSizeMake(200, 220);
        tmpController.wordsAry = [NSArray arrayWithObjects:@"完善",@"较好",@"一般",@"差",@"无",nil];
    }
    
        
    if (ctrl.tag == TAG_WXCC || ctrl.tag == TAG_YJWZCC) {
        tmpController.contentSizeForViewInPopover = CGSizeMake(200, 176);
        tmpController.wordsAry = [NSArray arrayWithObjects:@"隔离",@"隔开",@"分离",@"露天",nil];
    }
    
    if (ctrl.tag == TAG_WXLB1 || ctrl.tag == TAG_WXLB2 || ctrl.tag == TAG_WXLB3 || ctrl.tag == TAG_WXLB4 || ctrl.tag == TAG_WXLB5 ) {
        tmpController.contentSizeForViewInPopover = CGSizeMake(200, 176);
        tmpController.wordsAry = [NSArray arrayWithObjects:@"原料",@"主产品",@"副产品",@"中间品",nil];
    }
    

    UIPopoverController *tmppopover = [[UIPopoverController alloc] initWithContentViewController:tmpController];
    self.popController = tmppopover;
	[tmpController release];
    [tmppopover release];
    
    if (section == 1) {
        [self.popController presentPopoverFromRect: ctrl.frame
                                            inView:firstView 
                          permittedArrowDirections:UIPopoverArrowDirectionAny
                                          animated:YES];
    }
    else {
        [self.popController presentPopoverFromRect: ctrl.frame
                                            inView:secondView
                          permittedArrowDirections:UIPopoverArrowDirectionAny
                                          animated:YES];
    }
}

- (void)touchFactorField:(id)sender {
    UITextField *ctrl = (UITextField*)sender;
    self.curField = ctrl;
    NSInteger tag = [sender tag];
    MutilSelectViewController *mgdTypeController = [[MutilSelectViewController alloc] initWithStyle:UITableViewStyleGrouped];
    mgdTypeController.contentSizeForViewInPopover = CGSizeMake(200, 264);
    mgdTypeController.msg = @"其他污染因子";
    mgdTypeController.delegate = self;
    
    
    if (tag == TAG_FQYZ) {
        NSMutableArray *factorAry = [NSMutableArray arrayWithArray: [[DBHelper sharedInstance] queryYinziByType:@"FQ"]];
        [factorAry addObject:@"其他"];
        mgdTypeController.aryItems = factorAry;
        mgdTypeController.multiStr = firstView.fqwryzField.text;
    }
    if (tag == TAG_FSYZ) {
        NSMutableArray *factorAry = [NSMutableArray arrayWithArray: [[DBHelper sharedInstance] queryYinziByType:@"FS"]];
        [factorAry addObject:@"其他"];
        mgdTypeController.aryItems =  factorAry;
        mgdTypeController.multiStr = firstView.fswryzField.text;
    }
    
       
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mgdTypeController];
    
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.popController = popover;
    
    [popover release];
    [nav release];
    [mgdTypeController release];
	
	[popController presentPopoverFromRect:[ctrl bounds] inView:ctrl permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


-(void)touchMgdTypeField:(id)sender{
    UITextField *ctrl = (UITextField*)sender;
    self.curField = ctrl;
    MutilSelectViewController *mgdTypeController = [[MutilSelectViewController alloc] initWithStyle:UITableViewStyleGrouped];
    mgdTypeController.contentSizeForViewInPopover = CGSizeMake(200, 264);
    mgdTypeController.delegate = self;
    mgdTypeController.msg = @"其他类型";
    mgdTypeController.aryItems = [NSArray arrayWithObjects:@"饮用水水源地",@"人口积聚区",@"自然保护区",@"风景名胜",@"其他",@"无",nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mgdTypeController];
    
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.popController = popover;
    
    [popover release];
    [nav release];
    [mgdTypeController release];
	
	[popController presentPopoverFromRect:[ctrl bounds] inView:ctrl permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)segmentValueChanged:(UISegmentedControl *)paramSender{
    NSInteger tag = paramSender.tag;
    if (tag == TAG_SCQK) {
        NSInteger *selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString  *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        if([selectedSegmentText isEqualToString:@"停产"]){
            firstView.loadTxt.text = @"";
            firstView.loadLabel.hidden = YES;
            firstView.loadTxt.hidden = YES;
            
        }
        else {
            firstView.loadLabel.hidden = NO;
            firstView.loadTxt.hidden = NO;
        }
    }
    
    if (tag == TAG_YJZL) {
        NSInteger *selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString  *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        if([selectedSegmentText isEqualToString:@"无"]){
            firstView.emergencyNumbers.text = @"";
            firstView.numberLabel.hidden = YES;
            firstView.emergencyNumbers.hidden = YES;
        }
        
        else {
            firstView.numberLabel.hidden = NO;
            firstView.emergencyNumbers.hidden = NO;
        }
        
    }

    
    
    if (tag == TAG_YJYL) {
        NSInteger *selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString  *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        if([selectedSegmentText isEqualToString:@"无"]){
            firstView.exerciseYears.text = @"";
            firstView.exerciseYears.hidden = YES;
            firstView.yearLabel.hidden = YES;
            firstView.lineImageView.hidden = YES;
        }
        else {
            firstView.yearLabel.hidden = NO;
            firstView.lineImageView.hidden = NO;
            firstView.exerciseYears.hidden = NO;
        }
        
    }
    if (tag == TAG_GQWYSF) {
        NSInteger *selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString  *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        if([selectedSegmentText isEqualToString:@"是"]){
            secondView.gqbfhyyField.text = @"";
            secondView.gqbfhyyField.hidden = YES;
            secondView.reasonLabel1.hidden = YES;
            
        }
        else {
            secondView.gqbfhyyField.hidden = NO;
            secondView.reasonLabel1.hidden = NO;
        }
        
    }
    
    if (tag == TAG_YJCSF) {
        NSInteger *selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString  *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        if([selectedSegmentText isEqualToString:@"是"]){
            secondView.yjcbfhyyField.text =@"";
            secondView.yjcbfhyyField.hidden = YES;
            secondView.reasonLabel2.hidden = YES;
            
        }
        else {
            secondView.yjcbfhyyField.hidden = NO;
            secondView.reasonLabel2.hidden = NO;
        }
        
    }
    
    if (tag == TAG_YJFMSF) {
        NSInteger *selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString  *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        if([selectedSegmentText isEqualToString:@"是"]){
            secondView.yjfmbwsyyField.text = @"";
            secondView.yjfmbwsyyField.hidden = YES;
            secondView.reasonLabel3.hidden = YES;
            
        }
        else {
            secondView.yjfmbwsyyField.hidden = NO;
            secondView.reasonLabel3.hidden = NO;
        }
    }
    
    if (tag == TAG_YWFLSF) {
        NSInteger *selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString  *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        if([selectedSegmentText isEqualToString:@"是"]){
            secondView.ywflyyField.text = @"";
            secondView.ywflyyField.hidden = YES;
            secondView.reasonLabel4.hidden = YES;
        }
        else {
            secondView.ywflyyField.hidden = NO;
            secondView.reasonLabel4.hidden = NO;
        }
    }
    
    if (tag == TAG_FSCLSS) {
        NSInteger *selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString  *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        if([selectedSegmentText isEqualToString:@"正常"]){
            secondView.fsclssField.text = @"";
            secondView.fsclssField.hidden = YES;
            secondView.reasonLabel5.hidden = YES;
            
        }
        else {
            secondView.fsclssField.hidden = NO;
            secondView.reasonLabel5.hidden = NO;
        }

    }
    
    if (tag == TAG_FQCLSS) {
        NSInteger *selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString  *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        if([selectedSegmentText isEqualToString:@"正常"]){
            secondView.fqclssField.text = @"";
            secondView.fqclssField.hidden = YES;
            secondView.reasonLabel6.hidden = YES;
            
        }
        else {
            secondView.fqclssField.hidden = NO;
            secondView.reasonLabel6.hidden = NO;
        }

    }
    
    if (tag == TAG_YDQT) {
        NSInteger *selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString  *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        if([selectedSegmentText isEqualToString:@"无"]){
            secondView.ydqtField.text = @"";
            secondView.ydqtField.hidden = YES;
            secondView.reasonLabel7.hidden = YES;
            
        }
        else {
            secondView.ydqtField.hidden = NO;
            secondView.reasonLabel7.hidden = NO;
        }

    }
    
    
    if (tag == TAG_GQFM) {
        NSInteger *selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString  *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        if([selectedSegmentText isEqualToString:@"是"]){
            secondView.gqfmField.text = @"";
            secondView.gqfmField.hidden = YES;
            secondView.reasonLabel8.hidden = YES;
        }
        else {
            secondView.gqfmField.hidden = NO;
            secondView.reasonLabel8.hidden = NO;
        }
    }
    

    
    if (tag == TAG_YJCYW) {
        NSInteger *selectedSegmentIndex = [paramSender selectedSegmentIndex];
        NSString  *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];
        if([selectedSegmentText isEqualToString:@"无"]){
            secondView.yjccapacity.text = @"";
            secondView.yjccapacity.hidden = YES;
            secondView.areaLabel.hidden = YES;
            secondView.lineImageView.hidden = YES;
        }
        else {
            secondView.yjccapacity.hidden = NO;
            secondView.areaLabel.hidden = NO;
            secondView.lineImageView.hidden = NO;
        }
    }

}





#pragma mark -
#pragma mark WordsDelegate 
- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row {
    curField.text = words;
    if (popController != nil) {
        [popController dismissPopoverAnimated:YES];
    }

}

- (void)returnSelectedWords:(NSString *)words {
     curField.text = words;
    if (popController != nil) {
        [popController dismissPopoverAnimated:YES];
    }

}

-(void)returnLatitude:(NSString*)latitude Longitude:(NSString*)longitude {
    
    NSArray *jdAry = [longitude componentsSeparatedByString:@"."];
    NSString *degree = [jdAry objectAtIndex:0];
    NSString *minute = [jdAry objectAtIndex:1];
    NSString *second = [jdAry objectAtIndex:2];
    
    self.mgdJD = [NSString stringWithFormat:@"%f",[degree intValue]+[minute floatValue]/60+[second floatValue]/3600];
    longitude = [NSString stringWithFormat:@"%@°%@′%@″",degree,minute,second];
    firstView.mgdJingdu.text =longitude;
    
    NSArray *wdAry = [latitude componentsSeparatedByString:@"."];
    degree = [wdAry objectAtIndex:0];
    minute = [wdAry objectAtIndex:1];
    second = [wdAry objectAtIndex:2];
    
    self.mgdWD = [NSString stringWithFormat:@"%f",[degree intValue]+[minute floatValue]/60+[second floatValue]/3600];
    latitude = [NSString stringWithFormat:@"%@°%@′%@″",degree,minute,second];
    firstView.mgdWeidu.text = latitude;
    
    [popController dismissPopoverAnimated:YES];

}

#pragma mark -
#pragma mark Keyboard Notitification
- (void)keyboardWillShow:(NSNotification *)notification{
   //CGFloat originY = scrollView.contentOffset.y;
    //scrollView.contentOffset = CGPointMake(0, originY+240);
}

- (void)keyboardWillHide:(NSNotification *)notification{
    //CGFloat originY = scrollView.contentOffset.y;
    //scrollView.contentOffset = CGPointMake(0, originY-240);
}


#pragma mark -
#pragma mark UITextField delegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	return NO;
}

/*
-(void)sureCommitBilu
{
    
    NSDictionary *dicData1 = [firstView getValueData];
    NSDictionary *dicData2 = [secondView getValueData];

    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithDictionary:dicData1];
    [dicData setValuesForKeysWithDictionary:dicData2];

   // [dicData setValue:dwbh forKey:@"DWBH"];
  //  [dicData setValue:xczfbh forKey:@"XCZFBH"];


    [self commitRecordDatas:dicData];
    
}
*/

- (void)uploadAttachment:(id)sender {
    TakedPhotosViewController *controller = [[TakedPhotosViewController alloc] initWithNibName:@"TakedPhotosViewController" bundle:nil];
    controller.xczfbh = self.xczfbh;
    controller.attachSource = @"企业应急";
    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];

}

-(void)saveBilu:(id)sender
{
    secondView.isAdd = NO;
    NSDictionary *dicData1 = [firstView getValueData];
    NSDictionary *dicData2 = [secondView getValueData];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithDictionary:dicData1];
    [dicData setValuesForKeysWithDictionary:dicData2];
    [dicData setObject:self.xczfbh forKey:@"XCZFBH"];
    [dicData setObject:self.dwbh forKey:@"DWBH"];
    [dicData setObject:self.wryJD forKey:@"JD"];
    [dicData setObject:self.wryWD forKey:@"WD"];
    [dicData setObject:self.mgdJD forKey:@"MGDJD"];
    [dicData setObject:self.mgdWD forKey:@"MGDWD"];
    [self saveLocalRecord:dicData];
}

-(void)saveLocalRecord:(id)valueDatas{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:valueDatas options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@",jsonStr);
    
    DBHelper *helper = [DBHelper sharedInstance];
    BOOL res = [helper saveRecord:jsonStr XCZFBH:self.xczfbh WRYMC:self.wrymc TableName:self.tableName JCR:g_logedUserInfo.userName];
    
    [jsonStr release];
    if(res){
        self.recordStatus= Record_SaveLocal;
        [OMGToast showWithText:@"笔录已暂存在本地！" duration:1.0];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RecordStatus" object:[NSNumber numberWithInt:self.menuTagID]];
    }
}



//根据值来显示值
-(void)displayRecordDatas:(id)values{
    NSDictionary *valueDic = (NSDictionary*)values;
    [firstView loadData:valueDic];
    [secondView loadData:valueDic];
}

- (void)viewWillAppear:(BOOL)animated {
    self.title = @"企业环境应急检查表";
}

- (void)viewWillDisappear:(BOOL)animated {
    self.title = @"返回";
}

- (void)viewDidLoad
{
    self.tableName = @"T_YDZF_QYHJYJJCB";
    [super viewDidLoad];
    if (!self.isHisRecord) {
        //导航左边部分
        UIToolbar *tool1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 110, 44)];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backItemPressed)];
        
        UIBarButtonItem *photoButton = [[UIBarButtonItem alloc] initWithTitle:@"上传附件" style:UIBarButtonItemStyleDone target:self action:@selector(uploadAttachment:)];
        
        
        NSMutableArray* buttons1 = [[NSMutableArray alloc] initWithCapacity:8];
        [buttons1 addObject:leftButton];
        [buttons1 addObject:photoButton];
        [leftButton release];
        [tool1 setItems:buttons1 animated:NO];
        [buttons1 release];
        
        UIBarButtonItem *myBItem1 = [[UIBarButtonItem alloc] initWithCustomView:tool1];
        self.navigationItem.leftBarButtonItem = myBItem1;
        [myBItem1 release];
        [tool1 release];
        
    }
    self.title = @"企业环境应急检查表";
    self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)] autorelease];
        scrollView.delaysContentTouches = NO;
    [self.view addSubview:scrollView];
    [self addAllViews];
    
    if (self.isSaveRecord)
        [self loadLocalSaveRecord];
    
//    NSInteger *selectedSegmentIndex = [firstView.systemisExer selectedSegmentIndex];
//    NSString  *selectedSegmentText = [firstView.systemisExer titleForSegmentAtIndex:selectedSegmentIndex];
//    if([selectedSegmentText isEqualToString:@"无"]){
//        firstView.exerciseYears.hidden = YES;
//        firstView.yearLabel.hidden = YES;
//        firstView.lineImageView.hidden = YES;
//    }
//    else {
//        firstView.yearLabel.hidden = NO;
//        firstView.lineImageView.hidden = NO;
//        firstView.exerciseYears.hidden = NO;
//    }

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchFromDate:(id)sender{
    PopupDateViewController *dateController = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDate];
    dateController.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
    
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.popController = popover;
    
    [popover release];
    [nav release];
    [dateController release];
    
    UITextField *field =(UITextField*)sender;
    self.curField = field;
	[popController presentPopoverFromRect:[field bounds] inView:field permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date{
	[popController dismissPopoverAnimated:YES];
	if (bSaved) {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
		NSString *dateString = [dateFormatter stringFromDate:date];
		[dateFormatter release];
        curField.text =  dateString;
		
	}
    
}

-(void)viewDidAppear:(BOOL)animated{
    if (self.isHisRecord) {
        NSArray *aryChildViews1= [firstView subviews];
        NSArray *aryChildViews2 = [secondView subviews];
        NSMutableArray *ary = [NSMutableArray arrayWithArray:aryChildViews1];
        [ary addObjectsFromArray:aryChildViews2];
        for(UIView *childView in ary){
            childView.userInteractionEnabled = NO;
        }
    }
    
    [super viewDidAppear:animated];
}


@end
