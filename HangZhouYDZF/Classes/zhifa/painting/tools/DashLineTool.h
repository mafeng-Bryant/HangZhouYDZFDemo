//
//  DashLineTool.h
//  GMEPS_HZ
//
//  Created by power humor on 12-1-5.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Tool.h"

@interface DashLineTool : NSObject <Tool> {
    id <ToolDelegate> delegate;
    NSMutableArray *trackingTouches;
    NSMutableArray *startPoints;
}

+(DashLineTool*)sharedDashLineTool;

@end