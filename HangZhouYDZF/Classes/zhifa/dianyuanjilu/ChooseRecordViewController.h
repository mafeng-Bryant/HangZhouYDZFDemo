//
//  ChooseRecordViewController.h
//  GMEPS_HZ
//
//  Created by power humor on 12-7-27.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChooseRecordDelegate

-(void)returnInfo:(id)values;

@end
@interface ChooseRecordViewController : UITableViewController
{

}
@property(nonatomic,retain)NSMutableString *currentdata;
@property(nonatomic,assign)BOOL isGetHistory;
@property(nonatomic,strong)NSString *blName;  //指定的执法记录
@property(nonatomic,strong)NSString *wrymc;
@property(nonatomic,strong)NSString *type; //区分水与气
@property(nonatomic,strong)NSArray *chooseAry;
@property (nonatomic, assign) id<ChooseRecordDelegate> delegate;

@end
