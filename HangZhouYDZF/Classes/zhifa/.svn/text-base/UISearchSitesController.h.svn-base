//
//  UISearchSitesController.h
//  GMEPS_HZ
//
//  Created by chen on 11-10-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSyncManager.h"
@protocol SelectSitesDelegate
-(void)returnSites:(NSDictionary*)values source:(NSInteger)type;
@end

@class WebServiceHelper;
@interface UISearchSitesController : UITableViewController 
<UISearchBarDelegate,UISearchDisplayDelegate,UIAlertViewDelegate,SyncWryListDelegate>{
   
    id<SelectSitesDelegate> delegate;
    
    BOOL bLastSelected; //是否已选过企业
    BOOL isEmpty;//是否为空
    NSString *lastCompanyName;
    UITextField *anotherCompany;
    NSInteger currentIndex;
    NSInteger currentPage;
    NSInteger nParserStatus;
    WebServiceHelper *webService;
    NSMutableString *curData;
    NSInteger data_status;
    
}
@property(nonatomic,retain) NSMutableArray *dataResultArray;
@property (nonatomic, retain) IBOutlet UISearchBar *searchDataBar;
@property (nonatomic, assign) id <SelectSitesDelegate> delegate;

@property (nonatomic, assign) BOOL bLastSelected;
@property (nonatomic, assign) BOOL  isEnable;
@property (nonatomic, copy)NSString *lastCompanyName;

-(IBAction)cancelSelect:(id)sender;

@end
