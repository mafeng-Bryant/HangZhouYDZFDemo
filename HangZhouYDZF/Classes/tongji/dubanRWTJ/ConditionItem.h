//
//  ConditionItem.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ConditionItem : NSObject {
    NSString *condition;        //查询条件
    NSString *conditionCode;    //查询条件编号（主键）
    NSString *count;            //任务总数
}
@property (nonatomic,copy) NSString *condition;
@property (nonatomic,copy) NSString *conditionCode;
@property (nonatomic,copy) NSString *count;

- (ConditionItem *)initWithNone;
@end
