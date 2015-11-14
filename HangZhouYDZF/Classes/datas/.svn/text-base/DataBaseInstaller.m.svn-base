//
//  DataBaseInstaller.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataBaseInstaller.h"
#define DB_Version @"DB_Version"
@implementation DataBaseInstaller

+(void) Install{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dest = [documentsDirectory stringByAppendingPathComponent:@"wrydata.db"];
    //--(@"dest = %@",dest);
    NSString *source = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"wrydata.db"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //根据DB_Version来判断 如果是新版本app，就必须替换db文件
    BOOL shouldReplace = NO;
    NSString *dbVersion = [defaults objectForKey:DB_Version];
    NSString *settingVer = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if(dbVersion ==nil || [dbVersion length] <=0)
        shouldReplace = YES;
    else{
         
        if([settingVer isEqualToString:dbVersion])
            shouldReplace = NO;
        else
            shouldReplace = YES;
    }
   
    
    if(![fm fileExistsAtPath:source])
    {
        //NSLog(@"%@", @"数据库不存在");
        return;
    }
    
    if([fm fileExistsAtPath:dest])
    {
        if(shouldReplace){
            [fm removeItemAtPath:dest error:nil];//删除存在的文件
            [fm copyItemAtPath:source toPath:dest error:nil];
            NSLog(@"replaced %@", dbVersion);
        }
    }else{
        [fm copyItemAtPath:source toPath:dest error:nil];
        NSLog(@"copyed %@", dbVersion);
    }
    [defaults setObject:settingVer forKey:DB_Version];
}

+ (void) replaceDB{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dest = [documentsDirectory stringByAppendingPathComponent:@"wrydata.db"];
    
    
    NSString *source = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"wrydata.db"];
    
    if(![fm fileExistsAtPath:source])
    {
        //NSLog(@"%@", @"数据库不存在");
        return;
    }
    if([fm fileExistsAtPath:dest])
    {
        [fm removeItemAtPath:dest error:nil];//删除存在的文件
    }
    [fm copyItemAtPath:source toPath:dest error:nil];
    
    
}

+(void) removeDB{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dest = [documentsDirectory stringByAppendingPathComponent:@"wrydata.db"];
    
    
    if([fm fileExistsAtPath:dest])
    {
        [fm removeItemAtPath:dest error:nil];//删除存在的文件
    }
}
@end
