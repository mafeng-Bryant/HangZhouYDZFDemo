//
//  DataBaseInstaller.h
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseInstaller : NSObject
+ (void) Install;
+ (void) replaceDB;//重新覆盖db 即覆盖存在的db 方便重新下载数据
+(void) removeDB;
@end
