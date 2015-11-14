//
//  ConditionItem.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-10-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ConditionItem.h"


@implementation ConditionItem
@synthesize condition;
@synthesize conditionCode;
@synthesize count;

- (ConditionItem *)initWithNone {
    self = [super init];
    if (self) {
        self.conditionCode = @"";
        self.condition = @"";
        self.count = @"";
    }
    return self;
}
@end
