    //
//  psMainViewController.m
//  PollutionStatistics
//
//  Created by hejunhua on 11-9-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//14 119 740 800

#import "psMainViewController.h"
#import "DistrictStatisticsView.h"
#import "TypeStatisticsView.h"
#import "RegulatoryLevelStatisticsView.h"
#import "FirmSizeStatisticsView.h"
#import "industrialClassificationView.h"
#import "GMEPS_HZAppDelegate.h"
#import "UserInfo.h"

extern GMEPS_HZAppDelegate *g_appDelegate;
extern UserInfo *g_logedUserInfo;

@implementation psMainViewController
@synthesize viewController,childView;
@synthesize webservice;
@synthesize currentString;
@synthesize districts,regulatoryLevel,business,industry,firmSize;
@synthesize staItem;

- (IBAction)buttonPressed:(id)sender {
    UISegmentedControl *segCtrl = (UISegmentedControl *)sender;
    currentTag = segCtrl.selectedSegmentIndex;
    UIViewController *aViewCtrl;
    switch (currentTag) {
        case 0:
        {
            aViewCtrl = (UIViewController *)[viewController objectAtIndex:0];
            [childView addSubview:aViewCtrl.view];
            [childView setNeedsDisplay];
        }
            break;
        
        case 1:
        {
            aViewCtrl = (UIViewController *)[viewController objectAtIndex:1];
            [childView addSubview:aViewCtrl.view];
            [childView setNeedsDisplay];
        }
            break;
            
        case 2:
        {
            aViewCtrl = (UIViewController *)[viewController objectAtIndex:2];
            [childView addSubview:aViewCtrl.view];
            [childView setNeedsDisplay];
        }
            break;
            
        case 3:
        {
            aViewCtrl = (UIViewController *)[viewController objectAtIndex:3];
            [childView addSubview:aViewCtrl.view];
            [childView setNeedsDisplay];
        }
            break;
            
        case 4:
        {
            aViewCtrl = (UIViewController *)[viewController objectAtIndex:4];
            [childView addSubview:aViewCtrl.view];
            [childView setNeedsDisplay];
        }
            break;
            
        default:
            break;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"污染源统计类型";
	
    NSString *URL = [NSString  stringWithFormat: kStatistics_URL,g_appDelegate.ServerIP];
    NSString* params = [WebServiceHelper createParametersWithKey:@"userName"
                                                value:g_logedUserInfo.userName,@"UDID",g_appDelegate.udid,nil];
    
    webservice = [[WebServiceHelper alloc] initWithUrl:URL method:@"GetPollutionInfo_Log_UDID" view:self.view nameSpace:KSoapNameSpace parameters:params delegate:self];
    webservice.hudTitle = @"正在获取污染源统计数据，请稍候...";
    [webservice run];
    
	
    
   
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[viewController release];
    [childView release];
    [webservice release];
    [currentString release];
    
    [districts release];
    [business release];
    [firmSize release];
    [regulatoryLevel release];
    [industry release];
    
    [staItem release];
    [super dealloc];
}

#pragma mark -
#pragma mark NSXMLParser Delegate Method


- (void)parserDidStartDocument:(NSXMLParser *)parser {
	nParserStatus = -1;
    bDItem = NO;
    bBItem = NO;
    bIItem = NO;
    bFItem = NO;
    bRItem = NO;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:@"SSQY"]) {
        bDItem = YES;
        staItem = [[StatisticsItem alloc] initWithNone];
    } else if ([elementName isEqualToString:@"上城区"]) {
        nParserStatus = 0;
        [staItem.tj addObject:@"上城区"];
    } else if ([elementName isEqualToString:@"下城区"]) {
        nParserStatus = 1;
        [staItem.tj addObject:@"下城区"];
    } else if ([elementName isEqualToString:@"江干区"]) {
        nParserStatus = 2;
        [staItem.tj addObject:@"江干区"];
    } else if ([elementName isEqualToString:@"拱墅区"]) {
        nParserStatus = 3;
        [staItem.tj addObject:@"拱墅区"];
    } else if ([elementName isEqualToString:@"西湖区"]) {
        nParserStatus = 4;
        [staItem.tj addObject:@"西湖区"];
    } else if ([elementName isEqualToString:@"下沙区"]) {
        nParserStatus = 5;
        [staItem.tj addObject:@"下沙区"];
    } else if ([elementName isEqualToString:@"滨江区"]) {
        nParserStatus = 6;
        [staItem.tj addObject:@"滨江区"];
    } else if ([elementName isEqualToString:@"萧山区"]) {
        nParserStatus = 7;
        [staItem.tj addObject:@"萧山区"];
    } else if ([elementName isEqualToString:@"余杭区"]) {
        nParserStatus = 8;
        [staItem.tj addObject:@"余杭区"];
    } else if ([elementName isEqualToString:@"西湖名胜风景区"]) {
        nParserStatus = 9;
        [staItem.tj addObject:@"西湖名胜风景区"];
    } else if ([elementName isEqualToString:@"桐庐县"]) {
        nParserStatus = 10;
        [staItem.tj addObject:@"桐庐区"];
    } else if ([elementName isEqualToString:@"淳安县"]) {
        nParserStatus = 11;
        [staItem.tj addObject:@"淳安县"];
    } else if ([elementName isEqualToString:@"建德市"]) {
        nParserStatus = 12;
        [staItem.tj addObject:@"建德市"];
    } else if ([elementName isEqualToString:@"富阳市"]) {
        nParserStatus = 13;
        [staItem.tj addObject:@"富阳市"];
    } else if ([elementName isEqualToString:@"临安市"]) {
        nParserStatus = 14;
        [staItem.tj addObject:@"临安市"];
    } else if ([elementName isEqualToString:@"DWLX"]) {
        bBItem = YES;
        staItem = [[StatisticsItem alloc] initWithNone];
    } else if ([elementName isEqualToString:@"工业"]) {
        nParserStatus = 15;
        [staItem.tj addObject:@"工业"];
    } else if ([elementName isEqualToString:@"市政设施"]) {
        nParserStatus = 16;
        [staItem.tj addObject:@"市政设施"];
    } else if ([elementName isEqualToString:@"JGJB"]) {
        bRItem = YES;
        staItem = [[StatisticsItem alloc] initWithNone];
    } else if ([elementName isEqualToString:@"国控企业"]) {
        nParserStatus = 17;
        [staItem.tj addObject:@"国控企业"];
    } else if ([elementName isEqualToString:@"省控企业"]) {
        nParserStatus = 18;
        [staItem.tj addObject:@"省控企业"];
    } else if ([elementName isEqualToString:@"市控企业"]) {
        nParserStatus = 19;
        [staItem.tj addObject:@"市控企业"];
    } else if ([elementName isEqualToString:@"挂牌企业"]) {
        nParserStatus = 20;
        [staItem.tj addObject:@"挂牌企业"];
    } else if ([elementName isEqualToString:@"常规监管企业"]) {
        nParserStatus = 21;
        [staItem.tj addObject:@"常规监管企业"];
    } else if ([elementName isEqualToString:@"三同时企业"]) {
        nParserStatus = 22;
        [staItem.tj addObject:@"三同时企业"];
    } else if ([elementName isEqualToString:@"限期整改企业"]) {
        nParserStatus = 23;
        [staItem.tj addObject:@"限期整改企业"];
    } else if ([elementName isEqualToString:@"限期治理企业"]) {
        nParserStatus = 24;
        [staItem.tj addObject:@"限期治理企业"];
    } else if ([elementName isEqualToString:@"其他"]) {
        nParserStatus = 25;
        [staItem.tj addObject:@"其他"];
    } else if ([elementName isEqualToString:@"QYGM"]) {
        bFItem = YES;
        staItem = [[StatisticsItem alloc] initWithNone];
    } else if ([elementName isEqualToString:@"特大型"]) {
        nParserStatus = 26;
        [staItem.tj addObject:@"特大型"];
    } else if ([elementName isEqualToString:@"大一型"]) {
        nParserStatus = 27;
        [staItem.tj addObject:@"大一型"];
    } else if ([elementName isEqualToString:@"大二型"]) {
        nParserStatus = 28;
        [staItem.tj addObject:@"大二型"];
    } else if ([elementName isEqualToString:@"中一型"]) {
        nParserStatus = 29;
        [staItem.tj addObject:@"中一型"];
    } else if ([elementName isEqualToString:@"中二型"]) {
        nParserStatus = 30;
        [staItem.tj addObject:@"中二型"];
    } else if ([elementName isEqualToString:@"小型"]) {
        nParserStatus = 31;
        [staItem.tj addObject:@"小型"];
    } else if ([elementName isEqualToString:@"HYLX"]) {
        bIItem = YES;
        staItem = [[StatisticsItem alloc] initWithNone];
    } else if ([elementName isEqualToString:@"采矿业"]) {
        nParserStatus = 32;
        [staItem.tj addObject:@"采矿业"];
    } else if ([elementName isEqualToString:@"制造业"]) {
        nParserStatus = 33;
        [staItem.tj addObject:@"制造业"];
    } else if ([elementName isEqualToString:@"其它"]) {
        nParserStatus = 34;
        [staItem.tj addObject:@"其他"];
    } else if ([elementName isEqualToString:@"电力燃气及水的生产和供应业"]) {
        nParserStatus = 35;
        [staItem.tj addObject:@"电力燃气及水的生产和供应"];
    } else 
        nParserStatus = -1;
        
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (nParserStatus >= 0){
		if (!currentString)
			currentString = [NSMutableString string];
		[currentString appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

	if (nParserStatus >= 0){
        NSString *copyString = [currentString copy];
		[staItem.count addObject:copyString];
        [copyString release];
        nParserStatus = -1;
        currentString = nil;
	} else {
		if (bDItem) {
			if (!districts)
				districts = [[NSArray alloc] initWithObjects:staItem, nil];
			[staItem release];
			bDItem = NO;
		} else if (bBItem) {
			if (!business)
				business = [[NSArray alloc] initWithObjects:staItem, nil];
			[staItem release];
			bBItem = NO;
		} else if (bRItem) {
			if (!regulatoryLevel)
				regulatoryLevel = [[NSArray alloc] initWithObjects:staItem, nil];
			[staItem release];
			bRItem = NO;
		} else if (bFItem) {
			if (!firmSize)
				firmSize = [[NSArray alloc] initWithObjects:staItem, nil];
			[staItem release];
			bFItem = NO;
		} else if (bIItem) {
			if (!industry)
				industry = [[NSArray alloc] initWithObjects:staItem, nil];
			[staItem release];
			bIItem = NO;
		}
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
        
    //按行政所在区统计
    NSArray *dsAry = [[NSArray alloc] initWithArray:districts];
    DistrictStatisticsView *dsView = [[DistrictStatisticsView alloc] initWithNibName:@"DistrictStatisticsView" bundle:nil];
    dsView.pollution = dsAry;
    [controllers addObject:dsView];
    [dsAry release];
    [dsView release];
        
    //按单位类型统计
    NSArray *tsAry = [[NSArray alloc] initWithArray:business];
    TypeStatisticsView *tsView = [[TypeStatisticsView alloc] initWithNibName:@"TypeStatisticsView" bundle:nil];
    tsView.pollution = tsAry;
    [controllers addObject:tsView];
    [tsAry release];
    [tsView release];
        
    //按环保监管级别统计
    NSArray *rsAry = [[NSArray alloc] initWithArray:regulatoryLevel];
    RegulatoryLevelStatisticsView *rsView = [[RegulatoryLevelStatisticsView alloc] initWithNibName:@"RegulatoryLevelStatisticsView" bundle:nil];
    rsView.pollution = rsAry;
    [controllers addObject:rsView];
    [rsAry release];
    [rsView release];
        
    //按企业规模统计
    NSArray *fsAry = [[NSArray alloc] initWithArray:firmSize];
    FirmSizeStatisticsView *fsView = [[FirmSizeStatisticsView alloc] initWithNibName:@"FirmSizeStatisticsView" bundle:nil];
    fsView.pollution = fsAry;
    [controllers addObject:fsView];
    [fsAry release];
    [fsView release];
        
    //按工业污染源分类管理统计
    NSArray *isAry = [[NSArray alloc] initWithArray:industry];
    industrialClassificationView *isView = [[industrialClassificationView alloc] initWithNibName:@"industrialClassificationView" bundle:nil];
    isView.pollution = isAry;
    [controllers addObject:isView];
    [isAry release];
    [isView release];
        
    self.viewController = controllers;
    [controllers release];
    
        
    UIViewController *aViewCtrl;
    aViewCtrl = (UIViewController *)[viewController objectAtIndex:0];
    [childView addSubview:aViewCtrl.view];
    [childView setNeedsDisplay];
}

@end
