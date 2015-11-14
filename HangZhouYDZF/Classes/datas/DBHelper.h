//
//  DBHelper.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DBHelper : NSObject
+ (DBHelper *) sharedInstance;


//插入数据到本地数据库
-(void)insertTable:(NSString*)tableName andDatas:(NSArray*)aryItems; 
//添加新的污染源，没有污染源编号
-(BOOL)addNewWry:(NSDictionary*)values;
//更新污染源
-(BOOL)updateWry:(NSDictionary*)values byWryBH:(NSString*)wrybh;
//添加污染源
-(BOOL)insertWry:(NSDictionary*)values byWryBH:(NSString*)wrybh;
//查询指定管辖归属的污染源
-(NSArray*)queryWryListByRule:(NSString*)orgid;

//查询指定管辖归属的污染源名称污染源列表
-(NSArray*)queryWryListByRule:(NSString *)orgid Name:(NSString*)name;

-(BOOL)saveSignName:(NSData *)imageData XCZFBH:(NSString*)bh WRYMC:(NSString*)mc TableName:(NSString*)tableName JCR:(NSString*)jcr;


-(BOOL)saveRecord:(NSString*)jsonStr XCZFBH:(NSString*)bh WRYMC:(NSString*)mc TableName:(NSString*)tableName JCR:(NSString*)jcr;

-(BOOL)saveRecord:(NSString*)jsonStr XCZFBH:(NSString*)bh WRYMC:(NSString*)mc TableName:(NSString*)tableName JCR:(NSString*)jcr TYPE:(NSString*)type;

-(NSDictionary *)queryRecordByXCZFBH:(NSString*)bh andTableName:(NSString*)tableName;

-(NSArray *)queryRecordByXCZFBH:(NSString*)bh;

-(NSArray *)queryMessageList;
-(NSArray *)queryMessageInfo:(NSString *)sender;

-(NSArray *)queryRecordByWrymc:(NSString*)mc andTableName:(NSString*)tableName;

//增加了一个参数type
-(NSArray *)queryRecordByWrymc:(NSString*)mc andTableName:(NSString*)tableName TYPE:(NSString*)type;

-(BOOL)deleteRecordMessageList:(NSString *)number;

-(BOOL)deleteRecordByXCZFBH:(NSString*)bh;

-(BOOL)deleteRecordByXCZFBH:(NSString*)bh  andTableName:(NSString*)tableName andWRYMC:(NSString*)mc;
//增加了一个参数type
-(BOOL)deleteRecordByXCZFBH:(NSString*)bh  andTableName:(NSString*)tableName andWRYMC: (NSString*)mc andType:(NSString*)type;

//type 废水FS 废气FQ
-(NSArray *)queryYinziByType:(NSString*)type;

//是否今天已经提交过笔录
-(BOOL)hasCommitBL:(NSString*)wrymc andTableName:(NSString*)tableName;

-(NSString*)getXCZFBHByMc:(NSString*)wrymc;

-(void)saveXCZFBH:(NSString*)xczfbh Wrymc:(NSString*)wrymc TableName:(NSString*)tableName;

-(BOOL)saveMessage:(NSString *)text number:(NSString*)phoneNumber sender:(NSString *)sender;
@end
