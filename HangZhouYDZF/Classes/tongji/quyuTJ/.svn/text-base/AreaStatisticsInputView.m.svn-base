//
//  AreaStatisticsInputView.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AreaStatisticsInputView.h"
#import "ChartItem.h"
#import "TaskListView.h"
#import "GMEPS_HZAppDelegate.h"
#import "UserInfo.h"

extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;

@implementation AreaStatisticsInputView
@synthesize currentString,currentCondition;
@synthesize staCountArr,biluNameArr;
@synthesize staTypeArr,biluCountArr;
@synthesize currentCode;
@synthesize allInfoArr,tableNameArr;
@synthesize tmpItem,nParserStatus,bItem;

@synthesize beginDateValue;
@synthesize endDateValue;
@synthesize popView;
@synthesize resultTable,resultTable2;
@synthesize chartView;


- (void)popingInputView {
    popView = [[PopInputView alloc] initWithNibName:@"PopInputView" bundle:nil];
	popView.areaParentView = self;
    popView.parentTag = 0;
    
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:popView];
	nav.modalPresentationStyle =  UIModalPresentationFormSheet;
	[self presentModalViewController:nav animated:YES];
	nav.view.superview.frame = CGRectMake((768-380)/2, 240, 380, 250);
	// nav.view.superview.center = self.view.center;
	[nav release];
}

- (void)initWithBeginDate:(NSString *)bdValue endDate:(NSString *)edValue {
    if (staTypeArr) {
        [staTypeArr removeAllObjects];
    }
    if (staCountArr) {
        [staCountArr removeAllObjects];
    }
    if (allInfoArr) {
        [allInfoArr removeAllObjects];
    }
    
        self.beginDateValue = bdValue;
        self.endDateValue = edValue;
        self.resultTable.hidden = YES;
        self.resultTable2.hidden = YES;
    chartView.hidden = YES;
   
	
    NSString *param = [WebServiceHelper createParametersWithKey:@"beginDate" value:self.beginDateValue,@"endDate",self.endDateValue,@"orgid",g_logedUserInfo.userORGID,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    NSString *nameSpace = @"http://Services.MobileLaw.Powerdata.com/";
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    NSString *method = @"GetTaskBasicsByArea_Log_UDID";
    WebServiceHelper *webservice = [[WebServiceHelper alloc] initWithUrl:URL
                                                                  method:method
                                                                    view:self.view
                                                               nameSpace:nameSpace
                                                              parameters:param
                                                                delegate:self];
    
    webservice.hudTitle = @"正在查询区域统计数据，请稍候...";
    [webservice run];

    
    
    // Regisete for HUD callbacks so we can remove it from the window at the right time
    

//    NSString *param = [WebServiceHelper createParametersWithKey:@"beginDate" value:bdValue,@"endDate",edValue,@"orgid",g_logedUserInfo.userORGID,nil];
//    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
//    webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetTaskBasicsByArea" view:self.view  nameSpace:@"http://Services.MobileLaw.Powerdata.com/" parameters:param delegate:self];
//    webservice.hudTitle = @"正在获取数据，请稍候...";
//    [webservice run];
}



- (void)addChart {
    [chartView clearItems];
    
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    ChartItem *aItem;
    NSMutableArray *colorAry = [[[NSMutableArray alloc] initWithCapacity:20] autorelease];
    [ChartItem makeColorArray:colorAry];
    UIColor *aColor;
    for (int i = 0; i < [staCountArr count]; i++) {
        aColor = [colorAry objectAtIndex:i];
        aItem = [ChartItem itemWithValue:[[staCountArr objectAtIndex:i] intValue]*1.0f Name:[staTypeArr objectAtIndex:i] Color:aColor.CGColor];
        [itemArray addObject:aItem];
    }
    		
    [chartView addGroupArray:itemArray withGroupName:@""];
    [chartView setHidden:NO];
    [chartView setNeedsDisplay];
    [itemArray release];

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"区域统计图表结果";
    
    NSDate *today = [NSDate date];
      
    
       
    UIBarButtonItem *aItem = [[UIBarButtonItem alloc] initWithTitle:@"输入起止时间" style:UIBarButtonItemStylePlain
															 target:self
															 action:@selector(popingInputView)];
	self.navigationItem.rightBarButtonItem = aItem;
    
    NTChartView *chart = [[NTChartView alloc] initWithFrame:CGRectMake(15, 15, 738, 530)];
    [self.view addSubview:chart];
    self.chartView = chart;
    [chart release];
    
    self.tableNameArr = [NSArray arrayWithObjects:@"T_YDZF_WRYXCJCJL",@"T_YDZF_KYBL",@"T_YDZF_XCJCYJSZ",@"T_YDZF_XCZFGZS",@"T_YDZF_DCXWBL",@"T_YDZF_QYPF",@"T_YDZF_WRYFSCY",@"T_YDZF_ZXXCDFB1",@"T_YDZF_ZXXCDFB2",@"T_JCGL_XCZF_JBXX",nil];
//    self.tableNameArr = [NSArray arrayWithObjects:@"T_JCGL_XCZF_JBXX",@"T_YDZF_QYPF",@"T_YDZF_WRYFSCY",@"T_YDZF_KYBL",@"T_YDZF_XCZFGZS",@"T_YDZF_XCJCYJSZ",@"T_YDZF_DCXWBL",@"T_YDZF_JSXMGZB",nil];
//    self.biluNameArr = [NSArray arrayWithObjects:@"点源记录历史数据",@"企业评分",@"废水采样",@"现场勘验",@"执法告知",@"监察意见",@"询问记录",@"建设项目跟踪", nil];
     self.biluNameArr = [NSArray arrayWithObjects:@"污染源现场检查记录",@"现场勘验",@"监察意见",@"执法告知",@"询问记录",@"企业评分",@"废水采样",@"在线现场打分表气",@"在线现场打分表水",@"点源记录历史数据",nil];
    self.biluCountArr = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    self.currentCode = @"";
    self.currentCondition = @"";
    
    self.endDateValue = [[[NSString alloc] initWithFormat:@"%@",[[today description] substringToIndex:10]] autorelease];
    self.beginDateValue = @"1990-01-01";
    
    NSString *param = [WebServiceHelper createParametersWithKey:@"beginDate" value:self.beginDateValue,@"endDate",self.endDateValue,@"orgid",g_logedUserInfo.userORGID,@"userName",g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    NSString *nameSpace = @"http://Services.MobileLaw.Powerdata.com/";
    NSString *URL = [NSString  stringWithFormat: kTaskService_URL,g_appDelegate.ServerIP];
    NSString *method = @"GetTaskBasicsByArea_Log_UDID";
    WebServiceHelper *webservice = [[WebServiceHelper alloc] initWithUrl:URL
                                                method:method
                                                  view:self.view
                                             nameSpace:nameSpace
                                            parameters:param
                                              delegate:self];
    
    webservice.hudTitle = @"正在获取数据，请稍候...";
    [webservice run];

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [currentString release];
    [staTypeArr release];
    [staCountArr release];
    [allInfoArr release];
    [beginDateValue release];
    [endDateValue release];
    [resultTable release];
    [chartView release];
    [popView release];
    [super dealloc];
}

#pragma mark - NSXMLParser Delegate Method

#define kXZQH 0
#define kRWZS 1
#define kDYJL 2
#define kQYPF 3
#define kFSCY 4
#define kXCKY 5
#define kZFGZ 6
#define kJCYJ 7
#define kXWBL 8
#define kZXDFQ 9
#define kZXDFS 10
#define kCode 11
#define kWRYXCJCJL 12

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    bItem = NO;
	nParserStatus = -1;
    self.currentString = [NSMutableString string];
    self.allInfoArr = [[[NSMutableArray alloc] init] autorelease];
    self.staTypeArr = [[[NSMutableArray alloc] init] autorelease];
    self.staCountArr = [[[NSMutableArray alloc] init] autorelease];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"任务总数"])
		nParserStatus = kRWZS;
	if ([elementName isEqualToString:@"点源记录历史数据"])
		nParserStatus = kDYJL;
    if ([elementName isEqualToString:@"企业评分"])
        nParserStatus = kQYPF;
    if ([elementName isEqualToString:@"废水采样"])
        nParserStatus = kFSCY;
    if ([elementName isEqualToString:@"现场勘验"])
        nParserStatus = kXCKY;
    if ([elementName isEqualToString:@"执法告知书"])
        nParserStatus = kZFGZ;
    if ([elementName isEqualToString:@"监察意见书"])
        nParserStatus = kJCYJ;
    if ([elementName isEqualToString:@"询问笔录"])
        nParserStatus = kXWBL;
    if ([elementName isEqualToString:@"在线现场打分表气"]) {
        nParserStatus = kZXDFQ;
    }
    if ([elementName isEqualToString:@"在线现场打分表水"]) {
        nParserStatus = kZXDFS;
    }
    if ([elementName isEqualToString:@"行政区划"])
        nParserStatus = kXZQH;
    if ([elementName isEqualToString:@"区域代码"])
        nParserStatus = kCode;
    if ([elementName isEqualToString:@"污染源现场检查记录"])
        nParserStatus = kWRYXCJCJL;
    
    if ([elementName isEqualToString:@"TmpName"]) {
        bItem = YES;
         tmpItem = [[StatisticsListItem alloc] init];
    }
    
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (nParserStatus >= 0){
		[currentString appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if (nParserStatus >= 0) {
        switch (nParserStatus) {
            case kRWZS:
                tmpItem.taskCount = currentString;
                break;
            
            case kDYJL:
                tmpItem.dyjlCount = currentString;
                break;
                
            case kQYPF:
                tmpItem.qypfCount = currentString;
                break;
            
            case kFSCY:
                tmpItem.fscyCount = currentString;
                break;
                
            case kXCKY:
                tmpItem.xckyCount = currentString;
                break;
            
            case kZFGZ:
                tmpItem.zfgzCount = currentString;
                break;
                
            case kJCYJ:
                tmpItem.jcyjCount = currentString;
                break;
                
            case kXWBL:
                tmpItem.xwblCount = currentString;
                break;
            case kZXDFQ:
                tmpItem.xcdfqCount = currentString;
                break;
            case kZXDFS:
                tmpItem.xcdfsCount = currentString;
                break;
            case kWRYXCJCJL:
                tmpItem.wryxcjcjlCount = currentString;
                break;
            
            case kXZQH:
                tmpItem.condition = currentString;
                break;
            
            case kCode:
                tmpItem.conditionCode = currentString;
                break;
                
            default:
                break;
        }
        
        
        nParserStatus = -1;
        [self.currentString setString:@""];
    }
    
    if (bItem && [elementName isEqualToString:@"TmpName"]) {
        [allInfoArr addObject:tmpItem];
        [tmpItem release];
        
        bItem = NO;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
   
    self.resultTable.hidden = NO;
    self.resultTable2.hidden = NO;
    if ([allInfoArr count] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"查询时间段内没有任务！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        self.biluCountArr = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
        self.currentCondition = @"";
        
    } else {

        for (int i = 0;i < [allInfoArr count]; i++) {
            StatisticsListItem *aItem = [allInfoArr objectAtIndex:i];
            [self.staTypeArr addObject:aItem.condition];
            [self.staCountArr addObject:aItem.taskCount];
            if (i == 0) {
//                self.biluCountArr = [NSArray arrayWithObjects:aItem.dyjlCount,aItem.qypfCount,aItem.fscyCount,aItem.xckyCount,aItem.zfgzCount,aItem.jcyjCount,aItem.xwblCount,aItem.jsxmgzbCount, nil];
                self.biluCountArr = [NSArray arrayWithObjects:aItem.wryxcjcjlCount,aItem.xckyCount,aItem.jcyjCount,aItem.zfgzCount,aItem.xwblCount,aItem.qypfCount,aItem.fscyCount,aItem.xcdfqCount,aItem.xcdfsCount,aItem.dyjlCount,nil];
                self.currentCondition = aItem.condition;
                self.currentCode = aItem.conditionCode;
            }
        }
    }
    [self addChart];
    chartView.hidden = NO;
    [resultTable2 reloadData];
    [resultTable reloadData];

}


#pragma mark - Table View DataSource Methods

- (UITableViewCell*) getCell:(NSString*) CellIdentifier forTablieView:(UITableView*) tableView
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	return cell;
}

-(UITableViewCell*)makeSubCell:(UITableView *)tableView
					 withValue:(NSArray *)valueArray
{
	UILabel* lblTitle = nil;
	UILabel* lblValue = nil;
    
	UITableViewCell* aCell = [self getCell:@"Cell_resultTable" forTablieView:tableView];
	
	if (aCell.contentView != nil)
	{
		lblTitle = (UILabel *)[aCell.contentView viewWithTag:1];
		lblValue = (UILabel *)[aCell.contentView viewWithTag:2];

	}
	
	if (lblTitle == nil) {
		CGRect tRect1 = CGRectMake(0, 5, 200, 44);
		lblTitle = [[UILabel alloc] initWithFrame:tRect1]; //此处使用id定义任何控件对象
		[lblTitle setBackgroundColor:[UIColor clearColor]];
		[lblTitle setTextColor:[UIColor blackColor]];
		lblTitle.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblTitle.textAlignment = UITextAlignmentCenter;
        lblTitle.numberOfLines = 2;
		lblTitle.tag = 1;
		[aCell.contentView addSubview:lblTitle];
		[lblTitle release];
		
		CGRect tRect2 = CGRectMake(250, 5, 100, 44);
		lblValue = [[UILabel alloc] initWithFrame:tRect2]; //此处使用id定义任何控件对象
		[lblValue setBackgroundColor:[UIColor clearColor]];
		[lblValue setTextColor:[UIColor blackColor]];
		lblValue.font = [UIFont fontWithName:@"Helvetica" size:15.0];
		lblValue.textAlignment = UITextAlignmentCenter;
		lblValue.tag = 2;	
		[aCell.contentView addSubview:lblValue];
		[lblValue release];
        
	}
	
	if (lblTitle != nil)	[lblTitle setText:[valueArray objectAtIndex:0]];
	if (lblValue != nil)	[lblValue setText:[valueArray objectAtIndex:1]];
    
	if ([[valueArray objectAtIndex:1] intValue] == 0) {
        aCell.selectionStyle = UITableViewCellSelectionStyleNone;
        aCell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        aCell.selectionStyle = UITableViewCellSelectionStyleBlue;
        aCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
	return aCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView.tag == 1)
        return @"             行政区划             任务总数";
    else
        return self.currentCondition;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1)
        return [allInfoArr count];
    else
        return [biluNameArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView.tag == 1)
        return 44;
    else
        return 51;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
    
    UITableViewCell *cell;
    if (tableView.tag == 1) {
        StatisticsListItem *aItem = [allInfoArr objectAtIndex:row];
        NSArray *valueAry = [NSArray arrayWithObjects:aItem.condition,aItem.taskCount, nil];

        cell= [self makeSubCell:tableView withValue:valueAry];
    } else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"biluCount_Cell"];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"biluCount_Cell"] autorelease];
        }
        
        if (row == 8) {
            NSLog(@"break");
        }
        cell.textLabel.text = [biluNameArr objectAtIndex:row];
        cell.detailTextLabel.text = [biluCountArr objectAtIndex:row];
        
        if ([[biluCountArr objectAtIndex:row] intValue] == 0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }

    }
    
	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2 == 0 && tableView.tag == 1)
        cell.backgroundColor = LIGHT_BLUE_UICOLOR;
}

#pragma mark - TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1) {
        StatisticsListItem *aItem = [allInfoArr objectAtIndex:indexPath.row];
        
        if ([aItem.taskCount intValue] > 0) {
//            self.biluCountArr = [NSArray arrayWithObjects:aItem.dyjlCount,aItem.qypfCount,aItem.fscyCount,aItem.xckyCount,aItem.zfgzCount,aItem.jcyjCount,aItem.xwblCount,aItem.jsxmgzbCount, nil];
             self.biluCountArr = [NSArray arrayWithObjects:aItem.wryxcjcjlCount,aItem.xckyCount,aItem.jcyjCount,aItem.zfgzCount,aItem.xwblCount,aItem.qypfCount,aItem.fscyCount,aItem.xcdfqCount,aItem.xcdfsCount,aItem.dyjlCount,nil];
            self.currentCode = aItem.conditionCode;
            self.currentCondition = aItem.condition;
            [self.resultTable2 reloadData];
        }
    } else {
        
        if ([[biluCountArr objectAtIndex:indexPath.row] intValue] > 0) {
            TaskListView *childView = [[[TaskListView alloc] initWithNibName:@"TaskListView" bundle:nil] autorelease];
            
            [childView setConditionStr:self.currentCode];
            [childView setBeginDateStr:self.beginDateValue];
            [childView setEndDateStr:self.endDateValue];
            [childView setStatisticsTag:0];
            [childView setTableName:[tableNameArr objectAtIndex:indexPath.row]];
            
            [self.navigationController pushViewController:childView animated:YES];
            
        }
    }
}

@end
