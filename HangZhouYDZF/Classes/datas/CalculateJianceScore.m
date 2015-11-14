//
//  CalculateJianceScore.m
//  GMEPS_HZ
//
//  Created by 张仁松 on 13-5-8.
//
//

#import "CalculateJianceScore.h"

@implementation CalculateJianceScore

+(NSInteger)calcBiaoyeAry:(NSArray*)aryBiaoye andShiceAry:(NSArray*)aryShice
                  andType:(NSString*)type{
    if(aryBiaoye.count != aryShice.count){
        return -1;
    }
    CGFloat maxDiff = 10.0;//默认水不大于10%
    if([type isEqualToString:@"smoke"]){
        maxDiff = 5.0;
    }
    for(int i = 0; i < [aryShice count]; i++){
        CGFloat val1 = [[aryShice objectAtIndex:i] floatValue];
        CGFloat val2 = [[aryBiaoye objectAtIndex:i] floatValue];
        CGFloat diff = (val1 - val2)/val2;
        if (diff*100 > maxDiff || diff*100 < maxDiff*-1.0) {
            return 0;
        }
    }
    if([type isEqualToString:@"smoke"])
        return 15;
    else
        return 16;
}

+(NSInteger)calcShucaiAry:(NSArray*)aryShucai andShiceAry:(NSArray*)aryShice
                  andType:(NSString*)type{
    if(aryShucai.count != aryShice.count){
        return -1;
    }

    CGFloat maxDiff = 0;
    
    for(int i = 0; i < [aryShice count]; i++){
        CGFloat val1 = [[aryShice objectAtIndex:i] floatValue];
        CGFloat val2 = [[aryShucai objectAtIndex:i] floatValue];
        CGFloat diff = (val1 - val2)/val2;
        CGFloat absDiff = diff*100;
        if(absDiff < 0)absDiff = -absDiff;
        
        if (maxDiff < absDiff) {
            maxDiff = absDiff;
        }
    }
    if(maxDiff <= 2)
        return 12;
    else if(maxDiff <= 3)
        return 12*3/4;
    else if(maxDiff <= 4)
        return 12/2;
    else if(maxDiff <= 5)
        return 12/4;
    else
        return 0;
    
}
@end
