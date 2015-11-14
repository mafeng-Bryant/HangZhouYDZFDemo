//
//  UIChargeController.h
//  EPad
//
//  Created by chen on 11-6-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIChargeController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    UISearchBar *_searchBar;
	IBOutlet UITableView *myTableView;
    NSMutableArray *dataFGBH;
	NSMutableArray *dataFGMC;
	NSMutableArray *dataWJMC;
	NSMutableArray *dataSFML;
	NSMutableArray *dataFGDH;
    
    BOOL isExisSelect;
    BOOL isSelect;
    NSString *viewTitle;
}
@property(nonatomic,retain)UITableView *myTableView;
@property(nonatomic,retain) NSMutableArray *dataFGBH;
@property(nonatomic,retain) NSMutableArray *dataFGMC;
@property(nonatomic,retain) NSMutableArray *dataWJMC;
@property(nonatomic,retain) NSMutableArray *dataSFML;
@property(nonatomic,retain) NSMutableArray *dataFGDH;


@property(nonatomic,strong) UISearchBar *_searchBar; 
@property(nonatomic,strong) NSMutableArray *saveFGMC;
@property(nonatomic,strong) NSMutableArray *allInfo;
@property(nonatomic,strong) NSString *viewTitle;
@property(nonatomic,assign) BOOL isSelect;
@property(nonatomic,assign) BOOL isExisSelect;

//-(void)searchByFIDH:(id)strFIDH;
-(void)searchByFIDH:(id)strFIDH root:(id)rootMl;

@end
