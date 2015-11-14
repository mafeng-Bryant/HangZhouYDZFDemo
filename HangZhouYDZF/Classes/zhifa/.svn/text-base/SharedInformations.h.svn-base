//
//  SharedInformations.h
//  GMEPS_HZ
//
//  Created by chen on 11-10-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SharedInformations : NSObject<NSXMLParserDelegate> {
    NSString * reasonToSurvey; //案由
    
    BOOL bModifiedZhiFaInfo;
    NSString * XCFZR;	//现场负责人
	NSString * NL;	//年龄
	NSString * SFZHM;	//身份证号码	
	NSString * GZDW;	//工作单位
	NSString * ZW;	//职务
	NSString * YBAGX;	//与本案关系	
	NSString * JTZZ;	//家庭住址
	NSString * DH;	//电话	
	NSString * QTJZR;	//其他见证人
    NSString * ZFRY;//执法人员
	NSString * ZFZH;	//执法证号
	NSString * YB;	//邮编
    
    NSDictionary *lastSelectedComany;
    NSMutableDictionary *dicStoreTempData;//缓存数据
    NSMutableArray  *people;
   // NSMutableDictionary *dicPersonInfomation;
}

@property(nonatomic,retain) NSString * reasonToSurvey; //案由
@property(nonatomic,retain)NSString * XCFZR;	//现场负责人
@property(nonatomic,retain)NSString * NL;	//年龄
@property(nonatomic,retain)NSString * SFZHM;	//身份证号码	
@property(nonatomic,retain)NSString * GZDW;	//工作单位
@property(nonatomic,retain)NSString * ZW;	//职务
@property(nonatomic,retain)NSString * YBAGX;	//与本案关系	
@property(nonatomic,retain)NSString * JTZZ;	//家庭住址
@property(nonatomic,retain)NSString * DH;	//电话	
@property(nonatomic,retain)NSString * QTJZR;	//其他见证人
@property(nonatomic,retain)NSString * ZFRY;//执法人员
@property(nonatomic,retain)NSString * ZFZH;	//执法证号
@property(nonatomic,retain)NSString * YB;	//邮编
@property(nonatomic,retain)NSString * JCKSSJ;//检查开始时间
@property(nonatomic,retain)NSString * JCJSSJ;//检查结束时间
@property(nonatomic,retain)NSString * JCR; //检查人
@property(nonatomic,retain)NSString * JCRBH; //检查人编号
@property(nonatomic,retain)NSString * JLR; //记录人
@property(nonatomic,retain)NSString * FRDB; //法人代表
@property(nonatomic,retain)NSString * JCDD;//
@property(nonatomic,assign)BOOL bModifiedZhiFaInfo;
@property(nonatomic,retain) NSDictionary *lastSelectedComany;
//@property(nonatomic,retain) NSMutableDictionary *dicPersonInfomation;
@property(nonatomic,retain)NSMutableDictionary *dicStoreTempData;
@property(nonatomic,retain)NSMutableArray  *people;
+(SharedInformations*)sharedSharedInformations;

@end
