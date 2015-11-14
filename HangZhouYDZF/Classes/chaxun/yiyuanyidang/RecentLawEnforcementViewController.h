//
//  RecentLawEnforcementViewController.h
//  GMEPS_HZ
//
//  Created by TianZhuLi on 14-3-24.
//
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "MBProgressHUD.h"
#import "GMEPS_HZAppDelegate.h"
#import "UserInfo.h"
#import "JSONKit.h"
#import "TaskDetailsView.h"
#import "UITableViewCell+Custom.h"

extern UserInfo *g_logedUserInfo;
extern GMEPS_HZAppDelegate *g_appDelegate;

@interface RecentLawEnforcementViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)NSString *WRYBH;
@property(strong,nonatomic)NSString *WRYMC;
@property(strong,nonatomic)IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSMutableDictionary *dicDate;
@property(assign,nonatomic)int currentPageIndex;
@property(assign,nonatomic)int nParserStatus;
@property(assign,nonatomic)BOOL isLoading;
//@property(assign,nonatomic)BOOL requestForWRYMC;            //是否是请求污染源名称
@property(strong,nonatomic)NSMutableArray *allAry;          //历史移动执法记录的数组
@property (nonatomic, retain) NSMutableString *currentString;

@property(nonatomic,strong) WebServiceHelper *webService;
@property(nonatomic,strong)NSString *jsonString;
@property(nonatomic,strong)TaskDetailsView *childView;

- (id)initWithWRYBH:(NSString *)wrybh;

@end
