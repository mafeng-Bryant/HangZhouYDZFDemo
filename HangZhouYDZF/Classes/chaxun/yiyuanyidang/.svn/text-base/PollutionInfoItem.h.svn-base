//
//  PollutionInfoItem.h
//  RetrieveExamine
//
//  Created by hejunhua on 11-9-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
/**
 *  项目信息
 */
#import <Foundation/Foundation.h>


@interface PollutionInfoItem : NSObject {
	NSString *xmbh;     //项目编号
	NSString *xmmc;     //项目名称
	NSString *sprq;     //审批日期
	NSString *wrybh;    //污染源编号
	NSString *sftgsp;   //是否通过审批
}

@property (nonatomic,copy) NSString *xmbh;
@property (nonatomic,copy) NSString *xmmc;
@property (nonatomic,copy) NSString *sprq;
@property (nonatomic,copy) NSString *wrybh;
@property (nonatomic,copy) NSString *sftgsp;
@property (strong,nonatomic) NSString *yssqbh;//验收编号

+ (PollutionInfoItem *)creatAnItem;

- (PollutionInfoItem *)initWithNone;
@end
