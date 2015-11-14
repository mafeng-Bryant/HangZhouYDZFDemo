//
//  BaserecordViewController.h
//  GMEPS_HZ
//
//  Created by 文 克远 on 13-4-12.
//
//


#import <UIKit/UIKit.h>

#import "ChooseRecordViewController.h"
#import "UISearchSitesController.h"

@interface OutBaseRecordViewController : UIViewController
<NSXMLParserDelegate,ChooseRecordDelegate,SelectSitesDelegate>{
    UIButton *btnTitleView;
}
//提交记录
-(void)commitRecordDatas:(NSString*)commandSql;
//根据值来显示值
-(void)displayRecordDatas:(id)values;

-(void)saveLocalRecord:(id)valueDatas;

-(void)generateXCZFBH;
@property(nonatomic,assign) NSInteger recordStatus;
@property(nonatomic,copy) NSString *tableName;//数据库表名
@property(nonatomic,copy) NSString *dwbh;
@property(nonatomic,copy) NSString *wrymc;
@property(nonatomic,copy) NSString *xczfbh;
@property(nonatomic,assign) NSInteger menuTagID;//对应按钮的tag
@property(nonatomic,assign) BOOL isHisRecord;//YES 台账中调用此界面
@property(nonatomic,retain)NSDictionary *dicWryInfo;
@end
