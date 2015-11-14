//
//  STStatisticsItem.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface STStatisticsItem : NSObject {
    NSString *bh;       //任务编号（主键）
    NSString *zt;       //督办任务主题
    NSString *dbrdw;    //督办人单位
    NSString *jsrdw;    //办理人单位
    NSString *dbsj;     //督办时间
    NSString *dbrsfbj;  //督办人是否办结
}

@property (nonatomic,copy) NSString *bh;
@property (nonatomic,copy) NSString *zt;
@property (nonatomic,copy) NSString *dbrdw;
@property (nonatomic,copy) NSString *jsrdw;
@property (nonatomic,copy) NSString *dbsj;
@property (nonatomic,copy) NSString *dbrsfbj;

- (STStatisticsItem *)initWithNone;
@end
