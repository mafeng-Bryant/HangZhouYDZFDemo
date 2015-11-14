//
//  DashEllipseTool.h
//  GMEPS_HZ
//
//  Created by power humor on 12-1-6.
//  Copyright (c) 2012年 powerdata. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Tool.h"

@interface DashEllipseTool : NSObject <Tool> {
    id <ToolDelegate> delegate;
    NSMutableArray *trackingTouches;
    NSMutableArray *startPoints;
}

+(DashEllipseTool*)sharedDashEllipseTool;

@end
