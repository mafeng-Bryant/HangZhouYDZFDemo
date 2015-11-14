//
//  AccessoryLsitViewController.h
//  GMEPS_HZ
//
//  Created by TianZhuLi on 14-3-21.
//
//

#import <UIKit/UIKit.h>
#import "AccessoryItem.h"
#import "LTZProjectApprovalOpinionDetailViewController.h"
#import "GMEPS_HZAppDelegate.h"
#import "ImgDetailController.h"

extern GMEPS_HZAppDelegate *g_appDelegate;

@interface AccessoryLsitViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>



@property(strong,nonatomic)IBOutlet UITableView *listTableView;

@property(strong,nonatomic)NSArray *listArray;

@property(strong,nonatomic)NSString *urlString;

- (id)initWithAccessoryArray:(NSArray *)array;
@end
