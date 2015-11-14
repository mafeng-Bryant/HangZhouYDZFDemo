//
//  GGDMJConfig.m
//  GMEPS_HZ
//
//  Created by zhang on 13-4-8.
//
//

#import "GGDMJConfig.h"

@implementation GGDMJConfig

+(NSArray*)getDMNRByDMJBH:(NSString*)dmjbh{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"system_config" ofType:@"plist"];
    
    NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (dicData) {
        NSDictionary *ggdmj = [dicData objectForKey:@"GGDMJ"];
        if(ggdmj == nil)return nil;
        
        NSArray *aryItems = [ggdmj objectForKey:dmjbh];
        if (aryItems) {
            NSMutableArray *aryResult = [NSMutableArray arrayWithCapacity:10];
            for(NSDictionary *dic in aryItems){
                [aryResult addObject:[dic objectForKey:@"DMNR"]];
            }
            return aryResult;
        }
    }
    return nil;
}

+(NSString*)getDMByDMJBH:(NSString*)dmjbh andDMNR:(NSString*)dmnr{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"system_config" ofType:@"plist"];
    
    
    
    NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (dicData) {
        NSDictionary *ggdmj = [dicData objectForKey:@"GGDMJ"];
        if(ggdmj == nil)return nil;
        
        NSArray *aryItems = [ggdmj objectForKey:dmjbh];
        if (aryItems) {

            for(NSDictionary *dic in aryItems){
                if([dmnr isEqualToString:[dic objectForKey:@"DMNR"]])
                    return [dic objectForKey:@"DM"];
            }
            return @"";
        }
    }
    return @"";
}

+(NSString*)getDMNRByDMJBH:(NSString*)dmjbh andDM:(NSString*)dm{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"system_config" ofType:@"plist"];
    
    
    NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (dicData) {
        NSDictionary *ggdmj = [dicData objectForKey:@"GGDMJ"];
        if(ggdmj == nil)return nil;
        
        NSArray *aryItems = [ggdmj objectForKey:dmjbh];
        if (aryItems) {
            
            for(NSDictionary *dic in aryItems){
                if([dm isEqualToString:[dic objectForKey:@"DM"]])
                    return [dic objectForKey:@"DMNR"];
            }
            return @"";
        }
    }
    return @"";
}


@end
