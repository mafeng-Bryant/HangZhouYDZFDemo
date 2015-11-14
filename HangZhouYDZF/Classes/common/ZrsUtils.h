//
//  ZrsUtils.h
//  GuangXiOA
//
//  Created by 张 仁松 on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZrsUtils : NSObject
+(CGFloat)calculateTextHeight:(NSString*) text byFontSize:(CGFloat)size
                     andWidth:(CGFloat)width;
@end
