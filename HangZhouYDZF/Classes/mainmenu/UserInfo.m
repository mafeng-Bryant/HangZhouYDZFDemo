//
//  UserInfo.m
//  GMEPS_HZ
//
//  Created by chen on 11-9-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserInfo.h"


@implementation UserInfo
@synthesize userName;
@synthesize userORGID;
@synthesize userPhone;
@synthesize userDanwei;//部门名称
@synthesize BMBH;//部门编号
@synthesize ZFZJBH;
@synthesize FSHBJ;
@synthesize ZZDZ;
@synthesize BBH;
@synthesize YHID;

-(id)init{
    self = [super init];
    if (self) {
        userName = @"";
        userORGID = @"";
        userPhone = @"";
        userDanwei = @"";
        BMBH = @"";
        ZFZJBH = @"";
        FSHBJ = @"";
        ZZDZ = @"";
        BBH = @"";
        YHID = @"";
    }
    
    return self;
}

-(id)initWithUserInfo:(UserInfo*)another{
    
    self =[super init];
    if (self) {
        self.userName = another.userName;
        self.userORGID = another.userORGID;
        self.userPhone = another.userPhone;
        self.userDanwei = another.userDanwei;
        self.BMBH = another.BMBH;
        self.ZFZJBH = another.ZFZJBH;
        self.FSHBJ = another.FSHBJ;
        self.ZZDZ = another.ZZDZ;
        self.BBH = another.BBH;
        self.YHID = another.YHID;
    }

    return self;
}
@end
