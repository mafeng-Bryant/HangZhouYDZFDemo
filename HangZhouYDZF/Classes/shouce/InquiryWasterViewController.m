//
//  InquiryWasterViewController.m
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-6-18.
//
//

#import "InquiryWasterViewController.h"
#import "FMDatabase.h"
#import "WasteCategoryViewController.h"
#import "WasteOfSourceViewController.h"
#import "WasteFeatureViewController.h"
#import "WasteItemViewController.h"

extern sqlite3 *data_db;
@interface InquiryWasterViewController ()

@end

@implementation InquiryWasterViewController

- (void)dealloc {
    [_categoryBtn release];
    [_sourceBtn release];
    [_featureBtn release];
    [_nameField release];
    [_bhField release];
    [super dealloc];
}

#pragma mark - ViewController lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction methods
- (IBAction)inquiryByWasteCategory:(id)sender{
    [_categoryBtn setAlpha:0.5];
	[_categoryBtn setBackgroundImage:[UIImage imageNamed:@"hightlight.png"] forState:UIControlStateHighlighted];
    //获取数据库文件
    NSString *dbFilePath = [[NSBundle mainBundle] pathForResource:@"wrydata" ofType:@"db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbFilePath];
    if (![database open]) {
        NSLog(@"Open database failed");
        return;
    }
    
    NSString *queryStr = @"select distinct DMBH,DMNR from dangerwaste where sjdmbh is null";
    
    FMResultSet *resultSet =[database executeQuery:queryStr];
    NSMutableArray *bhAry = [NSMutableArray arrayWithCapacity:49];
    NSMutableArray *cgAry = [NSMutableArray arrayWithCapacity:49];
    while([resultSet next]) {
        NSString *wasteBH = [resultSet stringForColumn:@"DMBH"];
        NSString *wasteCategory = [resultSet stringForColumn:@"DMNR"];
        [bhAry addObject:wasteBH];
        [cgAry addObject:wasteCategory];
    }
    [database close];
    
    WasteCategoryViewController *wasteCategoryViewController = [[WasteCategoryViewController alloc] initWithStyle:UITableViewStylePlain];
    wasteCategoryViewController.title = @"废物类别查询";
    wasteCategoryViewController.wasteCGAry = cgAry;
    wasteCategoryViewController.wasteBHAry = bhAry;
    [self.navigationController pushViewController:wasteCategoryViewController animated:YES];
    
    [wasteCategoryViewController release];
}

- (IBAction)inquiryBySourceOfIndustry:(id)sender{
    [_sourceBtn setAlpha:0.5];
	[_sourceBtn setBackgroundImage:[UIImage imageNamed:@"hightlight.png"] forState:UIControlStateHighlighted];
    //获取数据库文件
    NSString *dbFilePath = [[NSBundle mainBundle] pathForResource:@"wrydata" ofType:@"db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbFilePath];
    if (![database open]) {
        NSLog(@"Open database failed");
        return;
    }
    
    NSString *queryStr = @"select  distinct HYLY from dangerwaste  where hyly is not null";
    
    FMResultSet *resultSet =[database executeQuery:queryStr];
    NSMutableArray *sourceAry = [NSMutableArray arrayWithCapacity:49];
    
    while([resultSet next]) {
        NSString *wasteSource = [resultSet stringForColumn:@"HYLY"];
        [sourceAry addObject:wasteSource];
    }
    [database close];
    
    WasteOfSourceViewController *wasteOfSourceViewController = [[WasteOfSourceViewController alloc] initWithStyle:UITableViewStylePlain];
    wasteOfSourceViewController.title = @"行业来源查询";
    wasteOfSourceViewController.wasteSourceAry = sourceAry;
    
    [self.navigationController pushViewController:wasteOfSourceViewController animated:YES];
    
    [wasteOfSourceViewController release];
}

- (IBAction)inquiryByFeatureOfDanger:(id)sender{
    [_featureBtn setAlpha:0.5];
	[_featureBtn setBackgroundImage:[UIImage imageNamed:@"hightlight.png"] forState:UIControlStateHighlighted];
    //获取数据库文件
    NSString *dbFilePath = [[NSBundle mainBundle] pathForResource:@"wrydata" ofType:@"db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbFilePath];
    if (![database open]) {
        NSLog(@"Open database failed");
        return;
    }
    
    NSString *queryStr = @"select  distinct fwtx  from dangerwaste  where fwtx is not null";
    
    FMResultSet *resultSet =[database executeQuery:queryStr];
    NSMutableArray *featureAry = [NSMutableArray arrayWithCapacity:49];
    
    while([resultSet next]) {
        NSString *wasteSource = [resultSet stringForColumn:@"FWTX"];
        [featureAry addObject:wasteSource];
    }
    
    [database close];
    
    WasteFeatureViewController *wasteFeatureViewController = [[WasteFeatureViewController alloc] initWithStyle:UITableViewStylePlain];
    wasteFeatureViewController.title = @"危险特性查询";
    wasteFeatureViewController.wasteFeatureAry = featureAry;
    
    [self.navigationController pushViewController:wasteFeatureViewController animated:YES];
    
    [wasteFeatureViewController release];

}

-(IBAction)searchBtnClicked:(id)sender{
    if ([_nameField.text isEqualToString:@""] && [_bhField.text isEqualToString:@""]) {
        NSString *msg =@"请输入查询条件";
        
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
    
    NSMutableString *sqlStr = [NSMutableString stringWithString:@"select  DMNR,DMBH,FWTX,HYLY,SJDMBH from dangerwaste  where "];
    
    NSString *tmp;
    //BOOL bHaveAdded = NO;
    if (![_nameField.text isEqualToString:@""]) {
        tmp = [NSString stringWithFormat:@"DMNR like '%%%@%%' ",_nameField.text];
        
        [sqlStr appendString:tmp];
        //bHaveAdded = YES;
    }
    
    if (![_bhField.text isEqualToString:@""]) {
        if ([_nameField.text isEqualToString:@""]) {
             tmp = [NSString stringWithFormat:@" DMBH like '%%%@%%' ",_bhField.text];
        }
        else {
             tmp = [NSString stringWithFormat:@" and DMBH like '%%%@%%' ",_bhField.text];
        }
       
        
        [sqlStr appendString:tmp];
        //bHaveAdded = YES;
    }
    
    //获取数据库文件
    NSString *dbFilePath = [[NSBundle mainBundle] pathForResource:@"wrydata" ofType:@"db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbFilePath];
    if (![database open]) {
        NSLog(@"Open database failed");
        return;
    }
    
    
    FMResultSet *resultSet =[database executeQuery:sqlStr];
    
    NSMutableArray *describeAry = [NSMutableArray array];
    NSMutableArray *bhAry       = [NSMutableArray array];
    NSMutableArray *featureAry  = [NSMutableArray array];
    NSMutableArray *sourAry     = [NSMutableArray array];
    NSMutableArray *cgAry = [NSMutableArray array];
    NSMutableArray *categoryAry = [NSMutableArray array];

    
    while([resultSet next]) {
        NSString *wasteDescribe = [resultSet stringForColumn:@"DMNR"];
        NSString *wasteBH       = [resultSet stringForColumn:@"DMBH"];
        NSString *wasteFeature  = [resultSet stringForColumn:@"FWTX"];
        NSString *wasteSource   = [resultSet stringForColumn:@"HYLY"];
        NSString *categoryBH   = [resultSet stringForColumn:@"SJDMBH"];
        
        [describeAry addObject:wasteDescribe];
        [bhAry       addObject:wasteBH];
        [featureAry  addObject:wasteFeature];
        [sourAry     addObject:wasteSource];
        [cgAry addObject:categoryBH];
    }
    
    if([bhAry count] == 0){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(73, 487, 624, 29)];
        [self.view addSubview:label];
        label.text = @"未查询到相关信息，请重新输入查询条件。";
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        [label release];
        [UIView animateWithDuration:5
                         animations:^{
                             label.alpha = 0;
                         } completion:^(BOOL finished) {

                             [label removeFromSuperview];
                         }];

        return;
    }
    for (NSString *bh in cgAry) {
        sqlStr =[NSString stringWithFormat:@"select  DMBH,DMNR from dangerwaste  where DMBH = \'%@\' ",bh];
        resultSet =[database executeQuery:sqlStr];
        NSString *cg = nil;
        while([resultSet next]) {
            cg =  [resultSet stringForColumn:@"DMNR"];
        }
        
        NSString *wasteCategory = [NSString stringWithFormat:@"%@<br/>%@",bh, cg];
        
        [categoryAry addObject:wasteCategory];
        
    }

    
    [database close];
    
    
    WasteItemViewController *wasteItemViewController = [[WasteItemViewController alloc] initWithStyle:UITableViewStylePlain];
    wasteItemViewController.title = @"模糊查询";
    wasteItemViewController.wasteDeAry = describeAry;
    wasteItemViewController.wasteBHAry = bhAry;
    wasteItemViewController.wasteFeAry = featureAry;
    wasteItemViewController.wasteHlAry = sourAry;
    wasteItemViewController.wasteCgAry = categoryAry;
    
    [self.navigationController pushViewController:wasteItemViewController animated:YES];
    [wasteItemViewController release];



}


@end
