//
//  LedgerListViewController.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "TaskDetailsView.h"
#import "MBProgressHUD.h"

@interface LedgerListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate,UISearchBarDelegate,UIScrollViewDelegate,MBProgressHUDDelegate> {
    NSMutableString *currentString;
    
    UITableView *listTable;
    TaskDetailsView *childView;
    
    int currentPageIndex;
    int nParserStatus;
    BOOL isLoading;
    NSMutableArray *allAry;
    NSMutableArray *updateAllAry;
    NSMutableDictionary *dicDate;
}

@property (nonatomic, retain) NSMutableString *currentString;

@property (nonatomic, retain) IBOutlet UITableView *listTable;
@property (nonatomic, retain) TaskDetailsView *childView;
@property (nonatomic, strong) UISearchBar *_searchBar;
@property(nonatomic,assign) NSInteger pageCount;
@property(nonatomic,retain)  UIWebView *nodataWebView;
@end
