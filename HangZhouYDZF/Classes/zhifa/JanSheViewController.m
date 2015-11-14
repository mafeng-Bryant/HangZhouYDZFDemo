//
//  JanSheViewController.m
//  GMEPS_HZ
//
//  Created by ihumor on 13-4-15.
//
//

#import "JanSheViewController.h"
#import "WebServiceHelper.h"
#import "GGDMJConfig.h"
#import "SharedInformations.h"
#import "UserInfo.h"


#import "TakedPhotosViewController.h"
#import "GUIDGenerator.h"
#import "JSONKit.h"


@interface JanSheViewController ()

@property (nonatomic, retain) UIPopoverController *popController;
@property (nonatomic, retain) UIScrollView *myScrollView;

@end

@implementation JanSheViewController
@synthesize popController,myScrollView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tableName = @"T_YDZF_GYJSXMHJJCJL";
    }
    return self;
}

- (void)uploadAttachment:(id)sender {
    TakedPhotosViewController *controller = [[TakedPhotosViewController alloc] initWithNibName:@"TakedPhotosViewController" bundle:nil];
    controller.xczfbh = self.xczfbh;
    controller.attachSource = @"工业项目三同时";
    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}

- (void)viewDidLoad
{
    self.tableName = @"T_YDZF_GYJSXMHJJCJL";
    [super viewDidLoad];
    self.title = @"工业项目三同时跟踪表";
    
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
    // Do any additional setup after loading the view from its nib.
    
    [self loadAllView];
    
    qyfhF.delegate = self;
    jsdzF.text = [self.dicWryInfo objectForKey:@"JSDZ"];
    jsxmmcF.text = [self.dicWryInfo objectForKey:@"XMMC"];
    fddbrF.text = [self.dicWryInfo objectForKey:@"FRDB"];
    fddbrlxdhF.text = [self.dicWryInfo objectForKey:@"FRLXDH"];
    spwhF.text = [self.dicWryInfo objectForKey:@"SPWH"];
    spsjF.text = [self.dicWryInfo objectForKey:@"SPSJ"];
    xmlxrF.text = [self.dicWryInfo objectForKey:@"XMLXR"];
    xmlxrdhF.text = [self.dicWryInfo objectForKey:@"XMLXDH"];
    
    NSString *xmlx = [self.dicWryInfo objectForKey:@"XMLX"];
        for (int n=0; n < xmlxSegCtrl.numberOfSegments; n++) {
            NSString *title = [xmlxSegCtrl titleForSegmentAtIndex:n];
            if ([title isEqualToString:xmlx]) {
                xmlxSegCtrl.selectedSegmentIndex = n;
            }
        }
        
    if (self.isSaveRecord)
        [self loadLocalSaveRecord];
    
}

-(void)saveBilu:(id)sender
{
    NSDictionary *dicData = [self getValueData];
    NSMutableDictionary *dicValue = [NSMutableDictionary dictionaryWithDictionary:dicData];
    [dicValue setValue:self.xczfbh forKey:@"XCZFBH"];
    [self saveLocalRecord:dicValue];
    
}

//根据值来显示值
-(void)displayRecordDatas:(id)object{
    NSDictionary* values = (NSDictionary*)object;
    [self loadData:values];
}

-(NSDictionary*)getValueData{
    
    NSMutableDictionary *dicValues = [NSMutableDictionary dictionaryWithCapacity:5];
    [dicValues setValue:jsxmmcF.text forKey:@"JSXMMC"];
    [dicValues setValue:jsdwF.text forKey:@"JSDW"];
    if([yqjgrqField.text length] > 0)
        [dicValues setValue:yqjgrqField.text forKey:@"YQJGRQ"];
    
    [dicValues setValue:jsdzF.text forKey:@"JSDZ"];
    [dicValues setValue:fddbrF.text forKey:@"FRDB"];
    [dicValues setValue:fddbrlxdhF.text forKey:@"FRLXDH"];
    [dicValues setValue:xmlxrF.text forKey:@"XMLXR"];
    [dicValues setValue:xmlxrdhF.text forKey:@"LXRDH"];
    [dicValues setValue:czF.text forKey:@"CZ"];
    
    
    [dicValues setValue:spwhF.text  forKey:@"SPWH"];
    if ([spsjF.text length] > 0)
        [dicValues setValue:spsjF.text forKey:@"SPSJ"];
    [dicValues setValue:zywrhyF.text forKey:@"ZYWRHY"];
    [dicValues setValue:ybwrhyF.text forKey:@"YBWRHY"];
    [dicValues setValue:hjjldwmcF.text forKey:@"HJJLDWMC"];
    NSString *str = [NSString stringWithFormat:@"%@,%@",xmfzrF.text,xmfzrdhF.text];
    [dicValues setValue:str forKey:@"XMFZRJLXDH"];
    [dicValues setValue:wsfhjlyqF.text forKey:@"WSFHJLYQ"];
    [dicValues setValue:zjmgddwzjjlF.text forKey:@"ZJMGDWZJJL"];
    [dicValues setValue:qyfhF.text forKey:@"QYFH"];
    
    
    [dicValues setValue:xmztgcjscText.text forKey:@"XMZTGZJSCMS"];
    [dicValues setValue:fswrfzText.text forKey:@"FSWRFZMS"];
    [dicValues setValue:fqwrfzText.text forKey:@"FQWRFZMS"];
    [dicValues setValue:zswrfzText.text forKey:@"ZSWRFZMS"];
    [dicValues setValue:gtfwclText.text forKey:@"GTFWCLMS"];
    [dicValues setValue:zxjcText.text forKey:@"ZXJC"];
    [dicValues setValue:yjczText.text forKey:@"YJCZ"];
    [dicValues setValue:hbglzdText.text forKey:@"HBGLZD"];
    [dicValues setValue:qtText.text forKey:@"QT"];
    
    [dicValues setValue:[xmlxSegCtrl titleForSegmentAtIndex:xmlxSegCtrl.selectedSegmentIndex] forKey:@"XMLX"];
    [dicValues setValue:[ssqkSegCtrl titleForSegmentAtIndex:ssqkSegCtrl.selectedSegmentIndex] forKey:@"SSQK"];
    [dicValues setValue:[gzlbSegCtrl titleForSegmentAtIndex:gzlbSegCtrl.selectedSegmentIndex] forKey:@"GZJB"];
    [dicValues setValue:[spyqSegCtrl titleForSegmentAtIndex:spyqSegCtrl.selectedSegmentIndex] forKey:@"HJJLSPYQ"];
    [dicValues setValue:[hjjlSegCtrl titleForSegmentAtIndex:hjjlSegCtrl.selectedSegmentIndex] forKey:@"SFWTHJJL"];
    [dicValues setValue:[ysjcSegCtrl titleForSegmentAtIndex:ysjcSegCtrl.selectedSegmentIndex] forKey:@"SFWTZZDWKZJGYS"];
    
    [dicValues setValue:[xmItemSegCtrl titleForSegmentAtIndex:xmItemSegCtrl.selectedSegmentIndex] forKey:@"XMZTGZJSC"];
    [dicValues setValue:[fsItemSegCtrl titleForSegmentAtIndex:fsItemSegCtrl.selectedSegmentIndex] forKey:@"FSWRFZ"];
    [dicValues setValue:[fqItemSegCtrl titleForSegmentAtIndex:fqItemSegCtrl.selectedSegmentIndex] forKey:@"FQWRFZ"];
    [dicValues setValue:[zsItemSegCtrl titleForSegmentAtIndex:zsItemSegCtrl.selectedSegmentIndex] forKey:@"ZSWRFZ"];
    [dicValues setValue:[gtItemSegCtrl titleForSegmentAtIndex:gtItemSegCtrl.selectedSegmentIndex] forKey:@"GTFWCL"];
    

    return dicValues;
    
}


- (void)loadAllView{
    
   
    if (JSXMQK.superview!=nil) {
        [JSXMQK removeFromSuperview];
    }
    [JSXMQK setFrame:CGRectMake(0.0, 0.0, 768.0, 910.0)];
    
    if (JSJSAndJC.superview!=nil) {
        [JSJSAndJC removeFromSuperview];
    }
    [JSJSAndJC setFrame:CGRectMake(0.0, 910.0, 768.0,  1850.0)];
    
    self.myScrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)] autorelease];
    myScrollView.delaysContentTouches = NO;
    [self.view addSubview:myScrollView];
    [myScrollView addSubview:JSXMQK];
    [myScrollView addSubview:JSJSAndJC];
     [myScrollView setContentSize:CGSizeMake(768, 3200)];
    
    [zywrhyF addTarget:self action:@selector(chooseWords:) forControlEvents:UIControlEventTouchDown];
    
    [spsjF addTarget:self action:@selector(chooseWords:) forControlEvents:UIControlEventTouchDown];
    [yqjgrqField addTarget:self action:@selector(chooseWords:) forControlEvents:UIControlEventTouchDown];
    
   
    
}

-(void)modifySeg:(UISegmentedControl*)segCtrl Value:(NSString*)value{
    for (int i = 0; i < segCtrl.numberOfSegments; i++) {
        if([[segCtrl titleForSegmentAtIndex:i] isEqualToString:value]){
            segCtrl.selectedSegmentIndex = i;
            break;
        }
    }
}

- (void)chooseWords:(UITextField *)sender{
    
    CGRect rect = sender.frame;
    curfield = sender;
    if (sender.tag == 10) {
        //主要污染行业
        zywrhyF.text = @"";
        CommenWordsViewController *tmpController = [[CommenWordsViewController alloc] initWithNibName:@"CommenWordsViewController" bundle:nil ];
        tmpController.contentSizeForViewInPopover = CGSizeMake(200, 350);
        tmpController.delegate = self;
         tmpController.wordsAry = [NSArray arrayWithObjects:@"造纸",@"建材",@"化工",@"冶炼",@"印染",@"农药",@"电镀",@"制革",@"酿造",@"水利火电",@"医药",@"垃圾处置",@"污水处理", nil ];
        UIPopoverController *tmppopover = [[UIPopoverController alloc] initWithContentViewController:tmpController];
       
        self.popController = tmppopover;
        [tmpController release];
        [tmppopover release];
        
        [self.popController presentPopoverFromRect: rect
                                                     inView:JSXMQK
                                   permittedArrowDirections:UIPopoverArrowDirectionAny
                                                   animated:YES];
        
       
    }
    else if (sender.tag == 11 || sender.tag == 12){
        //审批时间
        PopupDateViewController *dateController = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDate];
        dateController.delegate = self;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
        self.popController = popover;
        //popController.delegate = self;
        [popover release];
        [nav release];
        [dateController release];
        [popController presentPopoverFromRect:rect inView:JSXMQK permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            
    }
   
}

- (void)returnSelectedWords:(NSString *)words andRow:(NSInteger)row{

    zywrhyF.text = words;
    [popController dismissPopoverAnimated:YES];
}

- (void)PopupDateController:(PopupDateViewController *)controller Saved:(BOOL)bSaved selectedDate:(NSDate*)date{
	[popController dismissPopoverAnimated:YES];
	if (bSaved) {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
		NSString *dateString = [dateFormatter stringFromDate:date];
		[dateFormatter release];
        if(curfield)
            curfield.text =  dateString;
		
	}
    
}


#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField tag] == 111) {
        return YES;
    }
	return NO;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入数字"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];
        return NO;
        
    }
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [popController release];
    [myScrollView release];
    [super dealloc];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

- (void)loadData:(NSDictionary *)infoDic{
    NSString *jgrqStr = [infoDic objectForKey:@"YQJGRQ"];
     jgrqStr= [[jgrqStr componentsSeparatedByString:@" "] objectAtIndex:0];
     yqjgrqField.text = [jgrqStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
     NSString *spsjStr   = [infoDic objectForKey:@"SPSJ"];
     spsjStr= [[spsjStr componentsSeparatedByString:@" "] objectAtIndex:0];
    spsjF.text = [spsjStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];

    
    jsxmmcF.text = [infoDic objectForKey:@"JSXMMC"];
    jsdwF.text = [infoDic objectForKey:@"JSDW"];
   
    jsdzF.text = [infoDic objectForKey:@"JSDZ"];
    fddbrF.text = [infoDic objectForKey:@"FRDB"];
    fddbrlxdhF.text = [infoDic objectForKey:@"FRLXDH"];
    xmlxrF.text = [infoDic objectForKey:@"XMLXR"];
    xmlxrdhF.text = [infoDic objectForKey:@"LXRDH"];
    czF.text = [infoDic objectForKey:@"CZ"];
    
    spwhF.text = [infoDic objectForKey:@"SPWH"];
    
   
    zywrhyF.text = [infoDic objectForKey:@"ZYWRHY"];
    ybwrhyF.text = [infoDic objectForKey:@"YBWRHY"];
    hjjldwmcF.text = [infoDic objectForKey:@"HJJLDWMC"];
    NSString *str = [infoDic objectForKey:@"XMFZRJLXDH"];
    if (str.length>0) {
        NSArray *arr = [str componentsSeparatedByString:@","];
        if (arr.count==2) {
            xmfzrF.text = [arr objectAtIndex:0];
            xmfzrdhF.text = [arr objectAtIndex:1];
        }
    }
    wsfhjlyqF.text = [infoDic objectForKey:@"WSFHJLYQ"];
    zjmgddwzjjlF.text = [infoDic objectForKey:@"ZJMGDWZJJL"];
    qyfhF.text = [infoDic objectForKey:@"QYFH"];
    
    xmztgcjscText.text = [infoDic objectForKey:@"XMZTGZJSCMS"];
    fswrfzText.text = [infoDic objectForKey:@"FSWRFZMS"];
    fqwrfzText.text = [infoDic objectForKey:@"FQWRFZMS"];
    zswrfzText.text = [infoDic objectForKey:@"ZSWRFZMS"];
    gtfwclText.text = [infoDic objectForKey:@"GTFWCLMS"];
    zxjcText.text = [infoDic objectForKey:@"ZXJC"];
    yjczText.text = [infoDic objectForKey:@"YJCZ"];
    hbglzdText.text = [infoDic objectForKey:@"HBGLZD"];
    qtText.text = [infoDic objectForKey:@"QT"];
    
    
    [self modifySeg:xmlxSegCtrl Value:[infoDic objectForKey:@"XMLX"]];
    [self modifySeg:ssqkSegCtrl Value:[infoDic objectForKey:@"SSQK"]];
    [self modifySeg:gzlbSegCtrl Value:[infoDic objectForKey:@"GZJB"]];
    [self modifySeg:spyqSegCtrl Value:[infoDic objectForKey:@"HJJLSPYQ"]];

    [self modifySeg:hjjlSegCtrl Value:[infoDic objectForKey:@"SFWTHJJL"]];
    [self modifySeg:ysjcSegCtrl Value:[infoDic objectForKey:@"SFWTZZDWKZJGYS"]];
    [self modifySeg:xmItemSegCtrl Value:[infoDic objectForKey:@"XMZTGZJSC"]];
    [self modifySeg:fsItemSegCtrl Value:[infoDic objectForKey:@"FSWRFZ"]];
    
    [self modifySeg:fqItemSegCtrl Value:[infoDic objectForKey:@"FQWRFZ"]];
    [self modifySeg:zsItemSegCtrl Value:[infoDic objectForKey:@"ZSWRFZ"]];
    [self modifySeg:gtItemSegCtrl Value:[infoDic objectForKey:@"GTFWCL"]];
    
}

-(void)viewDidAppear:(BOOL)animated{
    if (self.isHisRecord) {
        NSArray *aryChildViews1 = [JSXMQK subviews];
        NSArray *aryChildViews2 = [JSJSAndJC subviews];

        NSMutableArray *ary = [NSMutableArray arrayWithArray:aryChildViews1];
        [ary addObjectsFromArray:aryChildViews2];
        for(UIView *childView in ary){
            
            if ([childView isKindOfClass:[UITextField class]] || [childView isKindOfClass:[UISegmentedControl class]] || [childView isKindOfClass:[UITextView class]]) {
                UIControl *ctrl = (UIControl*)childView;
                ctrl.userInteractionEnabled = NO;
            }
        }
    }
    [super viewDidAppear:animated];
}


@end
