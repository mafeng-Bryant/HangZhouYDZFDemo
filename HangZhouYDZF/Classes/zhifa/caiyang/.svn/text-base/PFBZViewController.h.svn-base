//
//  PFBZViewController.h
//  GMEPS_HZ
//
//  Created by  on 11-10-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
// 选择排放标准

#import <UIKit/UIKit.h>

#import "QQSectionHeaderView.h"

@protocol BiaoZhunSelectDelegate

-(void)returnSelectedBiaoZhun:(NSString*)strBZ;

@end



@interface PFBZViewController : UITableViewController
{
    NSArray *aryItems;
    NSArray *aryTitles;
    id<BiaoZhunSelectDelegate> delegate;
    int iSelIndex[5]; //-1表示什么也没选 
    
}
@property(nonatomic,assign)id<BiaoZhunSelectDelegate> delegate;

@end
