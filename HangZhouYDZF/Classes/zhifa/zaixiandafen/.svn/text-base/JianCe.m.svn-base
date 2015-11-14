//
//  JianCe.m
//  GMEPS_HZ
//
//  Created by 熊 熙 on 13-4-15.
//
//

#import "JianCe.h"

@implementation JianCe

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)awakeFromNib {
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, 280.0, 0);
    CGContextAddLineToPoint(context, 280.0, 1004.0);
    CGContextStrokePath(context);
}



@end
