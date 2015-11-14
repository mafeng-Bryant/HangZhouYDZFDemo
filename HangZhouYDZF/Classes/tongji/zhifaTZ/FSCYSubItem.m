//
//  FSCYSubItem.m
//  GMEPS_HZ
//
//  Created by power humor on 10/9/11.
//  Copyright 2011 powerdata. All rights reserved.
//

#import "FSCYSubItem.h"

@implementation FSCYSubItem
@synthesize ypbh;
@synthesize cydmc;
@synthesize cysj;
@synthesize jcxm1;
@synthesize sywg1;
@synthesize ls;
@synthesize kd;
@synthesize sd;
@synthesize ll;
@synthesize pfl;

- (FSCYSubItem *)initWithNone {
    
    self=[super init];
    
    if(self){
        self.ypbh = @"";
        self.cydmc = @"";
        self.cysj = @"";
        self.jcxm1 = @"";
        self.sywg1 = @"";
        self.ls = @"";
        self.kd = @"";
        self.sd = @"";
        self.ll = @"";
        self.pfl = @"";    
    }
    return self;
}

@end
