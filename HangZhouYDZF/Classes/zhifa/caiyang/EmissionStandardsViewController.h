//
//  EmissionStandardsViewController.h
//  GMEPS_HZ
//
//  Created by sz apple on 11-10-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StandardSelectDelegate
-(void)returnSelectedStandards:(NSArray*)aryStandards;
@end

@interface EmissionStandardsViewController : UITableViewController <UISearchBarDelegate> {
    NSMutableArray *standardSelected;
    NSMutableArray *filteredAry;
    NSArray *standardAry;
    id<StandardSelectDelegate> delegate;
}
@property (nonatomic, retain) NSMutableArray *standardSelected;
@property (nonatomic, copy) NSMutableArray *filteredAry;
@property (nonatomic, retain) NSArray *standardAry;
@property (nonatomic, assign) id<StandardSelectDelegate> delegate;
@end
