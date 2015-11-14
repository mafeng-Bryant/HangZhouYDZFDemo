//
//  OMGToast.h
//  axes
//
//  Created by on 12-8-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMGToast : NSObject{  
    NSString *text;  
    UIButton *contentView;  
    CGFloat  duration;  
}  

+(void)showWithText:(NSString *) text_;  
+(void)showWithText:(NSString *) text_  duration:(CGFloat)duration_;  

+(void)showWithText:(NSString *) text_  
          topOffset:(CGFloat) topOffset_;  
+(void)showWithText:(NSString *) text_  topOffset:(CGFloat) topOffset  
           duration:(CGFloat) duration_;  

+(void)showWithText:(NSString *) text_  
       bottomOffset:(CGFloat) bottomOffset_;  
+(void)showWithText:(NSString *) text_  
       bottomOffset:(CGFloat) bottomOffset_  
           duration:(CGFloat) duration_; 

@end
