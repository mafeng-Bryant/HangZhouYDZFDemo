//
//  PollutionInfoItem.m
//  RetrieveExamine
//
//  Created by hejunhua on 11-9-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PollutionInfoItem.h"


@implementation PollutionInfoItem
@synthesize xmbh;
@synthesize xmmc;
@synthesize sprq;
@synthesize wrybh;
@synthesize sftgsp;
@synthesize yssqbh;

- (PollutionInfoItem *)initWithNone {
    self = [super init];
    
    if (self) {
        self.xmbh = @"";
        self.xmmc = @"";
        self.sprq = @"";
        self.wrybh = @"";
        self.sftgsp = @"";
        self.yssqbh = @"";
    }
	return self;
}

+ (PollutionInfoItem *)creatAnItem{
    PollutionInfoItem *item = nil;
    return item;
}

@end
