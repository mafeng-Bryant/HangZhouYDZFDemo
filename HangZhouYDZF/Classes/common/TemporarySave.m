//
//  TemporarySave.m
//  GMEPS_HZ
//
//  Created by apple on 12-10-10.
//
//

#import "TemporarySave.h"

@implementation TemporarySave
+(void)isNll:(UITextField*)sender{
    if (sender.text == nil) {
        sender.text = @"";
    }
}
//根据名称删除对应的一条数据
+(void)deletePlistFileContent:(NSString*)bllx qymc:(NSString*)mc{
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:zancunBilu];
    
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:plistPath isDirectory:NO];
    NSMutableDictionary *dictplist = [[NSMutableDictionary alloc] init];
    if (isExist==YES) {
        dictplist = [dictplist initWithContentsOfFile:plistPath];
    }
    //写入文件
    [[dictplist objectForKey:bllx] removeObjectForKey:mc];
    [dictplist writeToFile:plistPath atomically:YES];
    [dictplist release];
}

//根据名称获取相应的数据
+(NSDictionary*)returnPlistDate:(NSString*)bllx qymc:(NSString*)mc{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:zancunBilu];
    
    //根据路径获取test.plist的全部内容
    NSDictionary *infolist = [NSDictionary dictionaryWithContentsOfFile:path];
    //NSDictionary *infolist= [[NSDictionary alloc]initWithContentsOfFile:path];
    
    NSDictionary *dicAll = [[infolist objectForKey:bllx] objectForKey:mc];
    
    //[infolist release];
    
    return dicAll;
}

+(void)saveBilu:(NSArray*)values1 key:(NSArray*)keys1 bllx:(NSString*)lx qymc:(NSString*)mc
{
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:zancunBilu];
    
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:plistPath isDirectory:NO];
    NSMutableDictionary *dictplist = [[NSMutableDictionary alloc] init];
    
    //定义第一个插件的属性
    NSMutableDictionary *plugin1 = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *plugin2 = [[NSMutableDictionary alloc]init];
    
    //textfield的插入数据
    //[plugin1 setObject:WRYBH forKey:@"WRYBH"];
    //[plugin1 setObject:QYMC.text forKey:@"WRYMC"];
    //[plugin1 setObject:DLRSSBM.text forKey:@"DLRSSBM"];
    UITextField *tmpField;
    for (int i = 0; i < [values1 count]; i++) {
        tmpField = [values1 objectAtIndex:i];
        if (tmpField.text==nil) tmpField.text = @"";
        NSString *keysStr = [keys1 objectAtIndex:i];
        [plugin1 setObject:tmpField.text forKey:keysStr];
    }
    //UISegmentedControl的插入数据
    //NSString *xb = [NSString stringWithFormat:@"%d",XB.selectedSegmentIndex];
    //[plugin1 setObject:xb forKey:@"XB"];
    //设置属性值
    if (isExist==YES) {
        dictplist = [dictplist initWithContentsOfFile:plistPath];
    }
    if ([dictplist objectForKey:lx]==nil) {
        [plugin2 setObject:plugin1 forKey:mc];
        [dictplist setObject:plugin2 forKey:lx];
    }
    else{
        [[dictplist objectForKey:lx] setObject:plugin1 forKey:mc];
    }
    //写入文件
    [dictplist writeToFile:plistPath atomically:YES];
    [dictplist release];
    [plugin1 release];
    [plugin2 release];
}

@end
