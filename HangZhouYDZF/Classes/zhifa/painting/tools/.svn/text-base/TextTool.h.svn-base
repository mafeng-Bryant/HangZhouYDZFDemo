//
//  TextTool.h


#import <Foundation/Foundation.h>

#import "Tool.h"

@interface TextTool : NSObject <Tool, UITextViewDelegate> {
  id <ToolDelegate> delegate;
  NSMutableArray *trackingTouches;
  NSMutableArray *startPoints;
  UIBezierPath *completedPath;
	CGFloat viewSlideDistance;
    UITextView *textView;
}

@property (retain, nonatomic) UIBezierPath *completedPath;
@property (retain, nonatomic) UITextView *textView;
+(TextTool*)sharedTextTool;

@end
