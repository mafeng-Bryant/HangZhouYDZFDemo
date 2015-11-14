//
//  SurveyTableViewController.h
//  GMEPS_HZ
//
//  Created by ZHONGWEN on 13-6-4.
//
//

#import <UIKit/UIKit.h>

@interface SurveyTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *elementAry;
@property (nonatomic, retain) NSArray *standardAry;
@property (nonatomic, retain) NSArray *actuallyAry;
@property (nonatomic, copy) NSString *headerTitle;

@end
