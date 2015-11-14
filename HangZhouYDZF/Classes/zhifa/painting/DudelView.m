//
//  DudelView.m
//  Dudel
//
//  Created by JN on 2/25/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DudelView.h"
#import "BackgroundDrawingInfo.h"
#import "Drawable.h"

@implementation DudelView

@synthesize drawables,bDrawBgImage;


- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
      drawables = [[NSMutableArray alloc] initWithCapacity:100];    
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super initWithCoder:aDecoder])) {
      drawables = [[NSMutableArray alloc] initWithCapacity:100];   
  }
  return self;
}

-(void)drawRect:(CGRect)rect {
    
    if (bDrawBgImage) {
        NSString* tmpDirectory  = [NSHomeDirectory() 
                                   stringByAppendingPathComponent:@"Documents/HistoryMap.jpg"];
        //NSLog(@"1-%@",tmpDirectory);
        UIImage *img = [UIImage imageWithContentsOfFile:tmpDirectory];
        BackgroundDrawingInfo *info = [[BackgroundDrawingInfo alloc] initWithImage:img];
        [drawables addObject:info];
        [info release];
  
        bDrawBgImage = NO;
    }

    for (id<Drawable> d in drawables) {
        [d draw];
    }
    [delegate drawTemporary];
}

-(void)drawImage{
    for (id<Drawable> d in drawables) {
        [d draw];
    }
    [delegate drawTemporary];
}

- (void)dealloc {
  [drawables release];
  [super dealloc];
}

- (void)saveImageToFile:(NSString*)fileName 
{

	
}

@end
