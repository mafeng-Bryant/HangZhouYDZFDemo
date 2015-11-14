//
//  StatisticsItem.h
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StatisticsItem : NSObject {
    NSMutableArray *tj;//按**统计
    NSMutableArray *count;//个数

}

@property (nonatomic, retain) NSMutableArray *tj;
@property (nonatomic, retain) NSMutableArray *count;

- (StatisticsItem *)initWithNone;

@end
