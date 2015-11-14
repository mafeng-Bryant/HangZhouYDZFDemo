//
//  FieldInspectionVC.m
//  GMEPS_HZ
//
//  Created by zhang on 13-4-7.
//
//

#import "FieldInspectionVC.h"
#import "JCNRView.h"
#import "JCXJView.h"
#import "DBHelper.h"

@interface FieldInspectionVC ()
@property(nonatomic,retain) JCNRView *jcnrView;
@property(nonatomic,retain) JCXJView *jcxjView;

@end

@implementation FieldInspectionVC
@synthesize scrollView,jcnrView,jcxjView;


- (id)init
{
    self = [super init];
    if (self) {
        
        // Custom initialization
        
    }
    return self;
}

-(void)dealloc{
    [jcnrView release];
    [jcxjView release];
    
    [super dealloc];
}

-(void)addAllViews{
    
    
    JCNRView *view2 =[[JCNRView alloc] init];
    [self.scrollView addSubview:view2];
    self.jcnrView = view2;
    [view2 release];
    
    JCXJView *view3 =[[JCXJView alloc] init];
     view3.frame = CGRectMake(0, 960,768 ,960 );
    [self.scrollView addSubview:view3];
    self.jcxjView = view3;
    [view3 release];
    [scrollView setContentSize:CGSizeMake(768, 2000)];

}

//根据值来显示值
-(void)displayRecordDatas:(id)object{
    NSDictionary* values = (NSDictionary*)object;
    [jcnrView loadData:values];
    [jcxjView loadData:values];
}

-(void)saveBilu:(id)sender
{
    NSString *userORGID = [self.dicWryInfo objectForKey:@"ORGID"];
    NSString *wryName = [self.dicWryInfo objectForKey:@"DWMC"];
    NSString *wryAddress = [self.dicWryInfo objectForKey:@"DWDZ"];
    NSString *legal =        [self.dicWryInfo objectForKey:@"DWFZR"];
    NSString *legalNumber =  [self.dicWryInfo objectForKey:@"DWFZRDH"];
    NSString *Gllb =      [self.dicWryInfo objectForKey:@"GLLB"];
    NSString *Hylx =      [self.dicWryInfo objectForKey:@"SSHY"];
    NSString *officer  =  [self.dicWryInfo objectForKey:@"JCR"];
    NSString *department = [self.dicWryInfo objectForKey:@"JCRBM"];
    NSString *certificate = [self.dicWryInfo objectForKey:@"ZJH"];
    NSString *startTime =   [self.dicWryInfo objectForKey:@"JCSJ"];
    NSString *userName = [self.dicWryInfo objectForKey:@"LRR"];
    
    NSDictionary *dicData1 = [jcnrView getValueData];
    NSDictionary *dicData2 = [jcxjView getValueData];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithDictionary:dicData1];
    [dicData setValuesForKeysWithDictionary:dicData2];
    [dicData setValue:self.dwbh forKey:@"DWBH"];
    [dicData setValue:self.xczfbh forKey:@"XCZFBH"];
    [dicData setObject:wryName forKey:@"DWMC"];
    [dicData setObject:wryAddress forKey:@"DWDZ"];
    [dicData setValue:legal forKey:@"FDDBR"];
    [dicData setValue:legalNumber forKey:@"FDDBRDH"];
    [dicData setValue:Gllb forKey:@"GLLB"];
    [dicData setValue:Hylx forKey:@"SSHY"];
    [dicData setValue:officer forKey:@"JCRY"];
    [dicData setValue:department forKey:@"JCDW"];
    [dicData setValue:certificate forKey:@"ZJH"];
    [dicData setValue:startTime forKey:@"JCSJ"];
    [dicData setValue:userORGID forKey:@"ORGID"];
    [dicData setValue:userName forKey:@"LRR"];
    [dicData setValuesForKeysWithDictionary:dicData2];
    [self saveLocalRecord:dicData];
}

- (void)viewDidLoad
{
     self.tableName = @"T_YDZF_WRYXCJCJL";
    [super viewDidLoad];
        self.title = @"现场监察记录";
   
    /*
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bilu_bg.png"]];
    bgView.frame =CGRectMake(0, 0, 768, 960);
    [self.view addSubview:bgView];
    [bgView release];*/
    
    self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)] autorelease];
    scrollView.delaysContentTouches = NO;
    [self.view addSubview:scrollView];
    [self addAllViews];
    if (self.isSaveRecord) 
        [self loadLocalSaveRecord];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    if (self.isHisRecord) {
        NSArray *aryChildViews1= [jcnrView subviews];
        NSArray *aryChildViews2 = [jcxjView subviews];
        NSMutableArray *ary = [NSMutableArray arrayWithArray:aryChildViews1];
        [ary addObjectsFromArray:aryChildViews2];
        for(UIView *childView in ary){
            if ([childView isKindOfClass:[UITextField class]] || [childView isKindOfClass:[UISegmentedControl class]]|| [childView isKindOfClass:[UITextView class]] || [childView isKindOfClass:[UISwitch class]]) {
                UIControl *ctrl = (UIControl*)childView;
                ctrl.userInteractionEnabled = NO;
            }
        }
    }
    [super viewDidAppear:animated];
}


@end
