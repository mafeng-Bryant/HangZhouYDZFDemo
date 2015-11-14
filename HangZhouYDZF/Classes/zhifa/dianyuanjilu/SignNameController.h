//
//  SignNameController.h
//  GMEPS_HZ
//
//  Created by 张 仁松 on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaintingView.h"
#import "MBProgressHUD.h"
#import "ChooseRecordViewController.h"
@protocol SignameDelegate
-(void)signFinished;
@end

@class WebServiceHelper;
@interface SignNameController : UIViewController<MBProgressHUDDelegate,ChooseRecordDelegate>{
    NSInteger commitStatus;
    IBOutlet UILabel* firstNameLabel;
    IBOutlet UILabel* secondNameLabel;
    BOOL _isRecord;
    
}


@property(nonatomic,retain)UIPopoverController *popRecordController;
@property(nonatomic,retain) IBOutlet PaintingView *signView;//执法人员签名
@property(nonatomic,retain) UIImageView *signImageView;
@property(nonatomic,assign) id<SignameDelegate> delegate;
@property(nonatomic,copy) NSString *tableName;
@property(nonatomic,copy) NSString *wrybh; //单位编号
@property(nonatomic,copy) NSString *wrymc; //单位名称
@property(nonatomic,copy) NSString *firstName; //第一个执法人员签名
@property(nonatomic,copy) NSString *secondName; //第二个执法人员签名
@property(nonatomic,retain) NSMutableString *currentdata;
@property(nonatomic,assign) NSInteger lxBH;
@property(nonatomic,copy)NSString *xczfbh;
-(IBAction)clearPressed:(id)sender; //清空书写的
-(IBAction)commitPressed:(id)sender;//提交签名 然后调用delegate 提交记录


@end
