//
//  HtmlTableGenerator.m
//  HNYDZF
//
//  Created by 张 仁松 on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HtmlTableGenerator.h"


@implementation HtmlTableGenerator

+(NSString*)genContentWithTitle:(NSString*)aTitle andParaMeters:(NSDictionary*)params
andType:(NSString*)serviceKey{
    
    NSDictionary *configDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json" ofType:@"plist"]];
    
    if(serviceKey == nil)return @"";
    NSDictionary * tmpDic = [configDic objectForKey:serviceKey];
    NSArray *aryKeys = [tmpDic objectForKey:@"keys"];
    NSArray *aryTypes = [tmpDic objectForKey:@"types"];
    
    NSMutableString *paramsStr = [NSMutableString stringWithCapacity:1500];
    int count = [aryKeys count];

    for (int i = 0; i < count; ) {
        NSString *key1 = [aryKeys objectAtIndex:i];
        NSNumber *keyType = [aryTypes objectAtIndex:i];
        
        if (i+1 < count) {
            NSNumber *nextKeyType = [aryTypes objectAtIndex:i+1];
            if([keyType intValue] == 2 && [nextKeyType intValue] == 2){
                NSString *key2 = [aryKeys objectAtIndex:i+1];
                NSString *value1 = [params objectForKey:key1];
                NSString *value2 = [params objectForKey:key2];
                if(value1 == nil)value1 = @"";
                if(value2 == nil)value2 = @"";
//                [paramsStr appendFormat:@"<tr><td width=\"13%%\" class=\"t1\">%@</td><td  width=\"37%%\"  class=\"t2\">%@</td><td width=\"13%%\" class=\"t1\">%@</td><td width=\"37%%\"  class=\"t2\">%@</td></tr>",
//                 [tmpDic objectForKey:key1],value1,[tmpDic objectForKey:key2],value2];
                [paramsStr appendFormat:@"<tr><td width=\"27%%\" class=\"t1\">%@</td><td  width=\"23%%\"  class=\"t2\">%@</td><td width=\"27%%\" class=\"t1\">%@</td><td width=\"23%%\"  class=\"t2\">%@</td></tr>",
                 [tmpDic objectForKey:key1],value1,[tmpDic objectForKey:key2],value2];
                i+=2;
                continue;
            }
        }        
        
        NSString *value = [params objectForKey:key1];
        if(value == nil)value = @"";
        [paramsStr appendFormat:@"<tr><td width=\"13%%\" class=\"t1\">%@</td><td colspan=\"3\" width=\"87%%\"  class=\"t2\">%@</td></tr>",
         [tmpDic objectForKey:key1],value];
        
        i += 1;
        
    }

    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tablenew" ofType:@"htm"];

    NSMutableString *resultHtml = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [resultHtml appendString:aTitle];
    [resultHtml appendString:@"</h2><div class=\"tablemain\"><table width=\"100%%\" border=\"0\" cellspacing=\"1\"  cellpadding=\"0\" bgcolor=\"#caeaff\">"];
    [resultHtml appendString:paramsStr];
    [resultHtml appendString:@"</table></div></div></body></html>"];
    return resultHtml;
    //[webview loadHTMLString:resultHtml baseURL:[[NSBundle mainBundle] bundleURL ]];
}


@end
