//
//  DYJLNewTableView.h
//  GMEPS_HZ
//
//  Created by ihumor on 13-4-8.
//
//

#import <UIKit/UIKit.h>
#import "TaskStatisticsItem.h"
#import "WebServiceHelper.h"

@interface DYJLNewTableView : UITableViewController <NSXMLParserDelegate>
{
    int nParserStatus;
}

@property (nonatomic, retain) TaskStatisticsItem *taskInfoItem;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *valueArr;
@property (nonatomic, strong) NSArray *titleRight;//右侧信息名称
@property (nonatomic, strong) NSArray *valueRight;//右侧信息内容
@property (nonatomic, retain) NSString *xczfbh;
@property (nonatomic, retain) WebServiceHelper *webservice;
@property (nonatomic, retain) NSMutableString *currentString;

@end
