//
//  EraserTool.h
//  Dudel
//
//  Created by chen on 11-6-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tool.h"

@interface EraserTool : NSObject <Tool>{

	id <ToolDelegate> delegate;
	NSMutableArray *trackingTouches;
	NSMutableArray *startPoints;
	NSMutableArray *paths;
}

+(EraserTool*)sharedEraserTool;

@end
