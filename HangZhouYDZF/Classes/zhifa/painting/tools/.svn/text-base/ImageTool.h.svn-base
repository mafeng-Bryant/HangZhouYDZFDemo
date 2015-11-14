//
//  ImageTool.h
//  GMEPS_HZ
//
//  Created by zhang on 11-10-21.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tool.h"

@interface ImageTool : NSObject <Tool>{
    
	id <ToolDelegate> delegate;
	NSMutableArray *trackingTouches;
	NSMutableArray *startPoints;
	
    CGRect ImgRect;
    
    UIImageView *imgView;
    BOOL bAnotherImg;//yes表示再次点击按钮图标
}

+(ImageTool*)sharedImageTool;
@property(nonatomic,assign)BOOL bAnotherImg;
@end
