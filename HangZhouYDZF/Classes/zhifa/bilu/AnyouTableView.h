//
//  AnyouTableView.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnyouDelegate
- (void)returnSelectedAnyou:(NSString *)anyou andRow:(NSInteger)row;
@end

@interface AnyouTableView : UITableViewController
<UISearchBarDelegate>{
    NSMutableArray *filteredAry;
    
    NSArray *anyouAry;
	id<AnyouDelegate> delegate;
    
}


@property(nonatomic,copy) NSArray *anyouAry;
@property (nonatomic, assign) id <AnyouDelegate> delegate;

@property(nonatomic,retain)NSMutableArray *filteredAry;
@end
