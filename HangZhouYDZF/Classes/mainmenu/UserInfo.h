//
//  UserInfo.h
//  GMEPS_HZ
//
//  Created by chen on 11-9-21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserInfo : NSObject {
	NSString *userName;
	NSString *userORGID;
	NSString *userPhone;
	NSString *userDanwei;//部门名称
	NSString *BMBH;//部门编号
  NSString *ZFZJBH;//执法证件编号
  NSString *FSHBJ;//附属环保局
  NSString *ZZDZ; //地址
  NSString *BBH;//版本号
  NSString *YHID;//用户ID  
}

@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *userORGID;
@property(nonatomic, copy) NSString *userPhone;
@property(nonatomic, copy) NSString *userDanwei;//部门名称
@property(nonatomic, copy) NSString *BMBH;//部门编号
@property(nonatomic, copy) NSString *ZFZJBH;//执法证编号
@property(nonatomic, copy) NSString *FSHBJ;//附属环保局
@property(nonatomic, copy) NSString *ZZDZ; //地址
@property(nonatomic, copy) NSString *BBH;//版本号
@property(nonatomic, copy) NSString *YHID;//用户ID

-(id)init;
-(id)initWithUserInfo:(UserInfo*)another;
@end
