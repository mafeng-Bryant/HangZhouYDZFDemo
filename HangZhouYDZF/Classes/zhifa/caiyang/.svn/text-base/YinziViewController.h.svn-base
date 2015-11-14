//
//  YinziViewController.h
//  GMEPS_HZ
//
//  Created by sz apple on 11-10-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YinziSelectDelegate

-(void)returnSelectedYinzi:(NSString *)strName andNo:(NSString*)strNo;

@end



@interface YinziViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    //key因子大类  value 是NSMutableArray 所有该类的因子


    NSArray *arySectionValues;//因子名称
    NSArray *arySectionNoValues;//因子编号
    NSMutableArray *arySelectedIndex;
    id< YinziSelectDelegate> delegate;
    IBOutlet UITableView *yzTableView;

}

@property(nonatomic,retain) NSArray *arySectionValues;
@property(nonatomic,retain) id< YinziSelectDelegate> delegate;
@property(nonatomic,retain) UITableView *yzTableView;
@property(nonatomic,retain)  NSMutableArray *arySelectedIndex;
@property(nonatomic,retain) NSArray *arySectionNoValues;
@end
