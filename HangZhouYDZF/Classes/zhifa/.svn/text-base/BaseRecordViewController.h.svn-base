//
//  BaserecordViewController.h
//  GMEPS_HZ
//
//  Created by 文 克远 on 13-4-12.
//
//

#import <UIKit/UIKit.h>

#import "ChooseRecordViewController.h"

@interface BaseRecordViewController : UIViewController
<NSXMLParserDelegate,ChooseRecordDelegate>
//提交记录
//-(void)commitRecordDatas:(id)values;
//根据值来显示值
- (void)loadLocalSaveRecord;
-(void)displayRecordDatas:(id)values;

-(void)saveLocalRecord:(id)valueDatas;

-(void)requestServerHisRecord;

//查看历史记录
-(void)historyButClick:(id)sender;

@property(nonatomic,assign) NSInteger recordStatus;
@property(nonatomic,copy) NSString *tableName;//数据库表名
@property(nonatomic,copy) NSString *dwbh;//污染源编号
@property(nonatomic,copy) NSString *jcdw;//检查单位
@property(nonatomic,copy) NSString *jcry;//检查人员
@property(nonatomic,copy) NSString *jcsj;//检查时间
@property(nonatomic,copy) NSString *jcjssj;//检查结束时间
@property(nonatomic,copy) NSString *zfzh;//执法证号
@property(nonatomic,copy) NSString *wrymc;
@property(nonatomic,copy) NSString *xczfbh;
@property(nonatomic,assign) BOOL isSaveRecord;//YES调用最近一次暂存记录
@property(nonatomic,assign) NSInteger menuTagID;//对应按钮的tag
@property(nonatomic,assign) BOOL isHisRecord;//YES 台账中调用此界面
@property(nonatomic,retain) NSDictionary *dicWryInfo;
@end
