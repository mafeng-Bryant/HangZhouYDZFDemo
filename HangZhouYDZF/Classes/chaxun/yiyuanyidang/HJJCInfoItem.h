//
//  HJJCInfoItem.h
//  GMEPS_HZ
//
//  Created by chen on 11-9-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
// 环境监测结点信息

#import <Foundation/Foundation.h>


@interface HJJCInfoItem : NSObject {
	NSString *JCRQ; //监测日期
	NSString *JCDMC;//监测点名称
	NSString *PFL;  //排放量
	NSString *WRWND; //污染物浓度
	NSString *DMNR;  //排放物名称
	NSString *BZ;//单位
}

@property(nonatomic,copy) NSString *JCRQ;
@property(nonatomic,copy) NSString *JCDMC;//监测点名称
@property(nonatomic,copy) NSString *PFL;  //排放量
@property(nonatomic,copy) NSString *WRWND; //污染物浓度
@property(nonatomic,copy) NSString *DMNR;  //排放物名称
@property(nonatomic,copy) NSString *BZ;//单位
@end
