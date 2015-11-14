//
//  ZrsUtils.m
//  GuangXiOA
//
//  Created by 张 仁松 on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZrsUtils.h"

@implementation ZrsUtils

+(CGFloat)calculateTextHeight:(NSString*) text byFontSize:(CGFloat)size
                     andWidth:(CGFloat)width{
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:size];
    
    CGSize constraintSize = CGSizeMake(width, MAXFLOAT);
    CGSize size1 = [text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    return size1.height + 20;        
    
}

@end
