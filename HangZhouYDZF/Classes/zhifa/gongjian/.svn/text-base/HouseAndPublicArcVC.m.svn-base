//
//  HouseAndPublicArcVC.m
//  GMEPS_HZ
//
//  Created by 文 克远 on 13-4-15.
//
//

#import "HouseAndPublicArcVC.h"
#import "HouseAndPublicArcFirstView.h"
#import "HouseAndPublicArcSecondView.h"
#import "GUIDGenerator.h"
#import "TakedPhotosViewController.h"
@interface HouseAndPublicArcVC ()
@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)HouseAndPublicArcFirstView *firstView;
@property(nonatomic,retain)HouseAndPublicArcSecondView *secondView;
@property(nonatomic,retain) UITextField *curField;
@property (nonatomic, retain) UIPopoverController *popController;
@end

@implementation HouseAndPublicArcVC
@synthesize scrollView,firstView,secondView,curField,popController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(void)dealloc{
    [scrollView release];
    [firstView release];
    [secondView release];
    [curField release];
    [popController release];
    
    [super dealloc];
}



-(void)addAllViews{
    
    HouseAndPublicArcFirstView *view1 =[[HouseAndPublicArcFirstView alloc] init];
    view1.frame = CGRectMake(0, 0,768 ,1110 );
    [self.scrollView addSubview:view1];
    
    self.firstView = view1;
    firstView.spsjField.delegate = self;
    firstView.yqjgrqField.delegate = self;
    [firstView.spsjField addTarget:self action:@selector(touchFromDate:) forControlEvents:UIControlEventTouchDown];
    [firstView.yqjgrqField addTarget:self action:@selector(touchFromDate:) forControlEvents:UIControlEventTouchDown];
    [view1 release];
    
    HouseAndPublicArcSecondView *view2 =[[HouseAndPublicArcSecondView alloc] init];
    view2.frame = CGRectMake(0, 1110,768 ,1100 );
    self.secondView = view2;
    [self.scrollView addSubview:view2];
    [view2 release];
    
    [scrollView setContentSize:CGSizeMake(768,2500)];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
	return NO;
}



-(void)saveBilu:(id)sender
{
    
    NSDictionary *dicData1 = [firstView getValueData];
    NSDictionary *dicData2 = [secondView getValueData];
    
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithDictionary:dicData1];
    [dicData setObject:self.wrymc forKey:@"DWMC"];
    [dicData setObject:self.xczfbh forKey:@"XCZFBH"];
    [dicData setValuesForKeysWithDictionary:dicData2];
    [self saveLocalRecord:dicData];
    
}


//根据值来显示值
-(void)displayRecordDatas:(id)object{
    NSDictionary* values = (NSDictionary*)object;
    [firstView loadData:values];
    [secondView loadData:values];
}

- (void)uploadAttachment:(id)sender {
    TakedPhotosViewController *controller = [[TakedPhotosViewController alloc] initWithNibName:@"TakedPhotosViewController" bundle:nil];
    controller.xczfbh = self.xczfbh;
    controller.attachSource = @"非工业项目三同时";
    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
}


- (void)viewDidLoad
{
    self.tableName = @"T_YDZF_FDCGJJSXMHJJCJL";
    [super viewDidLoad];
    self.title = @"非工业项目三同时跟踪表";
    
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
   /* UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bilu_bg.png"]];
    bgView.frame =CGRectMake(0, 0, 768, 960);
    [self.view addSubview:bgView];
    [bgView release];*/
    
    self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)] autorelease];
    scrollView.delaysContentTouches = NO;
    [self.view addSubview:scrollView];
    [self addAllViews];
    
    firstView.jsdzField.text = [self.dicWryInfo objectForKey:@"JSDZ"];
    firstView.frdbField.text = [self.dicWryInfo objectForKey:@"FRDB"];
    firstView.frlxdhField.text = [self.dicWryInfo objectForKey:@"FRLXDH"];
    
    firstView.jsxmmcField.text = [self.dicWryInfo objectForKey:@"XMMC"];
    firstView.spwhField.text = [self.dicWryInfo objectForKey:@"SPWH"];
    firstView.spsjField.text = [self.dicWryInfo objectForKey:@"SPSJ"];
    firstView.xmlxrField.text = [self.dicWryInfo objectForKey:@"XMLXR"];
    firstView.lxrdhField.text = [self.dicWryInfo objectForKey:@"XMLXDH"];
    
    NSString *xmlx = [self.dicWryInfo objectForKey:@"XMLX"];
    for (int n=0; n < firstView.xmlxSegCtrl.numberOfSegments; n++) {
        NSString *title = [firstView.xmlxSegCtrl titleForSegmentAtIndex:n];
        if ([title isEqualToString:xmlx]) {
            firstView.xmlxSegCtrl.selectedSegmentIndex = n;
        }
    }
    
    
    if (self.isSaveRecord)
        [self loadLocalSaveRecord];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchFromDate:(id)sender{
    
    if(popController == nil){
        PopupDateViewController *dateController = [[PopupDateViewController alloc] initWithPickerMode:UIDatePickerModeDate];
        dateController.delegate = self;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dateController];
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nav];
        self.popController = popover;
        
        [popover release];
        [nav release];
        [dateController release];
    }
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
            
            if ([childView isKindOfClass:[UITextField class]] || [childView isKindOfClass:[UISegmentedControl class]]|| [childView isKindOfClass:[UITextView class]]) {
                UIControl *ctrl = (UIControl*)childView;
                ctrl.userInteractionEnabled = NO;
            }
        }
    }
    [super viewDidAppear:animated];
}

@end
