//
//  DBHelper.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DBHelper.h"
#import "FMDatabaseQueue.h"
#import "GUIDGenerator.h"

@interface DBHelper()
@property(nonatomic,retain) FMDatabaseQueue *dbQueue;
@property(nonatomic,assign) BOOL isDbOpening;
@end

@implementation DBHelper
@synthesize dbQueue,isDbOpening;

static DBHelper *_sharedSingleton = nil;
+ (DBHelper *) sharedInstance
{
    @synchronized(self)
    {
        if(_sharedSingleton == nil)
        {
           // _sharedSingleton = [[super alloc] init];
            _sharedSingleton = [[super allocWithZone:NULL] init];
            
        }
    }
    
    return _sharedSingleton;
}

+ (id) allocWithZone:(NSZone *)zone
{
    return [[self sharedInstance] retain];
}

- (id) copyWithZone:(NSZone*)zone
{
    return self;
}

- (id) retain
{
    return self;
}

- (NSUInteger) retainCount
{
    return NSUIntegerMax; // denotes an object that cannot be released
}

- (oneway void)release
{
    //do nothing
}

- (id) autorelease
{
    return self;
}

-(BOOL)initDataBaseQueue{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"wrydata.db"];
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];;

    isDbOpening = YES;
    return YES;
    
}



-(void)insertTable:(NSString*)tableName andDatas:(NSArray*)aryItems{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    if(aryItems == nil || [aryItems count] == 0 )
        return;
    NSMutableString *sqlstr = [NSMutableString stringWithCapacity:100];
    NSMutableString *fieldStr = [NSMutableString stringWithCapacity:50];
    NSMutableString *valueStr = [NSMutableString stringWithCapacity:50];
    
    for(NSDictionary *dic in aryItems){
        
        NSArray *aryKeys = [dic allKeys];
        //NSInteger *fieldCount = [aryKeys count];
        for(NSString *field in aryKeys){
            [fieldStr appendFormat:@"%@,",field];
            [valueStr appendFormat:@"'%@',",[dic objectForKey:field]];
        }

//        //--(@"tableName = %@---->dic = %@",tableName,dic);
        [sqlstr appendFormat:@"insert into %@(%@) values(%@)",tableName,[fieldStr substringToIndex:([fieldStr length]-1)],[valueStr substringToIndex:([valueStr length]-1)]];
//        //--(@"sqlStr = %@",sqlstr);
        [dbQueue inDatabase:^(FMDatabase *db) {
            [db executeUpdate:sqlstr];
        }];
        
        [fieldStr setString:@""];
        [valueStr setString:@""];
        [sqlstr setString:@""];
    }
}

//添加新的污染源，没有污染源编号
-(BOOL)addNewWry:(NSDictionary*)values{
    return YES;
}

//更新污染源
-(BOOL)updateWry:(NSDictionary*)values byWryBH:(NSString*)wrybh{
    return YES;
}

-(void)deleteWry:(NSString*)wrybh{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    
    NSString *sql = [NSString stringWithFormat:@"DELETE  from T_WRY_JBXX  where WRYBH = '%@'",wrybh];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sql];
    }];
    //    //--(@"ary ------> %@",ary);
    return ;
}

-(BOOL)insertWry:(NSDictionary*)dicItem byWryBH:(NSString*)wrybh{
    [self deleteWry:wrybh];
    
    NSString *sql = [NSString stringWithFormat:@"insert into  T_wry_jbxx (WRYBH, WRYMC, WRYJC, CZHM, ZZJGDN, SZXZQ, GXGS, DWDZ, FRDB, LSGX, HYDM, QYGM, HBLXR, HBRLXDH, JDD, JDF, JDM, WDD, WDF, WDM,CJSJ) values ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@','%@','%@')",[dicItem objectForKey:@"WRYBH"],[dicItem objectForKey:@"WRYMC"],[dicItem objectForKey:@"WRYJC"],[dicItem objectForKey:@"CZHM"],[dicItem objectForKey:@"ZZJGDN"],[dicItem objectForKey:@"SZXZQ"],[dicItem objectForKey:@"GXGS"],[dicItem objectForKey:@"DWDZ"],[dicItem objectForKey:@"FRDB"],[dicItem objectForKey:@"LSGX"],[dicItem objectForKey:@"HYDM"],[dicItem objectForKey:@"QYGM"],[dicItem objectForKey:@"HBLXR"],[dicItem objectForKey:@"HBRLXDH"],[dicItem objectForKey:@"JDD"],[dicItem objectForKey:@"JDF"],[dicItem objectForKey:@"JDM"],[dicItem objectForKey:@"WDD"],[dicItem objectForKey:@"WDF"],[dicItem objectForKey:@"WDM"],[dicItem objectForKey:@"CJSJ"]];
    
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    
    //NSLog(@"SQL:%@",sql);
    [dbQueue inDatabase:^(FMDatabase *db) {
        BOOL res = [db executeUpdate:sql];
        if(res == NO)
            NSLog(@"error:SQL:%@",sql);
    }];
    return YES;
}

//查询指定管辖归属的污染源
-(NSArray*)queryWryListByRule:(NSString*)orgid{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    NSMutableArray *__block ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    NSString *sql = nil;
    if ([orgid isEqualToString:@"330100"]) {
        sql = @"SELECT * from T_WRY_JBXX ORDER BY CJSJ DESC";
    }
    else {
        sql = [NSString stringWithFormat:@"SELECT * from T_WRY_JBXX  where gxgs='%@' ORDER BY CJSJ DESC",orgid];
    }
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSMutableDictionary *dicItem = [NSMutableDictionary dictionaryWithCapacity:10];
            [dicItem setObject: [rs stringForColumn:@"WRYBH"] forKey:@"WRYBH"];
            [dicItem setObject: [rs stringForColumn:@"WRYMC"] forKey:@"WRYMC"];
            [dicItem setObject: [rs stringForColumn:@"WRYJC"] forKey:@"WRYJC"];
            [dicItem setObject: [rs stringForColumn:@"CZHM"] forKey:@"CZHM"];
            [dicItem setObject: [rs stringForColumn:@"ZZJGDN"] forKey:@"ZZJGDN"];
            [dicItem setObject: [rs stringForColumn:@"SZXZQ"] forKey:@"SZXZQ"];
            [dicItem setObject: [rs stringForColumn:@"GXGS"] forKey:@"GXGS"];
            [dicItem setObject: [rs stringForColumn:@"DWDZ"] forKey:@"DWDZ"];
            [dicItem setObject: [rs stringForColumn:@"FRDB"] forKey:@"FRDB"];
            [dicItem setObject: [rs stringForColumn:@"LSGX"] forKey:@"LSGX"];
            [dicItem setObject: [rs stringForColumn:@"HYDM"] forKey:@"HYDM"];
            [dicItem setObject: [rs stringForColumn:@"QYGM"] forKey:@"QYGM"];
            [dicItem setObject: [rs stringForColumn:@"HBLXR"] forKey:@"HBLXR"];
            [dicItem setObject: [rs stringForColumn:@"HBRLXDH"] forKey:@"HBRLXDH"];
            [dicItem setObject: [rs stringForColumn:@"JDD"] forKey:@"JDD"];
            [dicItem setObject: [rs stringForColumn:@"JDF"] forKey:@"JDF"];
            [dicItem setObject: [rs stringForColumn:@"JDM"] forKey:@"JDM"];
            [dicItem setObject: [rs stringForColumn:@"WDD"] forKey:@"WDD"];
            [dicItem setObject: [rs stringForColumn:@"WDF"] forKey:@"WDF"];
            [dicItem setObject: [rs stringForColumn:@"WDM"] forKey:@"WDM"];
            [ary addObject:dicItem];
            //--(@"aItem.bmbh = %@%@%@",aItem.bmbh,aItem.bmmc,aItem.yhmc);
        }
    }];
    //    //--(@"ary ------> %@",ary);
    return ary;
}

//查询指定管辖归属的污染源名称污染源列表
-(NSArray*)queryWryListByRule:(NSString *)orgid Name:(NSString*)name{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    NSMutableArray *__block ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    NSString *sql = nil;
    if ([orgid isEqualToString:@"330100"]) {
        sql = [NSString stringWithFormat:@"SELECT * from T_WRY_JBXX  where  WRYMC LIKE \'%%%@%%\' and  WRYBH is  not null ", name];
    }
    else {
        sql = [NSString stringWithFormat:@"SELECT * from T_WRY_JBXX  where gxgs=\"%@\" and WRYMC LIKE \'%%%@%%\' and  WRYBH is  not null ",orgid ,name];    }
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSMutableDictionary *dicItem = [NSMutableDictionary dictionaryWithCapacity:10];
            [dicItem setObject: [rs stringForColumn:@"WRYBH"] forKey:@"WRYBH"];
            [dicItem setObject: [rs stringForColumn:@"WRYMC"] forKey:@"WRYMC"];
            [dicItem setObject: [rs stringForColumn:@"WRYJC"] forKey:@"WRYJC"];
            [dicItem setObject: [rs stringForColumn:@"CZHM"] forKey:@"CZHM"];
            [dicItem setObject: [rs stringForColumn:@"ZZJGDN"] forKey:@"ZZJGDN"];
            [dicItem setObject: [rs stringForColumn:@"SZXZQ"] forKey:@"SZXZQ"];
            [dicItem setObject: [rs stringForColumn:@"GXGS"] forKey:@"GXGS"];
            [dicItem setObject: [rs stringForColumn:@"DWDZ"] forKey:@"DWDZ"];
            [dicItem setObject: [rs stringForColumn:@"FRDB"] forKey:@"FRDB"];
            [dicItem setObject: [rs stringForColumn:@"LSGX"] forKey:@"LSGX"];
            [dicItem setObject: [rs stringForColumn:@"HYDM"] forKey:@"HYDM"];
            [dicItem setObject: [rs stringForColumn:@"QYGM"] forKey:@"QYGM"];
            [dicItem setObject: [rs stringForColumn:@"HBLXR"] forKey:@"HBLXR"];
            [dicItem setObject: [rs stringForColumn:@"HBRLXDH"] forKey:@"HBRLXDH"];
            [dicItem setObject: [rs stringForColumn:@"JDD"] forKey:@"JDD"];
            [dicItem setObject: [rs stringForColumn:@"JDF"] forKey:@"JDF"];
            [dicItem setObject: [rs stringForColumn:@"JDM"] forKey:@"JDM"];
            [dicItem setObject: [rs stringForColumn:@"WDD"] forKey:@"WDD"];
            [dicItem setObject: [rs stringForColumn:@"WDF"] forKey:@"WDF"];
            [dicItem setObject: [rs stringForColumn:@"WDM"] forKey:@"WDM"];
            [ary addObject:dicItem];
            //--(@"aItem.bmbh = %@%@%@",aItem.bmbh,aItem.bmmc,aItem.yhmc);
        }
    }];
    //    //--(@"ary ------> %@",ary);
    return ary;
}

/*
 T_WRY_RECORD (XCZFBH nvarchar(50) ,WRYMC nvarchar(100) ,TABLENAME nvarchar(50) ,JCSJ nvarchar(20) ,JSON nvarchar(5000));*/

-(BOOL)saveMessage:(NSString *)text number:(NSString*)phoneNumber sender:(NSString *)sender {
    if ([phoneNumber length] <= 0  ) {
        return NO;
    }
    
    if (isDbOpening == NO) {
        [self initDataBaseQueue];
    }
    
    NSMutableString * query = [NSMutableString stringWithFormat:@"INSERT INTO   SendMessageList"];
    NSMutableString * keys = [NSMutableString stringWithFormat:@" ("];
    NSMutableString * values = [NSMutableString stringWithFormat:@" ( "];
    NSMutableArray * arguments = [NSMutableArray arrayWithCapacity:4];
    
    [keys appendString:@"sender,"];
    [values appendString:@"?,"];
    [arguments addObject:sender];
    
    [keys appendString:@"send_number,"];
    [values appendString:@"?,"];
    [arguments addObject:phoneNumber];
    
    [keys appendString:@"send_info,"];
    [values appendString:@"?,"];
    [arguments addObject:text];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *sendDate = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    [dateFormatter release];
    
    
    [keys appendString:@"send_date,"];
    [values appendString:@"?,"];
    [arguments addObject:sendDate];

    
    [keys appendString:@")"];
    [values appendString:@")"];
    [query appendFormat:@" %@ VALUES%@",
     [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
     [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];

    [dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:query withArgumentsInArray:arguments];
    }];
    
    return YES;
}

-(BOOL)saveSignName:(NSData *)imageData XCZFBH:(NSString*)bh WRYMC:(NSString*)mc TableName:(NSString*)tableName JCR:(NSString*)jcr {
    if( (imageData == nil) || [bh length] <=0 || [mc length] <=0 || [tableName length] <=0  )
        return NO;
    if (isDbOpening == NO) {
        [self initDataBaseQueue];
    }
    
    NSMutableString * query = [NSMutableString stringWithFormat:@"INSERT INTO T_WRY_RECORD"];
    NSMutableString * keys = [NSMutableString stringWithFormat:@" ("];
    NSMutableString * values = [NSMutableString stringWithFormat:@" ( "];
    NSMutableArray * arguments = [NSMutableArray arrayWithCapacity:5];
    
   
    [keys appendString:@"XCZFBH,"];
    [values appendString:@"?,"];
    [arguments addObject:bh];
    
    [keys appendString:@"WRYMC,"];
    [values appendString:@"?,"];
    [arguments addObject:mc];
    
    [keys appendString:@"TABLENAME,"];
    [values appendString:@"?,"];
    [arguments addObject:tableName];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    
    [keys appendString:@"JCSJ,"];
    [values appendString:@"?,"];
    [arguments addObject:dateString];
    
    
    [keys appendString:@"SignName,"];
    [values appendString:@"?,"];
    [arguments addObject:imageData];
    
    [keys appendString:@"JCR,"];
    [values appendString:@"?,"];
    [arguments addObject:jcr];
    
    [keys appendString:@")"];
    [values appendString:@")"];
    [query appendFormat:@" %@ VALUES%@",
     [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
     [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
    NSLog(@"%@",query);
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:query withArgumentsInArray:arguments];
    }];
    

    return YES;

}


-(BOOL)saveRecord:(NSString*)jsonStr XCZFBH:(NSString*)bh WRYMC:(NSString*)mc TableName:(NSString*)tableName JCR:(NSString*)jcr{
    if([bh length] <=0 || [mc length] <=0 || [tableName length] <=0 || [jsonStr length] <=0 )
        return NO;
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }

    [self deleteRecordByXCZFBH:bh andTableName:tableName andWRYMC:mc];
    NSMutableString *sqlstr = [NSMutableString stringWithCapacity:100];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    
    [sqlstr appendFormat:@"insert into T_WRY_RECORD(XCZFBH,WRYMC,TABLENAME,JCSJ,JSON,JCR) values('%@','%@','%@','%@','%@','%@')",bh,mc,tableName,dateString,jsonStr,jcr];
    //        //--(@"sqlStr = %@",sqlstr);
    [dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sqlstr];
    }];
    
    return YES;
}

-(BOOL)saveRecord:(NSString*)jsonStr XCZFBH:(NSString*)bh WRYMC:(NSString*)mc TableName:(NSString*)tableName JCR:(NSString*)jcr TYPE:(NSString*)type{
    
    if([bh length] <=0 || [mc length] <=0 || [tableName length] <=0 || [jsonStr length] <=0 )
        return NO;
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    
    [self deleteRecordByXCZFBH:bh andTableName:tableName andWRYMC:mc andType:type];
    NSMutableString *sqlstr = [NSMutableString stringWithCapacity:100];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    
    [sqlstr appendFormat:@"insert into T_WRY_RECORD(XCZFBH,WRYMC,TABLENAME,JCSJ,JSON,JCR,TYPE) values('%@','%@','%@','%@','%@','%@','%@')",bh,mc,tableName,dateString,jsonStr,jcr,type];
    //        //--(@"sqlStr = %@",sqlstr);
    [dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sqlstr];
    }];
    
    return YES;
    
}

-(NSDictionary *)queryRecordByXCZFBH:(NSString*)bh andTableName:(NSString*)tableName{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    NSMutableArray *__block ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * from T_WRY_RECORD  where XCZFBH ='%@' and  TABLENAME ='%@'",bh,tableName];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSMutableDictionary *dicItem = [NSMutableDictionary dictionaryWithCapacity:10];
            [dicItem setObject: [rs stringForColumn:@"XCZFBH"] forKey:@"XCZFBH"];
            [dicItem setObject: [rs stringForColumn:@"WRYMC"] forKey:@"WRYMC"];
            [dicItem setObject: [rs stringForColumn:@"TABLENAME"] forKey:@"TABLENAME"];
            [dicItem setObject: [rs stringForColumn:@"JCSJ"] forKey:@"JCSJ"];
            [dicItem setObject: [rs stringForColumn:@"JSON"] forKey:@"JSON"];
            [dicItem setObject: [rs stringForColumn:@"JCR"] forKey:@"JCR"];
            [dicItem setObject: [rs stringForColumn:@"TYPE"] forKey:@"TYPE"];
            [ary addObject:dicItem];
            //--(@"aItem.bmbh = %@%@%@",aItem.bmbh,aItem.bmmc,aItem.yhmc);
        }
    }];
    if([ary count] <= 0)
        return nil;
    return [ary objectAtIndex:0];
}

-(NSArray *)queryRecordByXCZFBH:(NSString*)bh{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    NSMutableArray *__block ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * from T_WRY_RECORD  where XCZFBH ='%@' order by jcsj desc ",bh];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSMutableDictionary *dicItem = [NSMutableDictionary dictionaryWithCapacity:10];
            [dicItem setObject: [rs stringForColumn:@"XCZFBH"] forKey:@"XCZFBH"];
            [dicItem setObject: [rs stringForColumn:@"WRYMC"] forKey:@"WRYMC"];
            [dicItem setObject: [rs stringForColumn:@"TABLENAME"] forKey:@"TABLENAME"];
            [dicItem setObject: [rs stringForColumn:@"JCSJ"] forKey:@"JCSJ"];
            if ([rs stringForColumn:@"JSON"]) {
                [dicItem setObject: [rs stringForColumn:@"JSON"] forKey:@"JSON"];
            }
            [dicItem setObject: [rs stringForColumn:@"TYPE"] forKey:@"TYPE"];
            [ary addObject:dicItem];
            //--(@"aItem.bmbh = %@%@%@",aItem.bmbh,aItem.bmmc,aItem.yhmc);
        }
    }];
    return ary;
}

-(NSArray *)queryRecordByWrymc:(NSString*)mc andTableName:(NSString*)tableName{
    return [self queryRecordByWrymc:mc andTableName:tableName TYPE:@""];
}

-(NSArray *)queryRecordByWrymc:(NSString*)mc andTableName:(NSString*)tableName TYPE:(NSString*)type{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    NSMutableArray *__block ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    NSString *sql ;
    if([type length] > 0)
        sql = [NSString stringWithFormat:@"SELECT * from T_WRY_RECORD  where WRYMC ='%@' and  TABLENAME ='%@' and  TYPE ='%@' order by JCSJ desc ",mc,tableName,type];
    else
        sql = [NSString stringWithFormat:@"SELECT * from T_WRY_RECORD  where WRYMC ='%@' and  TABLENAME ='%@' order by JCSJ desc ",mc,tableName];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSMutableDictionary *dicItem = [NSMutableDictionary dictionaryWithCapacity:10];
            [dicItem setObject: [rs stringForColumn:@"XCZFBH"] forKey:@"XCZFBH"];
            [dicItem setObject: [rs stringForColumn:@"WRYMC"] forKey:@"WRYMC"];
            [dicItem setObject: [rs stringForColumn:@"TABLENAME"] forKey:@"TABLENAME"];
            [dicItem setObject: [rs stringForColumn:@"JCSJ"] forKey:@"JCSJ"];
            [dicItem setObject: [rs stringForColumn:@"JSON"] forKey:@"JSON"];
            [dicItem setObject: [rs stringForColumn:@"JCR"] forKey:@"JCR"];
            [dicItem setObject: [rs stringForColumn:@"TYPE"] forKey:@"TYPE"];
            if ([rs dataForColumn:@"SignName"]) {
                [dicItem setObject:[rs dataForColumn:@"SignName"] forKey:@"SignName"];
            }
           
            [ary addObject:dicItem];

        }
    }];
    return ary;
}

-(BOOL)deleteRecordMessageList:(NSString *)number {
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    
    
    NSString *sqlstr = [NSString stringWithFormat:@"delete from SendMessageList where send_number = '%@' ",number];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sqlstr];
    }];
    
    return YES;

}

-(BOOL)deleteRecordByXCZFBH:(NSString*)bh{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    

    NSString *sqlstr = [NSString stringWithFormat:@"Delete from T_WRY_RECORD where XCZFBH ='%@'",bh];
    NSLog(@"sqlStr = %@",sqlstr);
    [dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sqlstr];
    }];
    
    return YES;
}

-(BOOL)deleteRecordByXCZFBH:(NSString*)bh  andTableName:(NSString*)tableName andWRYMC:(NSString*)mc{

    
    return [self deleteRecordByXCZFBH:bh andTableName:tableName andWRYMC:mc andType:@""];
}

-(BOOL)deleteRecordByXCZFBH:(NSString*)bh  andTableName:(NSString*)tableName andWRYMC: (NSString*)mc andType:(NSString*)type{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    NSString *sqlstr;
    if([type length] > 0)
        sqlstr = [NSString stringWithFormat:@"Delete from T_WRY_RECORD where XCZFBH ='%@' and WRYMC ='%@' and  TABLENAME ='%@'  and TYPE='%@'",bh,mc,tableName,type];
    else
        sqlstr = [NSString stringWithFormat:@"Delete from T_WRY_RECORD where XCZFBH ='%@' and WRYMC ='%@' and  TABLENAME ='%@'",bh,mc,tableName];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sqlstr];
    }];
    
    return YES;
}

-(NSArray *)queryMessageInfo:(NSString *)sender{
    if (isDbOpening == NO) {
        [self initDataBaseQueue];
    }
    
    NSMutableArray *__block ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    
    NSString *sql = [NSString stringWithFormat:@"select * from SendMessageList where send_number like \'%%%@%%\' or sender like \'%%%@%%\' ", sender,sender];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSMutableDictionary *dicItem = [NSMutableDictionary dictionaryWithCapacity:10];
            
            [dicItem setObject:[rs stringForColumn:@"sender"] forKey:@"sender"];
            [dicItem setObject:[rs stringForColumn:@"send_number"] forKey:@"send_number"];
            [dicItem setObject:[rs stringForColumn:@"send_info"] forKey:@"send_info"];
            [dicItem setObject:[rs stringForColumn:@"send_date"] forKey:@"send_date"];
            [ary addObject:dicItem];
        }
    }];
    
    return ary;
}


-(NSArray *)queryMessageList{
    if (isDbOpening == NO) {
         [self initDataBaseQueue];
    }
    
     NSMutableArray *__block ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
  
  NSString *sql  = @"SELECT tag,sender,send_number,send_info,max(send_Date) as Lately FROM SendMessageList group by send_number";
   
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSMutableDictionary *dicItem = [NSMutableDictionary dictionaryWithCapacity:10];
            
            [dicItem setObject:[rs stringForColumn:@"sender"] forKey:@"sender"];
            [dicItem setObject:[rs stringForColumn:@"send_number"] forKey:@"send_number"];
            [dicItem setObject:[rs stringForColumn:@"send_info"] forKey:@"send_info"];
            [dicItem setObject:[rs stringForColumn:@"lately"] forKey:@"lately"];
            [ary addObject:dicItem];
        }
    }];
    
    return ary;

}

-(NSArray *)queryYinziByType:(NSString*)type{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    NSMutableArray *__block ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM T_COMN_JCXM WHERE  WRWLB='%@'  ORDER BY PXM ASC",type];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {

           [ary addObject:[rs stringForColumn:@"WRW"]];
        }
    }];
    return ary;
}

-(BOOL)hasCommitBL:(NSString*)wyrmc andTableName:(NSString*)tableName{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    
    NSMutableArray *__block ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM xczfbh WHERE  TABLENAME='%@' and WRYMC='%@' and CJSJ = '%@'",tableName,wyrmc,dateString];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            
            [ary addObject:[rs stringForColumn:@"XCZFBH"]];
        }
    }];
    if([ary count] > 0)
        return YES;
    
    return NO;
}

-(NSString*)getXCZFBHByMc:(NSString*)wrymc{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    
    NSMutableArray *__block ary = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM xczfbh WHERE  WRYMC='%@' and CJSJ = '%@' order by XCZFBH desc",wrymc,dateString];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            
            [ary addObject:[rs stringForColumn:@"XCZFBH"]];
        }
    }];
    if([ary count] > 0)
        return [ary objectAtIndex:0];
    return [GUIDGenerator generateBHByWryName:wrymc];
}

-(void)saveXCZFBH:(NSString*)xczfbh Wrymc:(NSString*)wrymc TableName:(NSString*)tableName{
    if(isDbOpening == NO){
        [self initDataBaseQueue];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    
    NSString *sqlDel = [NSString stringWithFormat:@"DELETE  from xczfbh WHERE   WRYMC='%@' and XCZFBH !='%@'",wrymc,xczfbh];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        BOOL res = [db executeUpdate:sqlDel];
        if(res == NO)
            NSLog(@"SQL ERROR:%@",sqlDel);
    }];
    
    NSString *sqlInsert = [NSString stringWithFormat:@"INSERT INTO  xczfbh(WRYMC,XCZFBH,TABLENAME,CJSJ) values('%@','%@','%@', '%@')",wrymc,xczfbh,tableName, dateString];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        BOOL res = [db executeUpdate:sqlInsert];
        if(res == NO)
            NSLog(@"SQL ERROR:%@",sqlInsert);
        
    }];
}
@end
