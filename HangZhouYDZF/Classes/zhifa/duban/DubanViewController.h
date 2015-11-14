//
//  DubanViewController.h
//  EPad
//
//  Created by chen on 11-9-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServiceHelper.h"
#import "DBRWInfoItem.h"


@interface DubanViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource> {

    IBOutlet UITableView *myTableView;
    NSMutableString  *curData;
    
    DBRWInfoItem *aInfoItem;
    BOOL bWebServiceForTodo;
    
    NSMutableArray *aryTodoItems;
    int nParserStatus;
    
    NSMutableArray *arySendItems;
    
    BOOL bToDoWebService;
}

@property(nonatomic,retain) UITableView *myTableView;

@property(nonatomic,retain) NSMutableString  *curData;
@property(nonatomic,retain) DBRWInfoItem *aInfoItem;
@property(nonatomic,retain) NSMutableArray *aryTodoItems;
@property(nonatomic,retain) NSMutableArray *arySendItems;
@end
