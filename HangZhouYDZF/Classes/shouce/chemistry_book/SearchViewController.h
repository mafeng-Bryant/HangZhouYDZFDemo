//
//  SearchViewController.h
//  handbook
//
//  Created by chen on 11-4-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//查询的结果

#import <UIKit/UIKit.h>


@interface SearchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {

	
	IBOutlet UITableView *resultTableView;
	NSMutableArray *dataResultArray;
	  
}

@property(nonatomic,retain)UITableView *resultTableView;

@property(nonatomic,retain)NSMutableArray *dataResultArray;



@end
