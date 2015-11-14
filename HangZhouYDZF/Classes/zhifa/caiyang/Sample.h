//
//  Sample.h
//  EPad
//
//  Created by chen on 11-5-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Sample : NSObject {
	NSString *number;//样品编号
	NSString *name; //采样点名称
	NSString *date;  //采样时间
	NSString *waterOutlet; //水样外观
	NSString *testColumns; //监测因子
	NSString *testColumnsNo;//监测因子对应的编号
	NSString *speed;//流速
	NSString *width; //宽度
	NSString *depth; //深度
	NSString *flow;//流量
	NSString *DischargeVolume;//排放量
	
}

@property(nonatomic,retain) NSString *number;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *date;
@property(nonatomic,retain) NSString *waterOutlet; //水样外观
@property(nonatomic,retain) NSString *testColumns;
@property(nonatomic,retain) NSString *testColumnsNo;//监测因子对应的编号
@property(nonatomic,retain) NSString *speed;//流速
@property(nonatomic,retain) NSString *width; //宽度
@property(nonatomic,retain) NSString *depth; //深度
@property(nonatomic,retain) NSString *flow;//流量
@property(nonatomic,retain) NSString *DischargeVolume;//排放量
@end
