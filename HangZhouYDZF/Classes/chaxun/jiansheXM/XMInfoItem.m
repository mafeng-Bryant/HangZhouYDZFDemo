//
//  XMInfoItem.m
//  EPad
//
//  Created by chen on 11-9-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XMInfoItem.h"


@implementation XMInfoItem
@synthesize xhCode;
@synthesize xmmc;
@synthesize sprq;
@synthesize xzqh;
@synthesize sftgsp;

+ (XMInfoItem *)creatAnItem {
	XMInfoItem *oneItem = [[[XMInfoItem alloc] initWithNone] autorelease];
	return oneItem;
}

- (XMInfoItem *)initWithNone {
    self = [super init];
    
    if (self) {
        self.xhCode = @"";
        self.xmmc = @"";
        self.sprq = @"";
        self.xzqh = @"";
        self.sftgsp = @"";
    }
	return self;
}
@end
