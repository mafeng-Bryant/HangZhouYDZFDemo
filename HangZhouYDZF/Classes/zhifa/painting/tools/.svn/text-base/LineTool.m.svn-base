//
//  LineTool.m
//  Dudel
//
//  Created by JN on 2/25/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "LineTool.h"
#import "PathDrawingInfo.h"

#import "SynthesizeSingleton.h"

@implementation LineTool

@synthesize delegate;

SYNTHESIZE_SINGLETON_FOR_CLASS(LineTool);

- init {
  if ((self = [super init])) {
    trackingTouches = [[NSMutableArray arrayWithCapacity:100] retain];
    startPoints = [[NSMutableArray arrayWithCapacity:100] retain];
    //endPoints = [[NSMutableArray arrayWithCapacity:100] retain];
    //saveStartPoints = [[NSMutableArray arrayWithCapacity:100] retain];
    //saveEndPoints = [[NSMutableArray arrayWithCapacity:100] retain];
    isLine = YES;
  }
  return self;
}
//自动连接清楚所有节点的操作
- (void)activate {
    //[trackingTouches removeAllObjects];
    //[startPoints removeAllObjects];
    //[endPoints removeAllObjects];
    //[saveStartPoints removeAllObjects];
    //[saveEndPoints removeAllObjects];
}
//自动连接点撤销和不撤销操作
/*
-(void)deleteLastPoint:(BOOL)isDelete
{
    if (isDelete == YES) {
        if ([startPoints count]>0&&[endPoints count]>0) {
            CGPoint lastStartDeletePoint = [[[startPoints lastObject] copy]CGPointValue];
            [saveStartPoints addObject:[NSValue valueWithCGPoint:lastStartDeletePoint]];
            
            CGPoint lastEndDeletePoint = [[[endPoints lastObject] retain]CGPointValue];
            [saveEndPoints addObject:[NSValue valueWithCGPoint:lastEndDeletePoint]];
            [startPoints removeLastObject];
            [endPoints removeLastObject];
        }
        
    }
    else
    {
        if ([saveStartPoints count]>0&&[saveEndPoints count]>0){
        CGPoint lastStartDeletePoint = [[[saveStartPoints lastObject] copy]CGPointValue];
        [startPoints addObject:[NSValue valueWithCGPoint:lastStartDeletePoint]];
        
        CGPoint lastEndDeletePoint = [[[saveEndPoints lastObject] retain]CGPointValue];
        [endPoints addObject:[NSValue valueWithCGPoint:lastEndDeletePoint]];
        [saveStartPoints removeLastObject];
        [saveEndPoints removeLastObject];
        }
    }
    
        
}
*/
- (void)deactivate {
    [trackingTouches removeAllObjects];
    [startPoints removeAllObjects];
    //[endPoints removeAllObjects];
    //[saveStartPoints removeAllObjects];
    //[saveEndPoints removeAllObjects];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UIView *touchedView = [delegate viewForUseWithTool:self];
  for (UITouch *touch in [event allTouches]) {
    // remember the touch, and its original start point, for future
    [trackingTouches addObject:touch];
    CGPoint location = [touch locationInView:touchedView];
    [startPoints addObject:[NSValue valueWithCGPoint:location]];
  }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  UIView *touchedView = [delegate viewForUseWithTool:self];
  for (UITouch *touch in [event allTouches]) {
    // make a line from the start point to the current point
    NSUInteger touchIndex = [trackingTouches indexOfObject:touch];
    // only if we actually remember the start of this touch...
    if (touchIndex != NSNotFound) {
      CGPoint startPoint = [[startPoints objectAtIndex:touchIndex] CGPointValue];
      CGPoint endPoint = [touch locationInView:touchedView];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:startPoint];
        [path addLineToPoint:endPoint];
        PathDrawingInfo *info = [PathDrawingInfo pathDrawingInfoWithPath:path fillColor:delegate.fillColor strokeColor:delegate.strokeColor];
        [delegate addDrawable:info];
        [trackingTouches removeObjectAtIndex:touchIndex];
        [startPoints removeObjectAtIndex:touchIndex];
        
        //自动连接直线的开始和结束节点操作
      /*[endPoints addObject:[NSValue valueWithCGPoint:endPoint]];
      //NSLog(@"起点坐标：%@",startPoints);
      //NSLog(@"终点：%@",endPoints);
      if ([startPoints count]>1) {
          //判断头节点是否
          for (int i = 0; i <[startPoints count]-1; i++) {
                CGPoint samePoint =  [[startPoints objectAtIndex:i] CGPointValue];
                CGPoint lastPoint = [[startPoints lastObject] CGPointValue];
                int startAndStart;
                startAndStart = (samePoint.x-lastPoint.x)*(samePoint.x-lastPoint.x)+(samePoint.y-lastPoint.y)*(samePoint.y-lastPoint.y);
                if (startAndStart < 1000) {
                    startPoint = samePoint;
                    [startPoints removeLastObject];
                    [startPoints addObject:[NSValue valueWithCGPoint:startPoint]];
                    break;
                }
                else
                    startPoint = [[startPoints lastObject] CGPointValue];
          }
          for (int i = 0; i<[startPoints count]-1; i++) {
              CGPoint samePoint =  [[startPoints objectAtIndex:i] CGPointValue];
              CGPoint endLastPoint = [[endPoints lastObject]CGPointValue];
              int startAndEnd;
              startAndEnd = (samePoint.x-endLastPoint.x)*(samePoint.x-endLastPoint.x)+(samePoint.y-endLastPoint.y)*(samePoint.y-endLastPoint.y);
              if (startAndEnd < 1000) {
                  endPoint = samePoint;
                  [endPoints removeLastObject];
                  [endPoints addObject:[NSValue valueWithCGPoint:endPoint]];
                  break;
              }
              else
                  endPoint = [[endPoints lastObject] CGPointValue];
            
          }
          for (int i = 0;i < [endPoints count]-1; i++) {
              CGPoint lastPoint = [[startPoints lastObject] CGPointValue];
              CGPoint endSamePoint = [[endPoints objectAtIndex:i] CGPointValue];
              int endAndStart;
              endAndStart = (endSamePoint.x-lastPoint.x)*(endSamePoint.x-lastPoint.x)+(endSamePoint.y-lastPoint.y)*(endSamePoint.y-lastPoint.y);
              if (endAndStart < 1000) {
                  startPoint = endSamePoint;
                  [startPoints removeLastObject];
                  [startPoints addObject:[NSValue valueWithCGPoint:startPoint]];
                  //[endPoints removeLastObject];
                  break;
              }
          }
          for (int i =0 ; i < [endPoints count]; i++) {
              CGPoint endSamePoint = [[endPoints objectAtIndex:i] CGPointValue];
              CGPoint endLastPoint = [[endPoints lastObject]CGPointValue];
              int endAndEnd ;
              endAndEnd = (endSamePoint.x-endLastPoint.x)*(endSamePoint.x-endLastPoint.x)+(endSamePoint.y-endLastPoint.y)*(endSamePoint.y-endLastPoint.y);
              if (endAndEnd < 1000) {
                  endPoint = endSamePoint;
                  [endPoints removeLastObject];
                  [endPoints addObject:[NSValue valueWithCGPoint:endPoint]];
                  break;
              }

          }
      }
      else
      {
          startPoint = [[startPoints lastObject] CGPointValue];
          endPoint = [[endPoints lastObject] CGPointValue];
      }
       
      UIBezierPath *path = [UIBezierPath bezierPath];
      [path moveToPoint:startPoint];
      [path addLineToPoint:endPoint];
      PathDrawingInfo *info = [PathDrawingInfo pathDrawingInfoWithPath:path fillColor:delegate.fillColor strokeColor:delegate.strokeColor];
      [delegate addDrawable:info];
      [trackingTouches removeObjectAtIndex:touchIndex];
      //[startPoints removeObjectAtIndex:touchIndex];
        //[self deactivate];
       */
    }
  }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  
}

- (void)drawTemporary {
  UIView *touchedView = [delegate viewForUseWithTool:self];
  for (int i = 0; i<[trackingTouches count]; i++) {
    UITouch *touch = [trackingTouches objectAtIndex:i];
    CGPoint startPoint = [[startPoints lastObject] CGPointValue];
    CGPoint endPoint = [touch locationInView:touchedView];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    [delegate.strokeColor setStroke];
    [path stroke];
  }
}

- (void)dealloc {
    [trackingTouches release];
    [startPoints release];
    //[endPoints release];
    //[saveStartPoints release];
    //[saveEndPoints release];
    self.delegate = nil;
    [super dealloc];
}

@end
