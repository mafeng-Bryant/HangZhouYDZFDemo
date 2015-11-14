//
//  StatisticsItem.m
//  GMEPS_HZ
//
//  Created by ihumor on 11-9-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "StatisticsItem.h"


@implementation StatisticsItem
@synthesize tj;
@synthesize count;

- (StatisticsItem *)initWithNone {
    self = [super init];
    
    if (self) {
        self.tj = [[[NSMutableArray alloc] init] autorelease];
        self.count = [[[NSMutableArray alloc] init] autorelease];
    }
    return self;
}

@end
