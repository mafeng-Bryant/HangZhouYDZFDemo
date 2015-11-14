//
//  TextDrawingInfo.h


#import <Foundation/Foundation.h>
#import "Drawable.h"

@interface TextDrawingInfo : NSObject <Drawable> {
  UIBezierPath *path;
  UIColor *strokeColor;
  UIFont *font;
  NSString *text;
}

@property (retain, nonatomic) UIBezierPath *path;
@property (retain, nonatomic) UIColor *strokeColor;
@property (retain, nonatomic) UIFont *font;
@property (copy, nonatomic) NSString *text;

- (id)initWithPath:(UIBezierPath*)p text:(NSString*)t strokeColor:(UIColor*)s font:(UIFont*)f;
+ (id)textDrawingInfoWithPath:(UIBezierPath *)p text:t strokeColor:(UIColor *)s font:(UIFont *)f;

@end
