//
//  CalculateJianceScore.m
//  GMEPS_HZ
//
//  Created by 张仁松 on 13-5-8.
//
//

#import "CalculateJianceScore.h"
#import <math.h>

@implementation CalculateJianceScore

+(NSInteger)calcStandardAry:(NSArray*)aryBiaoye andActuallyAry:(NSArray*)aryShice
                  andType:(NSString*)type{
    if(aryBiaoye.count != aryShice.count){
        return -1;
    }
    double maxDiff = 10.0;//默认水不大于10%
    if([type isEqualToString:@"smoke"]){
        maxDiff = 5.0;
    }
    for(int i = 0; i < [aryShice count]; i++){
        double val1 = [[aryBiaoye objectAtIndex:i] doubleValue];
        double val2 = [[aryShice objectAtIndex:i] doubleValue];
        
        CGFloat diff =  (fabsf(val1 - val2))/val1;
        
        if ([type isEqualToString:@"smoke"]) {
            if (diff*100 > maxDiff ) {
                return 0;
            }

        }
        else {
            if (diff*100 >= maxDiff ) {
                return 0;
            }
        }
        
    }
    if([type isEqualToString:@"smoke"])
        return 15;
    else
        return 16;
}

+(NSInteger)calcShiceAry:(NSArray*)aryShice andShucaiAry:(NSArray*)aryShucai
                  andType:(NSString*)type{
    if(aryShucai.count != aryShice.count){
        return -1;
    }

    double maxDiff = 0.0;
    
    for(int i = 0; i < [aryShice count]; i++){
        double val1 = [[aryShice objectAtIndex:i] doubleValue];
        double val2 = [[aryShucai objectAtIndex:i] doubleValue];
        
        double diff = fabs(val1 - val2)/val1;
        double absDiff = diff*100.0;
        
        
        if (maxDiff < absDiff) {
            maxDiff = absDiff;
        }
    }
    
    if((maxDiff - 2) < 0)
        return 12;
    else if(((maxDiff -2) >= 0) && ((maxDiff - 3) < 0))
        return 12*3/4;
    else if(((maxDiff -3) >= 0) && ((maxDiff - 4) < 0))
        return 12/2;
    else if(((maxDiff -4) >= 0) && ((maxDiff - 5) < 0))
        return 12/4;
    else
        return 0;
    
}
@end
